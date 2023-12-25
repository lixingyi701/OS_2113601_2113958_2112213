#include <defs.h>
#include <stdio.h>
#include <wait.h>
#include <sync.h>
#include <proc.h>
#include <sched.h>
#include <dev.h>
#include <vfs.h>
#include <iobuf.h>
#include <inode.h>
#include <unistd.h>
#include <error.h>
#include <assert.h>

#define STDIN_BUFSIZE 4096

static char stdin_buffer[STDIN_BUFSIZE];
// 这里又有一个stdin设备的缓冲区, 能否和之前console的缓冲区合并?
static off_t p_rpos, p_wpos; // 描述缓冲区读写位置的变量
static wait_queue_t __wait_queue, *wait_queue = &__wait_queue;

// 把其他地方的字符写到stdin缓冲区, 准备被读取
void dev_stdin_write(char c)
{
    bool intr_flag;
    if (c != '\0')
    {
        // 进入这里，说明收到输入的字符
        local_intr_save(intr_flag); // 禁用中断
        {
            stdin_buffer[p_wpos % STDIN_BUFSIZE] = c;
            if (p_wpos - p_rpos < STDIN_BUFSIZE)
            {
                p_wpos++;
            }
            if (!wait_queue_empty(wait_queue))
            {
                // 若当前有进程在等待字符输入, 则进行唤醒
                wakeup_queue(wait_queue, WT_KBD, 1);
            }
        }
        local_intr_restore(intr_flag);
    }
}

// 读取len个字符
static int
dev_stdin_read(char *buf, size_t len)
{
    int ret = 0;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        for (; ret < len; ret++, p_rpos++)
        {
        try_again:
            // 如果 p_rpos < p_wpos，则表示有键盘输入的新字符在 stdin_buffer 中，于是就从 stdin_buffer 中取出新字符放到 iobuf 指向的缓冲区中
            if (p_rpos < p_wpos)
            { // 当前队列非空
                *buf++ = stdin_buffer[p_rpos % STDIN_BUFSIZE];
            }
            // 如果 p_rpos >=p_wpos，则表明没有新字符，这样调用 read 用户态库函数的用户进程就需要采用等待队列的睡眠操作进入睡眠状态，等待键盘输入字符的产生
            else
            {
                // 希望读取字符, 但是当前没有字符, 那么进行等待
                wait_t __wait, *wait = &__wait;
                wait_current_set(wait_queue, wait, WT_KBD);
                local_intr_restore(intr_flag);

                schedule();

                local_intr_save(intr_flag);
                wait_current_del(wait_queue, wait);
                if (wait->wakeup_flags == WT_KBD)
                {
                    goto try_again; // 再次尝试
                }
                break;
            }
        }
    }
    local_intr_restore(intr_flag);
    return ret;
}

static int
stdin_open(struct device *dev, uint32_t open_flags)
{
    if (open_flags != O_RDONLY)
    {
        return -E_INVAL;
    }
    return 0;
}

static int
stdin_close(struct device *dev)
{
    return 0;
}

// stdin_io 函数负责完成设备的读操作工作
static int
stdin_io(struct device *dev, struct iobuf *iob, bool write)
{
    // 可以看到，如果是写操作，则 stdin_io 函数直接报错返回，所以这也进一步说明了此设备文件是只读文件
    // 对应struct device 的d_io()
    if (!write)
    {
        // 如果是读操作，则此函数进一步调用 dev_stdin_read 函数完成对键盘设备的读入操作
        int ret;
        if ((ret = dev_stdin_read(iob->io_base, iob->io_resid)) > 0)
        {
            iob->io_resid -= ret;
        }
        return ret;
    }
    return -E_INVAL;
}

static int
stdin_ioctl(struct device *dev, int op, void *data)
{
    return -E_INVAL;
}

// stdin 设备文件的初始化过程主要由 stdin_device_init 完成了主要的初始化工作
static void
stdin_device_init(struct device *dev)
{
    // 相对于 stdout 的初始化过程，stdin 的初始化相对复杂一些，多了一个 stdin_buffer 缓冲区，描述缓冲区读写位置的变量 p_rpos、p_wpos 以及用于等待缓冲区的等待队列 wait_queue
    dev->d_blocks = 0;
    dev->d_blocksize = 1;
    dev->d_open = stdin_open;
    dev->d_close = stdin_close;
    dev->d_io = stdin_io;
    dev->d_ioctl = stdin_ioctl;

    // 在 stdin_device_init 函数的初始化中，也完成了对 p_rpos、p_wpos 和 wait_queue 的初始化
    p_rpos = p_wpos = 0;
    wait_queue_init(wait_queue);
}

void dev_init_stdin(void)
{
    struct inode *node;
    if ((node = dev_create_inode()) == NULL)
    {
        panic("stdin: dev_create_node.\n");
    }
    stdin_device_init(vop_info(node, device));

    int ret;
    if ((ret = vfs_add_dev("stdin", node, 0)) != 0)
    {
        panic("stdin: vfs_add_dev: %e.\n", ret);
    }
}
