#include <defs.h>
#include <stdio.h>
#include <dev.h>
#include <vfs.h>
#include <iobuf.h>
#include <inode.h>
#include <unistd.h>
#include <error.h>
#include <assert.h>

static int
stdout_open(struct device *dev, uint32_t open_flags)
{
    if (open_flags != O_WRONLY)
    {
        return -E_INVAL;
    }
    return 0;
}

static int
stdout_close(struct device *dev)
{
    return 0;
}

// stdout设备只需要支持写操作，调用cputchar()把字符逐个打印到控制台
static int
stdout_io(struct device *dev, struct iobuf *iob, bool write)
{
    // 对应struct device 的d_io()
    if (write)
    {
        // 可以看到，要写的数据放在 iob->io_base 所指的内存区域，一直写到 iob->io_resid 的值为 0 为止
        char *data = iob->io_base;
        for (; iob->io_resid != 0; iob->io_resid--)
        {
            // 每次写操作都是通过 cputchar 来完成的，此函数最终将通过 console 外设驱动来完成把数据输出到串口、并口和 CGA 显示器上过程
            cputchar(*data++);
        }
        return 0;
    }
    // if !write:
    // 另外，也可以注意到，如果用户想执行读操作，则 stdout_io 函数直接返回错误值-E_INVAL
    return -E_INVAL; // 对stdout执行读操作会报错
}

static int
stdout_ioctl(struct device *dev, int op, void *data)
{
    return -E_INVAL;
}

// stdout 设备文件的初始化过程主要由 stdout_device_init 完成
static void
stdout_device_init(struct device *dev)
{
    dev->d_blocks = 0;
    dev->d_blocksize = 1;
    // 可以看到，stdout_open 函数完成设备文件打开工作，如果发现用户进程调用 open 函数的参数 flags 不是只写（O_WRONLY），则会报错
    dev->d_open = stdout_open;
    dev->d_close = stdout_close;
    // stdout_io 函数完成设备的写操作工作
    dev->d_io = stdout_io;
    dev->d_ioctl = stdout_ioctl;
}

void dev_init_stdout(void)
{
    struct inode *node;
    if ((node = dev_create_inode()) == NULL)
    {
        panic("stdout: dev_create_node.\n");
    }
    stdout_device_init(vop_info(node, device));

    int ret;
    if ((ret = vfs_add_dev("stdout", node, 0)) != 0)
    {
        panic("stdout: vfs_add_dev: %e.\n", ret);
    }
}
