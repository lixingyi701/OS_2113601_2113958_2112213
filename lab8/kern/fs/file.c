#include <defs.h>
#include <string.h>
#include <vfs.h>
#include <proc.h>
#include <file.h>
#include <unistd.h>
#include <iobuf.h>
#include <inode.h>
#include <stat.h>
#include <dirent.h>
#include <error.h>
#include <assert.h>

#define testfd(fd) ((fd) >= 0 && (fd) < FILES_STRUCT_NENTRY)

// get_fd_array - get current process's open files table
static struct file *
get_fd_array(void)
{
    struct files_struct *filesp = current->filesp;
    assert(filesp != NULL && files_count(filesp) > 0);
    return filesp->fd_array;
}

// fd_array_init - initialize the open files table
void fd_array_init(struct file *fd_array)
{
    int fd;
    struct file *file = fd_array;
    for (fd = 0; fd < FILES_STRUCT_NENTRY; fd++, file++)
    {
        file->open_count = 0;
        file->status = FD_NONE, file->fd = fd;
    }
}

// fs_array_alloc - allocate a free file item (with FD_NONE status) in open files table
static int
fd_array_alloc(int fd, struct file **file_store)
{
    //    panic("debug");
    struct file *file = get_fd_array();
    if (fd == NO_FD)
    {
        for (fd = 0; fd < FILES_STRUCT_NENTRY; fd++, file++)
        {
            if (file->status == FD_NONE)
            {
                goto found;
            }
        }
        return -E_MAX_OPEN;
    }
    else
    {
        if (testfd(fd))
        {
            file += fd;
            if (file->status == FD_NONE)
            {
                goto found;
            }
            return -E_BUSY;
        }
        return -E_INVAL;
    }
found:
    assert(fopen_count(file) == 0);
    file->status = FD_INIT, file->node = NULL;
    *file_store = file;
    return 0;
}

// fd_array_free - free a file item in open files table
static void
fd_array_free(struct file *file)
{
    assert(file->status == FD_INIT || file->status == FD_CLOSED);
    assert(fopen_count(file) == 0);
    if (file->status == FD_CLOSED)
    {
        vfs_close(file->node);
    }
    file->status = FD_NONE;
}

static void
fd_array_acquire(struct file *file)
{
    assert(file->status == FD_OPENED);
    fopen_count_inc(file);
}

// fd_array_release - file's open_count--; if file's open_count-- == 0 , then call fd_array_free to free this file item
static void
fd_array_release(struct file *file)
{
    assert(file->status == FD_OPENED || file->status == FD_CLOSED);
    assert(fopen_count(file) > 0);
    if (fopen_count_dec(file) == 0)
    {
        fd_array_free(file);
    }
}

// fd_array_open - file's open_count++, set status to FD_OPENED
void fd_array_open(struct file *file)
{
    assert(file->status == FD_INIT && file->node != NULL);
    file->status = FD_OPENED;
    fopen_count_inc(file);
}

// fd_array_close - file's open_count--; if file's open_count-- == 0 , then call fd_array_free to free this file item
void fd_array_close(struct file *file)
{
    assert(file->status == FD_OPENED);
    assert(fopen_count(file) > 0);
    file->status = FD_CLOSED;
    if (fopen_count_dec(file) == 0)
    {
        fd_array_free(file);
    }
}

// fs_array_dup - duplicate file 'from'  to file 'to'
void fd_array_dup(struct file *to, struct file *from)
{
    // cprintf("[fd_array_dup]from fd=%d, to fd=%d\n",from->fd, to->fd);
    assert(to->status == FD_INIT && from->status == FD_OPENED);
    to->pos = from->pos;
    to->readable = from->readable;
    to->writable = from->writable;
    struct inode *node = from->node;
    vop_ref_inc(node), vop_open_inc(node);
    to->node = node;
    fd_array_open(to);
}

// fd2file - use fd as index of fd_array, return the array item (file)
static inline int
fd2file(int fd, struct file **file_store)
{
    if (testfd(fd))
    {
        struct file *file = get_fd_array() + fd;
        if (file->status == FD_OPENED && file->fd == fd)
        {
            *file_store = file;
            return 0;
        }
    }
    return -E_INVAL;
}

// file_testfd - test file is readble or writable?
bool file_testfd(int fd, bool readable, bool writable)
{
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0)
    {
        return 0;
    }
    if (readable && !file->readable)
    {
        return 0;
    }
    if (writable && !file->writable)
    {
        return 0;
    }
    return 1;
}

// open file
// 文件系统抽象层的处理流程
// 1、分配一个空闲的file数据结构变量file在文件系统抽象层的处理中，首先调用的是file_open函数，它要给这个即将打开的文件分配一个file数据结构的变量，这个变量其实是当前进程的打开文件数组current->fs_struct->filemap[]中的一个空闲元素（即还没用于一个打开的文件），而这个元素的索引值就是最终要返回到用户进程并赋值给变量fd。到了这一步还仅仅是给当前用户进程分配了一个file数据结构的变量，还没有找到对应的文件索引节点
int file_open(char *path, uint32_t open_flags)
{
    bool readable = 0, writable = 0;
    // 解析 open_flags
    switch (open_flags & O_ACCMODE)
    {
    case O_RDONLY:
        readable = 1;
        break;
    case O_WRONLY:
        writable = 1;
        break;
    case O_RDWR:
        readable = writable = 1;
        break;
    default:
        return -E_INVAL;
    }
    int ret;
    struct file *file;
    // 在当前进程分配file descriptor
    if ((ret = fd_array_alloc(NO_FD, &file)) != 0)
    {
        return ret;
    }
    struct inode *node;
    // 需要进一步调用vfs_open函数来找到path指出的文件所对应的基于inode数据结构的VFS索引节点node
    // 打开文件的工作在vfs_open完成
    if ((ret = vfs_open(path, open_flags, &node)) != 0)
    {
        // 打开失败，释放file descriptor
        fd_array_free(file);
        return ret;
    }
    file->pos = 0;
    if (open_flags & O_APPEND)
    {
        struct stat __stat, *stat = &__stat;
        if ((ret = vop_fstat(node, stat)) != 0)
        {
            vfs_close(node);
            fd_array_free(file);
            return ret;
        }
        // 追加写模式，设置当前位置为文件尾
        file->pos = stat->st_size;
    }
    file->node = node;
    file->readable = readable;
    file->writable = writable;
    // 设置该文件的状态为“打开”
    fd_array_open(file);
    return file->fd;
}

// close file
int file_close(int fd)
{
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0)
    {
        return ret;
    }
    fd_array_close(file);
    return 0;
}

// read file
// 这个函数是读文件的核心函数
// 函数有4个参数，fd是文件描述符，base是缓存的基地址，len是要读取的长度，copied_store存放实际读取的长度
int file_read(int fd, void *base, size_t len, size_t *copied_store)
{
    int ret;
    struct file *file;
    *copied_store = 0;
    // 函数首先调用fd2file函数找到对应的file结构，并检查是否可读
    if ((ret = fd2file(fd, &file)) != 0)
    {
        return ret;
    }
    if (!file->readable)
    {
        return -E_INVAL;
    }
    // 调用filemap_acquire函数使打开这个文件的计数加1
    fd_array_acquire(file);

    // 调用vop_read函数将文件内容读到iob中（详细分析见后）
    // vop_read函数实际上是对sfs_read的包装，在sfs_inode.c中sfs_node_fileops变量定义了.vop_read = sfs_read
    struct iobuf __iob, *iob = iobuf_init(&__iob, base, len, file->pos);
    ret = vop_read(file->node, iob);

    // 调整文件指针偏移量pos的值，使其向后移动实际读到的字节数iobuf_used(iob)
    size_t copied = iobuf_used(iob);
    if (file->status == FD_OPENED)
    {
        file->pos += copied;
    }
    *copied_store = copied;
    // 最后调用filemap_release函数使打开这个文件的计数减1，若打开计数为0，则释放file
    fd_array_release(file);
    return ret;
}

// write file
int file_write(int fd, void *base, size_t len, size_t *copied_store)
{
    int ret;
    struct file *file;
    *copied_store = 0;
    if ((ret = fd2file(fd, &file)) != 0)
    {
        return ret;
    }
    if (!file->writable)
    {
        return -E_INVAL;
    }
    fd_array_acquire(file);

    struct iobuf __iob, *iob = iobuf_init(&__iob, base, len, file->pos);
    ret = vop_write(file->node, iob);

    size_t copied = iobuf_used(iob);
    if (file->status == FD_OPENED)
    {
        file->pos += copied;
    }
    *copied_store = copied;
    fd_array_release(file);
    return ret;
}

// seek file
int file_seek(int fd, off_t pos, int whence)
{
    struct stat __stat, *stat = &__stat;
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0)
    {
        return ret;
    }
    fd_array_acquire(file);

    switch (whence)
    {
    case LSEEK_SET:
        break;
    case LSEEK_CUR:
        pos += file->pos;
        break;
    case LSEEK_END:
        if ((ret = vop_fstat(file->node, stat)) == 0)
        {
            pos += stat->st_size;
        }
        break;
    default:
        ret = -E_INVAL;
    }

    if (ret == 0)
    {
        if ((ret = vop_tryseek(file->node, pos)) == 0)
        {
            file->pos = pos;
        }
        //    cprintf("file_seek, pos=%d, whence=%d, ret=%d\n", pos, whence, ret);
    }
    fd_array_release(file);
    return ret;
}

// stat file
int file_fstat(int fd, struct stat *stat)
{
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0)
    {
        return ret;
    }
    fd_array_acquire(file);
    ret = vop_fstat(file->node, stat);
    fd_array_release(file);
    return ret;
}

// sync file
int file_fsync(int fd)
{
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0)
    {
        return ret;
    }
    fd_array_acquire(file);
    ret = vop_fsync(file->node);
    fd_array_release(file);
    return ret;
}

// get file entry in DIR
int file_getdirentry(int fd, struct dirent *direntp)
{
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0)
    {
        return ret;
    }
    fd_array_acquire(file);

    struct iobuf __iob, *iob = iobuf_init(&__iob, direntp->name, sizeof(direntp->name), direntp->offset);
    if ((ret = vop_getdirentry(file->node, iob)) == 0)
    {
        direntp->offset += iobuf_used(iob);
    }
    fd_array_release(file);
    return ret;
}

// duplicate file
int file_dup(int fd1, int fd2)
{
    int ret;
    struct file *file1, *file2;
    if ((ret = fd2file(fd1, &file1)) != 0)
    {
        return ret;
    }
    if ((ret = fd_array_alloc(fd2, &file2)) != 0)
    {
        return ret;
    }
    fd_array_dup(file2, file1);
    return file2->fd;
}
