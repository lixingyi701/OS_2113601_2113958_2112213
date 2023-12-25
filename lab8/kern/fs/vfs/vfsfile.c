#include <defs.h>
#include <string.h>
#include <vfs.h>
#include <inode.h>
#include <unistd.h>
#include <error.h>
#include <assert.h>

// open file in vfs, get/create inode for file with filename path.
// vfs_open函数需要完成两件事情：通过vfs_lookup找到path对应文件的inode；调用vop_open函数打开文件
// vfs_open是一个比较复杂的函数，这里我们使用的打开文件的flags, 基本是参照linux，如果希望详细了解，可以阅读linux manual: open
int vfs_open(char *path, uint32_t open_flags, struct inode **node_store)
{
    bool can_write = 0;
    // 解析open_flags并做合法性检查
    switch (open_flags & O_ACCMODE)
    {
    case O_RDONLY:
        break;
    case O_WRONLY:
    case O_RDWR:
        can_write = 1;
        break;
    default:
        return -E_INVAL;
    }

    if (open_flags & O_TRUNC)
    {
        if (!can_write)
        {
            return -E_INVAL;
        }
    }

    /*
    linux manual
           O_TRUNC
                  If the file already exists and is a regular file and the
                  access mode allows writing (i.e., is O_RDWR or O_WRONLY) it
                  will be truncated to length 0.  If the file is a FIFO or ter‐
                  minal device file, the O_TRUNC flag is ignored.  Otherwise,
                  the effect of O_TRUNC is unspecified.
    */
    int ret;
    struct inode *node;
    bool excl = (open_flags & O_EXCL) != 0;
    bool create = (open_flags & O_CREAT) != 0;
    ret = vfs_lookup(path, &node); // vfs_lookup根据路径构造inode

    // 要打开的文件还不存在，可能出错，也可能需要创建新文件
    if (ret != 0)
    {
        if (ret == -16 && (create))
        {
            char *name;
            struct inode *dir;
            if ((ret = vfs_lookup_parent(path, &dir, &name)) != 0)
            {
                // 需要在已经存在的目录下创建文件，目录不存在，则出错
                return ret;
            }
            // 创建新文件
            ret = vop_create(dir, name, excl, &node);
        }
        else
            return ret;
    }
    else if (excl && create)
    {
        /*
        linux manual
              O_EXCL Ensure that this call creates the file: if this flag is
              specified in conjunction with O_CREAT, and pathname already
              exists, then open() fails with the error EEXIST.
        */
        return -E_EXISTS;
    }
    assert(node != NULL);

    if ((ret = vop_open(node, open_flags)) != 0)
    {
        vop_ref_dec(node);
        return ret;
    }

    vop_open_inc(node);
    if (open_flags & O_TRUNC || create)
    {
        if ((ret = vop_truncate(node, 0)) != 0)
        {
            vop_open_dec(node);
            vop_ref_dec(node);
            return ret;
        }
    }
    *node_store = node;
    return 0;
}

// close file in vfs
int vfs_close(struct inode *node)
{
    vop_open_dec(node);
    vop_ref_dec(node);
    return 0;
}

// unimplement
int vfs_unlink(char *path)
{
    return -E_UNIMP;
}

// unimplement
int vfs_rename(char *old_path, char *new_path)
{
    return -E_UNIMP;
}

// unimplement
int vfs_link(char *old_path, char *new_path)
{
    return -E_UNIMP;
}

// unimplement
int vfs_symlink(char *old_path, char *new_path)
{
    return -E_UNIMP;
}

// unimplement
int vfs_readlink(char *path, struct iobuf *iob)
{
    return -E_UNIMP;
}

// unimplement
int vfs_mkdir(char *path)
{
    return -E_UNIMP;
}
