#ifndef __KERN_FS_SFS_SFS_H__
#define __KERN_FS_SFS_SFS_H__

#include <defs.h>
#include <mmu.h>
#include <list.h>
#include <sem.h>
#include <unistd.h>

/*
 * Simple FS (SFS) definitions visible to ucore. This covers the on-disk format
 * and is used by tools that work on SFS volumes, such as mksfs.
 */

#define SFS_MAGIC 0x2f8dbe2a                    /* magic number for sfs */
#define SFS_BLKSIZE PGSIZE                      /* size of block */
#define SFS_NDIRECT 12                          /* # of direct blocks in inode */
#define SFS_MAX_INFO_LEN 31                     /* max length of infomation */
#define SFS_MAX_FNAME_LEN FS_MAX_FNAME_LEN      /* max length of filename */
#define SFS_MAX_FILE_SIZE (1024UL * 1024 * 128) /* max file size (128M) */
#define SFS_BLKN_SUPER 0                        /* block the superblock lives in */
#define SFS_BLKN_ROOT 1                         /* location of the root dir inode */
#define SFS_BLKN_FREEMAP 2                      /* 1st block of the freemap */

/* # of bits in a block */
#define SFS_BLKBITS (SFS_BLKSIZE * CHAR_BIT)

/* # of entries in a block */
#define SFS_BLK_NENTRY (SFS_BLKSIZE / sizeof(uint32_t))

/* file types */
#define SFS_TYPE_INVAL 0 /* Should not appear on disk */
#define SFS_TYPE_FILE 1
#define SFS_TYPE_DIR 2
#define SFS_TYPE_LINK 3

/*
 * On-disk superblock
 */
/*
 * 我们从ucore实验指导书摘抄一段关于Simple File System的介绍。
 * 通常文件系统中，磁盘的使用是以扇区（Sector）为单位的，但是为了实现简便，SFS 中以 block （4K，与内存 page 大小相等）为基本单位。
 *
 * ucore 目前支持如下几种类型的文件：
 * - 常规文件：文件中包括的内容信息是由应用程序输入。SFS 文件系统在普通文件上不强加任何内部结构，把其文件内容信息看作为字节。
 * - 目录：包含一系列的 entry，每个 entry 包含文件名和指向与之相关联的索引节点（index node）的指针。目录是按层次结构组织的。
 * - 链接文件：实际上一个链接文件是一个已经存在的文件的另一个可选择的文件名。
 * - 设备文件：不包含数据，但是提供了一个映射物理设备（如串口、键盘等）到一个文件名的机制。可通过设备文件访问外围设备。
 * - 管道：管道是进程间通讯的一个基础设施。管道缓存了其输入端所接受的数据，以便在管道输出端读的进程能一个先进先出的方式来接受数据。
 *
 * SFS 通过索引节点来管理目录和常规文件，索引节点包含操作系统所需要的关于某个文件的关键信息，比如文件的属性、访问许可权以及其它控制信息都保存在索引节点中。可以有多个文件名可指向一个索引节点。
 *
 * SFS文件系统布局示意:
 * | superblock | root-dir inode | freemap | inodes, File Data, Dir Data Blocks |
 *
 * 第 0 个块（4K）是超级块（superblock），它包含了关于文件系统的所有关键参数，当计算机被启动或文件系统被首次接触时，超级块的内容就会被装入内存。
 * 第 1 个块放了一个 root-dir 的 inode，用来记录根目录的相关信息。有关 inode 还将在后续部分介绍。这里只要理解 root-dir 是 SFS 文件系统的根结点，通过这个 root-dir 的 inode 信息就可以定位并查找到根目录下的所有文件信息。
 * 从第 2 个块开始，根据 SFS 中所有块的数量，用 1 个 bit 来表示一个块的占用和未被占用的情况。这个区域称为 SFS 的 freemap 区域，这将占用若干个块空间。为了更好地记录和管理 freemap 区域，专门提供了两个文件 kern/fs/sfs/bitmap.[ch]来完成根据一个块号查找或设置对应的 bit 位的值
 * 最后在剩余的磁盘空间中，存放了所有其他目录和文件的 inode 信息和内容数据信息。需要注意的是虽然 inode 的大小小于一个块的大小（4096B），但为了实现简单，每个 inode 都占用一个完整的 block。
 *
 * 在 sfs_fs.c 文件中的 sfs_do_mount 函数中，完成了加载位于硬盘上的 SFS 文件系统的超级块 superblock 和 freemap 的工作。这样，在内存中就有了 SFS 文件系统的全局信息。
 */
struct sfs_super
{
    // 包含一个成员变量魔数 magic，其值为 0x2f8dbe2a，内核通过它来检查磁盘镜像是否是合法的 SFS img
    uint32_t magic; /* magic number, should be SFS_MAGIC */
    // 成员变量 blocks 记录了 SFS 中所有 block 的数量，即 img 的大小
    uint32_t blocks; /* # of blocks in fs */
    // 成员变量 unused_block 记录了 SFS 中还没有被使用的 block 的数量
    uint32_t unused_blocks; /* # of unused blocks in fs */
    // 成员变量 info 包含了字符串"simple file system"
    char info[SFS_MAX_INFO_LEN + 1]; /* infomation for sfs  */
};

/* inode (on disk) */
// 磁盘索引节点
// 对于普通文件，索引值指向的 block 中保存的是文件中的数据。而对于目录，索引值指向的数据保存的是目录下所有的文件名以及对应的索引节点所在的索引块（磁盘块）所形成的数组
struct sfs_disk_inode
{
    // 如果inode表示常规文件，则size是文件大小
    uint32_t size; /* size of the file (in bytes) */
    // inode的文件类型
    // 上面宏定义有吧
    uint16_t type; /* one of SYS_TYPE_* above */
    // 此inode的硬链接数
    uint16_t nlinks; /* # of hard links to this file */
    // 此inode的数据块数的个数
    // inode 里 blocks 表示该文件或者目录占用的磁盘的 block 的个数
    uint32_t blocks; /* # of blocks */
    // 此inode的直接数据块索引值（有SFS_NDIRECT个）
    // 如果 inode 表示的是文件，则成员变量 direct[]直接指向了保存文件内容数据的数据块索引值
    // 默认的，ucore 里 SFS_NDIRECT 是 12，即直接索引的数据页大小为 12 * 4k = 48k；当使用一级间接数据块索引时，ucore 支持最大的文件大小为 12 * 4k + 1024 * 4k = 48k + 4m
    uint32_t direct[SFS_NDIRECT]; /* direct blocks */
    // 此inode的一级间接数据块索引值
    // 数据索引表内，0 表示一个无效的索引
    // indiret 为 0 时，表示不使用一级索引块（因为 block 0 用来保存 super block，它不可能被其他任何文件或目录使用，所以这么设计也是合理的）
    uint32_t indirect; /* indirect blocks */
    //    uint32_t db_indirect;                           /* double indirect blocks */
    //   unused
};

/* file entry (on disk) */
// 对于目录，索引值指向的数据保存的是目录下所有的文件名以及对应的索引节点所在的索引块（磁盘块）所形成的数组
// 和 inode 相似，每个 sfs_disk_entry也占用一个 block
struct sfs_disk_entry
{
    // 索引节点所占数据块索引值
    // 操作系统中，每个文件系统下的 inode 都应该分配唯一的 inode 编号。SFS 下，为了实现的简便（偷懒），每个 inode 直接用他所在的磁盘 block 的编号作为 inode 编号
    // 比如，root block 的 inode 编号为 1
    // ino 表示磁盘 block 编号，通过读取该 block 的数据，能够得到相应的文件或文件夹的 inode。ino 为 0 时，表示一个无效的 entry
    uint32_t ino; /* inode number */
    // 文件名
    // 每个 sfs_disk_entry 数据结构中，name 表示目录下文件或文件夹的名称
    char name[SFS_MAX_FNAME_LEN + 1]; /* file name */
};

#define sfs_dentry_size \
    sizeof(((struct sfs_disk_entry *)0)->name)

/* inode for sfs */
// 内存中的索引节点
// 可以看到 SFS 中的内存 inode 包含了 SFS 的硬盘 inode 信息，而且还增加了其他一些信息，这属于是便于进行是判断否改写、互斥操作、回收和快速地定位等作用
// 需要注意，一个内存 inode 是在打开一个文件后才创建的，如果关机则相关信息都会消失
// 而硬盘 inode 的内容是保存在硬盘中的，只是在进程需要时才被读入到内存中，用于访问文件或目录的具体内容数据
struct sfs_inode
{
    struct sfs_disk_inode *din; /* on-disk inode */
    uint32_t ino;               /* inode number */
    bool dirty;                 /* true if inode modified */
    int reclaim_count;          /* kill inode if it hits zero */
    semaphore_t sem;            /* semaphore for din */
    list_entry_t inode_link;    /* entry for linked-list in sfs_fs */
    list_entry_t hash_link;     /* entry for hash linked-list in sfs_fs */
};

#define le2sin(le, member) \
    to_struct((le), struct sfs_inode, member)

/* filesystem for sfs */
struct sfs_fs
{
    struct sfs_super super;  /* on-disk superblock */
    struct device *dev;      /* device mounted on */
    struct bitmap *freemap;  /* blocks in use are mared 0 */
    bool super_dirty;        /* true if super/freemap modified */
    void *sfs_buffer;        /* buffer for non-block aligned io */
    semaphore_t fs_sem;      /* semaphore for fs */
    semaphore_t io_sem;      /* semaphore for io */
    semaphore_t mutex_sem;   /* semaphore for link/unlink and rename */
    list_entry_t inode_list; /* inode linked-list */
    list_entry_t *hash_list; /* inode hash linked-list */
};

/* hash for sfs */
#define SFS_HLIST_SHIFT 10
#define SFS_HLIST_SIZE (1 << SFS_HLIST_SHIFT)
#define sin_hashfn(x) (hash32(x, SFS_HLIST_SHIFT))

/* size of freemap (in bits) */
#define sfs_freemap_bits(super) ROUNDUP((super)->blocks, SFS_BLKBITS)

/* size of freemap (in blocks) */
#define sfs_freemap_blocks(super) ROUNDUP_DIV((super)->blocks, SFS_BLKBITS)

struct fs;
struct inode;

void sfs_init(void);
int sfs_mount(const char *devname);

void lock_sfs_fs(struct sfs_fs *sfs);
void lock_sfs_io(struct sfs_fs *sfs);
void unlock_sfs_fs(struct sfs_fs *sfs);
void unlock_sfs_io(struct sfs_fs *sfs);

int sfs_rblock(struct sfs_fs *sfs, void *buf, uint32_t blkno, uint32_t nblks);
int sfs_wblock(struct sfs_fs *sfs, void *buf, uint32_t blkno, uint32_t nblks);
int sfs_rbuf(struct sfs_fs *sfs, void *buf, size_t len, uint32_t blkno, off_t offset);
int sfs_wbuf(struct sfs_fs *sfs, void *buf, size_t len, uint32_t blkno, off_t offset);
int sfs_sync_super(struct sfs_fs *sfs);
int sfs_sync_freemap(struct sfs_fs *sfs);
int sfs_clear_block(struct sfs_fs *sfs, uint32_t blkno, uint32_t nblks);

int sfs_load_inode(struct sfs_fs *sfs, struct inode **node_store, uint32_t ino);

#endif /* !__KERN_FS_SFS_SFS_H__ */
