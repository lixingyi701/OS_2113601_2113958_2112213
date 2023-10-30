#include <swap.h>
#include <swapfs.h>
#include <mmu.h>
#include <fs.h>
#include <ide.h>
#include <pmm.h>
#include <assert.h>

void swapfs_init(void)
{                                            // 做一些检查
    static_assert((PGSIZE % SECTSIZE) == 0); // 静态断言是在编译时进行的断言检查
    if (!ide_device_valid(SWAP_DEV_NO))      // 检查交换设备的有效性
    {
        panic("swap fs isn't available.\n");
    }
    // swap.c/swap.h里的全局变量
    // 交换分区的最大偏移量，是常量
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
}

int swapfs_read(swap_entry_t entry, struct Page *page)
{
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
}

int swapfs_write(swap_entry_t entry, struct Page *page)
{
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
}
