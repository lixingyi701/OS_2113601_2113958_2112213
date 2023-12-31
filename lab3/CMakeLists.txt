cmake_minimum_required(VERSION 3.17)
project(lab3 C)

set(CMAKE_C_STANDARD 11)

include_directories(.)
include_directories(kern)
include_directories(kern/debug)
include_directories(kern/driver)
include_directories(kern/fs)
include_directories(kern/init)
include_directories(kern/libs)
include_directories(kern/mm)
include_directories(kern/sync)
include_directories(kern/trap)
include_directories(libs)
include_directories(tools)

add_executable(lab3
        kern/debug/assert.h
        kern/debug/kdebug.c
        kern/debug/kdebug.h
        kern/debug/kmonitor.c
        kern/debug/kmonitor.h
        kern/debug/panic.c
        kern/debug/stab.h
        kern/driver/clock.c
        kern/driver/clock.h
        kern/driver/console.c
        kern/driver/console.h
        kern/driver/ide.c
        kern/driver/ide.h
        kern/driver/intr.c
        kern/driver/intr.h
        kern/fs/fs.h
        kern/fs/swapfs.c
        kern/fs/swapfs.h
        kern/init/init.c
        kern/libs/stdio.c
        kern/mm/default_pmm.c
        kern/mm/default_pmm.h
        kern/mm/memlayout.h
        kern/mm/mmu.h
        kern/mm/pmm.c
        kern/mm/pmm.h
        kern/mm/swap.c
        kern/mm/swap.h
        kern/mm/swap_clock.c
        kern/mm/swap_clock.h
        kern/mm/swap_fifo.c
        kern/mm/swap_fifo.h
        kern/mm/swap_lru.c
        kern/mm/swap_lru.h
        kern/mm/vmm.c
        kern/mm/vmm.h
        kern/sync/sync.h
        kern/trap/trap.c
        kern/trap/trap.h
        libs/atomic.h
        libs/defs.h
        libs/error.h
        libs/list.h
        libs/printfmt.c
        libs/rand.c
        libs/readline.c
        libs/riscv.h
        libs/sbi.h
        libs/stdarg.h
        libs/stdio.h
        libs/stdlib.h
        libs/string.c
        libs/string.h
        tools/sign.c
        tools/vector.c)
