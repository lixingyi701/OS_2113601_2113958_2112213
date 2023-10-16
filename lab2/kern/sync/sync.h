#ifndef __KERN_SYNC_SYNC_H__
#define __KERN_SYNC_SYNC_H__

#include <defs.h>
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
    {
        intr_disable();
        return 1;
    }
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
    {
        intr_enable();
    }
}

// 宏定义中的 do{}while(0) 起到的作用是创建一个作用域，使得宏定义中的多条语句可以像单个语句那样使用，并且可以在宏展开时保持语义上的一致性
// 例如：#define REPLACE_FUN() funA(); funB();那么在 for 循环后直接替换就会出现问题，funB() 时钟执行
#define local_intr_save(x) \
    do                     \
    {                      \
        x = __intr_save(); \
    } while (0)
#define local_intr_restore(x) __intr_restore(x);

#endif /* !__KERN_SYNC_SYNC_H__ */
