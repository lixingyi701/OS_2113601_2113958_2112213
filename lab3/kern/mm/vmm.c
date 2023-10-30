#include <vmm.h>
#include <sync.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>
#include <error.h>
#include <pmm.h>
#include <riscv.h>
#include <swap.h>

/*
  vmm design include two parts: mm_struct (mm) & vma_struct (vma)
  mm is the memory manager for the set of continuous virtual memory
  area which have the same PDT. vma is a continuous virtual memory area.
  There a linear link list for vma & a redblack link list for vma in mm.
---------------
  mm related functions:
   golbal functions
     struct mm_struct * mm_create(void)
     void mm_destroy(struct mm_struct *mm)
     int do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr)
--------------
  vma related functions:
   global functions
     struct vma_struct * vma_create (uintptr_t vm_start, uintptr_t vm_end,...)
     void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
     struct vma_struct * find_vma(struct mm_struct *mm, uintptr_t addr)
   local functions
     inline void check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
---------------
   check correctness functions
     void check_vmm(void);
     void check_vma_struct(void);
     void check_pgfault(void);
*/

// szx func : print_vma and print_mm
void print_vma(char *name, struct vma_struct *vma)
{
    cprintf("-- %s print_vma --\n", name);
    cprintf("   mm_struct: %p\n", vma->vm_mm);
    cprintf("   vm_start,vm_end: %x,%x\n", vma->vm_start, vma->vm_end);
    cprintf("   vm_flags: %x\n", vma->vm_flags);
    cprintf("   list_entry_t: %p\n", &vma->list_link);
}

void print_mm(char *name, struct mm_struct *mm)
{
    cprintf("-- %s print_mm --\n", name);
    cprintf("   mmap_list: %p\n", &mm->mmap_list);
    cprintf("   map_count: %d\n", mm->map_count);
    list_entry_t *list = &mm->mmap_list;
    for (int i = 0; i < mm->map_count; i++)
    {
        list = list_next(list);
        print_vma(name, le2vma(list, list_link));
    }
}

static void check_vmm(void);
static void check_vma_struct(void);
static void check_pgfault(void);

// mm_create -  alloc a mm_struct & initialize it.
// 类似于构造函数
struct mm_struct *
mm_create(void)
{
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));

    // 初始化成员变量
    if (mm != NULL)
    {
        list_init(&(mm->mmap_list));
        mm->mmap_cache = NULL;
        mm->pgdir = NULL;
        mm->map_count = 0;

        if (swap_init_ok)
            swap_init_mm(mm);
        else
            mm->sm_priv = NULL;
    }
    return mm;
}

// vma_create - alloc a vma_struct & initialize it. (addr range: vm_start~vm_end)
struct vma_struct *
vma_create(uintptr_t vm_start, uintptr_t vm_end, uint_t vm_flags)
{
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));

    // 初始化成员变量
    if (vma != NULL)
    {
        vma->vm_start = vm_start;
        vma->vm_end = vm_end;
        vma->vm_flags = vm_flags;
    }
    return vma;
}

// find_vma - find a vma  (vma->vm_start <= addr < vma_vm_end)
// 根据addr查找vma
// 如果返回NULL，说明查询的虚拟地址不存在/不合法，既不对应内存里的某个页，也不对应硬盘里某个可以换进来的页
struct vma_struct *
find_vma(struct mm_struct *mm, uintptr_t addr)
{
    struct vma_struct *vma = NULL;
    if (mm != NULL)
    {
        // 先看一下mmap_cache这个vma，相当于一个cache的作用
        vma = mm->mmap_cache;
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
        {
            // 如果addr不在mmap_cache里面，那么只有从链表头开始遍历了
            bool found = 0;
            list_entry_t *list = &(mm->mmap_list), *le = list;
            // 找一圈
            while ((le = list_next(le)) != list)
            {
                vma = le2vma(le, list_link);
                // 找到了包含addr的vma，就可以了
                if (vma->vm_start <= addr && addr < vma->vm_end)
                {
                    found = 1;
                    break;
                }
            }
            if (!found)
            {
                vma = NULL;
            }
        }
        // 修改cache
        if (vma != NULL)
        {
            mm->mmap_cache = vma;
        }
    }
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
}

// insert_vma_struct -insert vma in mm's list link
// 把新的vma_struct插入到mm_struct对应的链表
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
    list_entry_t *list = &(mm->mmap_list); // 链表头
    list_entry_t *le_prev = list, *le_next;

    // 保证插入后所有vma_struct按照区间左端点有序排列
    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
        {
            break;
        }
        le_prev = le;
    }

    // le_prev <-> now <-> le_next
    le_next = list_next(le_prev);

    /* check overlap */
    // 虚拟内存块之间不能有重叠
    if (le_prev != list)
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
    }
    if (le_next != list)
    {
        check_vma_overlap(vma, le2vma(le_next, list_link));
    }

    // 设置页表
    vma->vm_mm = mm;
    // 插入
    list_add_after(le_prev, &(vma->list_link));

    // 更新map_count
    mm->map_count++;
}

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
    {
        list_del(le);
        kfree(le2vma(le, list_link), sizeof(struct vma_struct)); // kfree vma
    }
    kfree(mm, sizeof(struct mm_struct)); // kfree mm
    mm = NULL;
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
    check_vmm();
}

// check_vmm - check correctness of vmm
static void
check_vmm(void)
{
    size_t nr_free_pages_store = nr_free_pages();
    check_vma_struct();
    check_pgfault();

    nr_free_pages_store--; // szx : Sv39三级页表多占一个内存页，所以执行此操作
    assert(nr_free_pages_store == nr_free_pages());

    cprintf("check_vmm() succeeded.\n");
}

static void
check_vma_struct(void)
{
    size_t nr_free_pages_store = nr_free_pages();

    // 创建mm
    struct mm_struct *mm = mm_create();
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    // 申请内存空间vma，然后插入到mm中
    int i;
    // 1-step1倒序
    for (i = step1; i >= 1; i--)
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
    }

    // step1-step2顺序
    for (i = step1 + 1; i <= step2; i++)
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    // 现在能够按顺序查到
    for (i = 1; i <= step2; i++)
    {
        assert(le != &(mm->mmap_list));
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
        le = list_next(le);
    }

    // 也能find到
    for (i = 5; i <= 5 * step2; i += 5)
    {
        struct vma_struct *vma1 = find_vma(mm, i);
        assert(vma1 != NULL);
        struct vma_struct *vma2 = find_vma(mm, i + 1);
        assert(vma2 != NULL);
        struct vma_struct *vma3 = find_vma(mm, i + 2);
        assert(vma3 == NULL);
        struct vma_struct *vma4 = find_vma(mm, i + 3);
        assert(vma4 == NULL);
        struct vma_struct *vma5 = find_vma(mm, i + 4);
        assert(vma5 == NULL);

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
    }

    // 由于之前都是5i，所以小于5的应该都查不到
    for (i = 4; i >= 0; i--)
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
        if (vma_below_5 != NULL)
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
        }
        assert(vma_below_5 == NULL);
    }

    mm_destroy(mm);

    // 结束
    assert(nr_free_pages_store == nr_free_pages());

    cprintf("check_vma_struct() succeeded!\n");
}

struct mm_struct *check_mm_struct;

// check_pgfault - check correctness of pgfault handler
static void
check_pgfault(void)
{
    // char *name = "check_pgfault";
    size_t nr_free_pages_store = nr_free_pages();

    // 创建mm
    check_mm_struct = mm_create();

    assert(check_mm_struct != NULL);
    struct mm_struct *mm = check_mm_struct;
    pde_t *pgdir = mm->pgdir = boot_pgdir; // boot_pgdir在pmm.c pmm_init()中初始化为boot_page_table_sv39（entry.S中定义）
    assert(pgdir[0] == 0);

    // 创建vma
    struct vma_struct *vma = vma_create(0, PTSIZE, VM_WRITE);

    assert(vma != NULL);

    // vma插入mm
    insert_vma_struct(mm, vma);

    uintptr_t addr = 0x100;
    assert(find_vma(mm, addr) == vma);

    // 将100个字节写入地址0x100处，又挨个读出
    int i, sum = 0;
    for (i = 0; i < 100; i++)
    {
        // ! 第一次到这里的时候产生缺页异常
        *(char *)(addr + i) = i;
        sum += i;
    }
    for (i = 0; i < 100; i++)
    {
        sum -= *(char *)(addr + i);
    }
    assert(sum == 0);

    page_remove(pgdir, ROUNDDOWN(addr, PGSIZE));

    // 把这一个pde对应的页释放掉
    free_page(pde2page(pgdir[0]));

    pgdir[0] = 0;

    mm->pgdir = NULL;
    mm_destroy(mm);

    check_mm_struct = NULL;
    nr_free_pages_store--; // szx : Sv39第二级页表多占了一个内存页，所以执行此操作

    // 刚刚会多分配一个二级页表，所以这里空闲页数变少了1页
    assert(nr_free_pages_store == nr_free_pages());

    cprintf("check_pgfault() succeeded!\n");
}
// page fault number
volatile unsigned int pgfault_num = 0;

/* do_pgfault - interrupt handler to process the page fault execption
 * @mm         : the control struct for a set of vma using the same PDT
 * @error_code : the error code recorded in trapframe->tf_err which is setted by x86 hardware
 * @addr       : the addr which causes a memory access exception, (the contents of the CR2 register)
 *
 * CALL GRAPH: trap--> trap_dispatch-->pgfault_handler-->do_pgfault
 * The processor provides ucore's do_pgfault function with two items of information to aid in diagnosing
 * the exception and recovering from it.
 *   (1) The contents of the CR2 register. The processor loads the CR2 register with the
 *       32-bit linear address that generated the exception. The do_pgfault fun can
 *       use this address to locate the corresponding page directory and page-table
 *       entries.
 *   (2) An error code on the kernel stack. The error code for a page fault has a format different from
 *       that for other exceptions. The error code tells the exception handler three things:
 *         -- The P flag   (bit 0) indicates whether the exception was due to a not-present page (0)
 *            or to either an access rights violation or the use of a reserved bit (1).
 *         -- The W/R flag (bit 1) indicates whether the memory access that caused the exception
 *            was a read (0) or write (1).
 *         -- The U/S flag (bit 2) indicates whether the processor was executing at user mode (1)
 *            or supervisor mode (0) at the time of the exception.
 */
// 处理addr地址上的缺页异常
int do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr)
{
    // 1. 首先声明一个整数变量ret并初始化为-E_INVAL（错误代码）
    int ret = -E_INVAL;
    // 2. 调用find_vma函数在给定的mm_struct中查找包含给定虚拟地址addr的vma（虚拟内存区域）
    struct vma_struct *vma = find_vma(mm, addr);

    // 3. 增加页面错误计数器pgfault_num
    pgfault_num++;
    // 4. 如果找不到包含给定地址的vma，或者找到的vma的起始地址大于给定地址（不在范围内），则打印错误信息并跳转到标签failed
    if (vma == NULL || vma->vm_start > addr)
    {
        cprintf("not valid addr %x, and  can not find it in vma\n", addr);
        goto failed;
    }

    /* IF (write an existed addr ) OR
     *    (write an non_existed addr && addr is writable) OR
     *    (read  an non_existed addr && addr is readable)
     * THEN
     *    continue process
     */
    // 5. 根据vma的属性确定要设置的页表项权限perm
    // 如果vma的vm_flags中包含VM_WRITE标志，则设置写权限（PTE_W）
    uint32_t perm = PTE_U;
    if (vma->vm_flags & VM_WRITE)
    {
        perm |= (PTE_R | PTE_W);
    }
    // 6. 使用页面大小（PGSIZE）对齐给定地址
    addr = ROUNDDOWN(addr, PGSIZE);

    // 7. 初始化返回值ret为-E_NO_MEM（内存不足错误）
    ret = -E_NO_MEM;

    // 8. 声明一个指向页表项（pte）的指针ptep，并调用get_pte函数获取addr对应的页表项
    // 如果页表项所在的页表不存在，则会创建一个新的页表
    pte_t *ptep = NULL;
    /*
     * Maybe you want help comment, BELOW comments can help you finish the code
     *
     * Some Useful MACROs and DEFINEs, you can use them in below implementation.
     * MACROs or Functions:
     *   get_pte : get an pte and return the kernel virtual address of this pte for la
     *             if the PT contians this pte didn't exist, alloc a page for PT (notice the 3th parameter '1')
     *   pgdir_alloc_page : call alloc_page & page_insert functions to allocate a page size memory & setup
     *             an addr map pa<--->la with linear address la and the PDT pgdir
     * DEFINES:
     *   VM_WRITE  : If vma->vm_flags & VM_WRITE == 1/0, then the vma is writable/non writable
     *   PTE_W           0x002                   // page table/directory entry flags bit : Writeable
     *   PTE_U           0x004                   // page table/directory entry flags bit : User can access
     * VARIABLES:
     *   mm->pgdir : the PDT of these vma
     *
     */

    ptep = get_pte(mm->pgdir, addr, 1); //(1) try to find a pte, if pte's
                                        // PT(Page Table) isn't existed, then
                                        // create a PT.
    // 9. 如果获取到的页表项的值为0也就是NULL，表示该页表项不存在，需要分配一个物理页面，并建立页表项与线性地址之间的映射关系
    if (*ptep == 0)
    {
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL)
        {
            cprintf("pgdir_alloc_page in do_pgfault failed\n");
            goto failed;
        }
    }
    // 10. 如果获取到的页表项的值不为0，表示该页表项是一个交换条目（swap entry），需要从磁盘加载数据并将物理地址与逻辑地址进行映射
    else
    {
        /*LAB3 EXERCISE 3: YOUR CODE
         * 请你根据以下信息提示，补充函数
         * 现在我们认为pte是一个交换条目，那我们应该从磁盘加载数据并放到带有phy addr的页面，
         * 并将phy addr与逻辑addr映射，触发交换管理器记录该页面的访问情况
         *
         *  一些有用的宏和定义，可能会对你接下来代码的编写产生帮助(显然是有帮助的)
         *  宏或函数:
         *    swap_in(mm, addr, &page) : 分配一个内存页，然后根据
         *    PTE中的swap条目的addr，找到磁盘页的地址，将磁盘页的内容读入这个内存页
         *    page_insert ： 建立一个Page的phy addr与线性addr la的映射
         *    swap_map_swappable ： 设置页面可交换
         */
        // 11. 如果交换管理器已初始化（swap_init_ok为真），则调用swap_in函数从磁盘中加载数据到内存中的页面，并将页面插入到页表中
        if (swap_init_ok)
        {
            struct Page *page = NULL;
            // 在swap_in()函数执行完之后，page保存从磁盘换入的物理页面
            // swap_in()函数里面可能把内存里原有的页面换出去
            swap_in(mm, addr, &page);                 //(1）According to the mm AND addr, try
                                                      // to load the content of right disk page
                                                      // into the memory which page managed.
            page_insert(mm->pgdir, page, addr, perm); // 更新页表，插入新的页表项
            //(2) According to the mm, addr AND page,
            // setup the map of phy addr <---> virtual addr
            // 标记这个页面将来是可以再换出的
            // 实际上就是插入到了交换管理器中
            swap_map_swappable(mm, addr, page, 1); //(3) make the page swappable.
            page->pra_vaddr = addr;
        }
        // 12. 如果交换管理器未初始化，则打印错误信息并跳转到标签failed
        else
        {
            cprintf("no swap_init_ok but ptep is %x, failed\n", *ptep);
            goto failed;
        }
    }

    // 13. 将返回值ret设置为0，表示处理页面错误成功
    ret = 0;
failed:
    return ret;
}
