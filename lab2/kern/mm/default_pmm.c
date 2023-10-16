#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h>

/* In the first fit algorithm, the allocator keeps a list of free blocks (known as the free list) and,
   on receiving a request for memory, scans along the list for the first block that is large enough to
   satisfy the request. If the chosen block is significantly larger than that requested, then it is
   usually split, and the remainder added to the list as another free block.
   Please see Page 196~198, Section 8.2 of Yan Wei Min's chinese book "Data Structure -- C programming language"
*/
// you should rewrite functions: default_init,default_init_memmap,default_alloc_pages, default_free_pages.
/*
 * Details of FFMA
 * (1) Prepare: In order to implement the First-Fit Mem Alloc (FFMA), we should manage the free mem block use some list.
 *              The struct free_area_t is used for the management of free mem blocks. At first you should
 *              be familiar to the struct list in list.h. struct list is a simple doubly linked list implementation.
 *              You should know howto USE: list_init, list_add(list_add_after), list_add_before, list_del, list_next, list_prev
 *              Another tricky method is to transform a general list struct to a special struct (such as struct page):
 *              you can find some MACRO: le2page (in memlayout.h), (in future labs: le2vma (in vmm.h), le2proc (in proc.h),etc.)
 * (2) default_init: you can reuse the  demo default_init fun to init the free_list and set nr_free to 0.
 *              free_list is used to record the free mem blocks. nr_free is the total number for free mem blocks.
 * (3) default_init_memmap:  CALL GRAPH: kern_init --> pmm_init-->page_init-->init_memmap--> pmm_manager->init_memmap
 *              This fun is used to init a free block (with parameter: addr_base, page_number).
 *              First you should init each page (in memlayout.h) in this free block, include:
 *                  p->flags should be set bit PG_property (means this page is valid. In pmm_init fun (in pmm.c),
 *                  the bit PG_reserved is setted in p->flags)
 *                  if this page  is free and is not the first page of free block, p->property should be set to 0.
 *                  if this page  is free and is the first page of free block, p->property should be set to total num of block.
 *                  p->ref should be 0, because now p is free and no reference.
 *                  We can use p->page_link to link this page to free_list, (such as: list_add_before(&free_list, &(p->page_link)); )
 *              Finally, we should sum the number of free mem block: nr_free+=n
 * (4) default_alloc_pages: search find a first free block (block size >=n) in free list and reszie the free block, return the addr
 *              of malloced block.
 *              (4.1) So you should search freelist like this:
 *                       list_entry_t le = &free_list;
 *                       while((le=list_next(le)) != &free_list) {
 *                       ....
 *                 (4.1.1) In while loop, get the struct page and check the p->property (record the num of free block) >=n?
 *                       struct Page *p = le2page(le, page_link);
 *                       if(p->property >= n){ ...
 *                 (4.1.2) If we find this p, then it' means we find a free block(block size >=n), and the first n pages can be malloced.
 *                     Some flag bits of this page should be setted: PG_reserved =1, PG_property =0
 *                     unlink the pages from free_list
 *                     (4.1.2.1) If (p->property >n), we should re-caluclate number of the the rest of this free block,
 *                           (such as: le2page(le,page_link))->property = p->property - n;)
 *                 (4.1.3)  re-caluclate nr_free (number of the the rest of all free block)
 *                 (4.1.4)  return p
 *               (4.2) If we can not find a free block (block size >=n), then return NULL
 * (5) default_free_pages: relink the pages into  free list, maybe merge small free blocks into big free blocks.
 *               (5.1) according the base addr of withdrawed blocks, search free list, find the correct position
 *                     (from low to high addr), and insert the pages. (may use list_next, le2page, list_add_before)
 *               (5.2) reset the fields of pages, such as p->ref, p->flags (PageProperty)
 *               (5.3) try to merge low addr or high addr blocks. Notice: should change some pages's p->property correctly.
 */
free_area_t free_area; // 维护一个查找有序（地址按从小到大排列）空闲块（以页为最小单位的连续地址空间）的数据结构

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0; // nr_free可以理解为在这里可以使用的一个全局变量，记录可用的物理页面数
}

static void
default_init_memmap(struct Page *base, size_t n)
{
    // n要大于0
    assert(n > 0);
    // 令p为连续地址的空闲块的起始页
    struct Page *p = base;
    // 将这个空闲块的每个页面初始化
    for (; p != base + n; p++)
    {
        // 每次循环首先检查p的PG_reserved位是否设置为1，表示空闲可分配
        assert(PageReserved(p));
        // 设置这一页的flag为0，表示这页空闲，设置非起始页的property为0，表示不是起始页
        p->flags = p->property = 0;
        // 将这一页的ref设为0，因为这页现在空闲，没有引用
        set_page_ref(p, 0);
    }
    // 空闲块的第一页的连续空页值property设置为块中的总页数
    base->property = n;
    // 将空闲块的第一页的PG_property位设置为1，表示是起始页，可以被用作分配内存
    SetPageProperty(base);
    // 将空闲页的数目加n
    nr_free += n;
    // 将base->page_link此页链接到free_list中
    if (list_empty(&free_list))
    {
        list_add(&free_list, &(base->page_link));
    }
    else
    {
        list_entry_t *le = &free_list;
        while ((le = list_next(le)) != &free_list)
        {
            struct Page *page = le2page(le, page_link);
            if (base < page)
            {
                list_add_before(le, &(base->page_link));
                break;
            }
            else if (list_next(le) == &free_list)
            {
                list_add(le, &(base->page_link));
            }
        }
    }
}

static struct Page *
default_alloc_pages(size_t n)
{
    // n要大于0
    assert(n > 0);
    // 考虑边界情况，当n大于可以分配的内存数时，直接返回，确保分配不会超出范围，保证软件的鲁棒性
    if (n > nr_free)
    {
        return NULL;
    }
    struct Page *page = NULL;
    // 指针le指向空闲链表头，开始查找最小的地址
    list_entry_t *le = &free_list;
    // 遍历空闲链表
    while ((le = list_next(le)) != &free_list)
    {
        // 由链表元素获得对应的Page指针p
        struct Page *p = le2page(le, page_link);
        // 如果当前页面的property大于等于n，说明空闲块的连续空页数大于等于n，可以分配，令page等于p，直接退出
        if (p->property >= n)
        {
            page = p;
            break;
        }
    }
    // 如果找到了空闲块，进行重新组织，否则直接返回NULL
    if (page != NULL)
    {
        // 在空闲页链表中删除刚刚分配的空闲块
        list_entry_t *prev = list_prev(&(page->page_link));
        list_del(&(page->page_link));
        // 如果可以分配的空闲块的连续空页数大于n
        if (page->property > n)
        {
            // 创建一个地址为page+n的新物理页
            struct Page *p = page + n;
            // 页面的property设置为page多出来的空闲连续页数
            p->property = page->property - n;
            // 设置p的Page_property位，表示为新的空闲块的起始页
            SetPageProperty(p);
            // 将新的空闲块的页插入到空闲页链表的后面
            list_add(prev, &(p->page_link));
        }
        // 剩余空闲页的数目减n
        nr_free -= n;
        // 清除page的Page_property位，表示page已经被分配
        ClearPageProperty(page);
    }
    return page;
}

static void
default_free_pages(struct Page *base, size_t n)
{
    // n要大于0
    assert(n > 0);
    // 令p为连续地址的释放块的起始页
    struct Page *p = base;
    // 将这个释放块的每个页面初始化
    for (; p != base + n; p++)
    {
        // 检查每一页的Page_reserved位和Page_property是否都未被设置
        assert(!PageReserved(p) && !PageProperty(p));
        // 设置每一页的flags都为0，表示可以分配
        p->flags = 0;
        // 设置每一页的ref都为0，表示这页空闲
        set_page_ref(p, 0);
    }
    // 释放块起始页的property连续空页数设置为n
    base->property = n;
    // 设置起始页的Page_property位
    SetPageProperty(base);
    // 将空闲页的数目加n
    nr_free += n;

    if (list_empty(&free_list))
    {
        list_add(&free_list, &(base->page_link));
    }
    else
    {
        // 指针le指向空闲链表头，开始查找最小的地址
        list_entry_t *le = &free_list;
        // 遍历空闲链表，找第一个比base大的
        while ((le = list_next(le)) != &free_list)
        {
            // 由链表元素获得对应的Page指针page
            struct Page *page = le2page(le, page_link);
            if (base < page)
            {
                // 加在中间
                list_add_before(le, &(base->page_link));
                break;
            }
            // 如果链表下一个就是开头了，也就是走了一圈没有比base大的地址
            else if (list_next(le) == &free_list)
            {
                // 那就加在链表末尾
                list_add(le, &(base->page_link));
            }
        }
    }

    // 下面在base周围进行空闲块的合并
    list_entry_t *le = list_prev(&(base->page_link));
    if (le != &free_list)
    {
        // 由链表元素获得对应的Page指针p
        p = le2page(le, page_link);
        // 如果释放块的起始页在上一个空闲块的后面，那么进行合并
        if (p + p->property == base)
        {
            // 空闲块的连续空页数要加上释放块起始页base的连续空页数
            p->property += base->property;
            // 清除base的Page_property位，表示base不再是起始页
            ClearPageProperty(base);
            // 将原来的空闲块删除
            list_del(&(base->page_link));
            // 新的空闲块的起始页变成p
            base = p;
        }
    }

    le = list_next(&(base->page_link));
    if (le != &free_list)
    {
        // 由链表元素获得对应的Page指针p
        p = le2page(le, page_link);
        // 如果释放块在下一个空闲块起始页的前面，那么进行合并
        if (base + base->property == p)
        {
            // 释放块的连续空页数要加上空闲块起始页p的连续空页数
            base->property += p->property;
            // 清除p的Page_property位，表示p不再是新的空闲块的起始页
            ClearPageProperty(p);
            // 将原来的空闲块删除
            list_del(&(p->page_link));
        }
    }
}

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}

static void
basic_check(void)
{
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(p0 != p1 && p0 != p2 && p1 != p2);
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);

    assert(page2pa(p0) < npage * PGSIZE);
    assert(page2pa(p1) < npage * PGSIZE);
    assert(page2pa(p2) < npage * PGSIZE);

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    assert(alloc_page() == NULL);

    free_page(p0);
    free_page(p1);
    free_page(p2);
    assert(nr_free == 3);

    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(alloc_page() == NULL);

    free_page(p0);
    assert(!list_empty(&free_list));

    struct Page *p;
    assert((p = alloc_page()) == p0);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    free_list = free_list_store;
    nr_free = nr_free_store;

    free_page(p);
    free_page(p1);
    free_page(p2);
}

// LAB2: below code is used to check the first fit allocation algorithm
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
        count++, total += p->property;
    }
    assert(total == nr_free_pages());

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
    assert(p0 != NULL);
    assert(!PageProperty(p0));

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
    assert(alloc_pages(4) == NULL);
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
    assert((p1 = alloc_pages(3)) != NULL);
    assert(alloc_page() == NULL);
    assert(p0 + 2 == p1);

    p2 = p0 + 1;
    free_page(p0);
    free_pages(p1, 3);
    assert(PageProperty(p0) && p0->property == 1);
    assert(PageProperty(p1) && p1->property == 3);

    assert((p0 = alloc_page()) == p2 - 1);
    free_page(p0);
    assert((p0 = alloc_pages(2)) == p2 + 1);

    free_pages(p0, 2);
    free_page(p2);

    assert((p0 = alloc_pages(5)) != NULL);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
    }
    assert(count == 0);
    assert(total == 0);
}
// 这个结构体在
const struct pmm_manager default_pmm_manager = {
    .name = "default_pmm_manager",
    .init = default_init,
    .init_memmap = default_init_memmap,
    .alloc_pages = default_alloc_pages,
    .free_pages = default_free_pages,
    .nr_free_pages = default_nr_free_pages,
    .check = default_check,
};
