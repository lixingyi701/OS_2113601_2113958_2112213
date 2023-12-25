#ifndef __KERN_FS_DEVS_DEV_H__
#define __KERN_FS_DEVS_DEV_H__

#include <defs.h>

struct inode;
struct iobuf;

/*
 * Filesystem-namespace-accessible device.
 * d_io is for both reads and writes; the iobuf will indicates the direction.
 */
// 可以认为struct device是一个比较抽象的“设备”的定义。一个具体设备，只要实现了d_open()打开设备， d_close()关闭设备，d_io()(读写该设备，write参数是true/false决定是读还是写)，d_ioctl()(input/output control)四个函数接口，就可以被文件系统使用了
// 这个数据结构能够支持对块设备（比如磁盘）、字符设备（比如键盘）的表示，完成对设备的基本操作
// 但这个设备描述没有与文件系统以及表示一个文件的 inode 数据结构建立关系，为此，还需要另外一个数据结构把 device 和 inode 联通起来，这就要参见 kern/fs/vfs/vfsdev.c 中的 vfs_dev_t 数据结构了
struct device
{
    size_t d_blocks;
    size_t d_blocksize;
    int (*d_open)(struct device *dev, uint32_t open_flags);
    int (*d_close)(struct device *dev);
    int (*d_io)(struct device *dev, struct iobuf *iob, bool write);
    int (*d_ioctl)(struct device *dev, int op, void *data);
};

#define dop_open(dev, open_flags) ((dev)->d_open(dev, open_flags))
#define dop_close(dev) ((dev)->d_close(dev))
#define dop_io(dev, iob, write) ((dev)->d_io(dev, iob, write))
#define dop_ioctl(dev, op, data) ((dev)->d_ioctl(dev, op, data))

void dev_init(void);
struct inode *dev_create_inode(void);

#endif /* !__KERN_FS_DEVS_DEV_H__ */
