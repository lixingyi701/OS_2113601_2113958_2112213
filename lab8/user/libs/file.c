#include <defs.h>
#include <string.h>
#include <syscall.h>
#include <stdio.h>
#include <stat.h>
#include <error.h>
#include <unistd.h>

int open(const char *path, uint32_t open_flags)
{
    return sys_open(path, open_flags);
}

int close(int fd)
{
    return sys_close(fd);
}

// 这是用户态程序可以使用的“系统库函数”，从文件fd读取len个字节到base这个位置
// 当fd = 0的时候，表示从stdin读取
// trap.c改变了对stdin的处理, 将stdin作为一个设备(也是一个文件), 通过sys_read()接口读取标准输入的数据
// 注意，既然我们把stdin, stdout看作文件，那么也需要先打开文件，才能进行读写。在执行用户程序之前，我们先执行了umain.c建立一个运行时环境，这里主要做的工作，就是让程序能够使用stdin, stdout
int read(int fd, void *base, size_t len)
{
    // 读文件其实就是读出目录中的目录项，首先假定文件在磁盘上且已经打开
    // 用户进程有语句 read(fd, data, len);，即读取fd对应文件，读取长度为len，存入data中
    /* 通用文件访问接口层的处理流程
     * (1) 先进入通用文件访问接口层的处理流程，即进一步调用如下用户态函数：read->sys_read->syscall，从而引起系统调用进入到内核态
     * (2) 到了内核态以后，通过中断处理例程，会调用到sys_read内核函数，并进一步调用sysfile_read内核函数，进入到文件系统抽象层处理流程完成进一步读文件的操作
     *  参见：kern/syscall/syscall.c:    sys_read(uint64_t arg[]) { ... }
     */
    return sys_read(fd, base, len);
}

int write(int fd, void *base, size_t len)
{
    return sys_write(fd, base, len);
}

int seek(int fd, off_t pos, int whence)
{
    return sys_seek(fd, pos, whence);
}

int fstat(int fd, struct stat *stat)
{
    return sys_fstat(fd, stat);
}

int fsync(int fd)
{
    return sys_fsync(fd);
}

int dup2(int fd1, int fd2)
{
    return sys_dup(fd1, fd2);
}

static char
transmode(struct stat *stat)
{
    uint32_t mode = stat->st_mode;
    if (S_ISREG(mode))
        return 'r';
    if (S_ISDIR(mode))
        return 'd';
    if (S_ISLNK(mode))
        return 'l';
    if (S_ISCHR(mode))
        return 'c';
    if (S_ISBLK(mode))
        return 'b';
    return '-';
}

void print_stat(const char *name, int fd, struct stat *stat)
{
    cprintf("[%03d] %s\n", fd, name);
    cprintf("    mode    : %c\n", transmode(stat));
    cprintf("    links   : %lu\n", stat->st_nlinks);
    cprintf("    blocks  : %lu\n", stat->st_blocks);
    cprintf("    size    : %lu\n", stat->st_size);
}
