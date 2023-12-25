#include <defs.h>
#include <string.h>
#include <stdlib.h>
#include <list.h>
#include <stat.h>
#include <kmalloc.h>
#include <vfs.h>
#include <dev.h>
#include <sfs.h>
#include <inode.h>
#include <iobuf.h>
#include <bitmap.h>
#include <error.h>
#include <assert.h>

static const struct inode_ops sfs_node_dirops;  // dir operations
static const struct inode_ops sfs_node_fileops; // file operations

/*
 * lock_sin - lock the process of inode Rd/Wr
 */
static void
lock_sin(struct sfs_inode *sin)
{
    down(&(sin->sem));
}

/*
 * unlock_sin - unlock the process of inode Rd/Wr
 */
static void
unlock_sin(struct sfs_inode *sin)
{
    up(&(sin->sem));
}

/*
 * sfs_get_ops - return function addr of fs_node_dirops/sfs_node_fileops
 */
static const struct inode_ops *
sfs_get_ops(uint16_t type)
{
    switch (type)
    {
    case SFS_TYPE_DIR:
        return &sfs_node_dirops;
    case SFS_TYPE_FILE:
        return &sfs_node_fileops;
    }
    panic("invalid file type %d.\n", type);
}

/*
 * sfs_hash_list - return inode entry in sfs->hash_list
 */
static list_entry_t *
sfs_hash_list(struct sfs_fs *sfs, uint32_t ino)
{
    return sfs->hash_list + sin_hashfn(ino);
}

/*
 * sfs_set_links - link inode sin in sfs->linked-list AND sfs->hash_link
 */
static void
sfs_set_links(struct sfs_fs *sfs, struct sfs_inode *sin)
{
    list_add(&(sfs->inode_list), &(sin->inode_link));
    list_add(sfs_hash_list(sfs, sin->ino), &(sin->hash_link));
}

/*
 * sfs_remove_links - unlink inode sin in sfs->linked-list AND sfs->hash_link
 */
static void
sfs_remove_links(struct sfs_inode *sin)
{
    list_del(&(sin->inode_link));
    list_del(&(sin->hash_link));
}

/*
 * sfs_block_inuse - check the inode with NO. ino inuse info in bitmap
 */
static bool
sfs_block_inuse(struct sfs_fs *sfs, uint32_t ino)
{
    if (ino != 0 && ino < sfs->super.blocks)
    {
        return !bitmap_test(sfs->freemap, ino);
    }
    panic("sfs_block_inuse: called out of range (0, %u) %u.\n", sfs->super.blocks, ino);
}

/*
 * sfs_block_alloc -  check and get a free disk block
 */
static int
sfs_block_alloc(struct sfs_fs *sfs, uint32_t *ino_store)
{
    int ret;
    if ((ret = bitmap_alloc(sfs->freemap, ino_store)) != 0)
    {
        return ret;
    }
    assert(sfs->super.unused_blocks > 0);
    sfs->super.unused_blocks--, sfs->super_dirty = 1;
    assert(sfs_block_inuse(sfs, *ino_store));
    return sfs_clear_block(sfs, *ino_store, 1);
}

/*
 * sfs_block_free - set related bits for ino block to 1(means free) in bitmap, add sfs->super.unused_blocks, set superblock dirty *
 */
static void
sfs_block_free(struct sfs_fs *sfs, uint32_t ino)
{
    assert(sfs_block_inuse(sfs, ino));
    bitmap_free(sfs->freemap, ino);
    sfs->super.unused_blocks++, sfs->super_dirty = 1;
}

/*
 * sfs_create_inode - alloc a inode in memroy, and init din/ino/dirty/reclian_count/sem fields in sfs_inode in inode
 */
static int
sfs_create_inode(struct sfs_fs *sfs, struct sfs_disk_inode *din, uint32_t ino, struct inode **node_store)
{
    struct inode *node;
    if ((node = alloc_inode(sfs_inode)) != NULL)
    {
        vop_init(node, sfs_get_ops(din->type), info2fs(sfs, sfs));
        struct sfs_inode *sin = vop_info(node, sfs_inode);
        sin->din = din, sin->ino = ino, sin->dirty = 0, sin->reclaim_count = 1;
        sem_init(&(sin->sem), 1);
        *node_store = node;
        return 0;
    }
    return -E_NO_MEM;
}

/*
 * lookup_sfs_nolock - according ino, find related inode
 *
 * NOTICE: le2sin, info2node MACRO
 */
static struct inode *
lookup_sfs_nolock(struct sfs_fs *sfs, uint32_t ino)
{
    struct inode *node;
    list_entry_t *list = sfs_hash_list(sfs, ino), *le = list;
    while ((le = list_next(le)) != list)
    {
        struct sfs_inode *sin = le2sin(le, hash_link);
        if (sin->ino == ino)
        {
            node = info2node(sin, sfs_inode);
            if (vop_ref_inc(node) == 1)
            {
                sin->reclaim_count++;
            }
            return node;
        }
    }
    return NULL;
}

/*
 * sfs_load_inode - If the inode isn't existed, load inode related ino disk block data into a new created inode.
 *                  If the inode is in memory alreadily, then do nothing
 */
int sfs_load_inode(struct sfs_fs *sfs, struct inode **node_store, uint32_t ino)
{
    lock_sfs_fs(sfs);
    struct inode *node;
    if ((node = lookup_sfs_nolock(sfs, ino)) != NULL)
    {
        goto out_unlock;
    }

    int ret = -E_NO_MEM;
    struct sfs_disk_inode *din;
    if ((din = kmalloc(sizeof(struct sfs_disk_inode))) == NULL)
    {
        goto failed_unlock;
    }

    assert(sfs_block_inuse(sfs, ino));
    if ((ret = sfs_rbuf(sfs, din, sizeof(struct sfs_disk_inode), ino, 0)) != 0)
    {
        goto failed_cleanup_din;
    }

    assert(din->nlinks != 0);
    if ((ret = sfs_create_inode(sfs, din, ino, &node)) != 0)
    {
        goto failed_cleanup_din;
    }
    sfs_set_links(sfs, vop_info(node, sfs_inode));

out_unlock:
    unlock_sfs_fs(sfs);
    *node_store = node;
    return 0;

failed_cleanup_din:
    kfree(din);
failed_unlock:
    unlock_sfs_fs(sfs);
    return ret;
}

/*
 * sfs_bmap_get_sub_nolock - according entry pointer entp and index, find the index of indrect disk block
 *                           return the index of indrect disk block to ino_store. no lock protect
 * @sfs:      sfs file system
 * @entp:     the pointer of index of entry disk block
 * @index:    the index of block in indrect block
 * @create:   BOOL, if the block isn't allocated, if create = 1 the alloc a block,  otherwise just do nothing
 * @ino_store: 0 OR the index of already inused block or new allocated block.
 */
static int
sfs_bmap_get_sub_nolock(struct sfs_fs *sfs, uint32_t *entp, uint32_t index, bool create, uint32_t *ino_store)
{
    assert(index < SFS_BLK_NENTRY);
    int ret;
    uint32_t ent, ino = 0;
    off_t offset = index * sizeof(uint32_t); // the offset of entry in entry block
                                             // if entry block is existd, read the content of entry block into  sfs->sfs_buffer
    if ((ent = *entp) != 0)
    {
        if ((ret = sfs_rbuf(sfs, &ino, sizeof(uint32_t), ent, offset)) != 0)
        {
            return ret;
        }
        if (ino != 0 || !create)
        {
            goto out;
        }
    }
    else
    {
        if (!create)
        {
            goto out;
        }
        // if entry block isn't existd, allocated a entry block (for indrect block)
        if ((ret = sfs_block_alloc(sfs, &ent)) != 0)
        {
            return ret;
        }
    }

    if ((ret = sfs_block_alloc(sfs, &ino)) != 0)
    {
        goto failed_cleanup;
    }
    if ((ret = sfs_wbuf(sfs, &ino, sizeof(uint32_t), ent, offset)) != 0)
    {
        sfs_block_free(sfs, ino);
        goto failed_cleanup;
    }

out:
    if (ent != *entp)
    {
        *entp = ent;
    }
    *ino_store = ino;
    return 0;

failed_cleanup:
    if (ent != *entp)
    {
        sfs_block_free(sfs, ent);
    }
    return ret;
}

/*
 * sfs_bmap_get_nolock - according sfs_inode and index of block, find the NO. of disk block
 *                       no lock protect
 * @sfs:      sfs file system
 * @sin:      sfs inode in memory
 * @index:    the index of block in inode
 * @create:   BOOL, if the block isn't allocated, if create = 1 the alloc a block,  otherwise just do nothing
 * @ino_store: 0 OR the index of already inused block or new allocated block.
 */
// sfs_bmap_get_nolock 只由 sfs_bmap_load_nolock 调用
static int
sfs_bmap_get_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, uint32_t index, bool create, uint32_t *ino_store)
{
    struct sfs_disk_inode *din = sin->din;
    int ret;
    uint32_t ent, ino;
    // the index of disk block is in the fist SFS_NDIRECT  direct blocks
    if (index < SFS_NDIRECT)
    {
        if ((ino = din->direct[index]) == 0 && create)
        {
            if ((ret = sfs_block_alloc(sfs, &ino)) != 0)
            {
                return ret;
            }
            din->direct[index] = ino;
            sin->dirty = 1;
        }
        goto out;
    }
    // the index of disk block is in the indirect blocks.
    index -= SFS_NDIRECT;
    if (index < SFS_BLK_NENTRY)
    {
        ent = din->indirect;
        if ((ret = sfs_bmap_get_sub_nolock(sfs, &ent, index, create, &ino)) != 0)
        {
            return ret;
        }
        if (ent != din->indirect)
        {
            assert(din->indirect == 0);
            din->indirect = ent;
            sin->dirty = 1;
        }
        goto out;
    }
    else
    {
        panic("sfs_bmap_get_nolock - index out of range");
    }
out:
    assert(ino == 0 || sfs_block_inuse(sfs, ino));
    *ino_store = ino;
    return 0;
}

/*
 * sfs_bmap_free_sub_nolock - set the entry item to 0 (free) in the indirect block
 */
static int
sfs_bmap_free_sub_nolock(struct sfs_fs *sfs, uint32_t ent, uint32_t index)
{
    assert(sfs_block_inuse(sfs, ent) && index < SFS_BLK_NENTRY);
    int ret;
    uint32_t ino, zero = 0;
    off_t offset = index * sizeof(uint32_t);
    if ((ret = sfs_rbuf(sfs, &ino, sizeof(uint32_t), ent, offset)) != 0)
    {
        return ret;
    }
    if (ino != 0)
    {
        if ((ret = sfs_wbuf(sfs, &zero, sizeof(uint32_t), ent, offset)) != 0)
        {
            return ret;
        }
        sfs_block_free(sfs, ino);
    }
    return 0;
}

/*
 * sfs_bmap_free_nolock - free a block with logical index in inode and reset the inode's fields
 */
static int
sfs_bmap_free_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, uint32_t index)
{
    struct sfs_disk_inode *din = sin->din;
    int ret;
    uint32_t ent, ino;
    if (index < SFS_NDIRECT)
    {
        if ((ino = din->direct[index]) != 0)
        {
            // free the block
            sfs_block_free(sfs, ino);
            din->direct[index] = 0;
            sin->dirty = 1;
        }
        return 0;
    }

    index -= SFS_NDIRECT;
    if (index < SFS_BLK_NENTRY)
    {
        if ((ent = din->indirect) != 0)
        {
            // set the entry item to 0 in the indirect block
            if ((ret = sfs_bmap_free_sub_nolock(sfs, ent, index)) != 0)
            {
                return ret;
            }
        }
        return 0;
    }
    return 0;
}

/*
 * sfs_bmap_load_nolock - according to the DIR's inode and the logical index of block in inode, find the NO. of disk block.
 * @sfs:      sfs file system
 * @sin:      sfs inode in memory
 * @index:    the logical index of disk block in inode
 * @ino_store:the NO. of disk block
 */
// 将对应 sfs_inode 的第 index 个索引指向的 block 的索引值取出存到相应的指针指向的单元（ino_store）
// 注意，这些后缀为 nolock 的函数，只能在已经获得相应 inode 的 semaphore 才能调用
static int
sfs_bmap_load_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, uint32_t index, uint32_t *ino_store)
{
    struct sfs_disk_inode *din = sin->din;
    // 该函数只接受 index <= inode->blocks 的参数
    assert(index <= din->blocks);
    int ret;
    uint32_t ino;
    // 当 index == inode->blocks 时，该函数理解为需要为 inode 增长一个 block。并标记 inode 为 dirty（所有对 inode 数据的修改都要做这样的操作，这样，当 inode 不再使用的时候，sfs 能够保证 inode 数据能够被写回到磁盘）
    bool create = (index == din->blocks);
    // sfs_bmap_load_nolock 调用的 sfs_bmap_get_nolock 来完成相应的操作
    if ((ret = sfs_bmap_get_nolock(sfs, sin, index, create, &ino)) != 0)
    {
        return ret;
    }
    assert(sfs_block_inuse(sfs, ino));
    if (create)
    {
        din->blocks++;
    }
    if (ino_store != NULL)
    {
        *ino_store = ino;
    }
    return 0;
}

/*
 * sfs_bmap_truncate_nolock - free the disk block at the end of file
 */
// 将多级数据索引表的最后一个 entry 释放掉
// 他可以认为是 sfs_bmap_load_nolock 中，index == inode->blocks 的逆操作。当一个文件或目录被删除时，sfs 会循环调用该函数直到 inode->blocks 减为 0，释放所有的数据页
static int
sfs_bmap_truncate_nolock(struct sfs_fs *sfs, struct sfs_inode *sin)
{
    struct sfs_disk_inode *din = sin->din;
    assert(din->blocks != 0);
    int ret;
    // 函数通过 sfs_bmap_free_nolock 来实现，他应该是 sfs_bmap_get_nolock 的逆操作。和 sfs_bmap_get_nolock 一样，调用 sfs_bmap_free_nolock 也要格外小心
    if ((ret = sfs_bmap_free_nolock(sfs, sin, din->blocks - 1)) != 0)
    {
        return ret;
    }
    din->blocks--;
    sin->dirty = 1;
    return 0;
}

/*
 * sfs_dirent_read_nolock - read the file entry from disk block which contains this entry
 * @sfs:      sfs file system
 * @sin:      sfs inode in memory
 * @slot:     the index of file entry
 * @entry:    file entry
 */
// 将目录的第 slot 个 entry 读取到指定的内存空间。他通过上面提到的函数来完成
static int
sfs_dirent_read_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, int slot, struct sfs_disk_entry *entry)
{
    assert(sin->din->type == SFS_TYPE_DIR && (slot >= 0 && slot < sin->din->blocks));
    int ret;
    uint32_t ino;
    // according to the DIR's inode and the slot of file entry, find the index of disk block which contains this file entry
    if ((ret = sfs_bmap_load_nolock(sfs, sin, slot, &ino)) != 0)
    {
        return ret;
    }
    assert(sfs_block_inuse(sfs, ino));
    // read the content of file entry in the disk block
    if ((ret = sfs_rbuf(sfs, entry, sizeof(struct sfs_disk_entry), ino, 0)) != 0)
    {
        return ret;
    }
    entry->name[SFS_MAX_FNAME_LEN] = '\0';
    return 0;
}

#define sfs_dirent_link_nolock_check(sfs, sin, slot, lnksin, name)             \
    do                                                                         \
    {                                                                          \
        int err;                                                               \
        if ((err = sfs_dirent_link_nolock(sfs, sin, slot, lnksin, name)) != 0) \
        {                                                                      \
            warn("sfs_dirent_link error: %e.\n", err);                         \
        }                                                                      \
    } while (0)

#define sfs_dirent_unlink_nolock_check(sfs, sin, slot, lnksin)             \
    do                                                                     \
    {                                                                      \
        int err;                                                           \
        if ((err = sfs_dirent_unlink_nolock(sfs, sin, slot, lnksin)) != 0) \
        {                                                                  \
            warn("sfs_dirent_unlink error: %e.\n", err);                   \
        }                                                                  \
    } while (0)

/*
 * sfs_dirent_search_nolock - read every file entry in the DIR, compare file name with each entry->name
 *                            If equal, then return slot and NO. of disk of this file's inode
 * @sfs:        sfs file system
 * @sin:        sfs inode in memory
 * @name:       the filename
 * @ino_store:  NO. of disk of this file (with the filename)'s inode
 * @slot:       logical index of file entry (NOTICE: each file entry ocupied one  disk block)
 * @empty_slot: the empty logical index of file entry.
 */
// 是常用的查找函数
// 他在目录下查找 name，并且返回相应的搜索结果（文件或文件夹）的 inode 的编号（也是磁盘编号），和相应的 entry 在该目录的 index 编号以及目录下的数据页是否有空闲的 entry
static int
sfs_dirent_search_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, const char *name, uint32_t *ino_store, int *slot, int *empty_slot)
{
    assert(strlen(name) <= SFS_MAX_FNAME_LEN);
    struct sfs_disk_entry *entry;
    if ((entry = kmalloc(sizeof(struct sfs_disk_entry))) == NULL)
    {
        return -E_NO_MEM;
    }

#define set_pvalue(x, v) \
    do                   \
    {                    \
        if ((x) != NULL) \
        {                \
            *(x) = (v);  \
        }                \
    } while (0)
    int ret, i, nslots = sin->din->blocks;
    set_pvalue(empty_slot, nslots);
    for (i = 0; i < nslots; i++)
    {
        if ((ret = sfs_dirent_read_nolock(sfs, sin, i, entry)) != 0)
        {
            goto out;
        }
        // SFS 实现里文件的数据页是连续的，不存在任何空洞；而对于目录，数据页不是连续的，当某个 entry 删除的时候，SFS 通过设置 entry->ino 为 0 将该 entry 所在的 block 标记为 free，在需要添加新 entry 的时候，SFS 优先使用这些 free 的 entry，其次才会去在数据页尾追加新的 entry
        if (entry->ino == 0)
        {
            set_pvalue(empty_slot, i);
            continue;
        }
        if (strcmp(name, entry->name) == 0)
        {
            set_pvalue(slot, i);
            set_pvalue(ino_store, entry->ino);
            goto out;
        }
    }
#undef set_pvalue
    ret = -E_NOENT;
out:
    kfree(entry);
    return ret;
}

/*
 * sfs_dirent_findino_nolock - read all file entries in DIR's inode and find a entry->ino == ino
 */

static int
sfs_dirent_findino_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, uint32_t ino, struct sfs_disk_entry *entry)
{
    int ret, i, nslots = sin->din->blocks;
    for (i = 0; i < nslots; i++)
    {
        if ((ret = sfs_dirent_read_nolock(sfs, sin, i, entry)) != 0)
        {
            return ret;
        }
        if (entry->ino == ino)
        {
            return 0;
        }
    }
    return -E_NOENT;
}

/*
 * sfs_lookup_once - find inode corresponding the file name in DIR's sin inode
 * @sfs:        sfs file system
 * @sin:        DIR sfs inode in memory
 * @name:       the file name in DIR
 * @node_store: the inode corresponding the file name in DIR
 * @slot:       the logical index of file entry
 */
static int
sfs_lookup_once(struct sfs_fs *sfs, struct sfs_inode *sin, const char *name, struct inode **node_store, int *slot)
{
    int ret;
    uint32_t ino;
    lock_sin(sin);
    { // find the NO. of disk block and logical index of file entry
        // 调用sfs_dirent_search_nolock函数来查找与路径名匹配的目录项
        ret = sfs_dirent_search_nolock(sfs, sin, name, &ino, slot, NULL);
    }
    unlock_sin(sin);
    if (ret == 0)
    {
        // load the content of inode with the the NO. of disk block
        // 如果找到目录项，则根据目录项中记录的inode所处的数据块索引值找到路径名对应的SFS磁盘inode，并读入SFS磁盘inode对的内容，创建SFS内存inode
        ret = sfs_load_inode(sfs, node_store, ino);
    }
    return ret;
}

// sfs_opendir - just check the opne_flags, now support readonly
static int
sfs_opendir(struct inode *node, uint32_t open_flags)
{
    switch (open_flags & O_ACCMODE)
    {
    case O_RDONLY:
        break;
    case O_WRONLY:
    case O_RDWR:
    default:
        return -E_ISDIR;
    }
    if (open_flags & O_APPEND)
    {
        return -E_ISDIR;
    }
    return 0;
}

// sfs_openfile - open file (no use)
static int
sfs_openfile(struct inode *node, uint32_t open_flags)
{
    return 0;
}

// sfs_close - close file
static int
sfs_close(struct inode *node)
{
    return vop_fsync(node);
}

/*
 * sfs_io_nolock - Rd/Wr a file contentfrom offset position to offset+ length  disk blocks<-->buffer (in memroy)
 * @sfs:      sfs file system
 * @sin:      sfs inode in memory
 * @buf:      the buffer Rd/Wr
 * @offset:   the offset of file
 * @alenp:    the length need to read (is a pointer). and will RETURN the really Rd/Wr lenght
 * @write:    BOOL, 0 read, 1 write
 */
/*
 * 在sfs_io_nolock函数中完成操作如下：
 * (1) 先计算一些辅助变量，并处理一些特殊情况（比如越界），然后有sfs_buf_op = sfs_rbuf,sfs_block_op = sfs_rblock，设置读取的函数操作
 * (2) 接着进行实际操作，先处理起始的没有对齐到块的部分，再以块为单位循环处理中间的部分，最后处理末尾剩余的部分
 * (3) 每部分中都调用sfs_bmap_load_nolock函数得到blkno对应的inode编号，并调用sfs_rbuf或sfs_rblock函数读取数据（中间部分调用sfs_rblock，起始和末尾部分调用sfs_rbuf），调整相关变量
 * (4) 完成后如果offset + alen > din->fileinfo.size（写文件时会出现这种情况，读文件时不会出现这种情况，alen为实际读写的长度），则调整文件大小为offset + alen并设置dirty变量
 */
static int
sfs_io_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, void *buf, off_t offset, size_t *alenp, bool write)
{
    // 先计算一些辅助变量，并处理一些特殊情况（比如越界）
    struct sfs_disk_inode *din = sin->din;
    assert(din->type != SFS_TYPE_DIR);
    off_t endpos = offset + *alenp, blkoff;
    *alenp = 0;
    // calculate the Rd/Wr end position
    if (offset < 0 || offset >= SFS_MAX_FILE_SIZE || offset > endpos)
    {
        return -E_INVAL;
    }
    if (offset == endpos)
    {
        return 0;
    }
    if (endpos > SFS_MAX_FILE_SIZE)
    {
        endpos = SFS_MAX_FILE_SIZE;
    }
    if (!write)
    {
        if (offset >= din->size)
        {
            return 0;
        }
        if (endpos > din->size)
        {
            endpos = din->size;
        }
    }

    int (*sfs_buf_op)(struct sfs_fs *sfs, void *buf, size_t len, uint32_t blkno, off_t offset);
    int (*sfs_block_op)(struct sfs_fs *sfs, void *buf, uint32_t blkno, uint32_t nblks);
    // 设置读取的函数操作
    if (write)
    {
        sfs_buf_op = sfs_wbuf, sfs_block_op = sfs_wblock;
    }
    else
    {
        sfs_buf_op = sfs_rbuf, sfs_block_op = sfs_rblock;
    }

    int ret = 0;
    size_t size, alen = 0;
    uint32_t ino;
    uint32_t blkno = offset / SFS_BLKSIZE;         // The NO. of Rd/Wr begin block
    uint32_t nblks = endpos / SFS_BLKSIZE - blkno; // The size of Rd/Wr blocks

    // LAB8:EXERCISE1 YOUR CODE HINT: call sfs_bmap_load_nolock, sfs_rbuf, sfs_rblock,etc. read different kind of blocks in file
    /*
     * (1) If offset isn't aligned with the first block, Rd/Wr some content from offset to the end of the first block
     *       NOTICE: useful function: sfs_bmap_load_nolock, sfs_buf_op
     *               Rd/Wr size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset)
     * (2) Rd/Wr aligned blocks
     *       NOTICE: useful function: sfs_bmap_load_nolock, sfs_block_op
     * (3) If end position isn't aligned with the last block, Rd/Wr some content from begin to the (endpos % SFS_BLKSIZE) of the last block
     *       NOTICE: useful function: sfs_bmap_load_nolock, sfs_buf_op
     */

    // 接着进行实际操作，先处理起始的没有对齐到块的部分，再以块为单位循环处理中间的部分，最后处理末尾剩余的部分
    // 每部分中都调用sfs_bmap_load_nolock函数得到blkno对应的inode编号，并调用sfs_rbuf或sfs_rblock函数读取数据（中间部分调用sfs_rblock，起始和末尾部分调用sfs_rbuf），调整相关变量
    if ((blkoff = offset % SFS_BLKSIZE) != 0)
    {
        size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0)
        {
            goto out;
        }
        // sfs_rbuf和sfs_rblock函数最终都调用sfs_rwblock_nolock函数完成操作，而sfs_rwblock_nolock函数调用dop_io->disk0_io->disk0_read_blks_nolock->ide_read_secs完成对磁盘的操作
        if ((ret = sfs_buf_op(sfs, buf, size, ino, blkoff)) != 0)
        {
            goto out;
        }

        alen += size;
        buf += size;

        if (nblks == 0)
        {
            goto out;
        }

        blkno++;
        nblks--;
    }

    if (nblks > 0)
    {
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0)
        {
            goto out;
        }
        if ((ret = sfs_block_op(sfs, buf, ino, nblks)) != 0)
        {
            goto out;
        }

        alen += nblks * SFS_BLKSIZE;
        buf += nblks * SFS_BLKSIZE;
        blkno += nblks;
        nblks -= nblks;
    }

    if ((size = endpos % SFS_BLKSIZE) != 0)
    {
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0)
        {
            goto out;
        }
        if ((ret = sfs_buf_op(sfs, buf, size, ino, 0)) != 0)
        {
            goto out;
        }
        alen += size;
    }

out:
    *alenp = alen;
    // 完成后如果offset + alen > din->fileinfo.size（写文件时会出现这种情况，读文件时不会出现这种情况，alen为实际读写的长度），则调整文件大小为offset + alen并设置dirty变量
    if (offset + alen > sin->din->size)
    {
        sin->din->size = offset + alen;
        sin->dirty = 1;
    }
    return ret;
}

/*
 * sfs_io - Rd/Wr file. the wrapper of sfs_io_nolock
            with lock protect
 */
static inline int
sfs_io(struct inode *node, struct iobuf *iob, bool write)
{
    // 函数先找到inode对应sfs和sin
    struct sfs_fs *sfs = fsop_info(vop_fs(node), sfs);
    struct sfs_inode *sin = vop_info(node, sfs_inode);
    int ret;
    lock_sin(sin);
    {
        size_t alen = iob->io_resid;
        // 然后调用sfs_io_nolock函数进行读取文件操作
        ret = sfs_io_nolock(sfs, sin, iob->io_base, iob->io_offset, &alen, write);
        if (alen != 0)
        {
            // 最后调用iobuf_skip函数调整iobuf的指针
            iobuf_skip(iob, alen);
        }
    }
    unlock_sin(sin);
    return ret;
}

// sfs_read - read file
/* SFS文件系统层的处理流程
 */
static int
sfs_read(struct inode *node, struct iobuf *iob)
{
    // sfs_read函数调用sfs_io函数
    // 它有三个参数，node是对应文件的inode，iob是缓存，write表示是读还是写的布尔值（0表示读，1表示写），这里是0
    // 函数先找到inode对应sfs和sin，然后调用sfs_io_nolock函数进行读取文件操作，最后调用iobuf_skip函数调整iobuf的指针
    return sfs_io(node, iob, 0);
}

// sfs_write - write file
static int
sfs_write(struct inode *node, struct iobuf *iob)
{
    return sfs_io(node, iob, 1);
}

/*
 * sfs_fstat - Return nlinks/block/size, etc. info about a file. The pointer is a pointer to struct stat;
 */
static int
sfs_fstat(struct inode *node, struct stat *stat)
{
    int ret;
    memset(stat, 0, sizeof(struct stat));
    if ((ret = vop_gettype(node, &(stat->st_mode))) != 0)
    {
        return ret;
    }
    struct sfs_disk_inode *din = vop_info(node, sfs_inode)->din;
    stat->st_nlinks = din->nlinks;
    stat->st_blocks = din->blocks;
    stat->st_size = din->size;
    return 0;
}

/*
 * sfs_fsync - Force any dirty inode info associated with this file to stable storage.
 */
static int
sfs_fsync(struct inode *node)
{
    struct sfs_fs *sfs = fsop_info(vop_fs(node), sfs);
    struct sfs_inode *sin = vop_info(node, sfs_inode);
    int ret = 0;
    if (sin->dirty)
    {
        lock_sin(sin);
        {
            if (sin->dirty)
            {
                sin->dirty = 0;
                if ((ret = sfs_wbuf(sfs, sin->din, sizeof(struct sfs_disk_inode), sin->ino, 0)) != 0)
                {
                    sin->dirty = 1;
                }
            }
        }
        unlock_sin(sin);
    }
    return ret;
}

/*
 *sfs_namefile -Compute pathname relative to filesystem root of the file and copy to the specified io buffer.
 *
 */
static int
sfs_namefile(struct inode *node, struct iobuf *iob)
{
    struct sfs_disk_entry *entry;
    if (iob->io_resid <= 2 || (entry = kmalloc(sizeof(struct sfs_disk_entry))) == NULL)
    {
        return -E_NO_MEM;
    }

    struct sfs_fs *sfs = fsop_info(vop_fs(node), sfs);
    struct sfs_inode *sin = vop_info(node, sfs_inode);

    int ret;
    char *ptr = iob->io_base + iob->io_resid;
    size_t alen, resid = iob->io_resid - 2;
    vop_ref_inc(node);
    while (1)
    {
        struct inode *parent;
        if ((ret = sfs_lookup_once(sfs, sin, "..", &parent, NULL)) != 0)
        {
            goto failed;
        }

        uint32_t ino = sin->ino;
        vop_ref_dec(node);
        if (node == parent)
        {
            vop_ref_dec(node);
            break;
        }

        node = parent, sin = vop_info(node, sfs_inode);
        assert(ino != sin->ino && sin->din->type == SFS_TYPE_DIR);

        lock_sin(sin);
        {
            ret = sfs_dirent_findino_nolock(sfs, sin, ino, entry);
        }
        unlock_sin(sin);

        if (ret != 0)
        {
            goto failed;
        }

        if ((alen = strlen(entry->name) + 1) > resid)
        {
            goto failed_nomem;
        }
        resid -= alen, ptr -= alen;
        memcpy(ptr, entry->name, alen - 1);
        ptr[alen - 1] = '/';
    }
    alen = iob->io_resid - resid - 2;
    ptr = memmove(iob->io_base + 1, ptr, alen);
    ptr[-1] = '/', ptr[alen] = '\0';
    iobuf_skip(iob, alen);
    kfree(entry);
    return 0;

failed_nomem:
    ret = -E_NO_MEM;
failed:
    vop_ref_dec(node);
    kfree(entry);
    return ret;
}

/*
 * sfs_getdirentry_sub_noblock - get the content of file entry in DIR
 */
static int
sfs_getdirentry_sub_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, int slot, struct sfs_disk_entry *entry)
{
    int ret, i, nslots = sin->din->blocks;
    for (i = 0; i < nslots; i++)
    {
        if ((ret = sfs_dirent_read_nolock(sfs, sin, i, entry)) != 0)
        {
            return ret;
        }
        if (entry->ino != 0)
        {
            if (slot == 0)
            {
                return 0;
            }
            slot--;
        }
    }
    return -E_NOENT;
}

/*
 * sfs_getdirentry - according to the iob->io_offset, calculate the dir entry's slot in disk block,
                     get dir entry content from the disk
 */
static int
sfs_getdirentry(struct inode *node, struct iobuf *iob)
{
    struct sfs_disk_entry *entry;
    if ((entry = kmalloc(sizeof(struct sfs_disk_entry))) == NULL)
    {
        return -E_NO_MEM;
    }

    struct sfs_fs *sfs = fsop_info(vop_fs(node), sfs);
    struct sfs_inode *sin = vop_info(node, sfs_inode);

    int ret, slot;
    off_t offset = iob->io_offset;
    if (offset < 0 || offset % sfs_dentry_size != 0)
    {
        kfree(entry);
        return -E_INVAL;
    }
    if ((slot = offset / sfs_dentry_size) > sin->din->blocks)
    {
        kfree(entry);
        return -E_NOENT;
    }
    lock_sin(sin);
    if ((ret = sfs_getdirentry_sub_nolock(sfs, sin, slot, entry)) != 0)
    {
        unlock_sin(sin);
        goto out;
    }
    unlock_sin(sin);
    ret = iobuf_move(iob, entry->name, sfs_dentry_size, 1, NULL);
out:
    kfree(entry);
    return ret;
}

/*
 * sfs_reclaim - Free all resources inode occupied . Called when inode is no longer in use.
 */
static int
sfs_reclaim(struct inode *node)
{
    struct sfs_fs *sfs = fsop_info(vop_fs(node), sfs);
    struct sfs_inode *sin = vop_info(node, sfs_inode);

    int ret = -E_BUSY;
    uint32_t ent;
    lock_sfs_fs(sfs);
    assert(sin->reclaim_count > 0);
    if ((--sin->reclaim_count) != 0 || inode_ref_count(node) != 0)
    {
        goto failed_unlock;
    }
    if (sin->din->nlinks == 0)
    {
        if ((ret = vop_truncate(node, 0)) != 0)
        {
            goto failed_unlock;
        }
    }
    if (sin->dirty)
    {
        if ((ret = vop_fsync(node)) != 0)
        {
            goto failed_unlock;
        }
    }
    sfs_remove_links(sin);
    unlock_sfs_fs(sfs);

    if (sin->din->nlinks == 0)
    {
        sfs_block_free(sfs, sin->ino);
        if ((ent = sin->din->indirect) != 0)
        {
            sfs_block_free(sfs, ent);
        }
    }
    kfree(sin->din);
    vop_kill(node);
    return 0;

failed_unlock:
    unlock_sfs_fs(sfs);
    return ret;
}

/*
 * sfs_gettype - Return type of file. The values for file types are in sfs.h.
 */
static int
sfs_gettype(struct inode *node, uint32_t *type_store)
{
    struct sfs_disk_inode *din = vop_info(node, sfs_inode)->din;
    switch (din->type)
    {
    case SFS_TYPE_DIR:
        *type_store = S_IFDIR;
        return 0;
    case SFS_TYPE_FILE:
        *type_store = S_IFREG;
        return 0;
    case SFS_TYPE_LINK:
        *type_store = S_IFLNK;
        return 0;
    }
    panic("invalid file type %d.\n", din->type);
}

/*
 * sfs_tryseek - Check if seeking to the specified position within the file is legal.
 */
static int
sfs_tryseek(struct inode *node, off_t pos)
{
    if (pos < 0 || pos >= SFS_MAX_FILE_SIZE)
    {
        return -E_INVAL;
    }
    struct sfs_inode *sin = vop_info(node, sfs_inode);
    if (pos > sin->din->size)
    {
        return vop_truncate(node, pos);
    }
    return 0;
}

/*
 * sfs_truncfile : reszie the file with new length
 */
static int
sfs_truncfile(struct inode *node, off_t len)
{
    if (len < 0 || len > SFS_MAX_FILE_SIZE)
    {
        return -E_INVAL;
    }
    struct sfs_fs *sfs = fsop_info(vop_fs(node), sfs);
    struct sfs_inode *sin = vop_info(node, sfs_inode);
    struct sfs_disk_inode *din = sin->din;

    int ret = 0;
    // new number of disk blocks of file
    uint32_t nblks, tblks = ROUNDUP_DIV(len, SFS_BLKSIZE);
    if (din->size == len)
    {
        assert(tblks == din->blocks);
        return 0;
    }

    lock_sin(sin);
    // old number of disk blocks of file
    nblks = din->blocks;
    if (nblks < tblks)
    {
        // try to enlarge the file size by add new disk block at the end of file
        while (nblks != tblks)
        {
            if ((ret = sfs_bmap_load_nolock(sfs, sin, nblks, NULL)) != 0)
            {
                goto out_unlock;
            }
            nblks++;
        }
    }
    else if (tblks < nblks)
    {
        // try to reduce the file size
        while (tblks != nblks)
        {
            if ((ret = sfs_bmap_truncate_nolock(sfs, sin)) != 0)
            {
                goto out_unlock;
            }
            nblks--;
        }
    }
    assert(din->blocks == tblks);
    din->size = len;
    sin->dirty = 1;

out_unlock:
    unlock_sin(sin);
    return ret;
}

/*
 * sfs_lookup - Parse path relative to the passed directory
 *              DIR, and hand back the inode for the file it
 *              refers to.
 */
// 这里需要分析文件系统抽象层中没有彻底分析的vop_lookup函数到底做了啥。下面我们来看看。在sfs_inode.c中的sfs_node_dirops变量定义了“.vop_lookup = sfs_lookup”，所以我们重点分析sfs_lookup的实现。注意：在lab8中，为简化代码，sfs_lookup函数中并没有实现能够对多级目录进行查找的控制逻辑（在ucore_plus中有实现）
// sfs_lookup有三个参数：node，path，node_store。其中node是根目录“/”所对应的inode节点；path是文件sfs_filetest1的绝对路径/sfs_filetest1，而node_store是经过查找获得的sfs_filetest1所对应的inode节点
static int
sfs_lookup(struct inode *node, char *path, struct inode **node_store)
{
    // sfs_lookup函数以“/”为分割符，从左至右逐一分解path获得各个子目录和最终文件对应的inode节点。在本例中是调用sfs_lookup_once查找以根目录下的文件sfs_filetest1所对应的inode节点。当无法分解path后，就意味着找到了sfs_filetest1对应的inode节点，就可顺利返回了
    struct sfs_fs *sfs = fsop_info(vop_fs(node), sfs);
    assert(*path != '\0' && *path != '/');
    vop_ref_inc(node);
    struct sfs_inode *sin = vop_info(node, sfs_inode);
    if (sin->din->type != SFS_TYPE_DIR)
    {
        vop_ref_dec(node);
        return -E_NOTDIR;
    }
    struct inode *subnode;
    int ret = sfs_lookup_once(sfs, sin, path, &subnode, NULL);

    vop_ref_dec(node);
    if (ret != 0)
    {
        return ret;
    }
    *node_store = subnode;
    return 0;
}

// The sfs specific DIR operations correspond to the abstract operations on a inode.
// 目录操作
// 对于目录操作而言，由于目录也是一种文件，所以 sfs_opendir、sys_close 对应户进程发出的 open、close 函数
// 相对于 sfs_open，sfs_opendir 只是完成一些 open 函数传递的参数判断，没做其他更多的事情。目录的 close 操作与文件的 close 操作完全一致。由于目录的内容数据与文件的内容数据不同，所以读出目录的内容数据的函数是 sfs_getdirentry()，其主要工作是获取目录下的文件 inode 信息
// 这里用到的inode_ops结构体，在kern/fs/vfs/inode.h定义，作用是：把关于inode的操作接口，集中在一个结构体里，通过这个结构体，我们可以把Simple File System的接口（如sfs_openfile())提供给上层的VFS使用。可以想象我们除了Simple File System, 还在另一块磁盘上使用完全不同的文件系统Complex File System，显然vop_open(),vop_read()这些接口的实现都要不一样了。对于同一个文件系统这些接口都是一样的，所以我们可以提供”属于SFS的文件的inode_ops结构体", “属于CFS的文件的inode_ops结构体"
// 要获得更加详细的解释的话，参见kern/fs/vfs/inode.h中间的一大坨注释
static const struct inode_ops sfs_node_dirops = {
    .vop_magic = VOP_MAGIC,
    .vop_open = sfs_opendir,
    .vop_close = sfs_close,
    .vop_fstat = sfs_fstat,
    .vop_fsync = sfs_fsync,
    .vop_namefile = sfs_namefile,
    .vop_getdirentry = sfs_getdirentry,
    .vop_reclaim = sfs_reclaim,
    .vop_gettype = sfs_gettype,
    .vop_lookup = sfs_lookup,
};
/// The sfs specific FILE operations correspond to the abstract operations on a inode.
// 文件操作
// sfs_openfile、sfs_close、sfs_read 和 sfs_write 分别对应用户进程发出的 open、close、read、write 操作
// 其中 sfs_openfile 不用做什么事；sfs_close 需要把对文件的修改内容写回到硬盘上，这样确保硬盘上的文件内容数据是最新的；sfs_read 和 sfs_write 函数都调用了一个函数 sfs_io，并最终通过访问硬盘驱动来完成对文件内容数据的读写
static const struct inode_ops sfs_node_fileops = {
    .vop_magic = VOP_MAGIC,
    .vop_open = sfs_openfile,
    .vop_close = sfs_close,
    .vop_read = sfs_read,
    .vop_write = sfs_write,
    .vop_fstat = sfs_fstat,
    .vop_fsync = sfs_fsync,
    .vop_reclaim = sfs_reclaim,
    .vop_gettype = sfs_gettype,
    .vop_tryseek = sfs_tryseek,
    .vop_truncate = sfs_truncfile,
};
