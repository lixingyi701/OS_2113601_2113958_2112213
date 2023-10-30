#include <defs.h>
#include <stdio.h>
#include <string.h>
#include <console.h>
#include <kdebug.h>
#include <trap.h>
#include <clock.h>
#include <intr.h>
#include <pmm.h>
#include <vmm.h>
#include <ide.h>
#include <swap.h>
#include <kmonitor.h>

int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);

    print_kerninfo();

    // grade_backtrace();

    pmm_init(); // init physical memory management
                // 我们加入了多级页表的接口和测试

    idt_init(); // init interrupt descriptor table

    vmm_init(); // init virtual memory management
                // 新增函数, 初始化虚拟内存管理并测试

    ide_init();  // init ide devices. 新增函数, 初始化"硬盘".
                 // 这个函数啥也没做, 属于"历史遗留"
    swap_init(); // init swap. 新增函数, 初始化页面置换机制并测试

    clock_init(); // init clock interrupt
    // intr_enable();              // enable irq interrupt

    /* do nothing */
    while (1)
        ;
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3)
{
    mon_backtrace(0, NULL, NULL);
}

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1)
{
    grade_backtrace2(arg0, (sint_t)&arg0, arg1, (sint_t)&arg1);
}

void __attribute__((noinline))
grade_backtrace0(int arg0, sint_t arg1, int arg2)
{
    grade_backtrace1(arg0, arg2);
}

void grade_backtrace(void)
{
    grade_backtrace0(0, (sint_t)kern_init, 0xffff0000);
}

static void
lab1_print_cur_status(void)
{
    static int round = 0;
    round++;
}
