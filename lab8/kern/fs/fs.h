#ifndef __KERN_FS_FS_H__
#define __KERN_FS_FS_H__

#include <defs.h>
#include <mmu.h>
#include <sem.h>
#include <atomic.h>

#define SECTSIZE 512
#define PAGE_NSECT (PGSIZE / SECTSIZE)

#define SWAP_DEV_NO 1
#define DISK0_DEV_NO 2
#define DISK1_DEV_NO 3

void fs_init(void);
void fs_cleanup(void);

struct inode;
struct file;

/*
 * process's file related informaction
 */
// 在 kern/process/proc.h中的 proc_struct 结构中加入了描述了进程访问文件的数据接口 files_struct
// 当创建一个进程后，该进程的 files_struct 将会被初始化或复制父进程的 files_struct。当用户进程打开一个文件时，将从 fd_array 数组中取得一个空闲 file 项，然后会把此 file 的成员变量 node 指针指向一个代表此文件的 inode 的起始地址
struct files_struct
{
    // 进程当前执行目录的内存inode指针
    struct inode *pwd; // inode of present working directory
    // 进程打开文件的数组
    struct file *fd_array; // opened files array
    // 访问此文件的线程个数
    int files_count; // the number of opened files
    // 确保对进程控制块中fs_struct的互斥访问
    semaphore_t files_sem; // lock protect sem
};

#define FILES_STRUCT_BUFSIZE (PGSIZE - sizeof(struct files_struct))
#define FILES_STRUCT_NENTRY (FILES_STRUCT_BUFSIZE / sizeof(struct file))

void lock_files(struct files_struct *filesp);
void unlock_files(struct files_struct *filesp);

struct files_struct *files_create(void);
void files_destroy(struct files_struct *filesp);
void files_closeall(struct files_struct *filesp);
int dup_files(struct files_struct *to, struct files_struct *from);

static inline int
files_count(struct files_struct *filesp)
{
    return filesp->files_count;
}

static inline int
files_count_inc(struct files_struct *filesp)
{
    filesp->files_count += 1;
    return filesp->files_count;
}

static inline int
files_count_dec(struct files_struct *filesp)
{
    filesp->files_count -= 1;
    return filesp->files_count;
}

#endif /* !__KERN_FS_FS_H__ */
