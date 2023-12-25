#include <defs.h>
#include <string.h>
#include <vfs.h>
#include <inode.h>
#include <error.h>
#include <assert.h>

/*
 * get_device- Common code to pull the device name, if any, off the front of a
 *             path and choose the inode to begin the name lookup relative to.
 */

static int
get_device(char *path, char **subpath, struct inode **node_store)
{
    int i, slash = -1, colon = -1;
    for (i = 0; path[i] != '\0'; i++)
    {
        if (path[i] == ':')
        {
            colon = i;
            break;
        }
        if (path[i] == '/')
        {
            slash = i;
            break;
        }
    }
    if (colon < 0 && slash != 0)
    {
        /* *
         * No colon before a slash, so no device name specified, and the slash isn't leading
         * or is also absent, so this is a relative path or just a bare filename. Start from
         * the current directory, and use the whole thing as the subpath.
         * */
        *subpath = path;
        return vfs_get_curdir(node_store); // 把当前目录的inode存到node_store
    }
    if (colon > 0)
    {
        /* device:path - get root of device's filesystem */
        path[colon] = '\0';

        /* device:/path - skip slash, treat as device:path */
        while (path[++colon] == '/')
            ;
        *subpath = path + colon;
        return vfs_get_root(path, node_store);
    }

    /* *
     * we have either /path or :path
     * /path is a path relative to the root of the "boot filesystem"
     * :path is a path relative to the root of the current filesystem
     * */
    int ret;
    if (*path == '/')
    {
        if ((ret = vfs_get_bootfs(node_store)) != 0)
        {
            return ret;
        }
    }
    else
    {
        assert(*path == ':');
        struct inode *node;
        if ((ret = vfs_get_curdir(&node)) != 0)
        {
            return ret;
        }
        /* The current directory may not be a device, so it must have a fs. */
        assert(node->in_fs != NULL);
        *node_store = fsop_get_root(node->in_fs);
        vop_ref_dec(node);
    }

    /* ///... or :/... */
    while (*(++path) == '/')
        ;
    *subpath = path;
    return 0;
}

/*
 * vfs_lookup - get the inode according to the path filename
 */
// vfs_lookup函数是一个针对目录的操作函数，它会调用vop_lookup函数来找到SFS文件系统中的目录下的文件
int vfs_lookup(char *path, struct inode **node_store)
{
    int ret;
    struct inode *node;
    // 为此，vfs_lookup函数首先调用get_device函数，并进一步调用vfs_get_bootfs函数（其实调用了）来找到根目录“/”对应的inode，这个inode就是位于vfs.c中的inode变量bootfs_node，这个变量在init_main函数（位于kern/process/proc.c）执行时获得了赋值
    if ((ret = get_device(path, &path, &node)) != 0)
    {
        return ret;
    }
    if (*path != '\0')
    {
        // 通过调用vop_lookup函数来查找到根目录“/”下对应文件sfs_filetest1的索引节点，如果找到就返回此索引节点
        // 我们注意到，这个流程中，有大量以vop开头的函数，它们都通过一些宏和函数的转发，最后变成对inode结构体里的inode_ops结构体的“成员函数”（实际上是函数指针）的调用。对于SFS文件系统的inode来说，会变成对sfs文件系统的具体操作
        ret = vop_lookup(node, path, node_store);
        vop_ref_dec(node);
        return ret;
    }
    *node_store = node;
    return 0;
}

/*
 * vfs_lookup_parent - Name-to-vnode translation.
 *  (In BSD, both of these are subsumed by namei().)
 */
int vfs_lookup_parent(char *path, struct inode **node_store, char **endp)
{
    int ret;
    struct inode *node;
    if ((ret = get_device(path, &path, &node)) != 0)
    {
        return ret;
    }
    *endp = path;
    *node_store = node;
    return 0;
}
