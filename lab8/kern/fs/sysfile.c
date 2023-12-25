#include <defs.h>
#include <string.h>
#include <vmm.h>
#include <proc.h>
#include <kmalloc.h>
#include <vfs.h>
#include <file.h>
#include <iobuf.h>
#include <sysfile.h>
#include <stat.h>
#include <dirent.h>
#include <unistd.h>
#include <error.h>
#include <assert.h>

#define IOBUF_SIZE 4096

/* copy_path - copy path name */
static int
copy_path(char **to, const char *from)
{
    struct mm_struct *mm = current->mm;
    char *buffer;
    if ((buffer = kmalloc(FS_MAX_FPATH_LEN + 1)) == NULL)
    {
        return -E_NO_MEM;
    }
    lock_mm(mm);
    if (!copy_string(mm, buffer, from, FS_MAX_FPATH_LEN + 1))
    {
        unlock_mm(mm);
        goto failed_cleanup;
    }
    unlock_mm(mm);
    *to = buffer;
    return 0;

failed_cleanup:
    kfree(buffer);
    return -E_INVAL;
}

/* sysfile_open - open file */
// 首先，经过syscall.c的处理之后，进入内核态，执行sysfile_open()函数
int sysfile_open(const char *__path, uint32_t open_flags)
{
    int ret;
    char *path;
    // 到了这里，需要把位于用户空间的字符串__path拷贝到内核空间中的字符串path中
    if ((ret = copy_path(&path, __path)) != 0)
    {
        return ret;
    }
    // 然后调用了file_open，file_open调用了vfs_open, 使用了VFS的接口,进入到文件系统抽象层的处理流程完成进一步的打开文件操作中
    ret = file_open(path, open_flags);
    kfree(path);
    return ret;
}

/* sysfile_close - close file */
int sysfile_close(int fd)
{
    return file_close(fd);
}

/* sysfile_read - read file */
/* 文件系统抽象层的处理流程
 * (1) 检查错误，即检查读取长度是否为0和文件是否可读
 * (2) 分配buffer空间，即调用kmalloc函数分配4096字节的buffer空间
 * (3) 读文件过程
 */
int sysfile_read(int fd, void *base, size_t len)
{
    struct mm_struct *mm = current->mm;
    //(1) 检查错误，即检查读取长度是否为0和文件是否可读
    if (len == 0)
    {
        return 0;
    }
    if (!file_testfd(fd, 1, 0))
    {
        return -E_INVAL;
    }
    //(2) 分配buffer空间，即调用kmalloc函数分配4096字节的buffer空间
    void *buffer;
    if ((buffer = kmalloc(IOBUF_SIZE)) == NULL)
    {
        return -E_NO_MEM;
    }

    //(3) 读文件过程
    int ret = 0;
    size_t copied = 0, alen;
    // 循环读取文件，每次读取buffer大小
    while (len != 0)
    {
        // 每次循环中，先检查剩余部分大小，若其小于4096字节，则只读取剩余部分的大小
        if ((alen = IOBUF_SIZE) > len)
        {
            alen = len;
        }
        // 然后调用file_read函数（详细分析见后）将文件内容读取到buffer中，alen为实际大小
        // 这个函数在 kern/fs/file.c:int file_read(int fd, void *base, size_t len, size_t *copied_store)
        ret = file_read(fd, buffer, alen, &alen);
        if (alen != 0)
        {
            lock_mm(mm);
            {
                // 调用copy_to_user函数将读到的内容拷贝到用户的内存空间中，调整各变量以进行下一次循环读取，直至指定长度读取完成
                if (copy_to_user(mm, base, buffer, alen))
                {
                    assert(len >= alen);
                    base += alen, len -= alen, copied += alen;
                }
                else if (ret == 0)
                {
                    ret = -E_INVAL;
                }
            }
            unlock_mm(mm);
        }
        if (ret != 0 || alen == 0)
        {
            goto out;
        }
    }

out:
    // 最后函数调用层层返回至用户程序，用户程序收到了读到的文件内容
    kfree(buffer);
    if (copied != 0)
    {
        return copied;
    }
    return ret;
}

/* sysfile_write - write file */
int sysfile_write(int fd, void *base, size_t len)
{
    struct mm_struct *mm = current->mm;
    if (len == 0)
    {
        return 0;
    }
    if (!file_testfd(fd, 0, 1))
    {
        return -E_INVAL;
    }
    void *buffer;
    if ((buffer = kmalloc(IOBUF_SIZE)) == NULL)
    {
        return -E_NO_MEM;
    }

    int ret = 0;
    size_t copied = 0, alen;
    while (len != 0)
    {
        if ((alen = IOBUF_SIZE) > len)
        {
            alen = len;
        }
        lock_mm(mm);
        {
            if (!copy_from_user(mm, buffer, base, alen, 0))
            {
                ret = -E_INVAL;
            }
        }
        unlock_mm(mm);
        if (ret == 0)
        {
            ret = file_write(fd, buffer, alen, &alen);
            if (alen != 0)
            {
                assert(len >= alen);
                base += alen, len -= alen, copied += alen;
            }
        }
        if (ret != 0 || alen == 0)
        {
            goto out;
        }
    }

out:
    kfree(buffer);
    if (copied != 0)
    {
        return copied;
    }
    return ret;
}

/* sysfile_seek - seek file */
int sysfile_seek(int fd, off_t pos, int whence)
{
    return file_seek(fd, pos, whence);
}

/* sysfile_fstat - stat file */
int sysfile_fstat(int fd, struct stat *__stat)
{
    struct mm_struct *mm = current->mm;
    int ret;
    struct stat __local_stat, *stat = &__local_stat;
    if ((ret = file_fstat(fd, stat)) != 0)
    {
        return ret;
    }

    lock_mm(mm);
    {
        if (!copy_to_user(mm, __stat, stat, sizeof(struct stat)))
        {
            ret = -E_INVAL;
        }
    }
    unlock_mm(mm);
    return ret;
}

/* sysfile_fsync - sync file */
int sysfile_fsync(int fd)
{
    return file_fsync(fd);
}

/* sysfile_chdir - change dir */
int sysfile_chdir(const char *__path)
{
    int ret;
    char *path;
    if ((ret = copy_path(&path, __path)) != 0)
    {
        return ret;
    }
    ret = vfs_chdir(path);
    kfree(path);
    return ret;
}

/* sysfile_link - link file */
int sysfile_link(const char *__path1, const char *__path2)
{
    int ret;
    char *old_path, *new_path;
    if ((ret = copy_path(&old_path, __path1)) != 0)
    {
        return ret;
    }
    if ((ret = copy_path(&new_path, __path2)) != 0)
    {
        kfree(old_path);
        return ret;
    }
    ret = vfs_link(old_path, new_path);
    kfree(old_path), kfree(new_path);
    return ret;
}

/* sysfile_rename - rename file */
int sysfile_rename(const char *__path1, const char *__path2)
{
    int ret;
    char *old_path, *new_path;
    if ((ret = copy_path(&old_path, __path1)) != 0)
    {
        return ret;
    }
    if ((ret = copy_path(&new_path, __path2)) != 0)
    {
        kfree(old_path);
        return ret;
    }
    ret = vfs_rename(old_path, new_path);
    kfree(old_path), kfree(new_path);
    return ret;
}

/* sysfile_unlink - unlink file */
int sysfile_unlink(const char *__path)
{
    int ret;
    char *path;
    if ((ret = copy_path(&path, __path)) != 0)
    {
        return ret;
    }
    ret = vfs_unlink(path);
    kfree(path);
    return ret;
}

/* sysfile_get cwd - get current working directory */
int sysfile_getcwd(char *buf, size_t len)
{
    struct mm_struct *mm = current->mm;
    if (len == 0)
    {
        return -E_INVAL;
    }

    int ret = -E_INVAL;
    lock_mm(mm);
    {
        if (user_mem_check(mm, (uintptr_t)buf, len, 1))
        {
            struct iobuf __iob, *iob = iobuf_init(&__iob, buf, len, 0);
            ret = vfs_getcwd(iob);
        }
    }
    unlock_mm(mm);
    return ret;
}

/* sysfile_getdirentry - get the file entry in DIR */
int sysfile_getdirentry(int fd, struct dirent *__direntp)
{
    struct mm_struct *mm = current->mm;
    struct dirent *direntp;
    if ((direntp = kmalloc(sizeof(struct dirent))) == NULL)
    {
        return -E_NO_MEM;
    }

    int ret = 0;
    lock_mm(mm);
    {
        if (!copy_from_user(mm, &(direntp->offset), &(__direntp->offset), sizeof(direntp->offset), 1))
        {
            ret = -E_INVAL;
        }
    }
    unlock_mm(mm);

    if (ret != 0 || (ret = file_getdirentry(fd, direntp)) != 0)
    {
        goto out;
    }

    lock_mm(mm);
    {
        if (!copy_to_user(mm, __direntp, direntp, sizeof(struct dirent)))
        {
            ret = -E_INVAL;
        }
    }
    unlock_mm(mm);

out:
    kfree(direntp);
    return ret;
}

/* sysfile_dup -  duplicate fd1 to fd2 */
int sysfile_dup(int fd1, int fd2)
{
    return file_dup(fd1, fd2);
}

int sysfile_pipe(int *fd_store)
{
    return -E_UNIMP;
}

int sysfile_mkfifo(const char *__name, uint32_t open_flags)
{
    return -E_UNIMP;
}
