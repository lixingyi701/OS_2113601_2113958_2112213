#include <swap.h>
#include <swapfs.h>
#include <swap_fifo.h>
#include <swap_clock.h>
#include <swap_lru.h>
#include <stdio.h>
#include <string.h>
#include <memlayout.h>
#include <pmm.h>
#include <mmu.h>

// the valid vaddr for check is between 0~CHECK_VALID_VADDR-1
#define CHECK_VALID_VIR_PAGE_NUM 5
#define BEING_CHECK_VALID_VADDR 0X1000
#define CHECK_VALID_VADDR (CHECK_VALID_VIR_PAGE_NUM + 1) * 0x1000
// the max number of valid physical page for check
#define CHECK_VALID_PHY_PAGE_NUM 4
// the max access seq number
#define MAX_SEQ_NO 10

static struct swap_manager *sm;
size_t max_swap_offset;

volatile int swap_init_ok = 0;

unsigned int swap_page[CHECK_VALID_VIR_PAGE_NUM];

unsigned int swap_in_seq_no[MAX_SEQ_NO], swap_out_seq_no[MAX_SEQ_NO];

static void check_swap(void);

int swap_init(void)
{
     swapfs_init();

     // Since the IDE is faked, it can only store 7 pages at most to pass the test
     // 实际上max_swap_offset=7
     if (!(7 <= max_swap_offset &&
           max_swap_offset < MAX_SWAP_OFFSET_LIMIT))
     {
          panic("bad max_swap_offset %08x.\n", max_swap_offset);
     }

     sm = &swap_manager_lru;
     int r = sm->init();

     if (r == 0)
     {
          swap_init_ok = 1;
          cprintf("SWAP: manager = %s\n", sm->name);
          check_swap();
     }

     return r;
}

int swap_init_mm(struct mm_struct *mm)
{
     return sm->init_mm(mm);
}

int swap_tick_event(struct mm_struct *mm)
{
     return sm->tick_event(mm);
}

int swap_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
     return sm->map_swappable(mm, addr, page, swap_in);
}

int swap_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
     return sm->set_unswappable(mm, addr);
}

volatile unsigned int swap_out_num = 0;

// swap_out会踢出一页，然后写盘
int swap_out(struct mm_struct *mm, int n, int in_tick)
{
     int i;
     for (i = 0; i != n; ++i)
     {
          uintptr_t v;
          // struct Page **ptr_page=NULL;
          struct Page *page;
          // cprintf("i %d, SWAP: call swap_out_victim\n",i);
          int r = sm->swap_out_victim(mm, &page, in_tick); // 调用页面置换算法的接口
          // r=0表示成功找到了可以换出去的页面
          // 要换出去的物理页面存在page里
          if (r != 0)
          {
               cprintf("i %d, swap_out: call swap_out_victim failed\n", i);
               break;
          }
          // assert(!PageReserved(page));

          // cprintf("SWAP: choose victim page 0x%08x\n", page);

          v = page->pra_vaddr; // 可以获取物理页面对应的虚拟地址
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
          assert((*ptep & PTE_V) != 0);

          // 尝试把要换出的物理页面写到硬盘上的交换区，返回值不为0说明失败了
          if (swapfs_write((page->pra_vaddr / PGSIZE + 1) << 8, page) != 0)
          {
               cprintf("SWAP: failed to save\n");
               // 那还是把它存回去吧
               sm->map_swappable(mm, v, page, 0);
               continue;
          }
          else
          {
               // 成功换出
               cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr / PGSIZE + 1);
               *ptep = (page->pra_vaddr / PGSIZE + 1) << 8;
               free_page(page);
          }

          // 由于页表改变了，需要刷新TLB
          // 思考： swap_in()的时候插入新的页表项之后在哪里刷新了TLB?
          // 实际上是swap_in()返回之后，调用page_insert()时刷新的
          tlb_invalidate(mm->pgdir, v);
     }
     return i;
}

// swap_in会把数据从磁盘读到内存
int swap_in(struct mm_struct *mm, uintptr_t addr, struct Page **ptr_result)
{
     struct Page *result = alloc_page(); // 这里alloc_page()内部可能调用swap_out()
     // 找到对应的一个物理页面
     assert(result != NULL);

     pte_t *ptep = get_pte(mm->pgdir, addr, 0); // 找到/构建对应的页表项
     // cprintf("SWAP: load ptep %x swap entry %d to vaddr 0x%08x, page %x, No %d\n", ptep, (*ptep)>>8, addr, result, (result-pages));

     // 将物理地址映射到虚拟地址是在swap_in()退出之后，调用page_insert()完成的
     int r;
     if ((r = swapfs_read((*ptep), result)) != 0) // 将数据从硬盘读到内存
     {
          assert(r != 0);
     }
     cprintf("swap_in: load disk swap entry %d with swap_page in vadr 0x%x\n", (*ptep) >> 8, addr);
     *ptr_result = result;
     return 0;
}

static inline void
check_content_set(void)
{
     *(unsigned char *)0x1000 = 0x0a;
     assert(pgfault_num == 1);
     *(unsigned char *)0x1010 = 0x0a;
     assert(pgfault_num == 1);
     *(unsigned char *)0x2000 = 0x0b;
     assert(pgfault_num == 2);
     *(unsigned char *)0x2010 = 0x0b;
     assert(pgfault_num == 2);
     *(unsigned char *)0x3000 = 0x0c;
     assert(pgfault_num == 3);
     *(unsigned char *)0x3010 = 0x0c;
     assert(pgfault_num == 3);
     *(unsigned char *)0x4000 = 0x0d;
     assert(pgfault_num == 4);
     *(unsigned char *)0x4010 = 0x0d;
     assert(pgfault_num == 4);
}

static inline int
check_content_access(void)
{
     int ret = sm->check_swap();
     return ret;
}

struct Page *check_rp[CHECK_VALID_PHY_PAGE_NUM];
pte_t *check_ptep[CHECK_VALID_PHY_PAGE_NUM];
unsigned int check_swap_addr[CHECK_VALID_VIR_PAGE_NUM];

extern free_area_t free_area;

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
check_swap(void)
{
     // backup mem env
     int ret, count = 0, total = 0, i;
     list_entry_t *le = &free_list;
     while ((le = list_next(le)) != &free_list)
     {
          struct Page *p = le2page(le, page_link);
          assert(PageProperty(p)); // 空闲
          count++, total += p->property;
     }
     assert(total == nr_free_pages());
     cprintf("BEGIN check_swap: count %d, total %d\n", count, total);

     // now we set the phy pages env
     // 一样，初始化mm然后初始化vma
     struct mm_struct *mm = mm_create();
     assert(mm != NULL);

     extern struct mm_struct *check_mm_struct;
     // 当前没有其他函数使用check_mm_struct
     assert(check_mm_struct == NULL);

     check_mm_struct = mm;

     pde_t *pgdir = mm->pgdir = boot_pgdir;
     assert(pgdir[0] == 0);

     struct vma_struct *vma = vma_create(BEING_CHECK_VALID_VADDR, CHECK_VALID_VADDR, VM_WRITE | VM_READ);
     assert(vma != NULL);

     insert_vma_struct(mm, vma);

     // setup the temp Page Table vaddr 0~4MB
     cprintf("setup Page Table for vaddr 0X1000, so alloc a page\n");
     pte_t *temp_ptep = NULL;
     temp_ptep = get_pte(mm->pgdir, BEING_CHECK_VALID_VADDR, 1);
     assert(temp_ptep != NULL);
     cprintf("setup Page Table vaddr 0~4MB OVER!\n");

     // 准备物理页面
     for (i = 0; i < CHECK_VALID_PHY_PAGE_NUM; i++)
     {
          check_rp[i] = alloc_page();
          assert(check_rp[i] != NULL);
          assert(!PageProperty(check_rp[i])); // 不是空页面了
     }
     list_entry_t free_list_store = free_list;
     list_init(&free_list);
     assert(list_empty(&free_list));

     // assert(alloc_page() == NULL);

     unsigned int nr_free_store = nr_free;
     nr_free = 0;
     for (i = 0; i < CHECK_VALID_PHY_PAGE_NUM; i++)
     {
          free_pages(check_rp[i], 1);
     }
     assert(nr_free == CHECK_VALID_PHY_PAGE_NUM); // nr_free是全局的，free_pages会改变它的值

     cprintf("set up init env for check_swap begin!\n");
     // setup initial vir_page<->phy_page environment for page relpacement algorithm

     pgfault_num = 0;

     // check_content_set函数会进行访存，也就会导致缺页异常
     check_content_set();
     assert(nr_free == 0);
     for (i = 0; i < MAX_SEQ_NO; i++)
          swap_out_seq_no[i] = swap_in_seq_no[i] = -1; // 这两个也是全局变量

     for (i = 0; i < CHECK_VALID_PHY_PAGE_NUM; i++)
     {
          check_ptep[i] = 0;
          check_ptep[i] = get_pte(pgdir, (i + 1) * 0x1000, 0);
          // cprintf("i %d, check_ptep addr %x, value %x\n", i, check_ptep[i], *check_ptep[i]);
          assert(check_ptep[i] != NULL);
          assert(pte2page(*check_ptep[i]) == check_rp[i]);
          assert((*check_ptep[i] & PTE_V));
     }
     cprintf("set up init env for check_swap over!\n");
     // now access the virt pages to test  page relpacement algorithm
     // ! 初始化完成，调用核心测试函数，实际上是swap_manager的成员函数check_swap
     ret = check_content_access();
     assert(ret == 0);

     // 下面都是释放操作了
     // restore kernel mem env
     for (i = 0; i < CHECK_VALID_PHY_PAGE_NUM; i++)
     {
          free_pages(check_rp[i], 1);
     }

     // free_page(pte2page(*temp_ptep));

     mm_destroy(mm);

     nr_free = nr_free_store;
     free_list = free_list_store;

     le = &free_list;
     while ((le = list_next(le)) != &free_list)
     {
          struct Page *p = le2page(le, page_link);
          count--, total -= p->property;
     }
     cprintf("count is %d, total is %d\n", count, total);
     // assert(count == 0);

     cprintf("check_swap() succeeded!\n");
}
