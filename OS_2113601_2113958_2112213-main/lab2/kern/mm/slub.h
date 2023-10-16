#ifndef __KERN_MM_SLUB_H__
#define __KERN_MM_SLUB_H__

#include <pmm.h>
#include <list.h>

#define CACHE_NAMELEN 16

struct kmem_cache_t
{
    list_entry_t slabs_full;                             // 全满Slab链表
    list_entry_t slabs_partial;                          // 部分空闲Slab链表
    list_entry_t slabs_free;                             // 全空闲Slab链表
    uint16_t objsize;                                    // 对象大小
    uint16_t num;                                        // 每个Slab保存的对象数目
    void (*ctor)(void *, struct kmem_cache_t *, size_t); // 构造函数
    void (*dtor)(void *, struct kmem_cache_t *, size_t); // 析构函数
    char name[CACHE_NAMELEN];                            // 仓库名称
    list_entry_t cache_link;                             // 仓库链表
};

struct kmem_cache_t *
kmem_cache_create(const char *name, size_t size,
                  void (*ctor)(void *, struct kmem_cache_t *, size_t),
                  void (*dtor)(void *, struct kmem_cache_t *, size_t));
void kmem_cache_destroy(struct kmem_cache_t *cachep);
void *kmem_cache_alloc(struct kmem_cache_t *cachep);
void *kmem_cache_zalloc(struct kmem_cache_t *cachep);
void kmem_cache_free(struct kmem_cache_t *cachep, void *objp);
size_t kmem_cache_size(struct kmem_cache_t *cachep);
const char *kmem_cache_name(struct kmem_cache_t *cachep);
int kmem_cache_shrink(struct kmem_cache_t *cachep);
int kmem_cache_reap();
void *kmalloc(size_t size);
void kfree(void *objp);
// size_t ksize(void *objp);

void kmem_int();

#endif /* ! __KERN_MM_SLUB_H__ */