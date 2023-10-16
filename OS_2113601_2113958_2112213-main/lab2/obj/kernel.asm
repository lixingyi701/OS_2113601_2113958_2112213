
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200000:	c02062b7          	lui	t0,0xc0206
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	01e31313          	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc020000c:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200010:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc0200014:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200018:	03f31313          	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc020001c:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200020:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200024:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop

    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc0200028:	c0206137          	lui	sp,0xc0206

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc020002c:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200030:	03628293          	addi	t0,t0,54 # ffffffffc0200036 <kern_init>
    jr t0
ffffffffc0200034:	8282                	jr	t0

ffffffffc0200036 <kern_init>:
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc0200036:	00007517          	auipc	a0,0x7
ffffffffc020003a:	fda50513          	addi	a0,a0,-38 # ffffffffc0207010 <edata>
ffffffffc020003e:	00007617          	auipc	a2,0x7
ffffffffc0200042:	52260613          	addi	a2,a2,1314 # ffffffffc0207560 <end>
{
ffffffffc0200046:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200048:	8e09                	sub	a2,a2,a0
ffffffffc020004a:	4581                	li	a1,0
{
ffffffffc020004c:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020004e:	221020ef          	jal	ra,ffffffffc0202a6e <memset>
    cons_init(); // init the console
ffffffffc0200052:	402000ef          	jal	ra,ffffffffc0200454 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    // cprintf("%s\n\n", message);
    cputs(message);
ffffffffc0200056:	00003517          	auipc	a0,0x3
ffffffffc020005a:	a4250513          	addi	a0,a0,-1470 # ffffffffc0202a98 <etext>
ffffffffc020005e:	094000ef          	jal	ra,ffffffffc02000f2 <cputs>

    print_kerninfo();
ffffffffc0200062:	0e0000ef          	jal	ra,ffffffffc0200142 <print_kerninfo>

    // grade_backtrace();
    idt_init(); // init interrupt descriptor table
ffffffffc0200066:	408000ef          	jal	ra,ffffffffc020046e <idt_init>

    pmm_init(); // init physical memory management
ffffffffc020006a:	584010ef          	jal	ra,ffffffffc02015ee <pmm_init>

    kmem_int(); // challenge2使用
ffffffffc020006e:	5c5010ef          	jal	ra,ffffffffc0201e32 <kmem_int>

    idt_init(); // init interrupt descriptor table
ffffffffc0200072:	3fc000ef          	jal	ra,ffffffffc020046e <idt_init>

    clock_init();  // init clock interrupt
ffffffffc0200076:	39a000ef          	jal	ra,ffffffffc0200410 <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc020007a:	3e8000ef          	jal	ra,ffffffffc0200462 <intr_enable>

    /* do nothing */
    while (1)
        ;
ffffffffc020007e:	a001                	j	ffffffffc020007e <kern_init+0x48>

ffffffffc0200080 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc0200080:	1141                	addi	sp,sp,-16
ffffffffc0200082:	e022                	sd	s0,0(sp)
ffffffffc0200084:	e406                	sd	ra,8(sp)
ffffffffc0200086:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200088:	3ce000ef          	jal	ra,ffffffffc0200456 <cons_putc>
    (*cnt) ++;
ffffffffc020008c:	401c                	lw	a5,0(s0)
}
ffffffffc020008e:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc0200090:	2785                	addiw	a5,a5,1
ffffffffc0200092:	c01c                	sw	a5,0(s0)
}
ffffffffc0200094:	6402                	ld	s0,0(sp)
ffffffffc0200096:	0141                	addi	sp,sp,16
ffffffffc0200098:	8082                	ret

ffffffffc020009a <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc020009a:	1101                	addi	sp,sp,-32
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc020009c:	86ae                	mv	a3,a1
ffffffffc020009e:	862a                	mv	a2,a0
ffffffffc02000a0:	006c                	addi	a1,sp,12
ffffffffc02000a2:	00000517          	auipc	a0,0x0
ffffffffc02000a6:	fde50513          	addi	a0,a0,-34 # ffffffffc0200080 <cputch>
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000aa:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000ac:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000ae:	4b2020ef          	jal	ra,ffffffffc0202560 <vprintfmt>
    return cnt;
}
ffffffffc02000b2:	60e2                	ld	ra,24(sp)
ffffffffc02000b4:	4532                	lw	a0,12(sp)
ffffffffc02000b6:	6105                	addi	sp,sp,32
ffffffffc02000b8:	8082                	ret

ffffffffc02000ba <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc02000ba:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000bc:	02810313          	addi	t1,sp,40 # ffffffffc0206028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc02000c0:	f42e                	sd	a1,40(sp)
ffffffffc02000c2:	f832                	sd	a2,48(sp)
ffffffffc02000c4:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000c6:	862a                	mv	a2,a0
ffffffffc02000c8:	004c                	addi	a1,sp,4
ffffffffc02000ca:	00000517          	auipc	a0,0x0
ffffffffc02000ce:	fb650513          	addi	a0,a0,-74 # ffffffffc0200080 <cputch>
ffffffffc02000d2:	869a                	mv	a3,t1
cprintf(const char *fmt, ...) {
ffffffffc02000d4:	ec06                	sd	ra,24(sp)
ffffffffc02000d6:	e0ba                	sd	a4,64(sp)
ffffffffc02000d8:	e4be                	sd	a5,72(sp)
ffffffffc02000da:	e8c2                	sd	a6,80(sp)
ffffffffc02000dc:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02000de:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02000e0:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000e2:	47e020ef          	jal	ra,ffffffffc0202560 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02000e6:	60e2                	ld	ra,24(sp)
ffffffffc02000e8:	4512                	lw	a0,4(sp)
ffffffffc02000ea:	6125                	addi	sp,sp,96
ffffffffc02000ec:	8082                	ret

ffffffffc02000ee <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc02000ee:	3680006f          	j	ffffffffc0200456 <cons_putc>

ffffffffc02000f2 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc02000f2:	1101                	addi	sp,sp,-32
ffffffffc02000f4:	e822                	sd	s0,16(sp)
ffffffffc02000f6:	ec06                	sd	ra,24(sp)
ffffffffc02000f8:	e426                	sd	s1,8(sp)
ffffffffc02000fa:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc02000fc:	00054503          	lbu	a0,0(a0)
ffffffffc0200100:	c51d                	beqz	a0,ffffffffc020012e <cputs+0x3c>
ffffffffc0200102:	0405                	addi	s0,s0,1
ffffffffc0200104:	4485                	li	s1,1
ffffffffc0200106:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200108:	34e000ef          	jal	ra,ffffffffc0200456 <cons_putc>
    (*cnt) ++;
ffffffffc020010c:	008487bb          	addw	a5,s1,s0
    while ((c = *str ++) != '\0') {
ffffffffc0200110:	0405                	addi	s0,s0,1
ffffffffc0200112:	fff44503          	lbu	a0,-1(s0)
ffffffffc0200116:	f96d                	bnez	a0,ffffffffc0200108 <cputs+0x16>
ffffffffc0200118:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc020011c:	4529                	li	a0,10
ffffffffc020011e:	338000ef          	jal	ra,ffffffffc0200456 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200122:	8522                	mv	a0,s0
ffffffffc0200124:	60e2                	ld	ra,24(sp)
ffffffffc0200126:	6442                	ld	s0,16(sp)
ffffffffc0200128:	64a2                	ld	s1,8(sp)
ffffffffc020012a:	6105                	addi	sp,sp,32
ffffffffc020012c:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc020012e:	4405                	li	s0,1
ffffffffc0200130:	b7f5                	j	ffffffffc020011c <cputs+0x2a>

ffffffffc0200132 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc0200132:	1141                	addi	sp,sp,-16
ffffffffc0200134:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200136:	328000ef          	jal	ra,ffffffffc020045e <cons_getc>
ffffffffc020013a:	dd75                	beqz	a0,ffffffffc0200136 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc020013c:	60a2                	ld	ra,8(sp)
ffffffffc020013e:	0141                	addi	sp,sp,16
ffffffffc0200140:	8082                	ret

ffffffffc0200142 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc0200142:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc0200144:	00003517          	auipc	a0,0x3
ffffffffc0200148:	9a450513          	addi	a0,a0,-1628 # ffffffffc0202ae8 <etext+0x50>
void print_kerninfo(void) {
ffffffffc020014c:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc020014e:	f6dff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", kern_init);
ffffffffc0200152:	00000597          	auipc	a1,0x0
ffffffffc0200156:	ee458593          	addi	a1,a1,-284 # ffffffffc0200036 <kern_init>
ffffffffc020015a:	00003517          	auipc	a0,0x3
ffffffffc020015e:	9ae50513          	addi	a0,a0,-1618 # ffffffffc0202b08 <etext+0x70>
ffffffffc0200162:	f59ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc0200166:	00003597          	auipc	a1,0x3
ffffffffc020016a:	93258593          	addi	a1,a1,-1742 # ffffffffc0202a98 <etext>
ffffffffc020016e:	00003517          	auipc	a0,0x3
ffffffffc0200172:	9ba50513          	addi	a0,a0,-1606 # ffffffffc0202b28 <etext+0x90>
ffffffffc0200176:	f45ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc020017a:	00007597          	auipc	a1,0x7
ffffffffc020017e:	e9658593          	addi	a1,a1,-362 # ffffffffc0207010 <edata>
ffffffffc0200182:	00003517          	auipc	a0,0x3
ffffffffc0200186:	9c650513          	addi	a0,a0,-1594 # ffffffffc0202b48 <etext+0xb0>
ffffffffc020018a:	f31ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc020018e:	00007597          	auipc	a1,0x7
ffffffffc0200192:	3d258593          	addi	a1,a1,978 # ffffffffc0207560 <end>
ffffffffc0200196:	00003517          	auipc	a0,0x3
ffffffffc020019a:	9d250513          	addi	a0,a0,-1582 # ffffffffc0202b68 <etext+0xd0>
ffffffffc020019e:	f1dff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc02001a2:	00007597          	auipc	a1,0x7
ffffffffc02001a6:	7bd58593          	addi	a1,a1,1981 # ffffffffc020795f <end+0x3ff>
ffffffffc02001aa:	00000797          	auipc	a5,0x0
ffffffffc02001ae:	e8c78793          	addi	a5,a5,-372 # ffffffffc0200036 <kern_init>
ffffffffc02001b2:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001b6:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc02001ba:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001bc:	3ff5f593          	andi	a1,a1,1023
ffffffffc02001c0:	95be                	add	a1,a1,a5
ffffffffc02001c2:	85a9                	srai	a1,a1,0xa
ffffffffc02001c4:	00003517          	auipc	a0,0x3
ffffffffc02001c8:	9c450513          	addi	a0,a0,-1596 # ffffffffc0202b88 <etext+0xf0>
}
ffffffffc02001cc:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001ce:	eedff06f          	j	ffffffffc02000ba <cprintf>

ffffffffc02001d2 <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc02001d2:	1141                	addi	sp,sp,-16

    panic("Not Implemented!");
ffffffffc02001d4:	00003617          	auipc	a2,0x3
ffffffffc02001d8:	8e460613          	addi	a2,a2,-1820 # ffffffffc0202ab8 <etext+0x20>
ffffffffc02001dc:	04e00593          	li	a1,78
ffffffffc02001e0:	00003517          	auipc	a0,0x3
ffffffffc02001e4:	8f050513          	addi	a0,a0,-1808 # ffffffffc0202ad0 <etext+0x38>
void print_stackframe(void) {
ffffffffc02001e8:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc02001ea:	1c6000ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc02001ee <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc02001ee:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02001f0:	00003617          	auipc	a2,0x3
ffffffffc02001f4:	aa860613          	addi	a2,a2,-1368 # ffffffffc0202c98 <commands+0xe0>
ffffffffc02001f8:	00003597          	auipc	a1,0x3
ffffffffc02001fc:	ac058593          	addi	a1,a1,-1344 # ffffffffc0202cb8 <commands+0x100>
ffffffffc0200200:	00003517          	auipc	a0,0x3
ffffffffc0200204:	ac050513          	addi	a0,a0,-1344 # ffffffffc0202cc0 <commands+0x108>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200208:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc020020a:	eb1ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
ffffffffc020020e:	00003617          	auipc	a2,0x3
ffffffffc0200212:	ac260613          	addi	a2,a2,-1342 # ffffffffc0202cd0 <commands+0x118>
ffffffffc0200216:	00003597          	auipc	a1,0x3
ffffffffc020021a:	ae258593          	addi	a1,a1,-1310 # ffffffffc0202cf8 <commands+0x140>
ffffffffc020021e:	00003517          	auipc	a0,0x3
ffffffffc0200222:	aa250513          	addi	a0,a0,-1374 # ffffffffc0202cc0 <commands+0x108>
ffffffffc0200226:	e95ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
ffffffffc020022a:	00003617          	auipc	a2,0x3
ffffffffc020022e:	ade60613          	addi	a2,a2,-1314 # ffffffffc0202d08 <commands+0x150>
ffffffffc0200232:	00003597          	auipc	a1,0x3
ffffffffc0200236:	af658593          	addi	a1,a1,-1290 # ffffffffc0202d28 <commands+0x170>
ffffffffc020023a:	00003517          	auipc	a0,0x3
ffffffffc020023e:	a8650513          	addi	a0,a0,-1402 # ffffffffc0202cc0 <commands+0x108>
ffffffffc0200242:	e79ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    }
    return 0;
}
ffffffffc0200246:	60a2                	ld	ra,8(sp)
ffffffffc0200248:	4501                	li	a0,0
ffffffffc020024a:	0141                	addi	sp,sp,16
ffffffffc020024c:	8082                	ret

ffffffffc020024e <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc020024e:	1141                	addi	sp,sp,-16
ffffffffc0200250:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc0200252:	ef1ff0ef          	jal	ra,ffffffffc0200142 <print_kerninfo>
    return 0;
}
ffffffffc0200256:	60a2                	ld	ra,8(sp)
ffffffffc0200258:	4501                	li	a0,0
ffffffffc020025a:	0141                	addi	sp,sp,16
ffffffffc020025c:	8082                	ret

ffffffffc020025e <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc020025e:	1141                	addi	sp,sp,-16
ffffffffc0200260:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc0200262:	f71ff0ef          	jal	ra,ffffffffc02001d2 <print_stackframe>
    return 0;
}
ffffffffc0200266:	60a2                	ld	ra,8(sp)
ffffffffc0200268:	4501                	li	a0,0
ffffffffc020026a:	0141                	addi	sp,sp,16
ffffffffc020026c:	8082                	ret

ffffffffc020026e <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc020026e:	7115                	addi	sp,sp,-224
ffffffffc0200270:	e962                	sd	s8,144(sp)
ffffffffc0200272:	8c2a                	mv	s8,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc0200274:	00003517          	auipc	a0,0x3
ffffffffc0200278:	98c50513          	addi	a0,a0,-1652 # ffffffffc0202c00 <commands+0x48>
kmonitor(struct trapframe *tf) {
ffffffffc020027c:	ed86                	sd	ra,216(sp)
ffffffffc020027e:	e9a2                	sd	s0,208(sp)
ffffffffc0200280:	e5a6                	sd	s1,200(sp)
ffffffffc0200282:	e1ca                	sd	s2,192(sp)
ffffffffc0200284:	fd4e                	sd	s3,184(sp)
ffffffffc0200286:	f952                	sd	s4,176(sp)
ffffffffc0200288:	f556                	sd	s5,168(sp)
ffffffffc020028a:	f15a                	sd	s6,160(sp)
ffffffffc020028c:	ed5e                	sd	s7,152(sp)
ffffffffc020028e:	e566                	sd	s9,136(sp)
ffffffffc0200290:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc0200292:	e29ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc0200296:	00003517          	auipc	a0,0x3
ffffffffc020029a:	99250513          	addi	a0,a0,-1646 # ffffffffc0202c28 <commands+0x70>
ffffffffc020029e:	e1dff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    if (tf != NULL) {
ffffffffc02002a2:	000c0563          	beqz	s8,ffffffffc02002ac <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc02002a6:	8562                	mv	a0,s8
ffffffffc02002a8:	3a6000ef          	jal	ra,ffffffffc020064e <print_trapframe>
ffffffffc02002ac:	00003c97          	auipc	s9,0x3
ffffffffc02002b0:	90cc8c93          	addi	s9,s9,-1780 # ffffffffc0202bb8 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02002b4:	00003997          	auipc	s3,0x3
ffffffffc02002b8:	99c98993          	addi	s3,s3,-1636 # ffffffffc0202c50 <commands+0x98>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02002bc:	00003917          	auipc	s2,0x3
ffffffffc02002c0:	99c90913          	addi	s2,s2,-1636 # ffffffffc0202c58 <commands+0xa0>
        if (argc == MAXARGS - 1) {
ffffffffc02002c4:	4a3d                	li	s4,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02002c6:	00003b17          	auipc	s6,0x3
ffffffffc02002ca:	99ab0b13          	addi	s6,s6,-1638 # ffffffffc0202c60 <commands+0xa8>
    if (argc == 0) {
ffffffffc02002ce:	00003a97          	auipc	s5,0x3
ffffffffc02002d2:	9eaa8a93          	addi	s5,s5,-1558 # ffffffffc0202cb8 <commands+0x100>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02002d6:	4b8d                	li	s7,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02002d8:	854e                	mv	a0,s3
ffffffffc02002da:	612020ef          	jal	ra,ffffffffc02028ec <readline>
ffffffffc02002de:	842a                	mv	s0,a0
ffffffffc02002e0:	dd65                	beqz	a0,ffffffffc02002d8 <kmonitor+0x6a>
ffffffffc02002e2:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc02002e6:	4481                	li	s1,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02002e8:	c999                	beqz	a1,ffffffffc02002fe <kmonitor+0x90>
ffffffffc02002ea:	854a                	mv	a0,s2
ffffffffc02002ec:	764020ef          	jal	ra,ffffffffc0202a50 <strchr>
ffffffffc02002f0:	c925                	beqz	a0,ffffffffc0200360 <kmonitor+0xf2>
            *buf ++ = '\0';
ffffffffc02002f2:	00144583          	lbu	a1,1(s0)
ffffffffc02002f6:	00040023          	sb	zero,0(s0)
ffffffffc02002fa:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02002fc:	f5fd                	bnez	a1,ffffffffc02002ea <kmonitor+0x7c>
    if (argc == 0) {
ffffffffc02002fe:	dce9                	beqz	s1,ffffffffc02002d8 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200300:	6582                	ld	a1,0(sp)
ffffffffc0200302:	00003d17          	auipc	s10,0x3
ffffffffc0200306:	8b6d0d13          	addi	s10,s10,-1866 # ffffffffc0202bb8 <commands>
    if (argc == 0) {
ffffffffc020030a:	8556                	mv	a0,s5
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020030c:	4401                	li	s0,0
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020030e:	0d61                	addi	s10,s10,24
ffffffffc0200310:	716020ef          	jal	ra,ffffffffc0202a26 <strcmp>
ffffffffc0200314:	c919                	beqz	a0,ffffffffc020032a <kmonitor+0xbc>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200316:	2405                	addiw	s0,s0,1
ffffffffc0200318:	09740463          	beq	s0,s7,ffffffffc02003a0 <kmonitor+0x132>
ffffffffc020031c:	000d3503          	ld	a0,0(s10)
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200320:	6582                	ld	a1,0(sp)
ffffffffc0200322:	0d61                	addi	s10,s10,24
ffffffffc0200324:	702020ef          	jal	ra,ffffffffc0202a26 <strcmp>
ffffffffc0200328:	f57d                	bnez	a0,ffffffffc0200316 <kmonitor+0xa8>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc020032a:	00141793          	slli	a5,s0,0x1
ffffffffc020032e:	97a2                	add	a5,a5,s0
ffffffffc0200330:	078e                	slli	a5,a5,0x3
ffffffffc0200332:	97e6                	add	a5,a5,s9
ffffffffc0200334:	6b9c                	ld	a5,16(a5)
ffffffffc0200336:	8662                	mv	a2,s8
ffffffffc0200338:	002c                	addi	a1,sp,8
ffffffffc020033a:	fff4851b          	addiw	a0,s1,-1
ffffffffc020033e:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc0200340:	f8055ce3          	bgez	a0,ffffffffc02002d8 <kmonitor+0x6a>
}
ffffffffc0200344:	60ee                	ld	ra,216(sp)
ffffffffc0200346:	644e                	ld	s0,208(sp)
ffffffffc0200348:	64ae                	ld	s1,200(sp)
ffffffffc020034a:	690e                	ld	s2,192(sp)
ffffffffc020034c:	79ea                	ld	s3,184(sp)
ffffffffc020034e:	7a4a                	ld	s4,176(sp)
ffffffffc0200350:	7aaa                	ld	s5,168(sp)
ffffffffc0200352:	7b0a                	ld	s6,160(sp)
ffffffffc0200354:	6bea                	ld	s7,152(sp)
ffffffffc0200356:	6c4a                	ld	s8,144(sp)
ffffffffc0200358:	6caa                	ld	s9,136(sp)
ffffffffc020035a:	6d0a                	ld	s10,128(sp)
ffffffffc020035c:	612d                	addi	sp,sp,224
ffffffffc020035e:	8082                	ret
        if (*buf == '\0') {
ffffffffc0200360:	00044783          	lbu	a5,0(s0)
ffffffffc0200364:	dfc9                	beqz	a5,ffffffffc02002fe <kmonitor+0x90>
        if (argc == MAXARGS - 1) {
ffffffffc0200366:	03448863          	beq	s1,s4,ffffffffc0200396 <kmonitor+0x128>
        argv[argc ++] = buf;
ffffffffc020036a:	00349793          	slli	a5,s1,0x3
ffffffffc020036e:	0118                	addi	a4,sp,128
ffffffffc0200370:	97ba                	add	a5,a5,a4
ffffffffc0200372:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200376:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc020037a:	2485                	addiw	s1,s1,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc020037c:	e591                	bnez	a1,ffffffffc0200388 <kmonitor+0x11a>
ffffffffc020037e:	b749                	j	ffffffffc0200300 <kmonitor+0x92>
            buf ++;
ffffffffc0200380:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200382:	00044583          	lbu	a1,0(s0)
ffffffffc0200386:	ddad                	beqz	a1,ffffffffc0200300 <kmonitor+0x92>
ffffffffc0200388:	854a                	mv	a0,s2
ffffffffc020038a:	6c6020ef          	jal	ra,ffffffffc0202a50 <strchr>
ffffffffc020038e:	d96d                	beqz	a0,ffffffffc0200380 <kmonitor+0x112>
ffffffffc0200390:	00044583          	lbu	a1,0(s0)
ffffffffc0200394:	bf91                	j	ffffffffc02002e8 <kmonitor+0x7a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200396:	45c1                	li	a1,16
ffffffffc0200398:	855a                	mv	a0,s6
ffffffffc020039a:	d21ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
ffffffffc020039e:	b7f1                	j	ffffffffc020036a <kmonitor+0xfc>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc02003a0:	6582                	ld	a1,0(sp)
ffffffffc02003a2:	00003517          	auipc	a0,0x3
ffffffffc02003a6:	8de50513          	addi	a0,a0,-1826 # ffffffffc0202c80 <commands+0xc8>
ffffffffc02003aa:	d11ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    return 0;
ffffffffc02003ae:	b72d                	j	ffffffffc02002d8 <kmonitor+0x6a>

ffffffffc02003b0 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc02003b0:	00007317          	auipc	t1,0x7
ffffffffc02003b4:	11830313          	addi	t1,t1,280 # ffffffffc02074c8 <is_panic>
ffffffffc02003b8:	00032303          	lw	t1,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc02003bc:	715d                	addi	sp,sp,-80
ffffffffc02003be:	ec06                	sd	ra,24(sp)
ffffffffc02003c0:	e822                	sd	s0,16(sp)
ffffffffc02003c2:	f436                	sd	a3,40(sp)
ffffffffc02003c4:	f83a                	sd	a4,48(sp)
ffffffffc02003c6:	fc3e                	sd	a5,56(sp)
ffffffffc02003c8:	e0c2                	sd	a6,64(sp)
ffffffffc02003ca:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc02003cc:	02031c63          	bnez	t1,ffffffffc0200404 <__panic+0x54>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02003d0:	4785                	li	a5,1
ffffffffc02003d2:	8432                	mv	s0,a2
ffffffffc02003d4:	00007717          	auipc	a4,0x7
ffffffffc02003d8:	0ef72a23          	sw	a5,244(a4) # ffffffffc02074c8 <is_panic>

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02003dc:	862e                	mv	a2,a1
    va_start(ap, fmt);
ffffffffc02003de:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02003e0:	85aa                	mv	a1,a0
ffffffffc02003e2:	00003517          	auipc	a0,0x3
ffffffffc02003e6:	95650513          	addi	a0,a0,-1706 # ffffffffc0202d38 <commands+0x180>
    va_start(ap, fmt);
ffffffffc02003ea:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02003ec:	ccfff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    vcprintf(fmt, ap);
ffffffffc02003f0:	65a2                	ld	a1,8(sp)
ffffffffc02003f2:	8522                	mv	a0,s0
ffffffffc02003f4:	ca7ff0ef          	jal	ra,ffffffffc020009a <vcprintf>
    cprintf("\n");
ffffffffc02003f8:	00002517          	auipc	a0,0x2
ffffffffc02003fc:	7b850513          	addi	a0,a0,1976 # ffffffffc0202bb0 <etext+0x118>
ffffffffc0200400:	cbbff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
ffffffffc0200404:	064000ef          	jal	ra,ffffffffc0200468 <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200408:	4501                	li	a0,0
ffffffffc020040a:	e65ff0ef          	jal	ra,ffffffffc020026e <kmonitor>
ffffffffc020040e:	bfed                	j	ffffffffc0200408 <__panic+0x58>

ffffffffc0200410 <clock_init>:

/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
ffffffffc0200410:	1141                	addi	sp,sp,-16
ffffffffc0200412:	e406                	sd	ra,8(sp)
    // enable timer interrupt in sie
    set_csr(sie, MIP_STIP);
ffffffffc0200414:	02000793          	li	a5,32
ffffffffc0200418:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020041c:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200420:	67e1                	lui	a5,0x18
ffffffffc0200422:	6a078793          	addi	a5,a5,1696 # 186a0 <BASE_ADDRESS-0xffffffffc01e7960>
ffffffffc0200426:	953e                	add	a0,a0,a5
ffffffffc0200428:	59e020ef          	jal	ra,ffffffffc02029c6 <sbi_set_timer>
}
ffffffffc020042c:	60a2                	ld	ra,8(sp)
    ticks = 0;
ffffffffc020042e:	00007797          	auipc	a5,0x7
ffffffffc0200432:	0e07b923          	sd	zero,242(a5) # ffffffffc0207520 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc0200436:	00003517          	auipc	a0,0x3
ffffffffc020043a:	92250513          	addi	a0,a0,-1758 # ffffffffc0202d58 <commands+0x1a0>
}
ffffffffc020043e:	0141                	addi	sp,sp,16
    cprintf("++ setup timer interrupts\n");
ffffffffc0200440:	c7bff06f          	j	ffffffffc02000ba <cprintf>

ffffffffc0200444 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200444:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200448:	67e1                	lui	a5,0x18
ffffffffc020044a:	6a078793          	addi	a5,a5,1696 # 186a0 <BASE_ADDRESS-0xffffffffc01e7960>
ffffffffc020044e:	953e                	add	a0,a0,a5
ffffffffc0200450:	5760206f          	j	ffffffffc02029c6 <sbi_set_timer>

ffffffffc0200454 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200454:	8082                	ret

ffffffffc0200456 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc0200456:	0ff57513          	andi	a0,a0,255
ffffffffc020045a:	5500206f          	j	ffffffffc02029aa <sbi_console_putchar>

ffffffffc020045e <cons_getc>:
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int cons_getc(void) {
    int c = 0;
    c = sbi_console_getchar();
ffffffffc020045e:	5840206f          	j	ffffffffc02029e2 <sbi_console_getchar>

ffffffffc0200462 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200462:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200466:	8082                	ret

ffffffffc0200468 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200468:	100177f3          	csrrci	a5,sstatus,2
ffffffffc020046c:	8082                	ret

ffffffffc020046e <idt_init>:
     */

    extern void __alltraps(void);
    /* Set sup0 scratch register to 0, indicating to exception vector
       that we are presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc020046e:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc0200472:	00000797          	auipc	a5,0x0
ffffffffc0200476:	30678793          	addi	a5,a5,774 # ffffffffc0200778 <__alltraps>
ffffffffc020047a:	10579073          	csrw	stvec,a5
}
ffffffffc020047e:	8082                	ret

ffffffffc0200480 <print_regs>:
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200480:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs *gpr) {
ffffffffc0200482:	1141                	addi	sp,sp,-16
ffffffffc0200484:	e022                	sd	s0,0(sp)
ffffffffc0200486:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200488:	00003517          	auipc	a0,0x3
ffffffffc020048c:	9e850513          	addi	a0,a0,-1560 # ffffffffc0202e70 <commands+0x2b8>
void print_regs(struct pushregs *gpr) {
ffffffffc0200490:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200492:	c29ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200496:	640c                	ld	a1,8(s0)
ffffffffc0200498:	00003517          	auipc	a0,0x3
ffffffffc020049c:	9f050513          	addi	a0,a0,-1552 # ffffffffc0202e88 <commands+0x2d0>
ffffffffc02004a0:	c1bff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02004a4:	680c                	ld	a1,16(s0)
ffffffffc02004a6:	00003517          	auipc	a0,0x3
ffffffffc02004aa:	9fa50513          	addi	a0,a0,-1542 # ffffffffc0202ea0 <commands+0x2e8>
ffffffffc02004ae:	c0dff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc02004b2:	6c0c                	ld	a1,24(s0)
ffffffffc02004b4:	00003517          	auipc	a0,0x3
ffffffffc02004b8:	a0450513          	addi	a0,a0,-1532 # ffffffffc0202eb8 <commands+0x300>
ffffffffc02004bc:	bffff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc02004c0:	700c                	ld	a1,32(s0)
ffffffffc02004c2:	00003517          	auipc	a0,0x3
ffffffffc02004c6:	a0e50513          	addi	a0,a0,-1522 # ffffffffc0202ed0 <commands+0x318>
ffffffffc02004ca:	bf1ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc02004ce:	740c                	ld	a1,40(s0)
ffffffffc02004d0:	00003517          	auipc	a0,0x3
ffffffffc02004d4:	a1850513          	addi	a0,a0,-1512 # ffffffffc0202ee8 <commands+0x330>
ffffffffc02004d8:	be3ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02004dc:	780c                	ld	a1,48(s0)
ffffffffc02004de:	00003517          	auipc	a0,0x3
ffffffffc02004e2:	a2250513          	addi	a0,a0,-1502 # ffffffffc0202f00 <commands+0x348>
ffffffffc02004e6:	bd5ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02004ea:	7c0c                	ld	a1,56(s0)
ffffffffc02004ec:	00003517          	auipc	a0,0x3
ffffffffc02004f0:	a2c50513          	addi	a0,a0,-1492 # ffffffffc0202f18 <commands+0x360>
ffffffffc02004f4:	bc7ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02004f8:	602c                	ld	a1,64(s0)
ffffffffc02004fa:	00003517          	auipc	a0,0x3
ffffffffc02004fe:	a3650513          	addi	a0,a0,-1482 # ffffffffc0202f30 <commands+0x378>
ffffffffc0200502:	bb9ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200506:	642c                	ld	a1,72(s0)
ffffffffc0200508:	00003517          	auipc	a0,0x3
ffffffffc020050c:	a4050513          	addi	a0,a0,-1472 # ffffffffc0202f48 <commands+0x390>
ffffffffc0200510:	babff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200514:	682c                	ld	a1,80(s0)
ffffffffc0200516:	00003517          	auipc	a0,0x3
ffffffffc020051a:	a4a50513          	addi	a0,a0,-1462 # ffffffffc0202f60 <commands+0x3a8>
ffffffffc020051e:	b9dff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200522:	6c2c                	ld	a1,88(s0)
ffffffffc0200524:	00003517          	auipc	a0,0x3
ffffffffc0200528:	a5450513          	addi	a0,a0,-1452 # ffffffffc0202f78 <commands+0x3c0>
ffffffffc020052c:	b8fff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200530:	702c                	ld	a1,96(s0)
ffffffffc0200532:	00003517          	auipc	a0,0x3
ffffffffc0200536:	a5e50513          	addi	a0,a0,-1442 # ffffffffc0202f90 <commands+0x3d8>
ffffffffc020053a:	b81ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc020053e:	742c                	ld	a1,104(s0)
ffffffffc0200540:	00003517          	auipc	a0,0x3
ffffffffc0200544:	a6850513          	addi	a0,a0,-1432 # ffffffffc0202fa8 <commands+0x3f0>
ffffffffc0200548:	b73ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc020054c:	782c                	ld	a1,112(s0)
ffffffffc020054e:	00003517          	auipc	a0,0x3
ffffffffc0200552:	a7250513          	addi	a0,a0,-1422 # ffffffffc0202fc0 <commands+0x408>
ffffffffc0200556:	b65ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc020055a:	7c2c                	ld	a1,120(s0)
ffffffffc020055c:	00003517          	auipc	a0,0x3
ffffffffc0200560:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0202fd8 <commands+0x420>
ffffffffc0200564:	b57ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200568:	604c                	ld	a1,128(s0)
ffffffffc020056a:	00003517          	auipc	a0,0x3
ffffffffc020056e:	a8650513          	addi	a0,a0,-1402 # ffffffffc0202ff0 <commands+0x438>
ffffffffc0200572:	b49ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200576:	644c                	ld	a1,136(s0)
ffffffffc0200578:	00003517          	auipc	a0,0x3
ffffffffc020057c:	a9050513          	addi	a0,a0,-1392 # ffffffffc0203008 <commands+0x450>
ffffffffc0200580:	b3bff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200584:	684c                	ld	a1,144(s0)
ffffffffc0200586:	00003517          	auipc	a0,0x3
ffffffffc020058a:	a9a50513          	addi	a0,a0,-1382 # ffffffffc0203020 <commands+0x468>
ffffffffc020058e:	b2dff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200592:	6c4c                	ld	a1,152(s0)
ffffffffc0200594:	00003517          	auipc	a0,0x3
ffffffffc0200598:	aa450513          	addi	a0,a0,-1372 # ffffffffc0203038 <commands+0x480>
ffffffffc020059c:	b1fff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc02005a0:	704c                	ld	a1,160(s0)
ffffffffc02005a2:	00003517          	auipc	a0,0x3
ffffffffc02005a6:	aae50513          	addi	a0,a0,-1362 # ffffffffc0203050 <commands+0x498>
ffffffffc02005aa:	b11ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc02005ae:	744c                	ld	a1,168(s0)
ffffffffc02005b0:	00003517          	auipc	a0,0x3
ffffffffc02005b4:	ab850513          	addi	a0,a0,-1352 # ffffffffc0203068 <commands+0x4b0>
ffffffffc02005b8:	b03ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc02005bc:	784c                	ld	a1,176(s0)
ffffffffc02005be:	00003517          	auipc	a0,0x3
ffffffffc02005c2:	ac250513          	addi	a0,a0,-1342 # ffffffffc0203080 <commands+0x4c8>
ffffffffc02005c6:	af5ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc02005ca:	7c4c                	ld	a1,184(s0)
ffffffffc02005cc:	00003517          	auipc	a0,0x3
ffffffffc02005d0:	acc50513          	addi	a0,a0,-1332 # ffffffffc0203098 <commands+0x4e0>
ffffffffc02005d4:	ae7ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02005d8:	606c                	ld	a1,192(s0)
ffffffffc02005da:	00003517          	auipc	a0,0x3
ffffffffc02005de:	ad650513          	addi	a0,a0,-1322 # ffffffffc02030b0 <commands+0x4f8>
ffffffffc02005e2:	ad9ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02005e6:	646c                	ld	a1,200(s0)
ffffffffc02005e8:	00003517          	auipc	a0,0x3
ffffffffc02005ec:	ae050513          	addi	a0,a0,-1312 # ffffffffc02030c8 <commands+0x510>
ffffffffc02005f0:	acbff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02005f4:	686c                	ld	a1,208(s0)
ffffffffc02005f6:	00003517          	auipc	a0,0x3
ffffffffc02005fa:	aea50513          	addi	a0,a0,-1302 # ffffffffc02030e0 <commands+0x528>
ffffffffc02005fe:	abdff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200602:	6c6c                	ld	a1,216(s0)
ffffffffc0200604:	00003517          	auipc	a0,0x3
ffffffffc0200608:	af450513          	addi	a0,a0,-1292 # ffffffffc02030f8 <commands+0x540>
ffffffffc020060c:	aafff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200610:	706c                	ld	a1,224(s0)
ffffffffc0200612:	00003517          	auipc	a0,0x3
ffffffffc0200616:	afe50513          	addi	a0,a0,-1282 # ffffffffc0203110 <commands+0x558>
ffffffffc020061a:	aa1ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc020061e:	746c                	ld	a1,232(s0)
ffffffffc0200620:	00003517          	auipc	a0,0x3
ffffffffc0200624:	b0850513          	addi	a0,a0,-1272 # ffffffffc0203128 <commands+0x570>
ffffffffc0200628:	a93ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc020062c:	786c                	ld	a1,240(s0)
ffffffffc020062e:	00003517          	auipc	a0,0x3
ffffffffc0200632:	b1250513          	addi	a0,a0,-1262 # ffffffffc0203140 <commands+0x588>
ffffffffc0200636:	a85ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc020063a:	7c6c                	ld	a1,248(s0)
}
ffffffffc020063c:	6402                	ld	s0,0(sp)
ffffffffc020063e:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200640:	00003517          	auipc	a0,0x3
ffffffffc0200644:	b1850513          	addi	a0,a0,-1256 # ffffffffc0203158 <commands+0x5a0>
}
ffffffffc0200648:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc020064a:	a71ff06f          	j	ffffffffc02000ba <cprintf>

ffffffffc020064e <print_trapframe>:
void print_trapframe(struct trapframe *tf) {
ffffffffc020064e:	1141                	addi	sp,sp,-16
ffffffffc0200650:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200652:	85aa                	mv	a1,a0
void print_trapframe(struct trapframe *tf) {
ffffffffc0200654:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200656:	00003517          	auipc	a0,0x3
ffffffffc020065a:	b1a50513          	addi	a0,a0,-1254 # ffffffffc0203170 <commands+0x5b8>
void print_trapframe(struct trapframe *tf) {
ffffffffc020065e:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200660:	a5bff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200664:	8522                	mv	a0,s0
ffffffffc0200666:	e1bff0ef          	jal	ra,ffffffffc0200480 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc020066a:	10043583          	ld	a1,256(s0)
ffffffffc020066e:	00003517          	auipc	a0,0x3
ffffffffc0200672:	b1a50513          	addi	a0,a0,-1254 # ffffffffc0203188 <commands+0x5d0>
ffffffffc0200676:	a45ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc020067a:	10843583          	ld	a1,264(s0)
ffffffffc020067e:	00003517          	auipc	a0,0x3
ffffffffc0200682:	b2250513          	addi	a0,a0,-1246 # ffffffffc02031a0 <commands+0x5e8>
ffffffffc0200686:	a35ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
ffffffffc020068a:	11043583          	ld	a1,272(s0)
ffffffffc020068e:	00003517          	auipc	a0,0x3
ffffffffc0200692:	b2a50513          	addi	a0,a0,-1238 # ffffffffc02031b8 <commands+0x600>
ffffffffc0200696:	a25ff0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020069a:	11843583          	ld	a1,280(s0)
}
ffffffffc020069e:	6402                	ld	s0,0(sp)
ffffffffc02006a0:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc02006a2:	00003517          	auipc	a0,0x3
ffffffffc02006a6:	b2e50513          	addi	a0,a0,-1234 # ffffffffc02031d0 <commands+0x618>
}
ffffffffc02006aa:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc02006ac:	a0fff06f          	j	ffffffffc02000ba <cprintf>

ffffffffc02006b0 <interrupt_handler>:

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc02006b0:	11853783          	ld	a5,280(a0)
ffffffffc02006b4:	577d                	li	a4,-1
ffffffffc02006b6:	8305                	srli	a4,a4,0x1
ffffffffc02006b8:	8ff9                	and	a5,a5,a4
    switch (cause) {
ffffffffc02006ba:	472d                	li	a4,11
ffffffffc02006bc:	08f76563          	bltu	a4,a5,ffffffffc0200746 <interrupt_handler+0x96>
ffffffffc02006c0:	00002717          	auipc	a4,0x2
ffffffffc02006c4:	6b470713          	addi	a4,a4,1716 # ffffffffc0202d74 <commands+0x1bc>
ffffffffc02006c8:	078a                	slli	a5,a5,0x2
ffffffffc02006ca:	97ba                	add	a5,a5,a4
ffffffffc02006cc:	439c                	lw	a5,0(a5)
ffffffffc02006ce:	97ba                	add	a5,a5,a4
ffffffffc02006d0:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc02006d2:	00002517          	auipc	a0,0x2
ffffffffc02006d6:	73650513          	addi	a0,a0,1846 # ffffffffc0202e08 <commands+0x250>
ffffffffc02006da:	9e1ff06f          	j	ffffffffc02000ba <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc02006de:	00002517          	auipc	a0,0x2
ffffffffc02006e2:	70a50513          	addi	a0,a0,1802 # ffffffffc0202de8 <commands+0x230>
ffffffffc02006e6:	9d5ff06f          	j	ffffffffc02000ba <cprintf>
            cprintf("User software interrupt\n");
ffffffffc02006ea:	00002517          	auipc	a0,0x2
ffffffffc02006ee:	6be50513          	addi	a0,a0,1726 # ffffffffc0202da8 <commands+0x1f0>
ffffffffc02006f2:	9c9ff06f          	j	ffffffffc02000ba <cprintf>
            break;
        case IRQ_U_TIMER:
            cprintf("User Timer interrupt\n");
ffffffffc02006f6:	00002517          	auipc	a0,0x2
ffffffffc02006fa:	73250513          	addi	a0,a0,1842 # ffffffffc0202e28 <commands+0x270>
ffffffffc02006fe:	9bdff06f          	j	ffffffffc02000ba <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc0200702:	1141                	addi	sp,sp,-16
ffffffffc0200704:	e406                	sd	ra,8(sp)
            // read-only." -- privileged spec1.9.1, 4.1.4, p59
            // In fact, Call sbi_set_timer will clear STIP, or you can clear it
            // directly.
            // cprintf("Supervisor timer interrupt\n");
            // clear_csr(sip, SIP_STIP);
            clock_set_next_event();
ffffffffc0200706:	d3fff0ef          	jal	ra,ffffffffc0200444 <clock_set_next_event>
            if (++ticks % TICK_NUM == 0) {
ffffffffc020070a:	00007797          	auipc	a5,0x7
ffffffffc020070e:	e1678793          	addi	a5,a5,-490 # ffffffffc0207520 <ticks>
ffffffffc0200712:	639c                	ld	a5,0(a5)
ffffffffc0200714:	06400713          	li	a4,100
ffffffffc0200718:	0785                	addi	a5,a5,1
ffffffffc020071a:	02e7f733          	remu	a4,a5,a4
ffffffffc020071e:	00007697          	auipc	a3,0x7
ffffffffc0200722:	e0f6b123          	sd	a5,-510(a3) # ffffffffc0207520 <ticks>
ffffffffc0200726:	c315                	beqz	a4,ffffffffc020074a <interrupt_handler+0x9a>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200728:	60a2                	ld	ra,8(sp)
ffffffffc020072a:	0141                	addi	sp,sp,16
ffffffffc020072c:	8082                	ret
            cprintf("Supervisor external interrupt\n");
ffffffffc020072e:	00002517          	auipc	a0,0x2
ffffffffc0200732:	72250513          	addi	a0,a0,1826 # ffffffffc0202e50 <commands+0x298>
ffffffffc0200736:	985ff06f          	j	ffffffffc02000ba <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc020073a:	00002517          	auipc	a0,0x2
ffffffffc020073e:	68e50513          	addi	a0,a0,1678 # ffffffffc0202dc8 <commands+0x210>
ffffffffc0200742:	979ff06f          	j	ffffffffc02000ba <cprintf>
            print_trapframe(tf);
ffffffffc0200746:	f09ff06f          	j	ffffffffc020064e <print_trapframe>
}
ffffffffc020074a:	60a2                	ld	ra,8(sp)
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc020074c:	06400593          	li	a1,100
ffffffffc0200750:	00002517          	auipc	a0,0x2
ffffffffc0200754:	6f050513          	addi	a0,a0,1776 # ffffffffc0202e40 <commands+0x288>
}
ffffffffc0200758:	0141                	addi	sp,sp,16
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc020075a:	961ff06f          	j	ffffffffc02000ba <cprintf>

ffffffffc020075e <trap>:
            break;
    }
}

static inline void trap_dispatch(struct trapframe *tf) {
    if ((intptr_t)tf->cause < 0) {
ffffffffc020075e:	11853783          	ld	a5,280(a0)
ffffffffc0200762:	0007c863          	bltz	a5,ffffffffc0200772 <trap+0x14>
    switch (tf->cause) {
ffffffffc0200766:	472d                	li	a4,11
ffffffffc0200768:	00f76363          	bltu	a4,a5,ffffffffc020076e <trap+0x10>
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf) {
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
}
ffffffffc020076c:	8082                	ret
            print_trapframe(tf);
ffffffffc020076e:	ee1ff06f          	j	ffffffffc020064e <print_trapframe>
        interrupt_handler(tf);
ffffffffc0200772:	f3fff06f          	j	ffffffffc02006b0 <interrupt_handler>
	...

ffffffffc0200778 <__alltraps>:
    .endm

    .globl __alltraps
    .align(2)
__alltraps:
    SAVE_ALL
ffffffffc0200778:	14011073          	csrw	sscratch,sp
ffffffffc020077c:	712d                	addi	sp,sp,-288
ffffffffc020077e:	e002                	sd	zero,0(sp)
ffffffffc0200780:	e406                	sd	ra,8(sp)
ffffffffc0200782:	ec0e                	sd	gp,24(sp)
ffffffffc0200784:	f012                	sd	tp,32(sp)
ffffffffc0200786:	f416                	sd	t0,40(sp)
ffffffffc0200788:	f81a                	sd	t1,48(sp)
ffffffffc020078a:	fc1e                	sd	t2,56(sp)
ffffffffc020078c:	e0a2                	sd	s0,64(sp)
ffffffffc020078e:	e4a6                	sd	s1,72(sp)
ffffffffc0200790:	e8aa                	sd	a0,80(sp)
ffffffffc0200792:	ecae                	sd	a1,88(sp)
ffffffffc0200794:	f0b2                	sd	a2,96(sp)
ffffffffc0200796:	f4b6                	sd	a3,104(sp)
ffffffffc0200798:	f8ba                	sd	a4,112(sp)
ffffffffc020079a:	fcbe                	sd	a5,120(sp)
ffffffffc020079c:	e142                	sd	a6,128(sp)
ffffffffc020079e:	e546                	sd	a7,136(sp)
ffffffffc02007a0:	e94a                	sd	s2,144(sp)
ffffffffc02007a2:	ed4e                	sd	s3,152(sp)
ffffffffc02007a4:	f152                	sd	s4,160(sp)
ffffffffc02007a6:	f556                	sd	s5,168(sp)
ffffffffc02007a8:	f95a                	sd	s6,176(sp)
ffffffffc02007aa:	fd5e                	sd	s7,184(sp)
ffffffffc02007ac:	e1e2                	sd	s8,192(sp)
ffffffffc02007ae:	e5e6                	sd	s9,200(sp)
ffffffffc02007b0:	e9ea                	sd	s10,208(sp)
ffffffffc02007b2:	edee                	sd	s11,216(sp)
ffffffffc02007b4:	f1f2                	sd	t3,224(sp)
ffffffffc02007b6:	f5f6                	sd	t4,232(sp)
ffffffffc02007b8:	f9fa                	sd	t5,240(sp)
ffffffffc02007ba:	fdfe                	sd	t6,248(sp)
ffffffffc02007bc:	14001473          	csrrw	s0,sscratch,zero
ffffffffc02007c0:	100024f3          	csrr	s1,sstatus
ffffffffc02007c4:	14102973          	csrr	s2,sepc
ffffffffc02007c8:	143029f3          	csrr	s3,stval
ffffffffc02007cc:	14202a73          	csrr	s4,scause
ffffffffc02007d0:	e822                	sd	s0,16(sp)
ffffffffc02007d2:	e226                	sd	s1,256(sp)
ffffffffc02007d4:	e64a                	sd	s2,264(sp)
ffffffffc02007d6:	ea4e                	sd	s3,272(sp)
ffffffffc02007d8:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc02007da:	850a                	mv	a0,sp
    jal trap
ffffffffc02007dc:	f83ff0ef          	jal	ra,ffffffffc020075e <trap>

ffffffffc02007e0 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc02007e0:	6492                	ld	s1,256(sp)
ffffffffc02007e2:	6932                	ld	s2,264(sp)
ffffffffc02007e4:	10049073          	csrw	sstatus,s1
ffffffffc02007e8:	14191073          	csrw	sepc,s2
ffffffffc02007ec:	60a2                	ld	ra,8(sp)
ffffffffc02007ee:	61e2                	ld	gp,24(sp)
ffffffffc02007f0:	7202                	ld	tp,32(sp)
ffffffffc02007f2:	72a2                	ld	t0,40(sp)
ffffffffc02007f4:	7342                	ld	t1,48(sp)
ffffffffc02007f6:	73e2                	ld	t2,56(sp)
ffffffffc02007f8:	6406                	ld	s0,64(sp)
ffffffffc02007fa:	64a6                	ld	s1,72(sp)
ffffffffc02007fc:	6546                	ld	a0,80(sp)
ffffffffc02007fe:	65e6                	ld	a1,88(sp)
ffffffffc0200800:	7606                	ld	a2,96(sp)
ffffffffc0200802:	76a6                	ld	a3,104(sp)
ffffffffc0200804:	7746                	ld	a4,112(sp)
ffffffffc0200806:	77e6                	ld	a5,120(sp)
ffffffffc0200808:	680a                	ld	a6,128(sp)
ffffffffc020080a:	68aa                	ld	a7,136(sp)
ffffffffc020080c:	694a                	ld	s2,144(sp)
ffffffffc020080e:	69ea                	ld	s3,152(sp)
ffffffffc0200810:	7a0a                	ld	s4,160(sp)
ffffffffc0200812:	7aaa                	ld	s5,168(sp)
ffffffffc0200814:	7b4a                	ld	s6,176(sp)
ffffffffc0200816:	7bea                	ld	s7,184(sp)
ffffffffc0200818:	6c0e                	ld	s8,192(sp)
ffffffffc020081a:	6cae                	ld	s9,200(sp)
ffffffffc020081c:	6d4e                	ld	s10,208(sp)
ffffffffc020081e:	6dee                	ld	s11,216(sp)
ffffffffc0200820:	7e0e                	ld	t3,224(sp)
ffffffffc0200822:	7eae                	ld	t4,232(sp)
ffffffffc0200824:	7f4e                	ld	t5,240(sp)
ffffffffc0200826:	7fee                	ld	t6,248(sp)
ffffffffc0200828:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc020082a:	10200073          	sret

ffffffffc020082e <buddy_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc020082e:	00007797          	auipc	a5,0x7
ffffffffc0200832:	cfa78793          	addi	a5,a5,-774 # ffffffffc0207528 <free_area>
ffffffffc0200836:	e79c                	sd	a5,8(a5)
ffffffffc0200838:	e39c                	sd	a5,0(a5)
#define POWER_ROUND_DOWN(a) (POWER_REMAINDER(a) ? ((a)-POWER_REMAINDER(a)) : (a))

static void buddy_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc020083a:	0007a823          	sw	zero,16(a5)
}
ffffffffc020083e:	8082                	ret

ffffffffc0200840 <buddy_nr_free_pages>:

static size_t
buddy_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0200840:	00007517          	auipc	a0,0x7
ffffffffc0200844:	cf856503          	lwu	a0,-776(a0) # ffffffffc0207538 <free_area+0x10>
ffffffffc0200848:	8082                	ret

ffffffffc020084a <buddy_free_pages>:
{
ffffffffc020084a:	1141                	addi	sp,sp,-16
ffffffffc020084c:	e406                	sd	ra,8(sp)
ffffffffc020084e:	e022                	sd	s0,0(sp)
    assert(n > 0);
ffffffffc0200850:	22058b63          	beqz	a1,ffffffffc0200a86 <buddy_free_pages+0x23c>
    size_t length = POWER_ROUND_UP(n);
ffffffffc0200854:	0015d793          	srli	a5,a1,0x1
ffffffffc0200858:	8fcd                	or	a5,a5,a1
ffffffffc020085a:	0027d713          	srli	a4,a5,0x2
ffffffffc020085e:	8fd9                	or	a5,a5,a4
ffffffffc0200860:	0047d713          	srli	a4,a5,0x4
ffffffffc0200864:	8f5d                	or	a4,a4,a5
ffffffffc0200866:	00875793          	srli	a5,a4,0x8
ffffffffc020086a:	8f5d                	or	a4,a4,a5
ffffffffc020086c:	01075793          	srli	a5,a4,0x10
ffffffffc0200870:	8fd9                	or	a5,a5,a4
ffffffffc0200872:	8385                	srli	a5,a5,0x1
ffffffffc0200874:	00b7f733          	and	a4,a5,a1
ffffffffc0200878:	8e2e                	mv	t3,a1
ffffffffc020087a:	1e071063          	bnez	a4,ffffffffc0200a5a <buddy_free_pages+0x210>
    size_t begin = (base - allocate_area);
ffffffffc020087e:	00007797          	auipc	a5,0x7
ffffffffc0200882:	c5278793          	addi	a5,a5,-942 # ffffffffc02074d0 <allocate_area>
ffffffffc0200886:	0007b803          	ld	a6,0(a5)
ffffffffc020088a:	00003717          	auipc	a4,0x3
ffffffffc020088e:	b9e70713          	addi	a4,a4,-1122 # ffffffffc0203428 <commands+0x870>
ffffffffc0200892:	6318                	ld	a4,0(a4)
ffffffffc0200894:	410507b3          	sub	a5,a0,a6
ffffffffc0200898:	878d                	srai	a5,a5,0x3
ffffffffc020089a:	02e787b3          	mul	a5,a5,a4
    size_t block = BUDDY_BLOCK(begin, end);
ffffffffc020089e:	00007717          	auipc	a4,0x7
ffffffffc02008a2:	c3a70713          	addi	a4,a4,-966 # ffffffffc02074d8 <full_tree_size>
ffffffffc02008a6:	00073883          	ld	a7,0(a4)
    for (; p != base + n; p++)
ffffffffc02008aa:	00259713          	slli	a4,a1,0x2
ffffffffc02008ae:	00b70633          	add	a2,a4,a1
ffffffffc02008b2:	060e                	slli	a2,a2,0x3
ffffffffc02008b4:	962a                	add	a2,a2,a0
    size_t block = BUDDY_BLOCK(begin, end);
ffffffffc02008b6:	03c7d7b3          	divu	a5,a5,t3
ffffffffc02008ba:	03c8d733          	divu	a4,a7,t3
ffffffffc02008be:	973e                	add	a4,a4,a5
    for (; p != base + n; p++)
ffffffffc02008c0:	02c50363          	beq	a0,a2,ffffffffc02008e6 <buddy_free_pages+0x9c>
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02008c4:	6514                	ld	a3,8(a0)
        assert(!PageReserved(p));
ffffffffc02008c6:	87aa                	mv	a5,a0
ffffffffc02008c8:	8a85                	andi	a3,a3,1
ffffffffc02008ca:	c691                	beqz	a3,ffffffffc02008d6 <buddy_free_pages+0x8c>
ffffffffc02008cc:	aa69                	j	ffffffffc0200a66 <buddy_free_pages+0x21c>
ffffffffc02008ce:	6794                	ld	a3,8(a5)
ffffffffc02008d0:	8a85                	andi	a3,a3,1
ffffffffc02008d2:	18069a63          	bnez	a3,ffffffffc0200a66 <buddy_free_pages+0x21c>
        p->flags = 0;
ffffffffc02008d6:	0007b423          	sd	zero,8(a5)
    return KADDR(page2pa(page));
}

static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc02008da:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02008de:	02878793          	addi	a5,a5,40
ffffffffc02008e2:	fec796e3          	bne	a5,a2,ffffffffc02008ce <buddy_free_pages+0x84>
 * Insert the new element @elm *after* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_after(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm, listelm->next);
ffffffffc02008e6:	00007317          	auipc	t1,0x7
ffffffffc02008ea:	c4230313          	addi	t1,t1,-958 # ffffffffc0207528 <free_area>
ffffffffc02008ee:	00833603          	ld	a2,8(t1)
    nr_free += length;
ffffffffc02008f2:	01032783          	lw	a5,16(t1)
    record_area[block] = length;
ffffffffc02008f6:	00007597          	auipc	a1,0x7
ffffffffc02008fa:	bfa58593          	addi	a1,a1,-1030 # ffffffffc02074f0 <record_area>
    base->property = length;
ffffffffc02008fe:	000e069b          	sext.w	a3,t3
    record_area[block] = length;
ffffffffc0200902:	618c                	ld	a1,0(a1)
    base->property = length;
ffffffffc0200904:	c914                	sw	a3,16(a0)
    list_add(&free_list, &(base->page_link));
ffffffffc0200906:	01850e93          	addi	t4,a0,24
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc020090a:	01d63023          	sd	t4,0(a2)
    nr_free += length;
ffffffffc020090e:	9fb5                	addw	a5,a5,a3
    record_area[block] = length;
ffffffffc0200910:	00371693          	slli	a3,a4,0x3
    elm->next = next;
ffffffffc0200914:	f110                	sd	a2,32(a0)
    elm->prev = prev;
ffffffffc0200916:	00653c23          	sd	t1,24(a0)
    nr_free += length;
ffffffffc020091a:	00007617          	auipc	a2,0x7
ffffffffc020091e:	c0f62f23          	sw	a5,-994(a2) # ffffffffc0207538 <free_area+0x10>
    prev->next = next->prev = elm;
ffffffffc0200922:	00007417          	auipc	s0,0x7
ffffffffc0200926:	c1d43723          	sd	t4,-1010(s0) # ffffffffc0207530 <free_area+0x8>
    record_area[block] = length;
ffffffffc020092a:	96ae                	add	a3,a3,a1
ffffffffc020092c:	01c6b023          	sd	t3,0(a3)
    while (block != TREE_ROOT)
ffffffffc0200930:	4785                	li	a5,1
ffffffffc0200932:	4505                	li	a0,1
ffffffffc0200934:	00f71f63          	bne	a4,a5,ffffffffc0200952 <buddy_free_pages+0x108>
ffffffffc0200938:	aa29                	j	ffffffffc0200a52 <buddy_free_pages+0x208>
            record_area[block] = record_area[LEFT_CHILD(block)] | record_area[RIGHT_CHILD(block)];
ffffffffc020093a:	00479713          	slli	a4,a5,0x4
ffffffffc020093e:	972e                	add	a4,a4,a1
ffffffffc0200940:	9616                	add	a2,a2,t0
ffffffffc0200942:	6718                	ld	a4,8(a4)
ffffffffc0200944:	6214                	ld	a3,0(a2)
ffffffffc0200946:	8f55                	or	a4,a4,a3
ffffffffc0200948:	00e2b023          	sd	a4,0(t0)
ffffffffc020094c:	873e                	mv	a4,a5
    while (block != TREE_ROOT)
ffffffffc020094e:	10a78263          	beq	a5,a0,ffffffffc0200a52 <buddy_free_pages+0x208>
        size_t left = LEFT_CHILD(block);
ffffffffc0200952:	ffe77693          	andi	a3,a4,-2
        block = PARENT(block);
ffffffffc0200956:	00175793          	srli	a5,a4,0x1
        if (BUDDY_EMPTY(left) && BUDDY_EMPTY(right))
ffffffffc020095a:	00d7e733          	or	a4,a5,a3
ffffffffc020095e:	00275613          	srli	a2,a4,0x2
ffffffffc0200962:	8f51                	or	a4,a4,a2
ffffffffc0200964:	00475613          	srli	a2,a4,0x4
ffffffffc0200968:	8e59                	or	a2,a2,a4
ffffffffc020096a:	00865713          	srli	a4,a2,0x8
ffffffffc020096e:	8e59                	or	a2,a2,a4
ffffffffc0200970:	01065713          	srli	a4,a2,0x10
ffffffffc0200974:	8f51                	or	a4,a4,a2
ffffffffc0200976:	00369e93          	slli	t4,a3,0x3
ffffffffc020097a:	8305                	srli	a4,a4,0x1
ffffffffc020097c:	9eae                	add	t4,t4,a1
ffffffffc020097e:	00d77f33          	and	t5,a4,a3
ffffffffc0200982:	000ebf83          	ld	t6,0(t4)
        size_t left = LEFT_CHILD(block);
ffffffffc0200986:	8636                	mv	a2,a3
        if (BUDDY_EMPTY(left) && BUDDY_EMPTY(right))
ffffffffc0200988:	000f0663          	beqz	t5,ffffffffc0200994 <buddy_free_pages+0x14a>
ffffffffc020098c:	fff74713          	not	a4,a4
ffffffffc0200990:	00d77633          	and	a2,a4,a3
ffffffffc0200994:	02c8d733          	divu	a4,a7,a2
ffffffffc0200998:	00379613          	slli	a2,a5,0x3
ffffffffc020099c:	00c582b3          	add	t0,a1,a2
ffffffffc02009a0:	f8ef9de3          	bne	t6,a4,ffffffffc020093a <buddy_free_pages+0xf0>
        size_t right = RIGHT_CHILD(block);
ffffffffc02009a4:	0685                	addi	a3,a3,1
        if (BUDDY_EMPTY(left) && BUDDY_EMPTY(right))
ffffffffc02009a6:	0016de13          	srli	t3,a3,0x1
ffffffffc02009aa:	00de6e33          	or	t3,t3,a3
ffffffffc02009ae:	002e5393          	srli	t2,t3,0x2
ffffffffc02009b2:	01c3ee33          	or	t3,t2,t3
ffffffffc02009b6:	004e5393          	srli	t2,t3,0x4
ffffffffc02009ba:	01c3e3b3          	or	t2,t2,t3
ffffffffc02009be:	0083de13          	srli	t3,t2,0x8
ffffffffc02009c2:	007e63b3          	or	t2,t3,t2
ffffffffc02009c6:	0103de13          	srli	t3,t2,0x10
ffffffffc02009ca:	007e6e33          	or	t3,t3,t2
ffffffffc02009ce:	001e5e13          	srli	t3,t3,0x1
ffffffffc02009d2:	00de73b3          	and	t2,t3,a3
ffffffffc02009d6:	008eb403          	ld	s0,8(t4)
ffffffffc02009da:	00038663          	beqz	t2,ffffffffc02009e6 <buddy_free_pages+0x19c>
ffffffffc02009de:	fffe4e13          	not	t3,t3
ffffffffc02009e2:	01c6f6b3          	and	a3,a3,t3
ffffffffc02009e6:	02d8d6b3          	divu	a3,a7,a3
ffffffffc02009ea:	f4d418e3          	bne	s0,a3,ffffffffc020093a <buddy_free_pages+0xf0>
            list_del(&(allocate_area[lbegin].page_link));
ffffffffc02009ee:	02ef0733          	mul	a4,t5,a4
            record_area[block] = record_area[left] << 1;
ffffffffc02009f2:	0f86                	slli	t6,t6,0x1
            list_del(&(allocate_area[rbegin].page_link));
ffffffffc02009f4:	028383b3          	mul	t2,t2,s0
            list_del(&(allocate_area[lbegin].page_link));
ffffffffc02009f8:	00271f13          	slli	t5,a4,0x2
ffffffffc02009fc:	977a                	add	a4,a4,t5
ffffffffc02009fe:	070e                	slli	a4,a4,0x3
ffffffffc0200a00:	9742                	add	a4,a4,a6
    __list_del(listelm->prev, listelm->next);
ffffffffc0200a02:	7310                	ld	a2,32(a4)
ffffffffc0200a04:	01873f03          	ld	t5,24(a4)
            list_add(&free_list, &(allocate_area[lbegin].page_link));
ffffffffc0200a08:	01870e13          	addi	t3,a4,24
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0200a0c:	00cf3423          	sd	a2,8(t5)
            list_del(&(allocate_area[rbegin].page_link));
ffffffffc0200a10:	00239693          	slli	a3,t2,0x2
ffffffffc0200a14:	93b6                	add	t2,t2,a3
ffffffffc0200a16:	00339693          	slli	a3,t2,0x3
    next->prev = prev;
ffffffffc0200a1a:	01e63023          	sd	t5,0(a2)
ffffffffc0200a1e:	96c2                	add	a3,a3,a6
    __list_del(listelm->prev, listelm->next);
ffffffffc0200a20:	6e90                	ld	a2,24(a3)
ffffffffc0200a22:	7294                	ld	a3,32(a3)
    prev->next = next;
ffffffffc0200a24:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0200a26:	e290                	sd	a2,0(a3)
            record_area[block] = record_area[left] << 1;
ffffffffc0200a28:	01f2b023          	sd	t6,0(t0)
            allocate_area[lbegin].property = record_area[left] << 1;
ffffffffc0200a2c:	000eb683          	ld	a3,0(t4)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200a30:	00833603          	ld	a2,8(t1)
ffffffffc0200a34:	0016969b          	slliw	a3,a3,0x1
ffffffffc0200a38:	cb14                	sw	a3,16(a4)
    prev->next = next->prev = elm;
ffffffffc0200a3a:	01c63023          	sd	t3,0(a2)
    elm->next = next;
ffffffffc0200a3e:	f310                	sd	a2,32(a4)
    elm->prev = prev;
ffffffffc0200a40:	00673c23          	sd	t1,24(a4)
    prev->next = next->prev = elm;
ffffffffc0200a44:	00007697          	auipc	a3,0x7
ffffffffc0200a48:	afc6b623          	sd	t3,-1300(a3) # ffffffffc0207530 <free_area+0x8>
    elm->prev = prev;
ffffffffc0200a4c:	873e                	mv	a4,a5
    while (block != TREE_ROOT)
ffffffffc0200a4e:	f0a792e3          	bne	a5,a0,ffffffffc0200952 <buddy_free_pages+0x108>
}
ffffffffc0200a52:	60a2                	ld	ra,8(sp)
ffffffffc0200a54:	6402                	ld	s0,0(sp)
ffffffffc0200a56:	0141                	addi	sp,sp,16
ffffffffc0200a58:	8082                	ret
    size_t length = POWER_ROUND_UP(n);
ffffffffc0200a5a:	fff7c793          	not	a5,a5
ffffffffc0200a5e:	8fed                	and	a5,a5,a1
ffffffffc0200a60:	00179e13          	slli	t3,a5,0x1
ffffffffc0200a64:	bd29                	j	ffffffffc020087e <buddy_free_pages+0x34>
        assert(!PageReserved(p));
ffffffffc0200a66:	00003697          	auipc	a3,0x3
ffffffffc0200a6a:	9fa68693          	addi	a3,a3,-1542 # ffffffffc0203460 <commands+0x8a8>
ffffffffc0200a6e:	00003617          	auipc	a2,0x3
ffffffffc0200a72:	9ca60613          	addi	a2,a2,-1590 # ffffffffc0203438 <commands+0x880>
ffffffffc0200a76:	0ab00593          	li	a1,171
ffffffffc0200a7a:	00003517          	auipc	a0,0x3
ffffffffc0200a7e:	9d650513          	addi	a0,a0,-1578 # ffffffffc0203450 <commands+0x898>
ffffffffc0200a82:	92fff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(n > 0);
ffffffffc0200a86:	00003697          	auipc	a3,0x3
ffffffffc0200a8a:	9aa68693          	addi	a3,a3,-1622 # ffffffffc0203430 <commands+0x878>
ffffffffc0200a8e:	00003617          	auipc	a2,0x3
ffffffffc0200a92:	9aa60613          	addi	a2,a2,-1622 # ffffffffc0203438 <commands+0x880>
ffffffffc0200a96:	0a200593          	li	a1,162
ffffffffc0200a9a:	00003517          	auipc	a0,0x3
ffffffffc0200a9e:	9b650513          	addi	a0,a0,-1610 # ffffffffc0203450 <commands+0x898>
ffffffffc0200aa2:	90fff0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0200aa6 <buddy_allocate_pages>:
    assert(n > 0);
ffffffffc0200aa6:	1c050563          	beqz	a0,ffffffffc0200c70 <buddy_allocate_pages+0x1ca>
    size_t length = POWER_ROUND_UP(n);
ffffffffc0200aaa:	00155793          	srli	a5,a0,0x1
ffffffffc0200aae:	8fc9                	or	a5,a5,a0
ffffffffc0200ab0:	0027d713          	srli	a4,a5,0x2
ffffffffc0200ab4:	8fd9                	or	a5,a5,a4
ffffffffc0200ab6:	0047d713          	srli	a4,a5,0x4
ffffffffc0200aba:	8f5d                	or	a4,a4,a5
ffffffffc0200abc:	00875793          	srli	a5,a4,0x8
ffffffffc0200ac0:	8f5d                	or	a4,a4,a5
ffffffffc0200ac2:	01075793          	srli	a5,a4,0x10
ffffffffc0200ac6:	8fd9                	or	a5,a5,a4
ffffffffc0200ac8:	8385                	srli	a5,a5,0x1
ffffffffc0200aca:	00a7f733          	and	a4,a5,a0
ffffffffc0200ace:	18071c63          	bnez	a4,ffffffffc0200c66 <buddy_allocate_pages+0x1c0>
    while (length <= record_area[block] && length < NODE_LENGTH(block))
ffffffffc0200ad2:	00007797          	auipc	a5,0x7
ffffffffc0200ad6:	a1e78793          	addi	a5,a5,-1506 # ffffffffc02074f0 <record_area>
ffffffffc0200ada:	0007b803          	ld	a6,0(a5)
ffffffffc0200ade:	00007797          	auipc	a5,0x7
ffffffffc0200ae2:	9fa78793          	addi	a5,a5,-1542 # ffffffffc02074d8 <full_tree_size>
ffffffffc0200ae6:	0007be83          	ld	t4,0(a5)
ffffffffc0200aea:	00883583          	ld	a1,8(a6)
            list_del(&(allocate_area[begin].page_link));
ffffffffc0200aee:	00007797          	auipc	a5,0x7
ffffffffc0200af2:	9e278793          	addi	a5,a5,-1566 # ffffffffc02074d0 <allocate_area>
ffffffffc0200af6:	0007be03          	ld	t3,0(a5)
    size_t block = TREE_ROOT;
ffffffffc0200afa:	4785                	li	a5,1
    while (length <= record_area[block] && length < NODE_LENGTH(block))
ffffffffc0200afc:	00379313          	slli	t1,a5,0x3
    __list_add(elm, listelm, listelm->next);
ffffffffc0200b00:	00007f17          	auipc	t5,0x7
ffffffffc0200b04:	a28f0f13          	addi	t5,t5,-1496 # ffffffffc0207528 <free_area>
ffffffffc0200b08:	9342                	add	t1,t1,a6
ffffffffc0200b0a:	06a5ec63          	bltu	a1,a0,ffffffffc0200b82 <buddy_allocate_pages+0xdc>
ffffffffc0200b0e:	0017d613          	srli	a2,a5,0x1
ffffffffc0200b12:	00f66733          	or	a4,a2,a5
ffffffffc0200b16:	00275693          	srli	a3,a4,0x2
ffffffffc0200b1a:	8f55                	or	a4,a4,a3
ffffffffc0200b1c:	00475693          	srli	a3,a4,0x4
ffffffffc0200b20:	8ed9                	or	a3,a3,a4
ffffffffc0200b22:	0086d713          	srli	a4,a3,0x8
ffffffffc0200b26:	8ed9                	or	a3,a3,a4
ffffffffc0200b28:	0106d713          	srli	a4,a3,0x10
ffffffffc0200b2c:	8f55                	or	a4,a4,a3
ffffffffc0200b2e:	8305                	srli	a4,a4,0x1
ffffffffc0200b30:	00f778b3          	and	a7,a4,a5
ffffffffc0200b34:	86be                	mv	a3,a5
ffffffffc0200b36:	00088663          	beqz	a7,ffffffffc0200b42 <buddy_allocate_pages+0x9c>
ffffffffc0200b3a:	fff74713          	not	a4,a4
ffffffffc0200b3e:	00f776b3          	and	a3,a4,a5
ffffffffc0200b42:	02ded733          	divu	a4,t4,a3
ffffffffc0200b46:	0ce57563          	bleu	a4,a0,ffffffffc0200c10 <buddy_allocate_pages+0x16a>
        size_t left = LEFT_CHILD(block);
ffffffffc0200b4a:	00179f93          	slli	t6,a5,0x1
        size_t right = RIGHT_CHILD(block);
ffffffffc0200b4e:	00479693          	slli	a3,a5,0x4
ffffffffc0200b52:	001f8293          	addi	t0,t6,1
        if (BUDDY_EMPTY(block))
ffffffffc0200b56:	96c2                	add	a3,a3,a6
ffffffffc0200b58:	02b70e63          	beq	a4,a1,ffffffffc0200b94 <buddy_allocate_pages+0xee>
        else if (length & record_area[left])
ffffffffc0200b5c:	6298                	ld	a4,0(a3)
ffffffffc0200b5e:	00a77633          	and	a2,a4,a0
ffffffffc0200b62:	e615                	bnez	a2,ffffffffc0200b8e <buddy_allocate_pages+0xe8>
        else if (length & record_area[right])
ffffffffc0200b64:	6694                	ld	a3,8(a3)
ffffffffc0200b66:	00a6f633          	and	a2,a3,a0
ffffffffc0200b6a:	ee11                	bnez	a2,ffffffffc0200b86 <buddy_allocate_pages+0xe0>
        else if (length <= record_area[left])
ffffffffc0200b6c:	02a77163          	bleu	a0,a4,ffffffffc0200b8e <buddy_allocate_pages+0xe8>
        else if (length <= record_area[right])
ffffffffc0200b70:	8fbe                	mv	t6,a5
ffffffffc0200b72:	00a6fa63          	bleu	a0,a3,ffffffffc0200b86 <buddy_allocate_pages+0xe0>
ffffffffc0200b76:	87fe                	mv	a5,t6
    while (length <= record_area[block] && length < NODE_LENGTH(block))
ffffffffc0200b78:	00379313          	slli	t1,a5,0x3
ffffffffc0200b7c:	9342                	add	t1,t1,a6
ffffffffc0200b7e:	f8a5f8e3          	bleu	a0,a1,ffffffffc0200b0e <buddy_allocate_pages+0x68>
        return NULL;
ffffffffc0200b82:	4501                	li	a0,0
}
ffffffffc0200b84:	8082                	ret
            block = right;
ffffffffc0200b86:	8f96                	mv	t6,t0
ffffffffc0200b88:	85b6                	mv	a1,a3
        else if (length <= record_area[right])
ffffffffc0200b8a:	87fe                	mv	a5,t6
ffffffffc0200b8c:	b7f5                	j	ffffffffc0200b78 <buddy_allocate_pages+0xd2>
ffffffffc0200b8e:	85ba                	mv	a1,a4
ffffffffc0200b90:	87fe                	mv	a5,t6
ffffffffc0200b92:	b7dd                	j	ffffffffc0200b78 <buddy_allocate_pages+0xd2>
            size_t begin = NODE_BEGINNING(block);
ffffffffc0200b94:	06088b63          	beqz	a7,ffffffffc0200c0a <buddy_allocate_pages+0x164>
ffffffffc0200b98:	02b888b3          	mul	a7,a7,a1
            size_t end = NODE_ENDDING(block);
ffffffffc0200b9c:	00289613          	slli	a2,a7,0x2
ffffffffc0200ba0:	9646                	add	a2,a2,a7
ffffffffc0200ba2:	011587b3          	add	a5,a1,a7
ffffffffc0200ba6:	060e                	slli	a2,a2,0x3
ffffffffc0200ba8:	98be                	add	a7,a7,a5
ffffffffc0200baa:	9672                	add	a2,a2,t3
    __list_del(listelm->prev, listelm->next);
ffffffffc0200bac:	01863383          	ld	t2,24(a2)
ffffffffc0200bb0:	02063283          	ld	t0,32(a2)
            allocate_area[begin].property >>= 1;
ffffffffc0200bb4:	4a18                	lw	a4,16(a2)
            size_t mid = (begin + end) >> 1;
ffffffffc0200bb6:	0018d893          	srli	a7,a7,0x1
            allocate_area[mid].property = allocate_area[begin].property;
ffffffffc0200bba:	00289793          	slli	a5,a7,0x2
    prev->next = next;
ffffffffc0200bbe:	0053b423          	sd	t0,8(t2)
ffffffffc0200bc2:	97c6                	add	a5,a5,a7
    next->prev = prev;
ffffffffc0200bc4:	0072b023          	sd	t2,0(t0)
            allocate_area[begin].property >>= 1;
ffffffffc0200bc8:	0017571b          	srliw	a4,a4,0x1
            allocate_area[mid].property = allocate_area[begin].property;
ffffffffc0200bcc:	078e                	slli	a5,a5,0x3
            allocate_area[begin].property >>= 1;
ffffffffc0200bce:	ca18                	sw	a4,16(a2)
            allocate_area[mid].property = allocate_area[begin].property;
ffffffffc0200bd0:	97f2                	add	a5,a5,t3
ffffffffc0200bd2:	cb98                	sw	a4,16(a5)
            record_area[left] = record_area[block] >> 1;
ffffffffc0200bd4:	8185                	srli	a1,a1,0x1
ffffffffc0200bd6:	e28c                	sd	a1,0(a3)
            record_area[right] = record_area[block] >> 1;
ffffffffc0200bd8:	00033703          	ld	a4,0(t1)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200bdc:	008f3883          	ld	a7,8(t5)
            list_add(&free_list, &(allocate_area[begin].page_link));
ffffffffc0200be0:	01860593          	addi	a1,a2,24
            record_area[right] = record_area[block] >> 1;
ffffffffc0200be4:	8305                	srli	a4,a4,0x1
ffffffffc0200be6:	e698                	sd	a4,8(a3)
    prev->next = next->prev = elm;
ffffffffc0200be8:	00b8b023          	sd	a1,0(a7)
            list_add(&free_list, &(allocate_area[mid].page_link));
ffffffffc0200bec:	01878713          	addi	a4,a5,24
    elm->next = next;
ffffffffc0200bf0:	03163023          	sd	a7,32(a2)
    prev->next = next->prev = elm;
ffffffffc0200bf4:	ee18                	sd	a4,24(a2)
    elm->next = next;
ffffffffc0200bf6:	f38c                	sd	a1,32(a5)
    elm->prev = prev;
ffffffffc0200bf8:	01e7bc23          	sd	t5,24(a5)
    prev->next = next->prev = elm;
ffffffffc0200bfc:	00007617          	auipc	a2,0x7
ffffffffc0200c00:	92e63a23          	sd	a4,-1740(a2) # ffffffffc0207530 <free_area+0x8>
            block = left;
ffffffffc0200c04:	628c                	ld	a1,0(a3)
        else if (length <= record_area[right])
ffffffffc0200c06:	87fe                	mv	a5,t6
ffffffffc0200c08:	bf85                	j	ffffffffc0200b78 <buddy_allocate_pages+0xd2>
ffffffffc0200c0a:	8672                	mv	a2,t3
ffffffffc0200c0c:	88ae                	mv	a7,a1
ffffffffc0200c0e:	bf79                	j	ffffffffc0200bac <buddy_allocate_pages+0x106>
    page = &(allocate_area[NODE_BEGINNING(block)]);
ffffffffc0200c10:	02e88733          	mul	a4,a7,a4
    nr_free -= length;
ffffffffc0200c14:	00007697          	auipc	a3,0x7
ffffffffc0200c18:	91468693          	addi	a3,a3,-1772 # ffffffffc0207528 <free_area>
ffffffffc0200c1c:	4a94                	lw	a3,16(a3)
    while (block != TREE_ROOT)
ffffffffc0200c1e:	4885                	li	a7,1
    nr_free -= length;
ffffffffc0200c20:	9e89                	subw	a3,a3,a0
    page = &(allocate_area[NODE_BEGINNING(block)]);
ffffffffc0200c22:	00271513          	slli	a0,a4,0x2
ffffffffc0200c26:	972a                	add	a4,a4,a0
ffffffffc0200c28:	00371513          	slli	a0,a4,0x3
ffffffffc0200c2c:	9572                	add	a0,a0,t3
    __list_del(listelm->prev, listelm->next);
ffffffffc0200c2e:	7118                	ld	a4,32(a0)
ffffffffc0200c30:	6d0c                	ld	a1,24(a0)
    prev->next = next;
ffffffffc0200c32:	e598                	sd	a4,8(a1)
    next->prev = prev;
ffffffffc0200c34:	e30c                	sd	a1,0(a4)
    record_area[block] = 0;
ffffffffc0200c36:	00033023          	sd	zero,0(t1)
    nr_free -= length;
ffffffffc0200c3a:	00007717          	auipc	a4,0x7
ffffffffc0200c3e:	8ed72f23          	sw	a3,-1794(a4) # ffffffffc0207538 <free_area+0x10>
    while (block != TREE_ROOT)
ffffffffc0200c42:	f51781e3          	beq	a5,a7,ffffffffc0200b84 <buddy_allocate_pages+0xde>
ffffffffc0200c46:	4585                	li	a1,1
ffffffffc0200c48:	a011                	j	ffffffffc0200c4c <buddy_allocate_pages+0x1a6>
ffffffffc0200c4a:	8205                	srli	a2,a2,0x1
        record_area[block] = record_area[LEFT_CHILD(block)] | record_area[RIGHT_CHILD(block)];
ffffffffc0200c4c:	00461793          	slli	a5,a2,0x4
ffffffffc0200c50:	97c2                	add	a5,a5,a6
ffffffffc0200c52:	6394                	ld	a3,0(a5)
ffffffffc0200c54:	6798                	ld	a4,8(a5)
ffffffffc0200c56:	00361793          	slli	a5,a2,0x3
ffffffffc0200c5a:	97c2                	add	a5,a5,a6
ffffffffc0200c5c:	8f55                	or	a4,a4,a3
ffffffffc0200c5e:	e398                	sd	a4,0(a5)
    while (block != TREE_ROOT)
ffffffffc0200c60:	feb615e3          	bne	a2,a1,ffffffffc0200c4a <buddy_allocate_pages+0x1a4>
}
ffffffffc0200c64:	8082                	ret
    size_t length = POWER_ROUND_UP(n);
ffffffffc0200c66:	fff7c793          	not	a5,a5
ffffffffc0200c6a:	8d7d                	and	a0,a0,a5
ffffffffc0200c6c:	0506                	slli	a0,a0,0x1
ffffffffc0200c6e:	b595                	j	ffffffffc0200ad2 <buddy_allocate_pages+0x2c>
{
ffffffffc0200c70:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0200c72:	00002697          	auipc	a3,0x2
ffffffffc0200c76:	7be68693          	addi	a3,a3,1982 # ffffffffc0203430 <commands+0x878>
ffffffffc0200c7a:	00002617          	auipc	a2,0x2
ffffffffc0200c7e:	7be60613          	addi	a2,a2,1982 # ffffffffc0203438 <commands+0x880>
ffffffffc0200c82:	07200593          	li	a1,114
ffffffffc0200c86:	00002517          	auipc	a0,0x2
ffffffffc0200c8a:	7ca50513          	addi	a0,a0,1994 # ffffffffc0203450 <commands+0x898>
{
ffffffffc0200c8e:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0200c90:	f20ff0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0200c94 <buddy_init_memmap.part.2>:
    for (p = base; p < base + n; p++)
ffffffffc0200c94:	00259693          	slli	a3,a1,0x2
ffffffffc0200c98:	96ae                	add	a3,a3,a1
static void buddy_init_memmap(struct Page *base, size_t n)
ffffffffc0200c9a:	1141                	addi	sp,sp,-16
    for (p = base; p < base + n; p++)
ffffffffc0200c9c:	068e                	slli	a3,a3,0x3
static void buddy_init_memmap(struct Page *base, size_t n)
ffffffffc0200c9e:	e406                	sd	ra,8(sp)
    for (p = base; p < base + n; p++)
ffffffffc0200ca0:	96aa                	add	a3,a3,a0
ffffffffc0200ca2:	02d57363          	bleu	a3,a0,ffffffffc0200cc8 <buddy_init_memmap.part.2+0x34>
ffffffffc0200ca6:	6518                	ld	a4,8(a0)
        assert(PageReserved(p));
ffffffffc0200ca8:	87aa                	mv	a5,a0
ffffffffc0200caa:	8b05                	andi	a4,a4,1
ffffffffc0200cac:	e711                	bnez	a4,ffffffffc0200cb8 <buddy_init_memmap.part.2+0x24>
ffffffffc0200cae:	a609                	j	ffffffffc0200fb0 <buddy_init_memmap.part.2+0x31c>
ffffffffc0200cb0:	6798                	ld	a4,8(a5)
ffffffffc0200cb2:	8b05                	andi	a4,a4,1
ffffffffc0200cb4:	2e070e63          	beqz	a4,ffffffffc0200fb0 <buddy_init_memmap.part.2+0x31c>
        p->flags = p->property = 0;
ffffffffc0200cb8:	0007a823          	sw	zero,16(a5)
ffffffffc0200cbc:	0007b423          	sd	zero,8(a5)
    for (p = base; p < base + n; p++)
ffffffffc0200cc0:	02878793          	addi	a5,a5,40
ffffffffc0200cc4:	fed7e6e3          	bltu	a5,a3,ffffffffc0200cb0 <buddy_init_memmap.part.2+0x1c>
    total_size = n;
ffffffffc0200cc8:	00007797          	auipc	a5,0x7
ffffffffc0200ccc:	82b7bc23          	sd	a1,-1992(a5) # ffffffffc0207500 <total_size>
    if (n < 512)
ffffffffc0200cd0:	1ff00793          	li	a5,511
ffffffffc0200cd4:	06b7f163          	bleu	a1,a5,ffffffffc0200d36 <buddy_init_memmap.part.2+0xa2>
        full_tree_size = POWER_ROUND_DOWN(n);
ffffffffc0200cd8:	0015d793          	srli	a5,a1,0x1
ffffffffc0200cdc:	8fcd                	or	a5,a5,a1
ffffffffc0200cde:	0027d713          	srli	a4,a5,0x2
ffffffffc0200ce2:	8fd9                	or	a5,a5,a4
ffffffffc0200ce4:	0047d713          	srli	a4,a5,0x4
ffffffffc0200ce8:	8f5d                	or	a4,a4,a5
ffffffffc0200cea:	00875793          	srli	a5,a4,0x8
ffffffffc0200cee:	8f5d                	or	a4,a4,a5
ffffffffc0200cf0:	01075793          	srli	a5,a4,0x10
ffffffffc0200cf4:	8fd9                	or	a5,a5,a4
ffffffffc0200cf6:	8385                	srli	a5,a5,0x1
ffffffffc0200cf8:	00f5f6b3          	and	a3,a1,a5
ffffffffc0200cfc:	872e                	mv	a4,a1
ffffffffc0200cfe:	c689                	beqz	a3,ffffffffc0200d08 <buddy_init_memmap.part.2+0x74>
ffffffffc0200d00:	fff7c793          	not	a5,a5
ffffffffc0200d04:	00b7f733          	and	a4,a5,a1
        record_area_size = full_tree_size * sizeof(size_t) * 2 / PGSIZE;
ffffffffc0200d08:	00471693          	slli	a3,a4,0x4
ffffffffc0200d0c:	82b1                	srli	a3,a3,0xc
        if (n > full_tree_size + (record_area_size << 1))
ffffffffc0200d0e:	00169613          	slli	a2,a3,0x1
        full_tree_size = POWER_ROUND_DOWN(n);
ffffffffc0200d12:	00006797          	auipc	a5,0x6
ffffffffc0200d16:	7ce7b323          	sd	a4,1990(a5) # ffffffffc02074d8 <full_tree_size>
        record_area_size = full_tree_size * sizeof(size_t) * 2 / PGSIZE;
ffffffffc0200d1a:	00006797          	auipc	a5,0x6
ffffffffc0200d1e:	7cd7bf23          	sd	a3,2014(a5) # ffffffffc02074f8 <record_area_size>
        if (n > full_tree_size + (record_area_size << 1))
ffffffffc0200d22:	00c707b3          	add	a5,a4,a2
ffffffffc0200d26:	24b7ee63          	bltu	a5,a1,ffffffffc0200f82 <buddy_init_memmap.part.2+0x2ee>
ffffffffc0200d2a:	40d587b3          	sub	a5,a1,a3
ffffffffc0200d2e:	26f76b63          	bltu	a4,a5,ffffffffc0200fa4 <buddy_init_memmap.part.2+0x310>
ffffffffc0200d32:	8636                	mv	a2,a3
ffffffffc0200d34:	a0a9                	j	ffffffffc0200d7e <buddy_init_memmap.part.2+0xea>
        full_tree_size = POWER_ROUND_UP(n - 1);
ffffffffc0200d36:	15fd                	addi	a1,a1,-1
ffffffffc0200d38:	0015d793          	srli	a5,a1,0x1
ffffffffc0200d3c:	00b7e733          	or	a4,a5,a1
ffffffffc0200d40:	00275793          	srli	a5,a4,0x2
ffffffffc0200d44:	8fd9                	or	a5,a5,a4
ffffffffc0200d46:	0047d713          	srli	a4,a5,0x4
ffffffffc0200d4a:	8fd9                	or	a5,a5,a4
ffffffffc0200d4c:	0087d713          	srli	a4,a5,0x8
ffffffffc0200d50:	8f5d                	or	a4,a4,a5
ffffffffc0200d52:	8305                	srli	a4,a4,0x1
ffffffffc0200d54:	00e5f6b3          	and	a3,a1,a4
ffffffffc0200d58:	87ae                	mv	a5,a1
ffffffffc0200d5a:	ca81                	beqz	a3,ffffffffc0200d6a <buddy_init_memmap.part.2+0xd6>
ffffffffc0200d5c:	fff74713          	not	a4,a4
ffffffffc0200d60:	8f6d                	and	a4,a4,a1
ffffffffc0200d62:	00171593          	slli	a1,a4,0x1
ffffffffc0200d66:	22f5ed63          	bltu	a1,a5,ffffffffc0200fa0 <buddy_init_memmap.part.2+0x30c>
ffffffffc0200d6a:	00006717          	auipc	a4,0x6
ffffffffc0200d6e:	76b73723          	sd	a1,1902(a4) # ffffffffc02074d8 <full_tree_size>
        record_area_size = 1;
ffffffffc0200d72:	4705                	li	a4,1
ffffffffc0200d74:	00006697          	auipc	a3,0x6
ffffffffc0200d78:	78e6b223          	sd	a4,1924(a3) # ffffffffc02074f8 <record_area_size>
ffffffffc0200d7c:	4605                	li	a2,1
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d7e:	00006717          	auipc	a4,0x6
ffffffffc0200d82:	7da70713          	addi	a4,a4,2010 # ffffffffc0207558 <pages>
ffffffffc0200d86:	6314                	ld	a3,0(a4)
ffffffffc0200d88:	00002717          	auipc	a4,0x2
ffffffffc0200d8c:	6a070713          	addi	a4,a4,1696 # ffffffffc0203428 <commands+0x870>
ffffffffc0200d90:	6318                	ld	a4,0(a4)
ffffffffc0200d92:	40d506b3          	sub	a3,a0,a3
ffffffffc0200d96:	868d                	srai	a3,a3,0x3
ffffffffc0200d98:	02e686b3          	mul	a3,a3,a4
    real_tree_size = (full_tree_size < total_size - record_area_size) ? full_tree_size : total_size - record_area_size;
ffffffffc0200d9c:	00006817          	auipc	a6,0x6
ffffffffc0200da0:	74f83623          	sd	a5,1868(a6) # ffffffffc02074e8 <real_tree_size>
ffffffffc0200da4:	00003597          	auipc	a1,0x3
ffffffffc0200da8:	ee458593          	addi	a1,a1,-284 # ffffffffc0203c88 <nbase>
    physical_area = base;
ffffffffc0200dac:	00006797          	auipc	a5,0x6
ffffffffc0200db0:	72a7ba23          	sd	a0,1844(a5) # ffffffffc02074e0 <physical_area>
ffffffffc0200db4:	619c                	ld	a5,0(a1)
    record_area = KADDR(page2pa(base));
ffffffffc0200db6:	00006717          	auipc	a4,0x6
ffffffffc0200dba:	75270713          	addi	a4,a4,1874 # ffffffffc0207508 <npage>
ffffffffc0200dbe:	6318                	ld	a4,0(a4)
ffffffffc0200dc0:	96be                	add	a3,a3,a5
ffffffffc0200dc2:	57fd                	li	a5,-1
ffffffffc0200dc4:	83b1                	srli	a5,a5,0xc
ffffffffc0200dc6:	8ff5                	and	a5,a5,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0200dc8:	06b2                	slli	a3,a3,0xc
ffffffffc0200dca:	20e7f363          	bleu	a4,a5,ffffffffc0200fd0 <buddy_init_memmap.part.2+0x33c>
ffffffffc0200dce:	00006797          	auipc	a5,0x6
ffffffffc0200dd2:	78278793          	addi	a5,a5,1922 # ffffffffc0207550 <va_pa_offset>
ffffffffc0200dd6:	6398                	ld	a4,0(a5)
    allocate_area = base + record_area_size;
ffffffffc0200dd8:	00261793          	slli	a5,a2,0x2
ffffffffc0200ddc:	97b2                	add	a5,a5,a2
    record_area = KADDR(page2pa(base));
ffffffffc0200dde:	96ba                	add	a3,a3,a4
    allocate_area = base + record_area_size;
ffffffffc0200de0:	078e                	slli	a5,a5,0x3
ffffffffc0200de2:	97aa                	add	a5,a5,a0
    memset(record_area, 0, record_area_size * PGSIZE);
ffffffffc0200de4:	0632                	slli	a2,a2,0xc
ffffffffc0200de6:	4581                	li	a1,0
ffffffffc0200de8:	8536                	mv	a0,a3
    record_area = KADDR(page2pa(base));
ffffffffc0200dea:	00006717          	auipc	a4,0x6
ffffffffc0200dee:	70d73323          	sd	a3,1798(a4) # ffffffffc02074f0 <record_area>
    allocate_area = base + record_area_size;
ffffffffc0200df2:	00006717          	auipc	a4,0x6
ffffffffc0200df6:	6cf73f23          	sd	a5,1758(a4) # ffffffffc02074d0 <allocate_area>
    memset(record_area, 0, record_area_size * PGSIZE);
ffffffffc0200dfa:	475010ef          	jal	ra,ffffffffc0202a6e <memset>
    nr_free += real_tree_size;
ffffffffc0200dfe:	00006797          	auipc	a5,0x6
ffffffffc0200e02:	6ea78793          	addi	a5,a5,1770 # ffffffffc02074e8 <real_tree_size>
ffffffffc0200e06:	6394                	ld	a3,0(a5)
ffffffffc0200e08:	00006897          	auipc	a7,0x6
ffffffffc0200e0c:	72088893          	addi	a7,a7,1824 # ffffffffc0207528 <free_area>
ffffffffc0200e10:	0108a783          	lw	a5,16(a7)
    record_area = KADDR(page2pa(base));
ffffffffc0200e14:	00006317          	auipc	t1,0x6
ffffffffc0200e18:	6dc30313          	addi	t1,t1,1756 # ffffffffc02074f0 <record_area>
    record_area[block] = real_subtree_size;
ffffffffc0200e1c:	00033703          	ld	a4,0(t1)
    nr_free += real_tree_size;
ffffffffc0200e20:	0006859b          	sext.w	a1,a3
ffffffffc0200e24:	9fad                	addw	a5,a5,a1
ffffffffc0200e26:	00006617          	auipc	a2,0x6
ffffffffc0200e2a:	70f62923          	sw	a5,1810(a2) # ffffffffc0207538 <free_area+0x10>
    size_t full_subtree_size = full_tree_size;
ffffffffc0200e2e:	00006e17          	auipc	t3,0x6
ffffffffc0200e32:	6aae0e13          	addi	t3,t3,1706 # ffffffffc02074d8 <full_tree_size>
    record_area[block] = real_subtree_size;
ffffffffc0200e36:	e714                	sd	a3,8(a4)
    allocate_area = base + record_area_size;
ffffffffc0200e38:	00006e97          	auipc	t4,0x6
ffffffffc0200e3c:	698e8e93          	addi	t4,t4,1688 # ffffffffc02074d0 <allocate_area>
    size_t full_subtree_size = full_tree_size;
ffffffffc0200e40:	000e3703          	ld	a4,0(t3)
    while (real_subtree_size > 0 && real_subtree_size < full_subtree_size)
ffffffffc0200e44:	12068063          	beqz	a3,ffffffffc0200f64 <buddy_init_memmap.part.2+0x2d0>
ffffffffc0200e48:	16e6f163          	bleu	a4,a3,ffffffffc0200faa <buddy_init_memmap.part.2+0x316>
    size_t block = TREE_ROOT;
ffffffffc0200e4c:	4785                	li	a5,1
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0200e4e:	4f09                	li	t5,2
        full_subtree_size >>= 1;
ffffffffc0200e50:	00479613          	slli	a2,a5,0x4
ffffffffc0200e54:	8305                	srli	a4,a4,0x1
        if (real_subtree_size > full_subtree_size)
ffffffffc0200e56:	00860293          	addi	t0,a2,8
ffffffffc0200e5a:	00179f93          	slli	t6,a5,0x1
ffffffffc0200e5e:	10d77663          	bleu	a3,a4,ffffffffc0200f6a <buddy_init_memmap.part.2+0x2d6>
            struct Page *page = &allocate_area[NODE_BEGINNING(block)];
ffffffffc0200e62:	0017d513          	srli	a0,a5,0x1
ffffffffc0200e66:	8d5d                	or	a0,a0,a5
ffffffffc0200e68:	00255813          	srli	a6,a0,0x2
ffffffffc0200e6c:	00a86533          	or	a0,a6,a0
ffffffffc0200e70:	00455813          	srli	a6,a0,0x4
ffffffffc0200e74:	00a86833          	or	a6,a6,a0
ffffffffc0200e78:	00885513          	srli	a0,a6,0x8
ffffffffc0200e7c:	01056833          	or	a6,a0,a6
ffffffffc0200e80:	01085513          	srli	a0,a6,0x10
ffffffffc0200e84:	01056533          	or	a0,a0,a6
ffffffffc0200e88:	8105                	srli	a0,a0,0x1
ffffffffc0200e8a:	00f573b3          	and	t2,a0,a5
ffffffffc0200e8e:	000eb583          	ld	a1,0(t4)
ffffffffc0200e92:	000e3803          	ld	a6,0(t3)
ffffffffc0200e96:	00038563          	beqz	t2,ffffffffc0200ea0 <buddy_init_memmap.part.2+0x20c>
ffffffffc0200e9a:	fff54513          	not	a0,a0
ffffffffc0200e9e:	8fe9                	and	a5,a5,a0
ffffffffc0200ea0:	02f857b3          	divu	a5,a6,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc0200ea4:	0088b803          	ld	a6,8(a7)
ffffffffc0200ea8:	027787b3          	mul	a5,a5,t2
ffffffffc0200eac:	00279513          	slli	a0,a5,0x2
ffffffffc0200eb0:	97aa                	add	a5,a5,a0
ffffffffc0200eb2:	078e                	slli	a5,a5,0x3
ffffffffc0200eb4:	97ae                	add	a5,a5,a1
            list_add(&(free_list), &(page->page_link));
ffffffffc0200eb6:	01878593          	addi	a1,a5,24
            page->property = full_subtree_size;
ffffffffc0200eba:	cb98                	sw	a4,16(a5)
    prev->next = next->prev = elm;
ffffffffc0200ebc:	00b83023          	sd	a1,0(a6)
ffffffffc0200ec0:	00006517          	auipc	a0,0x6
ffffffffc0200ec4:	66b53823          	sd	a1,1648(a0) # ffffffffc0207530 <free_area+0x8>
    elm->next = next;
ffffffffc0200ec8:	0307b023          	sd	a6,32(a5)
    elm->prev = prev;
ffffffffc0200ecc:	0117bc23          	sd	a7,24(a5)
static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc0200ed0:	0007a023          	sw	zero,0(a5)
ffffffffc0200ed4:	07a1                	addi	a5,a5,8
ffffffffc0200ed6:	41e7b02f          	amoor.d	zero,t5,(a5)
            record_area[LEFT_CHILD(block)] = full_subtree_size;
ffffffffc0200eda:	00033583          	ld	a1,0(t1)
            real_subtree_size -= full_subtree_size;
ffffffffc0200ede:	8e99                	sub	a3,a3,a4
            block = RIGHT_CHILD(block);
ffffffffc0200ee0:	001f8793          	addi	a5,t6,1
            record_area[LEFT_CHILD(block)] = full_subtree_size;
ffffffffc0200ee4:	962e                	add	a2,a2,a1
ffffffffc0200ee6:	e218                	sd	a4,0(a2)
            record_area[RIGHT_CHILD(block)] = real_subtree_size;
ffffffffc0200ee8:	9596                	add	a1,a1,t0
ffffffffc0200eea:	e194                	sd	a3,0(a1)
    while (real_subtree_size > 0 && real_subtree_size < full_subtree_size)
ffffffffc0200eec:	f6e6e2e3          	bltu	a3,a4,ffffffffc0200e50 <buddy_init_memmap.part.2+0x1bc>
        struct Page *page = &allocate_area[NODE_BEGINNING(block)];
ffffffffc0200ef0:	0017d613          	srli	a2,a5,0x1
ffffffffc0200ef4:	8e5d                	or	a2,a2,a5
ffffffffc0200ef6:	00265713          	srli	a4,a2,0x2
ffffffffc0200efa:	8e59                	or	a2,a2,a4
ffffffffc0200efc:	00465713          	srli	a4,a2,0x4
ffffffffc0200f00:	8f51                	or	a4,a4,a2
ffffffffc0200f02:	00875613          	srli	a2,a4,0x8
ffffffffc0200f06:	8f51                	or	a4,a4,a2
ffffffffc0200f08:	01075613          	srli	a2,a4,0x10
ffffffffc0200f0c:	8e59                	or	a2,a2,a4
ffffffffc0200f0e:	8205                	srli	a2,a2,0x1
ffffffffc0200f10:	00f67833          	and	a6,a2,a5
ffffffffc0200f14:	000eb703          	ld	a4,0(t4)
ffffffffc0200f18:	000e3503          	ld	a0,0(t3)
ffffffffc0200f1c:	0006859b          	sext.w	a1,a3
ffffffffc0200f20:	00080e63          	beqz	a6,ffffffffc0200f3c <buddy_init_memmap.part.2+0x2a8>
ffffffffc0200f24:	fff64613          	not	a2,a2
ffffffffc0200f28:	8ff1                	and	a5,a5,a2
ffffffffc0200f2a:	02f557b3          	divu	a5,a0,a5
ffffffffc0200f2e:	030787b3          	mul	a5,a5,a6
ffffffffc0200f32:	00279693          	slli	a3,a5,0x2
ffffffffc0200f36:	97b6                	add	a5,a5,a3
ffffffffc0200f38:	078e                	slli	a5,a5,0x3
ffffffffc0200f3a:	973e                	add	a4,a4,a5
        page->property = real_subtree_size;
ffffffffc0200f3c:	cb0c                	sw	a1,16(a4)
ffffffffc0200f3e:	00072023          	sw	zero,0(a4)
ffffffffc0200f42:	4789                	li	a5,2
ffffffffc0200f44:	00870693          	addi	a3,a4,8
ffffffffc0200f48:	40f6b02f          	amoor.d	zero,a5,(a3)
    __list_add(elm, listelm, listelm->next);
ffffffffc0200f4c:	0088b783          	ld	a5,8(a7)
        list_add(&(free_list), &(page->page_link));
ffffffffc0200f50:	01870693          	addi	a3,a4,24
    prev->next = next->prev = elm;
ffffffffc0200f54:	e394                	sd	a3,0(a5)
ffffffffc0200f56:	00006617          	auipc	a2,0x6
ffffffffc0200f5a:	5cd63d23          	sd	a3,1498(a2) # ffffffffc0207530 <free_area+0x8>
    elm->next = next;
ffffffffc0200f5e:	f31c                	sd	a5,32(a4)
    elm->prev = prev;
ffffffffc0200f60:	01173c23          	sd	a7,24(a4)
}
ffffffffc0200f64:	60a2                	ld	ra,8(sp)
ffffffffc0200f66:	0141                	addi	sp,sp,16
ffffffffc0200f68:	8082                	ret
            record_area[LEFT_CHILD(block)] = real_subtree_size;
ffffffffc0200f6a:	00033783          	ld	a5,0(t1)
ffffffffc0200f6e:	963e                	add	a2,a2,a5
ffffffffc0200f70:	e214                	sd	a3,0(a2)
            record_area[RIGHT_CHILD(block)] = 0;
ffffffffc0200f72:	9796                	add	a5,a5,t0
ffffffffc0200f74:	0007b023          	sd	zero,0(a5)
    while (real_subtree_size > 0 && real_subtree_size < full_subtree_size)
ffffffffc0200f78:	d6f5                	beqz	a3,ffffffffc0200f64 <buddy_init_memmap.part.2+0x2d0>
            block = LEFT_CHILD(block);
ffffffffc0200f7a:	87fe                	mv	a5,t6
    while (real_subtree_size > 0 && real_subtree_size < full_subtree_size)
ffffffffc0200f7c:	ece6eae3          	bltu	a3,a4,ffffffffc0200e50 <buddy_init_memmap.part.2+0x1bc>
ffffffffc0200f80:	bf85                	j	ffffffffc0200ef0 <buddy_init_memmap.part.2+0x25c>
            full_tree_size <<= 1;
ffffffffc0200f82:	0706                	slli	a4,a4,0x1
ffffffffc0200f84:	00006797          	auipc	a5,0x6
ffffffffc0200f88:	54e7ba23          	sd	a4,1364(a5) # ffffffffc02074d8 <full_tree_size>
            record_area_size <<= 1;
ffffffffc0200f8c:	00006797          	auipc	a5,0x6
ffffffffc0200f90:	56c7b623          	sd	a2,1388(a5) # ffffffffc02074f8 <record_area_size>
ffffffffc0200f94:	40c587b3          	sub	a5,a1,a2
ffffffffc0200f98:	def773e3          	bleu	a5,a4,ffffffffc0200d7e <buddy_init_memmap.part.2+0xea>
ffffffffc0200f9c:	87ba                	mv	a5,a4
ffffffffc0200f9e:	b3c5                	j	ffffffffc0200d7e <buddy_init_memmap.part.2+0xea>
ffffffffc0200fa0:	87ae                	mv	a5,a1
ffffffffc0200fa2:	b3e1                	j	ffffffffc0200d6a <buddy_init_memmap.part.2+0xd6>
ffffffffc0200fa4:	87ba                	mv	a5,a4
        if (n > full_tree_size + (record_area_size << 1))
ffffffffc0200fa6:	8636                	mv	a2,a3
ffffffffc0200fa8:	bbd9                	j	ffffffffc0200d7e <buddy_init_memmap.part.2+0xea>
        struct Page *page = &allocate_area[NODE_BEGINNING(block)];
ffffffffc0200faa:	000eb703          	ld	a4,0(t4)
ffffffffc0200fae:	b779                	j	ffffffffc0200f3c <buddy_init_memmap.part.2+0x2a8>
        assert(PageReserved(p));
ffffffffc0200fb0:	00002697          	auipc	a3,0x2
ffffffffc0200fb4:	4c868693          	addi	a3,a3,1224 # ffffffffc0203478 <commands+0x8c0>
ffffffffc0200fb8:	00002617          	auipc	a2,0x2
ffffffffc0200fbc:	48060613          	addi	a2,a2,1152 # ffffffffc0203438 <commands+0x880>
ffffffffc0200fc0:	02f00593          	li	a1,47
ffffffffc0200fc4:	00002517          	auipc	a0,0x2
ffffffffc0200fc8:	48c50513          	addi	a0,a0,1164 # ffffffffc0203450 <commands+0x898>
ffffffffc0200fcc:	be4ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    record_area = KADDR(page2pa(base));
ffffffffc0200fd0:	00002617          	auipc	a2,0x2
ffffffffc0200fd4:	4b860613          	addi	a2,a2,1208 # ffffffffc0203488 <commands+0x8d0>
ffffffffc0200fd8:	04500593          	li	a1,69
ffffffffc0200fdc:	00002517          	auipc	a0,0x2
ffffffffc0200fe0:	47450513          	addi	a0,a0,1140 # ffffffffc0203450 <commands+0x898>
ffffffffc0200fe4:	bccff0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0200fe8 <buddy_init_memmap>:
    assert(n > 0);
ffffffffc0200fe8:	c199                	beqz	a1,ffffffffc0200fee <buddy_init_memmap+0x6>
ffffffffc0200fea:	cabff06f          	j	ffffffffc0200c94 <buddy_init_memmap.part.2>
{
ffffffffc0200fee:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0200ff0:	00002697          	auipc	a3,0x2
ffffffffc0200ff4:	44068693          	addi	a3,a3,1088 # ffffffffc0203430 <commands+0x878>
ffffffffc0200ff8:	00002617          	auipc	a2,0x2
ffffffffc0200ffc:	44060613          	addi	a2,a2,1088 # ffffffffc0203438 <commands+0x880>
ffffffffc0201000:	02b00593          	li	a1,43
ffffffffc0201004:	00002517          	auipc	a0,0x2
ffffffffc0201008:	44c50513          	addi	a0,a0,1100 # ffffffffc0203450 <commands+0x898>
{
ffffffffc020100c:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020100e:	ba2ff0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0201012 <alloc_check>:

static void alloc_check(void)
{
ffffffffc0201012:	715d                	addi	sp,sp,-80
    size_t total_size_store = total_size;
ffffffffc0201014:	00006797          	auipc	a5,0x6
ffffffffc0201018:	4ec78793          	addi	a5,a5,1260 # ffffffffc0207500 <total_size>
{
ffffffffc020101c:	f84a                	sd	s2,48(sp)
    struct Page *p;
    for (p = physical_area; p < physical_area + 1026; p++)
ffffffffc020101e:	00006917          	auipc	s2,0x6
ffffffffc0201022:	4c290913          	addi	s2,s2,1218 # ffffffffc02074e0 <physical_area>
{
ffffffffc0201026:	f44e                	sd	s3,40(sp)
    size_t total_size_store = total_size;
ffffffffc0201028:	0007b983          	ld	s3,0(a5)
    for (p = physical_area; p < physical_area + 1026; p++)
ffffffffc020102c:	00093783          	ld	a5,0(s2)
ffffffffc0201030:	66a9                	lui	a3,0xa
{
ffffffffc0201032:	e486                	sd	ra,72(sp)
ffffffffc0201034:	e0a2                	sd	s0,64(sp)
ffffffffc0201036:	fc26                	sd	s1,56(sp)
ffffffffc0201038:	f052                	sd	s4,32(sp)
ffffffffc020103a:	ec56                	sd	s5,24(sp)
ffffffffc020103c:	e85a                	sd	s6,16(sp)
ffffffffc020103e:	e45e                	sd	s7,8(sp)
ffffffffc0201040:	4605                	li	a2,1
    for (p = physical_area; p < physical_area + 1026; p++)
ffffffffc0201042:	05068693          	addi	a3,a3,80 # a050 <BASE_ADDRESS-0xffffffffc01f5fb0>
ffffffffc0201046:	00878713          	addi	a4,a5,8
ffffffffc020104a:	40c7302f          	amoor.d	zero,a2,(a4)
ffffffffc020104e:	00093503          	ld	a0,0(s2)
ffffffffc0201052:	02878793          	addi	a5,a5,40
ffffffffc0201056:	00d50733          	add	a4,a0,a3
ffffffffc020105a:	fee7e6e3          	bltu	a5,a4,ffffffffc0201046 <alloc_check+0x34>
    elm->prev = elm->next = elm;
ffffffffc020105e:	00006497          	auipc	s1,0x6
ffffffffc0201062:	4ca48493          	addi	s1,s1,1226 # ffffffffc0207528 <free_area>
ffffffffc0201066:	40200593          	li	a1,1026
ffffffffc020106a:	00006797          	auipc	a5,0x6
ffffffffc020106e:	4c97b323          	sd	s1,1222(a5) # ffffffffc0207530 <free_area+0x8>
ffffffffc0201072:	00006797          	auipc	a5,0x6
ffffffffc0201076:	4a97bb23          	sd	s1,1206(a5) # ffffffffc0207528 <free_area>
    nr_free = 0;
ffffffffc020107a:	00006797          	auipc	a5,0x6
ffffffffc020107e:	4a07af23          	sw	zero,1214(a5) # ffffffffc0207538 <free_area+0x10>
    assert(n > 0);
ffffffffc0201082:	c13ff0ef          	jal	ra,ffffffffc0200c94 <buddy_init_memmap.part.2>
    buddy_init();
    buddy_init_memmap(physical_area, 1026);

    struct Page *p0, *p1, *p2, *p3;
    p0 = p1 = p2 = NULL;
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201086:	4505                	li	a0,1
ffffffffc0201088:	49c000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc020108c:	8a2a                	mv	s4,a0
ffffffffc020108e:	38050b63          	beqz	a0,ffffffffc0201424 <alloc_check+0x412>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201092:	4505                	li	a0,1
ffffffffc0201094:	490000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc0201098:	8b2a                	mv	s6,a0
ffffffffc020109a:	26050563          	beqz	a0,ffffffffc0201304 <alloc_check+0x2f2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020109e:	4505                	li	a0,1
ffffffffc02010a0:	484000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc02010a4:	8aaa                	mv	s5,a0
ffffffffc02010a6:	22050f63          	beqz	a0,ffffffffc02012e4 <alloc_check+0x2d2>
    assert((p3 = alloc_page()) != NULL);
ffffffffc02010aa:	4505                	li	a0,1
ffffffffc02010ac:	478000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc02010b0:	8baa                	mv	s7,a0
ffffffffc02010b2:	20050963          	beqz	a0,ffffffffc02012c4 <alloc_check+0x2b2>

    assert(p0 + 1 == p1);
ffffffffc02010b6:	028a0793          	addi	a5,s4,40
ffffffffc02010ba:	1efb1563          	bne	s6,a5,ffffffffc02012a4 <alloc_check+0x292>
    assert(p1 + 1 == p2);
ffffffffc02010be:	050a0793          	addi	a5,s4,80
ffffffffc02010c2:	26fa9163          	bne	s5,a5,ffffffffc0201324 <alloc_check+0x312>
    assert(p2 + 1 == p3);
ffffffffc02010c6:	078a0793          	addi	a5,s4,120
ffffffffc02010ca:	40f51d63          	bne	a0,a5,ffffffffc02014e4 <alloc_check+0x4d2>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0 && page_ref(p3) == 0);
ffffffffc02010ce:	000a2783          	lw	a5,0(s4)
ffffffffc02010d2:	1a079963          	bnez	a5,ffffffffc0201284 <alloc_check+0x272>
ffffffffc02010d6:	000b2783          	lw	a5,0(s6)
ffffffffc02010da:	1a079563          	bnez	a5,ffffffffc0201284 <alloc_check+0x272>
ffffffffc02010de:	000aa783          	lw	a5,0(s5)
ffffffffc02010e2:	1a079163          	bnez	a5,ffffffffc0201284 <alloc_check+0x272>
ffffffffc02010e6:	411c                	lw	a5,0(a0)
ffffffffc02010e8:	18079e63          	bnez	a5,ffffffffc0201284 <alloc_check+0x272>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02010ec:	00006797          	auipc	a5,0x6
ffffffffc02010f0:	46c78793          	addi	a5,a5,1132 # ffffffffc0207558 <pages>
ffffffffc02010f4:	639c                	ld	a5,0(a5)
ffffffffc02010f6:	00002717          	auipc	a4,0x2
ffffffffc02010fa:	33270713          	addi	a4,a4,818 # ffffffffc0203428 <commands+0x870>
ffffffffc02010fe:	630c                	ld	a1,0(a4)
ffffffffc0201100:	40fa0733          	sub	a4,s4,a5
ffffffffc0201104:	870d                	srai	a4,a4,0x3
ffffffffc0201106:	02b70733          	mul	a4,a4,a1
ffffffffc020110a:	00003697          	auipc	a3,0x3
ffffffffc020110e:	b7e68693          	addi	a3,a3,-1154 # ffffffffc0203c88 <nbase>
ffffffffc0201112:	6290                	ld	a2,0(a3)

    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201114:	00006697          	auipc	a3,0x6
ffffffffc0201118:	3f468693          	addi	a3,a3,1012 # ffffffffc0207508 <npage>
ffffffffc020111c:	6294                	ld	a3,0(a3)
ffffffffc020111e:	06b2                	slli	a3,a3,0xc
ffffffffc0201120:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201122:	0732                	slli	a4,a4,0xc
ffffffffc0201124:	2cd77063          	bleu	a3,a4,ffffffffc02013e4 <alloc_check+0x3d2>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0201128:	40fb0733          	sub	a4,s6,a5
ffffffffc020112c:	870d                	srai	a4,a4,0x3
ffffffffc020112e:	02b70733          	mul	a4,a4,a1
ffffffffc0201132:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201134:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201136:	28d77763          	bleu	a3,a4,ffffffffc02013c4 <alloc_check+0x3b2>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc020113a:	40fa8733          	sub	a4,s5,a5
ffffffffc020113e:	870d                	srai	a4,a4,0x3
ffffffffc0201140:	02b70733          	mul	a4,a4,a1
ffffffffc0201144:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201146:	0732                	slli	a4,a4,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201148:	1ed77e63          	bleu	a3,a4,ffffffffc0201344 <alloc_check+0x332>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc020114c:	40f507b3          	sub	a5,a0,a5
ffffffffc0201150:	878d                	srai	a5,a5,0x3
ffffffffc0201152:	02b787b3          	mul	a5,a5,a1
    assert(page2pa(p3) < npage * PGSIZE);

    list_entry_t *le = &free_list;
ffffffffc0201156:	00006417          	auipc	s0,0x6
ffffffffc020115a:	3d240413          	addi	s0,s0,978 # ffffffffc0207528 <free_area>
ffffffffc020115e:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201160:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p3) < npage * PGSIZE);
ffffffffc0201162:	00d7e963          	bltu	a5,a3,ffffffffc0201174 <alloc_check+0x162>
ffffffffc0201166:	ac39                	j	ffffffffc0201384 <alloc_check+0x372>
    while ((le = list_next(le)) != &free_list)
    {
        p = le2page(le, page_link);
        assert(buddy_allocate_pages(p->property) != NULL);
ffffffffc0201168:	ff846503          	lwu	a0,-8(s0)
ffffffffc020116c:	93bff0ef          	jal	ra,ffffffffc0200aa6 <buddy_allocate_pages>
ffffffffc0201170:	0e050a63          	beqz	a0,ffffffffc0201264 <alloc_check+0x252>
    return listelm->next;
ffffffffc0201174:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != &free_list)
ffffffffc0201176:	fe9419e3          	bne	s0,s1,ffffffffc0201168 <alloc_check+0x156>
    }

    assert(alloc_page() == NULL);
ffffffffc020117a:	4505                	li	a0,1
ffffffffc020117c:	3a8000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc0201180:	34051263          	bnez	a0,ffffffffc02014c4 <alloc_check+0x4b2>

    free_page(p0);
ffffffffc0201184:	4585                	li	a1,1
ffffffffc0201186:	8552                	mv	a0,s4
ffffffffc0201188:	3e0000ef          	jal	ra,ffffffffc0201568 <free_pages>
    free_page(p1);
ffffffffc020118c:	4585                	li	a1,1
ffffffffc020118e:	855a                	mv	a0,s6
ffffffffc0201190:	3d8000ef          	jal	ra,ffffffffc0201568 <free_pages>
    free_page(p2);
ffffffffc0201194:	4585                	li	a1,1
ffffffffc0201196:	8556                	mv	a0,s5
ffffffffc0201198:	3d0000ef          	jal	ra,ffffffffc0201568 <free_pages>
    assert(nr_free == 3);
ffffffffc020119c:	4818                	lw	a4,16(s0)
ffffffffc020119e:	478d                	li	a5,3
ffffffffc02011a0:	1cf71263          	bne	a4,a5,ffffffffc0201364 <alloc_check+0x352>

    assert((p1 = alloc_page()) != NULL);
ffffffffc02011a4:	4505                	li	a0,1
ffffffffc02011a6:	37e000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc02011aa:	8a2a                	mv	s4,a0
ffffffffc02011ac:	24050c63          	beqz	a0,ffffffffc0201404 <alloc_check+0x3f2>
    assert((p0 = alloc_pages(2)) != NULL);
ffffffffc02011b0:	4509                	li	a0,2
ffffffffc02011b2:	372000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc02011b6:	842a                	mv	s0,a0
ffffffffc02011b8:	2e050663          	beqz	a0,ffffffffc02014a4 <alloc_check+0x492>
    assert(p0 + 2 == p1);
ffffffffc02011bc:	05050793          	addi	a5,a0,80
ffffffffc02011c0:	2cfa1263          	bne	s4,a5,ffffffffc0201484 <alloc_check+0x472>

    assert(alloc_page() == NULL);
ffffffffc02011c4:	4505                	li	a0,1
ffffffffc02011c6:	35e000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc02011ca:	1c051d63          	bnez	a0,ffffffffc02013a4 <alloc_check+0x392>

    free_pages(p0, 2);
ffffffffc02011ce:	4589                	li	a1,2
ffffffffc02011d0:	8522                	mv	a0,s0
ffffffffc02011d2:	396000ef          	jal	ra,ffffffffc0201568 <free_pages>
    free_page(p1);
ffffffffc02011d6:	4585                	li	a1,1
ffffffffc02011d8:	8552                	mv	a0,s4
ffffffffc02011da:	38e000ef          	jal	ra,ffffffffc0201568 <free_pages>
    free_page(p3);
ffffffffc02011de:	855e                	mv	a0,s7
ffffffffc02011e0:	4585                	li	a1,1
ffffffffc02011e2:	386000ef          	jal	ra,ffffffffc0201568 <free_pages>

    assert((p = alloc_pages(4)) == p0);
ffffffffc02011e6:	4511                	li	a0,4
ffffffffc02011e8:	33c000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc02011ec:	30a41c63          	bne	s0,a0,ffffffffc0201504 <alloc_check+0x4f2>
    assert(alloc_page() == NULL);
ffffffffc02011f0:	4505                	li	a0,1
ffffffffc02011f2:	332000ef          	jal	ra,ffffffffc0201524 <alloc_pages>
ffffffffc02011f6:	26051763          	bnez	a0,ffffffffc0201464 <alloc_check+0x452>

    assert(nr_free == 0);
ffffffffc02011fa:	489c                	lw	a5,16(s1)
ffffffffc02011fc:	24079463          	bnez	a5,ffffffffc0201444 <alloc_check+0x432>

    for (p = physical_area; p < physical_area + total_size_store; p++)
ffffffffc0201200:	00093783          	ld	a5,0(s2)
ffffffffc0201204:	00299693          	slli	a3,s3,0x2
ffffffffc0201208:	96ce                	add	a3,a3,s3
ffffffffc020120a:	068e                	slli	a3,a3,0x3
ffffffffc020120c:	00d78733          	add	a4,a5,a3
ffffffffc0201210:	04e7f863          	bleu	a4,a5,ffffffffc0201260 <alloc_check+0x24e>
ffffffffc0201214:	4605                	li	a2,1
ffffffffc0201216:	00878713          	addi	a4,a5,8
ffffffffc020121a:	40c7302f          	amoor.d	zero,a2,(a4)
ffffffffc020121e:	00093503          	ld	a0,0(s2)
ffffffffc0201222:	02878793          	addi	a5,a5,40
ffffffffc0201226:	00d50733          	add	a4,a0,a3
ffffffffc020122a:	fee7e6e3          	bltu	a5,a4,ffffffffc0201216 <alloc_check+0x204>
        SetPageReserved(p);
    buddy_init();
    buddy_init_memmap(physical_area, total_size_store);
}
ffffffffc020122e:	6406                	ld	s0,64(sp)
    elm->prev = elm->next = elm;
ffffffffc0201230:	00006797          	auipc	a5,0x6
ffffffffc0201234:	3097b023          	sd	s1,768(a5) # ffffffffc0207530 <free_area+0x8>
ffffffffc0201238:	00006797          	auipc	a5,0x6
ffffffffc020123c:	2e97b823          	sd	s1,752(a5) # ffffffffc0207528 <free_area>
ffffffffc0201240:	60a6                	ld	ra,72(sp)
ffffffffc0201242:	74e2                	ld	s1,56(sp)
ffffffffc0201244:	7942                	ld	s2,48(sp)
ffffffffc0201246:	7a02                	ld	s4,32(sp)
ffffffffc0201248:	6ae2                	ld	s5,24(sp)
ffffffffc020124a:	6b42                	ld	s6,16(sp)
ffffffffc020124c:	6ba2                	ld	s7,8(sp)
    buddy_init_memmap(physical_area, total_size_store);
ffffffffc020124e:	85ce                	mv	a1,s3
}
ffffffffc0201250:	79a2                	ld	s3,40(sp)
    nr_free = 0;
ffffffffc0201252:	00006797          	auipc	a5,0x6
ffffffffc0201256:	2e07a323          	sw	zero,742(a5) # ffffffffc0207538 <free_area+0x10>
}
ffffffffc020125a:	6161                	addi	sp,sp,80
    buddy_init_memmap(physical_area, total_size_store);
ffffffffc020125c:	d8dff06f          	j	ffffffffc0200fe8 <buddy_init_memmap>
    for (p = physical_area; p < physical_area + total_size_store; p++)
ffffffffc0201260:	853e                	mv	a0,a5
ffffffffc0201262:	b7f1                	j	ffffffffc020122e <alloc_check+0x21c>
        assert(buddy_allocate_pages(p->property) != NULL);
ffffffffc0201264:	00002697          	auipc	a3,0x2
ffffffffc0201268:	10c68693          	addi	a3,a3,268 # ffffffffc0203370 <commands+0x7b8>
ffffffffc020126c:	00002617          	auipc	a2,0x2
ffffffffc0201270:	1cc60613          	addi	a2,a2,460 # ffffffffc0203438 <commands+0x880>
ffffffffc0201274:	0ec00593          	li	a1,236
ffffffffc0201278:	00002517          	auipc	a0,0x2
ffffffffc020127c:	1d850513          	addi	a0,a0,472 # ffffffffc0203450 <commands+0x898>
ffffffffc0201280:	930ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0 && page_ref(p3) == 0);
ffffffffc0201284:	00002697          	auipc	a3,0x2
ffffffffc0201288:	01468693          	addi	a3,a3,20 # ffffffffc0203298 <commands+0x6e0>
ffffffffc020128c:	00002617          	auipc	a2,0x2
ffffffffc0201290:	1ac60613          	addi	a2,a2,428 # ffffffffc0203438 <commands+0x880>
ffffffffc0201294:	0e100593          	li	a1,225
ffffffffc0201298:	00002517          	auipc	a0,0x2
ffffffffc020129c:	1b850513          	addi	a0,a0,440 # ffffffffc0203450 <commands+0x898>
ffffffffc02012a0:	910ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(p0 + 1 == p1);
ffffffffc02012a4:	00002697          	auipc	a3,0x2
ffffffffc02012a8:	fc468693          	addi	a3,a3,-60 # ffffffffc0203268 <commands+0x6b0>
ffffffffc02012ac:	00002617          	auipc	a2,0x2
ffffffffc02012b0:	18c60613          	addi	a2,a2,396 # ffffffffc0203438 <commands+0x880>
ffffffffc02012b4:	0de00593          	li	a1,222
ffffffffc02012b8:	00002517          	auipc	a0,0x2
ffffffffc02012bc:	19850513          	addi	a0,a0,408 # ffffffffc0203450 <commands+0x898>
ffffffffc02012c0:	8f0ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p3 = alloc_page()) != NULL);
ffffffffc02012c4:	00002697          	auipc	a3,0x2
ffffffffc02012c8:	f8468693          	addi	a3,a3,-124 # ffffffffc0203248 <commands+0x690>
ffffffffc02012cc:	00002617          	auipc	a2,0x2
ffffffffc02012d0:	16c60613          	addi	a2,a2,364 # ffffffffc0203438 <commands+0x880>
ffffffffc02012d4:	0dc00593          	li	a1,220
ffffffffc02012d8:	00002517          	auipc	a0,0x2
ffffffffc02012dc:	17850513          	addi	a0,a0,376 # ffffffffc0203450 <commands+0x898>
ffffffffc02012e0:	8d0ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02012e4:	00002697          	auipc	a3,0x2
ffffffffc02012e8:	f4468693          	addi	a3,a3,-188 # ffffffffc0203228 <commands+0x670>
ffffffffc02012ec:	00002617          	auipc	a2,0x2
ffffffffc02012f0:	14c60613          	addi	a2,a2,332 # ffffffffc0203438 <commands+0x880>
ffffffffc02012f4:	0db00593          	li	a1,219
ffffffffc02012f8:	00002517          	auipc	a0,0x2
ffffffffc02012fc:	15850513          	addi	a0,a0,344 # ffffffffc0203450 <commands+0x898>
ffffffffc0201300:	8b0ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201304:	00002697          	auipc	a3,0x2
ffffffffc0201308:	f0468693          	addi	a3,a3,-252 # ffffffffc0203208 <commands+0x650>
ffffffffc020130c:	00002617          	auipc	a2,0x2
ffffffffc0201310:	12c60613          	addi	a2,a2,300 # ffffffffc0203438 <commands+0x880>
ffffffffc0201314:	0da00593          	li	a1,218
ffffffffc0201318:	00002517          	auipc	a0,0x2
ffffffffc020131c:	13850513          	addi	a0,a0,312 # ffffffffc0203450 <commands+0x898>
ffffffffc0201320:	890ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(p1 + 1 == p2);
ffffffffc0201324:	00002697          	auipc	a3,0x2
ffffffffc0201328:	f5468693          	addi	a3,a3,-172 # ffffffffc0203278 <commands+0x6c0>
ffffffffc020132c:	00002617          	auipc	a2,0x2
ffffffffc0201330:	10c60613          	addi	a2,a2,268 # ffffffffc0203438 <commands+0x880>
ffffffffc0201334:	0df00593          	li	a1,223
ffffffffc0201338:	00002517          	auipc	a0,0x2
ffffffffc020133c:	11850513          	addi	a0,a0,280 # ffffffffc0203450 <commands+0x898>
ffffffffc0201340:	870ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201344:	00002697          	auipc	a3,0x2
ffffffffc0201348:	fec68693          	addi	a3,a3,-20 # ffffffffc0203330 <commands+0x778>
ffffffffc020134c:	00002617          	auipc	a2,0x2
ffffffffc0201350:	0ec60613          	addi	a2,a2,236 # ffffffffc0203438 <commands+0x880>
ffffffffc0201354:	0e500593          	li	a1,229
ffffffffc0201358:	00002517          	auipc	a0,0x2
ffffffffc020135c:	0f850513          	addi	a0,a0,248 # ffffffffc0203450 <commands+0x898>
ffffffffc0201360:	850ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(nr_free == 3);
ffffffffc0201364:	00002697          	auipc	a3,0x2
ffffffffc0201368:	05468693          	addi	a3,a3,84 # ffffffffc02033b8 <commands+0x800>
ffffffffc020136c:	00002617          	auipc	a2,0x2
ffffffffc0201370:	0cc60613          	addi	a2,a2,204 # ffffffffc0203438 <commands+0x880>
ffffffffc0201374:	0f400593          	li	a1,244
ffffffffc0201378:	00002517          	auipc	a0,0x2
ffffffffc020137c:	0d850513          	addi	a0,a0,216 # ffffffffc0203450 <commands+0x898>
ffffffffc0201380:	830ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(page2pa(p3) < npage * PGSIZE);
ffffffffc0201384:	00002697          	auipc	a3,0x2
ffffffffc0201388:	fcc68693          	addi	a3,a3,-52 # ffffffffc0203350 <commands+0x798>
ffffffffc020138c:	00002617          	auipc	a2,0x2
ffffffffc0201390:	0ac60613          	addi	a2,a2,172 # ffffffffc0203438 <commands+0x880>
ffffffffc0201394:	0e600593          	li	a1,230
ffffffffc0201398:	00002517          	auipc	a0,0x2
ffffffffc020139c:	0b850513          	addi	a0,a0,184 # ffffffffc0203450 <commands+0x898>
ffffffffc02013a0:	810ff0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013a4:	00002697          	auipc	a3,0x2
ffffffffc02013a8:	ffc68693          	addi	a3,a3,-4 # ffffffffc02033a0 <commands+0x7e8>
ffffffffc02013ac:	00002617          	auipc	a2,0x2
ffffffffc02013b0:	08c60613          	addi	a2,a2,140 # ffffffffc0203438 <commands+0x880>
ffffffffc02013b4:	0fa00593          	li	a1,250
ffffffffc02013b8:	00002517          	auipc	a0,0x2
ffffffffc02013bc:	09850513          	addi	a0,a0,152 # ffffffffc0203450 <commands+0x898>
ffffffffc02013c0:	ff1fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02013c4:	00002697          	auipc	a3,0x2
ffffffffc02013c8:	f4c68693          	addi	a3,a3,-180 # ffffffffc0203310 <commands+0x758>
ffffffffc02013cc:	00002617          	auipc	a2,0x2
ffffffffc02013d0:	06c60613          	addi	a2,a2,108 # ffffffffc0203438 <commands+0x880>
ffffffffc02013d4:	0e400593          	li	a1,228
ffffffffc02013d8:	00002517          	auipc	a0,0x2
ffffffffc02013dc:	07850513          	addi	a0,a0,120 # ffffffffc0203450 <commands+0x898>
ffffffffc02013e0:	fd1fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc02013e4:	00002697          	auipc	a3,0x2
ffffffffc02013e8:	f0c68693          	addi	a3,a3,-244 # ffffffffc02032f0 <commands+0x738>
ffffffffc02013ec:	00002617          	auipc	a2,0x2
ffffffffc02013f0:	04c60613          	addi	a2,a2,76 # ffffffffc0203438 <commands+0x880>
ffffffffc02013f4:	0e300593          	li	a1,227
ffffffffc02013f8:	00002517          	auipc	a0,0x2
ffffffffc02013fc:	05850513          	addi	a0,a0,88 # ffffffffc0203450 <commands+0x898>
ffffffffc0201400:	fb1fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201404:	00002697          	auipc	a3,0x2
ffffffffc0201408:	e0468693          	addi	a3,a3,-508 # ffffffffc0203208 <commands+0x650>
ffffffffc020140c:	00002617          	auipc	a2,0x2
ffffffffc0201410:	02c60613          	addi	a2,a2,44 # ffffffffc0203438 <commands+0x880>
ffffffffc0201414:	0f600593          	li	a1,246
ffffffffc0201418:	00002517          	auipc	a0,0x2
ffffffffc020141c:	03850513          	addi	a0,a0,56 # ffffffffc0203450 <commands+0x898>
ffffffffc0201420:	f91fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201424:	00002697          	auipc	a3,0x2
ffffffffc0201428:	dc468693          	addi	a3,a3,-572 # ffffffffc02031e8 <commands+0x630>
ffffffffc020142c:	00002617          	auipc	a2,0x2
ffffffffc0201430:	00c60613          	addi	a2,a2,12 # ffffffffc0203438 <commands+0x880>
ffffffffc0201434:	0d900593          	li	a1,217
ffffffffc0201438:	00002517          	auipc	a0,0x2
ffffffffc020143c:	01850513          	addi	a0,a0,24 # ffffffffc0203450 <commands+0x898>
ffffffffc0201440:	f71fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(nr_free == 0);
ffffffffc0201444:	00002697          	auipc	a3,0x2
ffffffffc0201448:	fd468693          	addi	a3,a3,-44 # ffffffffc0203418 <commands+0x860>
ffffffffc020144c:	00002617          	auipc	a2,0x2
ffffffffc0201450:	fec60613          	addi	a2,a2,-20 # ffffffffc0203438 <commands+0x880>
ffffffffc0201454:	10300593          	li	a1,259
ffffffffc0201458:	00002517          	auipc	a0,0x2
ffffffffc020145c:	ff850513          	addi	a0,a0,-8 # ffffffffc0203450 <commands+0x898>
ffffffffc0201460:	f51fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201464:	00002697          	auipc	a3,0x2
ffffffffc0201468:	f3c68693          	addi	a3,a3,-196 # ffffffffc02033a0 <commands+0x7e8>
ffffffffc020146c:	00002617          	auipc	a2,0x2
ffffffffc0201470:	fcc60613          	addi	a2,a2,-52 # ffffffffc0203438 <commands+0x880>
ffffffffc0201474:	10100593          	li	a1,257
ffffffffc0201478:	00002517          	auipc	a0,0x2
ffffffffc020147c:	fd850513          	addi	a0,a0,-40 # ffffffffc0203450 <commands+0x898>
ffffffffc0201480:	f31fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201484:	00002697          	auipc	a3,0x2
ffffffffc0201488:	f6468693          	addi	a3,a3,-156 # ffffffffc02033e8 <commands+0x830>
ffffffffc020148c:	00002617          	auipc	a2,0x2
ffffffffc0201490:	fac60613          	addi	a2,a2,-84 # ffffffffc0203438 <commands+0x880>
ffffffffc0201494:	0f800593          	li	a1,248
ffffffffc0201498:	00002517          	auipc	a0,0x2
ffffffffc020149c:	fb850513          	addi	a0,a0,-72 # ffffffffc0203450 <commands+0x898>
ffffffffc02014a0:	f11fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p0 = alloc_pages(2)) != NULL);
ffffffffc02014a4:	00002697          	auipc	a3,0x2
ffffffffc02014a8:	f2468693          	addi	a3,a3,-220 # ffffffffc02033c8 <commands+0x810>
ffffffffc02014ac:	00002617          	auipc	a2,0x2
ffffffffc02014b0:	f8c60613          	addi	a2,a2,-116 # ffffffffc0203438 <commands+0x880>
ffffffffc02014b4:	0f700593          	li	a1,247
ffffffffc02014b8:	00002517          	auipc	a0,0x2
ffffffffc02014bc:	f9850513          	addi	a0,a0,-104 # ffffffffc0203450 <commands+0x898>
ffffffffc02014c0:	ef1fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02014c4:	00002697          	auipc	a3,0x2
ffffffffc02014c8:	edc68693          	addi	a3,a3,-292 # ffffffffc02033a0 <commands+0x7e8>
ffffffffc02014cc:	00002617          	auipc	a2,0x2
ffffffffc02014d0:	f6c60613          	addi	a2,a2,-148 # ffffffffc0203438 <commands+0x880>
ffffffffc02014d4:	0ef00593          	li	a1,239
ffffffffc02014d8:	00002517          	auipc	a0,0x2
ffffffffc02014dc:	f7850513          	addi	a0,a0,-136 # ffffffffc0203450 <commands+0x898>
ffffffffc02014e0:	ed1fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(p2 + 1 == p3);
ffffffffc02014e4:	00002697          	auipc	a3,0x2
ffffffffc02014e8:	da468693          	addi	a3,a3,-604 # ffffffffc0203288 <commands+0x6d0>
ffffffffc02014ec:	00002617          	auipc	a2,0x2
ffffffffc02014f0:	f4c60613          	addi	a2,a2,-180 # ffffffffc0203438 <commands+0x880>
ffffffffc02014f4:	0e000593          	li	a1,224
ffffffffc02014f8:	00002517          	auipc	a0,0x2
ffffffffc02014fc:	f5850513          	addi	a0,a0,-168 # ffffffffc0203450 <commands+0x898>
ffffffffc0201500:	eb1fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p = alloc_pages(4)) == p0);
ffffffffc0201504:	00002697          	auipc	a3,0x2
ffffffffc0201508:	ef468693          	addi	a3,a3,-268 # ffffffffc02033f8 <commands+0x840>
ffffffffc020150c:	00002617          	auipc	a2,0x2
ffffffffc0201510:	f2c60613          	addi	a2,a2,-212 # ffffffffc0203438 <commands+0x880>
ffffffffc0201514:	10000593          	li	a1,256
ffffffffc0201518:	00002517          	auipc	a0,0x2
ffffffffc020151c:	f3850513          	addi	a0,a0,-200 # ffffffffc0203450 <commands+0x898>
ffffffffc0201520:	e91fe0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0201524 <alloc_pages>:
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201524:	100027f3          	csrr	a5,sstatus
ffffffffc0201528:	8b89                	andi	a5,a5,2
ffffffffc020152a:	eb89                	bnez	a5,ffffffffc020153c <alloc_pages+0x18>
    // 然后返回分配的 Page 结构指针。
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc020152c:	00006797          	auipc	a5,0x6
ffffffffc0201530:	01c78793          	addi	a5,a5,28 # ffffffffc0207548 <pmm_manager>
ffffffffc0201534:	639c                	ld	a5,0(a5)
ffffffffc0201536:	0187b303          	ld	t1,24(a5)
ffffffffc020153a:	8302                	jr	t1
{
ffffffffc020153c:	1141                	addi	sp,sp,-16
ffffffffc020153e:	e406                	sd	ra,8(sp)
ffffffffc0201540:	e022                	sd	s0,0(sp)
ffffffffc0201542:	842a                	mv	s0,a0
    {
        intr_disable();
ffffffffc0201544:	f25fe0ef          	jal	ra,ffffffffc0200468 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201548:	00006797          	auipc	a5,0x6
ffffffffc020154c:	00078793          	mv	a5,a5
ffffffffc0201550:	639c                	ld	a5,0(a5)
ffffffffc0201552:	8522                	mv	a0,s0
ffffffffc0201554:	6f9c                	ld	a5,24(a5)
ffffffffc0201556:	9782                	jalr	a5
ffffffffc0201558:	842a                	mv	s0,a0

static inline void __intr_restore(bool flag)
{
    if (flag)
    {
        intr_enable();
ffffffffc020155a:	f09fe0ef          	jal	ra,ffffffffc0200462 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc020155e:	8522                	mv	a0,s0
ffffffffc0201560:	60a2                	ld	ra,8(sp)
ffffffffc0201562:	6402                	ld	s0,0(sp)
ffffffffc0201564:	0141                	addi	sp,sp,16
ffffffffc0201566:	8082                	ret

ffffffffc0201568 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201568:	100027f3          	csrr	a5,sstatus
ffffffffc020156c:	8b89                	andi	a5,a5,2
ffffffffc020156e:	eb89                	bnez	a5,ffffffffc0201580 <free_pages+0x18>
    // 了解物理内存管理器的工作原理，然后在这里实现自己的释放算法。
    // 实现算法后，调用 pmm_manager->free_pages(base, n) 来释放物理内存。
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201570:	00006797          	auipc	a5,0x6
ffffffffc0201574:	fd878793          	addi	a5,a5,-40 # ffffffffc0207548 <pmm_manager>
ffffffffc0201578:	639c                	ld	a5,0(a5)
ffffffffc020157a:	0207b303          	ld	t1,32(a5)
ffffffffc020157e:	8302                	jr	t1
{
ffffffffc0201580:	1101                	addi	sp,sp,-32
ffffffffc0201582:	ec06                	sd	ra,24(sp)
ffffffffc0201584:	e822                	sd	s0,16(sp)
ffffffffc0201586:	e426                	sd	s1,8(sp)
ffffffffc0201588:	842a                	mv	s0,a0
ffffffffc020158a:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc020158c:	eddfe0ef          	jal	ra,ffffffffc0200468 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201590:	00006797          	auipc	a5,0x6
ffffffffc0201594:	fb878793          	addi	a5,a5,-72 # ffffffffc0207548 <pmm_manager>
ffffffffc0201598:	639c                	ld	a5,0(a5)
ffffffffc020159a:	85a6                	mv	a1,s1
ffffffffc020159c:	8522                	mv	a0,s0
ffffffffc020159e:	739c                	ld	a5,32(a5)
ffffffffc02015a0:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc02015a2:	6442                	ld	s0,16(sp)
ffffffffc02015a4:	60e2                	ld	ra,24(sp)
ffffffffc02015a6:	64a2                	ld	s1,8(sp)
ffffffffc02015a8:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02015aa:	eb9fe06f          	j	ffffffffc0200462 <intr_enable>

ffffffffc02015ae <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02015ae:	100027f3          	csrr	a5,sstatus
ffffffffc02015b2:	8b89                	andi	a5,a5,2
ffffffffc02015b4:	eb89                	bnez	a5,ffffffffc02015c6 <nr_free_pages+0x18>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc02015b6:	00006797          	auipc	a5,0x6
ffffffffc02015ba:	f9278793          	addi	a5,a5,-110 # ffffffffc0207548 <pmm_manager>
ffffffffc02015be:	639c                	ld	a5,0(a5)
ffffffffc02015c0:	0287b303          	ld	t1,40(a5)
ffffffffc02015c4:	8302                	jr	t1
{
ffffffffc02015c6:	1141                	addi	sp,sp,-16
ffffffffc02015c8:	e406                	sd	ra,8(sp)
ffffffffc02015ca:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc02015cc:	e9dfe0ef          	jal	ra,ffffffffc0200468 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc02015d0:	00006797          	auipc	a5,0x6
ffffffffc02015d4:	f7878793          	addi	a5,a5,-136 # ffffffffc0207548 <pmm_manager>
ffffffffc02015d8:	639c                	ld	a5,0(a5)
ffffffffc02015da:	779c                	ld	a5,40(a5)
ffffffffc02015dc:	9782                	jalr	a5
ffffffffc02015de:	842a                	mv	s0,a0
        intr_enable();
ffffffffc02015e0:	e83fe0ef          	jal	ra,ffffffffc0200462 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc02015e4:	8522                	mv	a0,s0
ffffffffc02015e6:	60a2                	ld	ra,8(sp)
ffffffffc02015e8:	6402                	ld	s0,0(sp)
ffffffffc02015ea:	0141                	addi	sp,sp,16
ffffffffc02015ec:	8082                	ret

ffffffffc02015ee <pmm_init>:
    pmm_manager = &buddy_pmm_manager;
ffffffffc02015ee:	00002797          	auipc	a5,0x2
ffffffffc02015f2:	ec278793          	addi	a5,a5,-318 # ffffffffc02034b0 <buddy_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02015f6:	638c                	ld	a1,0(a5)
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void)
{
ffffffffc02015f8:	7139                	addi	sp,sp,-64
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02015fa:	00002517          	auipc	a0,0x2
ffffffffc02015fe:	f0650513          	addi	a0,a0,-250 # ffffffffc0203500 <buddy_pmm_manager+0x50>
{
ffffffffc0201602:	fc06                	sd	ra,56(sp)
    pmm_manager = &buddy_pmm_manager;
ffffffffc0201604:	00006717          	auipc	a4,0x6
ffffffffc0201608:	f4f73223          	sd	a5,-188(a4) # ffffffffc0207548 <pmm_manager>
{
ffffffffc020160c:	f426                	sd	s1,40(sp)
ffffffffc020160e:	f04a                	sd	s2,32(sp)
ffffffffc0201610:	ec4e                	sd	s3,24(sp)
ffffffffc0201612:	e456                	sd	s5,8(sp)
ffffffffc0201614:	f822                	sd	s0,48(sp)
ffffffffc0201616:	e852                	sd	s4,16(sp)
    pmm_manager = &buddy_pmm_manager;
ffffffffc0201618:	00006497          	auipc	s1,0x6
ffffffffc020161c:	f3048493          	addi	s1,s1,-208 # ffffffffc0207548 <pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201620:	a9bfe0ef          	jal	ra,ffffffffc02000ba <cprintf>
    pmm_manager->init();
ffffffffc0201624:	609c                	ld	a5,0(s1)
ffffffffc0201626:	00006997          	auipc	s3,0x6
ffffffffc020162a:	ee298993          	addi	s3,s3,-286 # ffffffffc0207508 <npage>
ffffffffc020162e:	00006a97          	auipc	s5,0x6
ffffffffc0201632:	f2aa8a93          	addi	s5,s5,-214 # ffffffffc0207558 <pages>
ffffffffc0201636:	679c                	ld	a5,8(a5)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0201638:	fff80937          	lui	s2,0xfff80
    pmm_manager->init();
ffffffffc020163c:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET; // 硬编码 0xFFFFFFFF40000000
ffffffffc020163e:	57f5                	li	a5,-3
ffffffffc0201640:	07fa                	slli	a5,a5,0x1e
    cprintf("physcial memory map:\n");
ffffffffc0201642:	00002517          	auipc	a0,0x2
ffffffffc0201646:	ed650513          	addi	a0,a0,-298 # ffffffffc0203518 <buddy_pmm_manager+0x68>
    va_pa_offset = PHYSICAL_MEMORY_OFFSET; // 硬编码 0xFFFFFFFF40000000
ffffffffc020164a:	00006717          	auipc	a4,0x6
ffffffffc020164e:	f0f73323          	sd	a5,-250(a4) # ffffffffc0207550 <va_pa_offset>
    cprintf("physcial memory map:\n");
ffffffffc0201652:	a69fe0ef          	jal	ra,ffffffffc02000ba <cprintf>
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin, // 打印一个长整型(long int)的16进制数,不足16位在前面填充0
ffffffffc0201656:	46c5                	li	a3,17
ffffffffc0201658:	06ee                	slli	a3,a3,0x1b
ffffffffc020165a:	40100613          	li	a2,1025
ffffffffc020165e:	16fd                	addi	a3,a3,-1
ffffffffc0201660:	0656                	slli	a2,a2,0x15
ffffffffc0201662:	07e005b7          	lui	a1,0x7e00
ffffffffc0201666:	00002517          	auipc	a0,0x2
ffffffffc020166a:	eca50513          	addi	a0,a0,-310 # ffffffffc0203530 <buddy_pmm_manager+0x80>
ffffffffc020166e:	a4dfe0ef          	jal	ra,ffffffffc02000ba <cprintf>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0201672:	777d                	lui	a4,0xfffff
ffffffffc0201674:	00007797          	auipc	a5,0x7
ffffffffc0201678:	eeb78793          	addi	a5,a5,-277 # ffffffffc020855f <end+0xfff>
ffffffffc020167c:	8ff9                	and	a5,a5,a4
    npage = maxpa / PGSIZE;
ffffffffc020167e:	00088737          	lui	a4,0x88
ffffffffc0201682:	00006697          	auipc	a3,0x6
ffffffffc0201686:	e8e6b323          	sd	a4,-378(a3) # ffffffffc0207508 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc020168a:	00006717          	auipc	a4,0x6
ffffffffc020168e:	ecf73723          	sd	a5,-306(a4) # ffffffffc0207558 <pages>
ffffffffc0201692:	4681                	li	a3,0
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0201694:	4701                	li	a4,0
ffffffffc0201696:	4605                	li	a2,1
ffffffffc0201698:	a019                	j	ffffffffc020169e <pmm_init+0xb0>
ffffffffc020169a:	000ab783          	ld	a5,0(s5)
        SetPageReserved(pages + i); // 记得吗？在kern/mm/memlayout.h定义的
ffffffffc020169e:	97b6                	add	a5,a5,a3
ffffffffc02016a0:	07a1                	addi	a5,a5,8
ffffffffc02016a2:	40c7b02f          	amoor.d	zero,a2,(a5)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02016a6:	0009b783          	ld	a5,0(s3)
ffffffffc02016aa:	0705                	addi	a4,a4,1
ffffffffc02016ac:	02868693          	addi	a3,a3,40
ffffffffc02016b0:	012785b3          	add	a1,a5,s2
ffffffffc02016b4:	feb763e3          	bltu	a4,a1,ffffffffc020169a <pmm_init+0xac>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02016b8:	000ab403          	ld	s0,0(s5)
ffffffffc02016bc:	00279693          	slli	a3,a5,0x2
ffffffffc02016c0:	96be                	add	a3,a3,a5
ffffffffc02016c2:	fec007b7          	lui	a5,0xfec00
ffffffffc02016c6:	943e                	add	s0,s0,a5
ffffffffc02016c8:	068e                	slli	a3,a3,0x3
ffffffffc02016ca:	9436                	add	s0,s0,a3
ffffffffc02016cc:	c02007b7          	lui	a5,0xc0200
ffffffffc02016d0:	0af46963          	bltu	s0,a5,ffffffffc0201782 <pmm_init+0x194>
ffffffffc02016d4:	00006a17          	auipc	s4,0x6
ffffffffc02016d8:	e7ca0a13          	addi	s4,s4,-388 # ffffffffc0207550 <va_pa_offset>
ffffffffc02016dc:	000a3683          	ld	a3,0(s4)
    cprintf("freemem = %p\n", freemem);
ffffffffc02016e0:	00002517          	auipc	a0,0x2
ffffffffc02016e4:	eb850513          	addi	a0,a0,-328 # ffffffffc0203598 <buddy_pmm_manager+0xe8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02016e8:	8c15                	sub	s0,s0,a3
    cprintf("freemem = %p\n", freemem);
ffffffffc02016ea:	85a2                	mv	a1,s0
ffffffffc02016ec:	9cffe0ef          	jal	ra,ffffffffc02000ba <cprintf>
    if (freemem < mem_end)
ffffffffc02016f0:	45c5                	li	a1,17
ffffffffc02016f2:	05ee                	slli	a1,a1,0x1b
ffffffffc02016f4:	04b46e63          	bltu	s0,a1,ffffffffc0201750 <pmm_init+0x162>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc02016f8:	609c                	ld	a5,0(s1)
ffffffffc02016fa:	7b9c                	ld	a5,48(a5)
ffffffffc02016fc:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc02016fe:	00002517          	auipc	a0,0x2
ffffffffc0201702:	eda50513          	addi	a0,a0,-294 # ffffffffc02035d8 <buddy_pmm_manager+0x128>
ffffffffc0201706:	9b5fe0ef          	jal	ra,ffffffffc02000ba <cprintf>
    satp_virtual = (pte_t *)boot_page_table_sv39;
ffffffffc020170a:	00005697          	auipc	a3,0x5
ffffffffc020170e:	8f668693          	addi	a3,a3,-1802 # ffffffffc0206000 <boot_page_table_sv39>
ffffffffc0201712:	00006797          	auipc	a5,0x6
ffffffffc0201716:	ded7bf23          	sd	a3,-514(a5) # ffffffffc0207510 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc020171a:	c02007b7          	lui	a5,0xc0200
ffffffffc020171e:	06f6ef63          	bltu	a3,a5,ffffffffc020179c <pmm_init+0x1ae>
ffffffffc0201722:	000a3783          	ld	a5,0(s4)
}
ffffffffc0201726:	7442                	ld	s0,48(sp)
ffffffffc0201728:	70e2                	ld	ra,56(sp)
ffffffffc020172a:	74a2                	ld	s1,40(sp)
ffffffffc020172c:	7902                	ld	s2,32(sp)
ffffffffc020172e:	69e2                	ld	s3,24(sp)
ffffffffc0201730:	6a42                	ld	s4,16(sp)
ffffffffc0201732:	6aa2                	ld	s5,8(sp)
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0201734:	85b6                	mv	a1,a3
    satp_physical = PADDR(satp_virtual);
ffffffffc0201736:	8e9d                	sub	a3,a3,a5
ffffffffc0201738:	00006797          	auipc	a5,0x6
ffffffffc020173c:	e0d7b423          	sd	a3,-504(a5) # ffffffffc0207540 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0201740:	00002517          	auipc	a0,0x2
ffffffffc0201744:	eb850513          	addi	a0,a0,-328 # ffffffffc02035f8 <buddy_pmm_manager+0x148>
ffffffffc0201748:	8636                	mv	a2,a3
}
ffffffffc020174a:	6121                	addi	sp,sp,64
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc020174c:	96ffe06f          	j	ffffffffc02000ba <cprintf>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0201750:	6685                	lui	a3,0x1
ffffffffc0201752:	16fd                	addi	a3,a3,-1
ffffffffc0201754:	9436                	add	s0,s0,a3
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa)
{
    if (PPN(pa) >= npage)
ffffffffc0201756:	0009b703          	ld	a4,0(s3)
ffffffffc020175a:	76fd                	lui	a3,0xfffff
ffffffffc020175c:	8c75                	and	s0,s0,a3
ffffffffc020175e:	00c45793          	srli	a5,s0,0xc
ffffffffc0201762:	04e7f963          	bleu	a4,a5,ffffffffc02017b4 <pmm_init+0x1c6>
    pmm_manager->init_memmap(base, n);
ffffffffc0201766:	6098                	ld	a4,0(s1)
    {
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0201768:	97ca                	add	a5,a5,s2
ffffffffc020176a:	00279913          	slli	s2,a5,0x2
ffffffffc020176e:	000ab503          	ld	a0,0(s5)
ffffffffc0201772:	993e                	add	s2,s2,a5
ffffffffc0201774:	6b1c                	ld	a5,16(a4)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0201776:	8d81                	sub	a1,a1,s0
ffffffffc0201778:	090e                	slli	s2,s2,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc020177a:	81b1                	srli	a1,a1,0xc
ffffffffc020177c:	954a                	add	a0,a0,s2
ffffffffc020177e:	9782                	jalr	a5
ffffffffc0201780:	bfa5                	j	ffffffffc02016f8 <pmm_init+0x10a>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0201782:	86a2                	mv	a3,s0
ffffffffc0201784:	00002617          	auipc	a2,0x2
ffffffffc0201788:	ddc60613          	addi	a2,a2,-548 # ffffffffc0203560 <buddy_pmm_manager+0xb0>
ffffffffc020178c:	08600593          	li	a1,134
ffffffffc0201790:	00002517          	auipc	a0,0x2
ffffffffc0201794:	df850513          	addi	a0,a0,-520 # ffffffffc0203588 <buddy_pmm_manager+0xd8>
ffffffffc0201798:	c19fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc020179c:	00002617          	auipc	a2,0x2
ffffffffc02017a0:	dc460613          	addi	a2,a2,-572 # ffffffffc0203560 <buddy_pmm_manager+0xb0>
ffffffffc02017a4:	0a500593          	li	a1,165
ffffffffc02017a8:	00002517          	auipc	a0,0x2
ffffffffc02017ac:	de050513          	addi	a0,a0,-544 # ffffffffc0203588 <buddy_pmm_manager+0xd8>
ffffffffc02017b0:	c01fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02017b4:	00002617          	auipc	a2,0x2
ffffffffc02017b8:	df460613          	addi	a2,a2,-524 # ffffffffc02035a8 <buddy_pmm_manager+0xf8>
ffffffffc02017bc:	07700593          	li	a1,119
ffffffffc02017c0:	00002517          	auipc	a0,0x2
ffffffffc02017c4:	e0850513          	addi	a0,a0,-504 # ffffffffc02035c8 <buddy_pmm_manager+0x118>
ffffffffc02017c8:	be9fe0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc02017cc <test_ctor>:

static void
test_ctor(void *objp, struct kmem_cache_t *cachep, size_t size)
{
    char *p = objp;
    for (int i = 0; i < size; i++)
ffffffffc02017cc:	ca09                	beqz	a2,ffffffffc02017de <test_ctor+0x12>
ffffffffc02017ce:	962a                	add	a2,a2,a0
        p[i] = TEST_OBJECT_CTVAL;
ffffffffc02017d0:	02200793          	li	a5,34
ffffffffc02017d4:	00f50023          	sb	a5,0(a0)
ffffffffc02017d8:	0505                	addi	a0,a0,1
    for (int i = 0; i < size; i++)
ffffffffc02017da:	fec51de3          	bne	a0,a2,ffffffffc02017d4 <test_ctor+0x8>
}
ffffffffc02017de:	8082                	ret

ffffffffc02017e0 <test_dtor>:

static void
test_dtor(void *objp, struct kmem_cache_t *cachep, size_t size)
{
    char *p = objp;
    for (int i = 0; i < size; i++)
ffffffffc02017e0:	ca01                	beqz	a2,ffffffffc02017f0 <test_dtor+0x10>
ffffffffc02017e2:	962a                	add	a2,a2,a0
        p[i] = TEST_OBJECT_DTVAL;
ffffffffc02017e4:	47c5                	li	a5,17
ffffffffc02017e6:	00f50023          	sb	a5,0(a0)
ffffffffc02017ea:	0505                	addi	a0,a0,1
    for (int i = 0; i < size; i++)
ffffffffc02017ec:	fec51de3          	bne	a0,a2,ffffffffc02017e6 <test_dtor+0x6>
}
ffffffffc02017f0:	8082                	ret

ffffffffc02017f2 <kmem_slab_destroy>:
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02017f2:	00006797          	auipc	a5,0x6
ffffffffc02017f6:	d6678793          	addi	a5,a5,-666 # ffffffffc0207558 <pages>
ffffffffc02017fa:	639c                	ld	a5,0(a5)
{
ffffffffc02017fc:	7179                	addi	sp,sp,-48
ffffffffc02017fe:	e84a                	sd	s2,16(sp)
ffffffffc0201800:	40f586b3          	sub	a3,a1,a5
ffffffffc0201804:	00002797          	auipc	a5,0x2
ffffffffc0201808:	c2478793          	addi	a5,a5,-988 # ffffffffc0203428 <commands+0x870>
ffffffffc020180c:	639c                	ld	a5,0(a5)
ffffffffc020180e:	868d                	srai	a3,a3,0x3
    return KADDR(page2pa(page));
ffffffffc0201810:	00006717          	auipc	a4,0x6
ffffffffc0201814:	cf870713          	addi	a4,a4,-776 # ffffffffc0207508 <npage>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0201818:	02f686b3          	mul	a3,a3,a5
ffffffffc020181c:	00002797          	auipc	a5,0x2
ffffffffc0201820:	46c78793          	addi	a5,a5,1132 # ffffffffc0203c88 <nbase>
ffffffffc0201824:	0007b903          	ld	s2,0(a5)
    return KADDR(page2pa(page));
ffffffffc0201828:	6318                	ld	a4,0(a4)
ffffffffc020182a:	57fd                	li	a5,-1
ffffffffc020182c:	83b1                	srli	a5,a5,0xc
ffffffffc020182e:	f406                	sd	ra,40(sp)
ffffffffc0201830:	f022                	sd	s0,32(sp)
ffffffffc0201832:	ec26                	sd	s1,24(sp)
ffffffffc0201834:	e44e                	sd	s3,8(sp)
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0201836:	96ca                	add	a3,a3,s2
    return KADDR(page2pa(page));
ffffffffc0201838:	8ff5                	and	a5,a5,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc020183a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020183c:	06e7fd63          	bleu	a4,a5,ffffffffc02018b6 <kmem_slab_destroy+0xc4>
    if (cachep->dtor)
ffffffffc0201840:	613c                	ld	a5,64(a0)
ffffffffc0201842:	89ae                	mv	s3,a1
ffffffffc0201844:	842a                	mv	s0,a0
ffffffffc0201846:	c7a1                	beqz	a5,ffffffffc020188e <kmem_slab_destroy+0x9c>
    void *buf = bufctl + cachep->num;
ffffffffc0201848:	03255703          	lhu	a4,50(a0)
        for (void *p = buf; p < buf + cachep->objsize * cachep->num; p += cachep->objsize)
ffffffffc020184c:	03055603          	lhu	a2,48(a0)
ffffffffc0201850:	00006597          	auipc	a1,0x6
ffffffffc0201854:	d0058593          	addi	a1,a1,-768 # ffffffffc0207550 <va_pa_offset>
ffffffffc0201858:	0005b903          	ld	s2,0(a1)
ffffffffc020185c:	02e605bb          	mulw	a1,a2,a4
    void *buf = bufctl + cachep->num;
ffffffffc0201860:	0706                	slli	a4,a4,0x1
ffffffffc0201862:	96ca                	add	a3,a3,s2
ffffffffc0201864:	00e68933          	add	s2,a3,a4
        for (void *p = buf; p < buf + cachep->objsize * cachep->num; p += cachep->objsize)
ffffffffc0201868:	95ca                	add	a1,a1,s2
ffffffffc020186a:	02b97263          	bleu	a1,s2,ffffffffc020188e <kmem_slab_destroy+0x9c>
ffffffffc020186e:	84ca                	mv	s1,s2
ffffffffc0201870:	a011                	j	ffffffffc0201874 <kmem_slab_destroy+0x82>
ffffffffc0201872:	603c                	ld	a5,64(s0)
            cachep->dtor(p, cachep, cachep->objsize);
ffffffffc0201874:	8526                	mv	a0,s1
ffffffffc0201876:	85a2                	mv	a1,s0
ffffffffc0201878:	9782                	jalr	a5
        for (void *p = buf; p < buf + cachep->objsize * cachep->num; p += cachep->objsize)
ffffffffc020187a:	03045603          	lhu	a2,48(s0)
ffffffffc020187e:	03245783          	lhu	a5,50(s0)
ffffffffc0201882:	94b2                	add	s1,s1,a2
ffffffffc0201884:	02c787bb          	mulw	a5,a5,a2
ffffffffc0201888:	97ca                	add	a5,a5,s2
ffffffffc020188a:	fef4e4e3          	bltu	s1,a5,ffffffffc0201872 <kmem_slab_destroy+0x80>
    __list_del(listelm->prev, listelm->next);
ffffffffc020188e:	0189b703          	ld	a4,24(s3)
ffffffffc0201892:	0209b783          	ld	a5,32(s3)
    page->property = page->flags = 0;
ffffffffc0201896:	0009b423          	sd	zero,8(s3)
ffffffffc020189a:	0009a823          	sw	zero,16(s3)
}
ffffffffc020189e:	7402                	ld	s0,32(sp)
    prev->next = next;
ffffffffc02018a0:	e71c                	sd	a5,8(a4)
ffffffffc02018a2:	70a2                	ld	ra,40(sp)
ffffffffc02018a4:	64e2                	ld	s1,24(sp)
ffffffffc02018a6:	6942                	ld	s2,16(sp)
    free_page(page); // 这个是manager中的函数
ffffffffc02018a8:	854e                	mv	a0,s3
}
ffffffffc02018aa:	69a2                	ld	s3,8(sp)
    next->prev = prev;
ffffffffc02018ac:	e398                	sd	a4,0(a5)
    free_page(page); // 这个是manager中的函数
ffffffffc02018ae:	4585                	li	a1,1
}
ffffffffc02018b0:	6145                	addi	sp,sp,48
    free_page(page); // 这个是manager中的函数
ffffffffc02018b2:	cb7ff06f          	j	ffffffffc0201568 <free_pages>
ffffffffc02018b6:	00002617          	auipc	a2,0x2
ffffffffc02018ba:	bd260613          	addi	a2,a2,-1070 # ffffffffc0203488 <commands+0x8d0>
ffffffffc02018be:	06100593          	li	a1,97
ffffffffc02018c2:	00002517          	auipc	a0,0x2
ffffffffc02018c6:	d0650513          	addi	a0,a0,-762 # ffffffffc02035c8 <buddy_pmm_manager+0x118>
ffffffffc02018ca:	ae7fe0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc02018ce <kmem_cache_alloc>:
// kmem_cache_alloc - allocate an object
// 先查找slabs_partial，如果没找到空闲区域则查找slabs_free，还是没找到就申请一个新的slab
// 从slab分配一个对象后，如果slab变满，那么将slab加入slabs_full
void *
kmem_cache_alloc(struct kmem_cache_t *cachep)
{
ffffffffc02018ce:	715d                	addi	sp,sp,-80
ffffffffc02018d0:	e0a2                	sd	s0,64(sp)
    return list->next == list;
ffffffffc02018d2:	6d00                	ld	s0,24(a0)
ffffffffc02018d4:	fc26                	sd	s1,56(sp)
ffffffffc02018d6:	f84a                	sd	s2,48(sp)
ffffffffc02018d8:	f44e                	sd	s3,40(sp)
ffffffffc02018da:	00002797          	auipc	a5,0x2
ffffffffc02018de:	3ae78793          	addi	a5,a5,942 # ffffffffc0203c88 <nbase>
ffffffffc02018e2:	e486                	sd	ra,72(sp)
ffffffffc02018e4:	f052                	sd	s4,32(sp)
ffffffffc02018e6:	ec56                	sd	s5,24(sp)
ffffffffc02018e8:	e85a                	sd	s6,16(sp)
ffffffffc02018ea:	e45e                	sd	s7,8(sp)
    // cprintf("开始分配！\n");
    list_entry_t *le = NULL;
    // Find in partial list
    if (!list_empty(&(cachep->slabs_partial)))
ffffffffc02018ec:	01050913          	addi	s2,a0,16
{
ffffffffc02018f0:	84aa                	mv	s1,a0
ffffffffc02018f2:	0007b983          	ld	s3,0(a5)
    if (!list_empty(&(cachep->slabs_partial)))
ffffffffc02018f6:	0a890763          	beq	s2,s0,ffffffffc02019a4 <kmem_cache_alloc+0xd6>
ffffffffc02018fa:	00006797          	auipc	a5,0x6
ffffffffc02018fe:	c5e78793          	addi	a5,a5,-930 # ffffffffc0207558 <pages>
ffffffffc0201902:	0007b803          	ld	a6,0(a5)
ffffffffc0201906:	00006797          	auipc	a5,0x6
ffffffffc020190a:	c0278793          	addi	a5,a5,-1022 # ffffffffc0207508 <npage>
ffffffffc020190e:	638c                	ld	a1,0(a5)
    return listelm->next;
ffffffffc0201910:	00002b17          	auipc	s6,0x2
ffffffffc0201914:	b18b0b13          	addi	s6,s6,-1256 # ffffffffc0203428 <commands+0x870>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0201918:	000b3783          	ld	a5,0(s6)
            return NULL;
        le = list_next(&(cachep->slabs_free));
    }
    // Alloc
    list_del(le);
    struct slab_t *slab = le2slab(le, page_link);
ffffffffc020191c:	fe840693          	addi	a3,s0,-24
ffffffffc0201920:	410686b3          	sub	a3,a3,a6
ffffffffc0201924:	868d                	srai	a3,a3,0x3
ffffffffc0201926:	02f686b3          	mul	a3,a3,a5
    __list_del(listelm->prev, listelm->next);
ffffffffc020192a:	6018                	ld	a4,0(s0)
ffffffffc020192c:	641c                	ld	a5,8(s0)
    prev->next = next;
ffffffffc020192e:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0201930:	e398                	sd	a4,0(a5)
    return KADDR(page2pa(page));
ffffffffc0201932:	57fd                	li	a5,-1
ffffffffc0201934:	83b1                	srli	a5,a5,0xc
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0201936:	96ce                	add	a3,a3,s3
    return KADDR(page2pa(page));
ffffffffc0201938:	8ff5                	and	a5,a5,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc020193a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020193c:	14b7fb63          	bleu	a1,a5,ffffffffc0201a92 <kmem_cache_alloc+0x1c4>
    void *kva = slab2kva(slab);
    int16_t *bufctl = kva;
    void *buf = bufctl + cachep->num;
    void *objp = buf + slab->free * cachep->objsize;
ffffffffc0201940:	ffa41703          	lh	a4,-6(s0)
ffffffffc0201944:	0304d503          	lhu	a0,48(s1)
    // Update slab
    slab->inuse++;
ffffffffc0201948:	ff845783          	lhu	a5,-8(s0)
ffffffffc020194c:	00006617          	auipc	a2,0x6
ffffffffc0201950:	c0460613          	addi	a2,a2,-1020 # ffffffffc0207550 <va_pa_offset>
    void *objp = buf + slab->free * cachep->objsize;
ffffffffc0201954:	02e5053b          	mulw	a0,a0,a4
ffffffffc0201958:	6210                	ld	a2,0(a2)
    slab->inuse++;
ffffffffc020195a:	2785                	addiw	a5,a5,1
ffffffffc020195c:	17c2                	slli	a5,a5,0x30
ffffffffc020195e:	96b2                	add	a3,a3,a2
ffffffffc0201960:	93c1                	srli	a5,a5,0x30
    slab->free = bufctl[slab->free];
ffffffffc0201962:	0706                	slli	a4,a4,0x1
    void *buf = bufctl + cachep->num;
ffffffffc0201964:	0324d603          	lhu	a2,50(s1)
    slab->free = bufctl[slab->free];
ffffffffc0201968:	9736                	add	a4,a4,a3
    slab->inuse++;
ffffffffc020196a:	fef41c23          	sh	a5,-8(s0)
    slab->free = bufctl[slab->free];
ffffffffc020196e:	00071703          	lh	a4,0(a4)
    void *buf = bufctl + cachep->num;
ffffffffc0201972:	00161593          	slli	a1,a2,0x1
    void *objp = buf + slab->free * cachep->objsize;
ffffffffc0201976:	952e                	add	a0,a0,a1
    slab->free = bufctl[slab->free];
ffffffffc0201978:	fee41d23          	sh	a4,-6(s0)
    void *objp = buf + slab->free * cachep->objsize;
ffffffffc020197c:	9536                	add	a0,a0,a3
    if (slab->inuse == cachep->num)
ffffffffc020197e:	10f60263          	beq	a2,a5,ffffffffc0201a82 <kmem_cache_alloc+0x1b4>
    __list_add(elm, listelm, listelm->next);
ffffffffc0201982:	6c9c                	ld	a5,24(s1)
    prev->next = next->prev = elm;
ffffffffc0201984:	e380                	sd	s0,0(a5)
ffffffffc0201986:	ec80                	sd	s0,24(s1)
    elm->next = next;
ffffffffc0201988:	e41c                	sd	a5,8(s0)
    elm->prev = prev;
ffffffffc020198a:	01243023          	sd	s2,0(s0)
        list_add(&(cachep->slabs_full), le);
    else
        list_add(&(cachep->slabs_partial), le);
    return objp;
}
ffffffffc020198e:	60a6                	ld	ra,72(sp)
ffffffffc0201990:	6406                	ld	s0,64(sp)
ffffffffc0201992:	74e2                	ld	s1,56(sp)
ffffffffc0201994:	7942                	ld	s2,48(sp)
ffffffffc0201996:	79a2                	ld	s3,40(sp)
ffffffffc0201998:	7a02                	ld	s4,32(sp)
ffffffffc020199a:	6ae2                	ld	s5,24(sp)
ffffffffc020199c:	6b42                	ld	s6,16(sp)
ffffffffc020199e:	6ba2                	ld	s7,8(sp)
ffffffffc02019a0:	6161                	addi	sp,sp,80
ffffffffc02019a2:	8082                	ret
    return list->next == list;
ffffffffc02019a4:	7500                	ld	s0,40(a0)
        if (list_empty(&(cachep->slabs_free)) && kmem_cache_grow(cachep) == NULL)
ffffffffc02019a6:	02050793          	addi	a5,a0,32
ffffffffc02019aa:	f4f418e3          	bne	s0,a5,ffffffffc02018fa <kmem_cache_alloc+0x2c>
    struct Page *page = alloc_page(); // ! 这个是manager中的函数，对接上buddy的接口
ffffffffc02019ae:	4505                	li	a0,1
ffffffffc02019b0:	b75ff0ef          	jal	ra,ffffffffc0201524 <alloc_pages>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02019b4:	00006a17          	auipc	s4,0x6
ffffffffc02019b8:	ba4a0a13          	addi	s4,s4,-1116 # ffffffffc0207558 <pages>
ffffffffc02019bc:	000a3803          	ld	a6,0(s4)
ffffffffc02019c0:	00002b17          	auipc	s6,0x2
ffffffffc02019c4:	a68b0b13          	addi	s6,s6,-1432 # ffffffffc0203428 <commands+0x870>
ffffffffc02019c8:	000b3683          	ld	a3,0(s6)
ffffffffc02019cc:	410507b3          	sub	a5,a0,a6
ffffffffc02019d0:	878d                	srai	a5,a5,0x3
ffffffffc02019d2:	02d787b3          	mul	a5,a5,a3
    return KADDR(page2pa(page));
ffffffffc02019d6:	00006a97          	auipc	s5,0x6
ffffffffc02019da:	b32a8a93          	addi	s5,s5,-1230 # ffffffffc0207508 <npage>
ffffffffc02019de:	577d                	li	a4,-1
ffffffffc02019e0:	000ab583          	ld	a1,0(s5)
ffffffffc02019e4:	8331                	srli	a4,a4,0xc
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02019e6:	97ce                	add	a5,a5,s3
    return KADDR(page2pa(page));
ffffffffc02019e8:	8f7d                	and	a4,a4,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc02019ea:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc02019ec:	0ab77f63          	bleu	a1,a4,ffffffffc0201aaa <kmem_cache_alloc+0x1dc>
    slab->inuse = slab->free = 0;                        // 当前没有分配过
ffffffffc02019f0:	00052823          	sw	zero,16(a0)
    __list_add(elm, listelm, listelm->next);
ffffffffc02019f4:	7498                	ld	a4,40(s1)
ffffffffc02019f6:	00006697          	auipc	a3,0x6
ffffffffc02019fa:	b5a68693          	addi	a3,a3,-1190 # ffffffffc0207550 <va_pa_offset>
ffffffffc02019fe:	6294                	ld	a3,0(a3)
    slab->cachep = cachep;                               // 设置仓库对象
ffffffffc0201a00:	e504                	sd	s1,8(a0)
    list_add(&(cachep->slabs_free), &(slab->slab_link)); // 当前这一页全空闲
ffffffffc0201a02:	01850893          	addi	a7,a0,24
    prev->next = next->prev = elm;
ffffffffc0201a06:	01173023          	sd	a7,0(a4)
    for (int i = 1; i < cachep->num; i++)
ffffffffc0201a0a:	0324d603          	lhu	a2,50(s1)
ffffffffc0201a0e:	0314b423          	sd	a7,40(s1)
ffffffffc0201a12:	97b6                	add	a5,a5,a3
    elm->next = next;
ffffffffc0201a14:	f118                	sd	a4,32(a0)
    elm->prev = prev;
ffffffffc0201a16:	ed00                	sd	s0,24(a0)
ffffffffc0201a18:	4705                	li	a4,1
ffffffffc0201a1a:	843e                	mv	s0,a5
ffffffffc0201a1c:	00c77a63          	bleu	a2,a4,ffffffffc0201a30 <kmem_cache_alloc+0x162>
        bufctl[i - 1] = i;
ffffffffc0201a20:	00e79023          	sh	a4,0(a5)
    for (int i = 1; i < cachep->num; i++)
ffffffffc0201a24:	0324d603          	lhu	a2,50(s1)
ffffffffc0201a28:	2705                	addiw	a4,a4,1
ffffffffc0201a2a:	0789                	addi	a5,a5,2
ffffffffc0201a2c:	fec74ae3          	blt	a4,a2,ffffffffc0201a20 <kmem_cache_alloc+0x152>
    bufctl[cachep->num - 1] = -1;
ffffffffc0201a30:	0606                	slli	a2,a2,0x1
    if (cachep->ctor)
ffffffffc0201a32:	7c9c                	ld	a5,56(s1)
    bufctl[cachep->num - 1] = -1;
ffffffffc0201a34:	9622                	add	a2,a2,s0
ffffffffc0201a36:	577d                	li	a4,-1
ffffffffc0201a38:	fee61f23          	sh	a4,-2(a2)
    if (cachep->ctor)
ffffffffc0201a3c:	cba9                	beqz	a5,ffffffffc0201a8e <kmem_cache_alloc+0x1c0>
    void *buf = bufctl + cachep->num;
ffffffffc0201a3e:	0324d703          	lhu	a4,50(s1)
        for (void *p = buf; p < buf + cachep->objsize * cachep->num; p += cachep->objsize)
ffffffffc0201a42:	0304d603          	lhu	a2,48(s1)
    void *buf = bufctl + cachep->num;
ffffffffc0201a46:	00171693          	slli	a3,a4,0x1
        for (void *p = buf; p < buf + cachep->objsize * cachep->num; p += cachep->objsize)
ffffffffc0201a4a:	02e6073b          	mulw	a4,a2,a4
    void *buf = bufctl + cachep->num;
ffffffffc0201a4e:	9436                	add	s0,s0,a3
        for (void *p = buf; p < buf + cachep->objsize * cachep->num; p += cachep->objsize)
ffffffffc0201a50:	8ba2                	mv	s7,s0
ffffffffc0201a52:	9722                	add	a4,a4,s0
ffffffffc0201a54:	00e46463          	bltu	s0,a4,ffffffffc0201a5c <kmem_cache_alloc+0x18e>
ffffffffc0201a58:	a81d                	j	ffffffffc0201a8e <kmem_cache_alloc+0x1c0>
ffffffffc0201a5a:	7c9c                	ld	a5,56(s1)
            cachep->ctor(p, cachep, cachep->objsize);
ffffffffc0201a5c:	855e                	mv	a0,s7
ffffffffc0201a5e:	85a6                	mv	a1,s1
ffffffffc0201a60:	9782                	jalr	a5
        for (void *p = buf; p < buf + cachep->objsize * cachep->num; p += cachep->objsize)
ffffffffc0201a62:	0304d603          	lhu	a2,48(s1)
ffffffffc0201a66:	0324d783          	lhu	a5,50(s1)
ffffffffc0201a6a:	9bb2                	add	s7,s7,a2
ffffffffc0201a6c:	02c787bb          	mulw	a5,a5,a2
ffffffffc0201a70:	97a2                	add	a5,a5,s0
ffffffffc0201a72:	fefbe4e3          	bltu	s7,a5,ffffffffc0201a5a <kmem_cache_alloc+0x18c>
ffffffffc0201a76:	7480                	ld	s0,40(s1)
ffffffffc0201a78:	000a3803          	ld	a6,0(s4)
ffffffffc0201a7c:	000ab583          	ld	a1,0(s5)
ffffffffc0201a80:	bd61                	j	ffffffffc0201918 <kmem_cache_alloc+0x4a>
    __list_add(elm, listelm, listelm->next);
ffffffffc0201a82:	649c                	ld	a5,8(s1)
    prev->next = next->prev = elm;
ffffffffc0201a84:	e380                	sd	s0,0(a5)
ffffffffc0201a86:	e480                	sd	s0,8(s1)
    elm->next = next;
ffffffffc0201a88:	e41c                	sd	a5,8(s0)
    elm->prev = prev;
ffffffffc0201a8a:	e004                	sd	s1,0(s0)
ffffffffc0201a8c:	b709                	j	ffffffffc020198e <kmem_cache_alloc+0xc0>
ffffffffc0201a8e:	7480                	ld	s0,40(s1)
ffffffffc0201a90:	b561                	j	ffffffffc0201918 <kmem_cache_alloc+0x4a>
ffffffffc0201a92:	00002617          	auipc	a2,0x2
ffffffffc0201a96:	9f660613          	addi	a2,a2,-1546 # ffffffffc0203488 <commands+0x8d0>
ffffffffc0201a9a:	06100593          	li	a1,97
ffffffffc0201a9e:	00002517          	auipc	a0,0x2
ffffffffc0201aa2:	b2a50513          	addi	a0,a0,-1238 # ffffffffc02035c8 <buddy_pmm_manager+0x118>
ffffffffc0201aa6:	90bfe0ef          	jal	ra,ffffffffc02003b0 <__panic>
ffffffffc0201aaa:	86be                	mv	a3,a5
ffffffffc0201aac:	00002617          	auipc	a2,0x2
ffffffffc0201ab0:	9dc60613          	addi	a2,a2,-1572 # ffffffffc0203488 <commands+0x8d0>
ffffffffc0201ab4:	06100593          	li	a1,97
ffffffffc0201ab8:	00002517          	auipc	a0,0x2
ffffffffc0201abc:	b1050513          	addi	a0,a0,-1264 # ffffffffc02035c8 <buddy_pmm_manager+0x118>
ffffffffc0201ac0:	8f1fe0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0201ac4 <kmem_cache_create>:
{
ffffffffc0201ac4:	7139                	addi	sp,sp,-64
ffffffffc0201ac6:	f426                	sd	s1,40(sp)
    assert(size <= (PGSIZE - 2));
ffffffffc0201ac8:	6485                	lui	s1,0x1
{
ffffffffc0201aca:	fc06                	sd	ra,56(sp)
ffffffffc0201acc:	f822                	sd	s0,48(sp)
ffffffffc0201ace:	f04a                	sd	s2,32(sp)
ffffffffc0201ad0:	ec4e                	sd	s3,24(sp)
ffffffffc0201ad2:	e852                	sd	s4,16(sp)
ffffffffc0201ad4:	e456                	sd	s5,8(sp)
    assert(size <= (PGSIZE - 2));
ffffffffc0201ad6:	ffe48793          	addi	a5,s1,-2 # ffe <BASE_ADDRESS-0xffffffffc01ff002>
ffffffffc0201ada:	08b7e263          	bltu	a5,a1,ffffffffc0201b5e <kmem_cache_create+0x9a>
ffffffffc0201ade:	89aa                	mv	s3,a0
    struct kmem_cache_t *cachep = kmem_cache_alloc(&(cache_cache));
ffffffffc0201ae0:	00005517          	auipc	a0,0x5
ffffffffc0201ae4:	53050513          	addi	a0,a0,1328 # ffffffffc0207010 <edata>
ffffffffc0201ae8:	892e                	mv	s2,a1
ffffffffc0201aea:	8ab2                	mv	s5,a2
ffffffffc0201aec:	8a36                	mv	s4,a3
ffffffffc0201aee:	de1ff0ef          	jal	ra,ffffffffc02018ce <kmem_cache_alloc>
ffffffffc0201af2:	842a                	mv	s0,a0
    if (cachep != NULL)
ffffffffc0201af4:	c939                	beqz	a0,ffffffffc0201b4a <kmem_cache_create+0x86>
        cachep->num = PGSIZE / (sizeof(int16_t) + size);
ffffffffc0201af6:	00290793          	addi	a5,s2,2 # fffffffffff80002 <end+0x3fd78aa2>
ffffffffc0201afa:	02f4d4b3          	divu	s1,s1,a5
        cachep->objsize = size;
ffffffffc0201afe:	03251823          	sh	s2,48(a0)
        cachep->ctor = ctor;
ffffffffc0201b02:	03553c23          	sd	s5,56(a0)
        cachep->dtor = dtor;
ffffffffc0201b06:	05453023          	sd	s4,64(a0)
        memcpy(cachep->name, name, CACHE_NAMELEN);
ffffffffc0201b0a:	4641                	li	a2,16
ffffffffc0201b0c:	85ce                	mv	a1,s3
ffffffffc0201b0e:	04850513          	addi	a0,a0,72
        cachep->num = PGSIZE / (sizeof(int16_t) + size);
ffffffffc0201b12:	02941923          	sh	s1,50(s0)
        memcpy(cachep->name, name, CACHE_NAMELEN);
ffffffffc0201b16:	76b000ef          	jal	ra,ffffffffc0202a80 <memcpy>
    __list_add(elm, listelm, listelm->next);
ffffffffc0201b1a:	00005717          	auipc	a4,0x5
ffffffffc0201b1e:	55e70713          	addi	a4,a4,1374 # ffffffffc0207078 <cache_chain>
    elm->prev = elm->next = elm;
ffffffffc0201b22:	e400                	sd	s0,8(s0)
    __list_add(elm, listelm, listelm->next);
ffffffffc0201b24:	6714                	ld	a3,8(a4)
        list_init(&(cachep->slabs_free));
ffffffffc0201b26:	02040613          	addi	a2,s0,32
        list_init(&(cachep->slabs_partial));
ffffffffc0201b2a:	01040593          	addi	a1,s0,16
    elm->prev = elm->next = elm;
ffffffffc0201b2e:	e000                	sd	s0,0(s0)
        list_add(&(cache_chain), &(cachep->cache_link));
ffffffffc0201b30:	05840793          	addi	a5,s0,88
ffffffffc0201b34:	f410                	sd	a2,40(s0)
ffffffffc0201b36:	f010                	sd	a2,32(s0)
ffffffffc0201b38:	ec0c                	sd	a1,24(s0)
ffffffffc0201b3a:	e80c                	sd	a1,16(s0)
    prev->next = next->prev = elm;
ffffffffc0201b3c:	e29c                	sd	a5,0(a3)
ffffffffc0201b3e:	00005617          	auipc	a2,0x5
ffffffffc0201b42:	54f63123          	sd	a5,1346(a2) # ffffffffc0207080 <cache_chain+0x8>
    elm->next = next;
ffffffffc0201b46:	f034                	sd	a3,96(s0)
    elm->prev = prev;
ffffffffc0201b48:	ec38                	sd	a4,88(s0)
}
ffffffffc0201b4a:	8522                	mv	a0,s0
ffffffffc0201b4c:	70e2                	ld	ra,56(sp)
ffffffffc0201b4e:	7442                	ld	s0,48(sp)
ffffffffc0201b50:	74a2                	ld	s1,40(sp)
ffffffffc0201b52:	7902                	ld	s2,32(sp)
ffffffffc0201b54:	69e2                	ld	s3,24(sp)
ffffffffc0201b56:	6a42                	ld	s4,16(sp)
ffffffffc0201b58:	6aa2                	ld	s5,8(sp)
ffffffffc0201b5a:	6121                	addi	sp,sp,64
ffffffffc0201b5c:	8082                	ret
    assert(size <= (PGSIZE - 2));
ffffffffc0201b5e:	00002697          	auipc	a3,0x2
ffffffffc0201b62:	af268693          	addi	a3,a3,-1294 # ffffffffc0203650 <buddy_pmm_manager+0x1a0>
ffffffffc0201b66:	00002617          	auipc	a2,0x2
ffffffffc0201b6a:	8d260613          	addi	a2,a2,-1838 # ffffffffc0203438 <commands+0x880>
ffffffffc0201b6e:	0cf00593          	li	a1,207
ffffffffc0201b72:	00002517          	auipc	a0,0x2
ffffffffc0201b76:	af650513          	addi	a0,a0,-1290 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0201b7a:	837fe0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0201b7e <kmem_cache_zalloc>:

// kmem_cache_zalloc - allocate an object and fill it with zero
// 使用kmem_cache_alloc分配一个对象之后将对象内存区域初始化为零
void *
kmem_cache_zalloc(struct kmem_cache_t *cachep)
{
ffffffffc0201b7e:	1101                	addi	sp,sp,-32
ffffffffc0201b80:	ec06                	sd	ra,24(sp)
ffffffffc0201b82:	e822                	sd	s0,16(sp)
ffffffffc0201b84:	e426                	sd	s1,8(sp)
ffffffffc0201b86:	84aa                	mv	s1,a0
    void *objp = kmem_cache_alloc(cachep);
ffffffffc0201b88:	d47ff0ef          	jal	ra,ffffffffc02018ce <kmem_cache_alloc>
    memset(objp, 0, cachep->objsize);
ffffffffc0201b8c:	0304d603          	lhu	a2,48(s1)
ffffffffc0201b90:	4581                	li	a1,0
    void *objp = kmem_cache_alloc(cachep);
ffffffffc0201b92:	842a                	mv	s0,a0
    memset(objp, 0, cachep->objsize);
ffffffffc0201b94:	6db000ef          	jal	ra,ffffffffc0202a6e <memset>
    return objp;
}
ffffffffc0201b98:	8522                	mv	a0,s0
ffffffffc0201b9a:	60e2                	ld	ra,24(sp)
ffffffffc0201b9c:	6442                	ld	s0,16(sp)
ffffffffc0201b9e:	64a2                	ld	s1,8(sp)
ffffffffc0201ba0:	6105                	addi	sp,sp,32
ffffffffc0201ba2:	8082                	ret

ffffffffc0201ba4 <kmem_cache_free>:
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0201ba4:	00002797          	auipc	a5,0x2
ffffffffc0201ba8:	0e478793          	addi	a5,a5,228 # ffffffffc0203c88 <nbase>
ffffffffc0201bac:	6394                	ld	a3,0(a5)
    return KADDR(page2pa(page));
ffffffffc0201bae:	00006797          	auipc	a5,0x6
ffffffffc0201bb2:	95a78793          	addi	a5,a5,-1702 # ffffffffc0207508 <npage>
ffffffffc0201bb6:	6390                	ld	a2,0(a5)
ffffffffc0201bb8:	577d                	li	a4,-1
ffffffffc0201bba:	8331                	srli	a4,a4,0xc
ffffffffc0201bbc:	8f75                	and	a4,a4,a3
// kmem_cache_free - free an object
// 将对象从Slab中释放，也就是将对象空间加入空闲链表（slabs_partial或者slabs_free），更新Slab元信息。如果Slab变空，那么将Slab加入slabs_partial链表
void kmem_cache_free(struct kmem_cache_t *cachep, void *objp)
{
    // Get slab of object
    void *base = page2kva(pages);
ffffffffc0201bbe:	00006797          	auipc	a5,0x6
ffffffffc0201bc2:	99a78793          	addi	a5,a5,-1638 # ffffffffc0207558 <pages>
ffffffffc0201bc6:	639c                	ld	a5,0(a5)
    return page2ppn(page) << PGSHIFT;
ffffffffc0201bc8:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0201bca:	08c77e63          	bleu	a2,a4,ffffffffc0201c66 <kmem_cache_free+0xc2>
    void *kva = ROUNDDOWN(objp, PGSIZE);
    struct slab_t *slab = (struct slab_t *)&pages[(kva - base) / PGSIZE];
    // Get offset in slab
    int16_t *bufctl = kva;
    void *buf = bufctl + cachep->num;
ffffffffc0201bce:	03255703          	lhu	a4,50(a0)
    void *kva = ROUNDDOWN(objp, PGSIZE);
ffffffffc0201bd2:	767d                	lui	a2,0xfffff
    int offset = (objp - buf) / cachep->objsize;
ffffffffc0201bd4:	03055803          	lhu	a6,48(a0)
    void *kva = ROUNDDOWN(objp, PGSIZE);
ffffffffc0201bd8:	8e6d                	and	a2,a2,a1
    void *buf = bufctl + cachep->num;
ffffffffc0201bda:	0706                	slli	a4,a4,0x1
ffffffffc0201bdc:	9732                	add	a4,a4,a2
    int offset = (objp - buf) / cachep->objsize;
ffffffffc0201bde:	8d99                	sub	a1,a1,a4
ffffffffc0201be0:	0305c5b3          	div	a1,a1,a6
ffffffffc0201be4:	00006717          	auipc	a4,0x6
ffffffffc0201be8:	96c70713          	addi	a4,a4,-1684 # ffffffffc0207550 <va_pa_offset>
ffffffffc0201bec:	6318                	ld	a4,0(a4)
    struct slab_t *slab = (struct slab_t *)&pages[(kva - base) / PGSIZE];
ffffffffc0201bee:	6805                	lui	a6,0x1
ffffffffc0201bf0:	187d                	addi	a6,a6,-1
ffffffffc0201bf2:	96ba                	add	a3,a3,a4
ffffffffc0201bf4:	40d606b3          	sub	a3,a2,a3
ffffffffc0201bf8:	43f6d713          	srai	a4,a3,0x3f
ffffffffc0201bfc:	01077733          	and	a4,a4,a6
ffffffffc0201c00:	96ba                	add	a3,a3,a4
ffffffffc0201c02:	86b1                	srai	a3,a3,0xc
ffffffffc0201c04:	00269713          	slli	a4,a3,0x2
ffffffffc0201c08:	96ba                	add	a3,a3,a4
ffffffffc0201c0a:	068e                	slli	a3,a3,0x3
ffffffffc0201c0c:	97b6                	add	a5,a5,a3
    __list_del(listelm->prev, listelm->next);
ffffffffc0201c0e:	7398                	ld	a4,32(a5)
ffffffffc0201c10:	6f94                	ld	a3,24(a5)
    // Update slab
    list_del(&(slab->slab_link));
    bufctl[offset] = slab->free;
ffffffffc0201c12:	01279883          	lh	a7,18(a5)
ffffffffc0201c16:	01878813          	addi	a6,a5,24
    prev->next = next;
ffffffffc0201c1a:	e698                	sd	a4,8(a3)
    next->prev = prev;
ffffffffc0201c1c:	e314                	sd	a3,0(a4)
ffffffffc0201c1e:	0005871b          	sext.w	a4,a1
ffffffffc0201c22:	0706                	slli	a4,a4,0x1
ffffffffc0201c24:	963a                	add	a2,a2,a4
ffffffffc0201c26:	01161023          	sh	a7,0(a2) # fffffffffffff000 <end+0x3fdf7aa0>
    slab->inuse--;
ffffffffc0201c2a:	0107d703          	lhu	a4,16(a5)
    slab->free = offset;
ffffffffc0201c2e:	00b79923          	sh	a1,18(a5)
    slab->inuse--;
ffffffffc0201c32:	377d                	addiw	a4,a4,-1
ffffffffc0201c34:	1742                	slli	a4,a4,0x30
ffffffffc0201c36:	9341                	srli	a4,a4,0x30
ffffffffc0201c38:	00e79823          	sh	a4,16(a5)
    if (slab->inuse == 0)
ffffffffc0201c3c:	eb19                	bnez	a4,ffffffffc0201c52 <kmem_cache_free+0xae>
    __list_add(elm, listelm, listelm->next);
ffffffffc0201c3e:	7518                	ld	a4,40(a0)
        list_add(&(cachep->slabs_free), &(slab->slab_link));
ffffffffc0201c40:	02050693          	addi	a3,a0,32
    prev->next = next->prev = elm;
ffffffffc0201c44:	01073023          	sd	a6,0(a4)
ffffffffc0201c48:	03053423          	sd	a6,40(a0)
    elm->next = next;
ffffffffc0201c4c:	f398                	sd	a4,32(a5)
    elm->prev = prev;
ffffffffc0201c4e:	ef94                	sd	a3,24(a5)
ffffffffc0201c50:	8082                	ret
    __list_add(elm, listelm, listelm->next);
ffffffffc0201c52:	6d18                	ld	a4,24(a0)
    else
        list_add(&(cachep->slabs_partial), &(slab->slab_link));
ffffffffc0201c54:	01050693          	addi	a3,a0,16
    prev->next = next->prev = elm;
ffffffffc0201c58:	01073023          	sd	a6,0(a4)
ffffffffc0201c5c:	01053c23          	sd	a6,24(a0)
    elm->next = next;
ffffffffc0201c60:	f398                	sd	a4,32(a5)
    elm->prev = prev;
ffffffffc0201c62:	ef94                	sd	a3,24(a5)
ffffffffc0201c64:	8082                	ret
{
ffffffffc0201c66:	1141                	addi	sp,sp,-16
ffffffffc0201c68:	00002617          	auipc	a2,0x2
ffffffffc0201c6c:	82060613          	addi	a2,a2,-2016 # ffffffffc0203488 <commands+0x8d0>
ffffffffc0201c70:	06100593          	li	a1,97
ffffffffc0201c74:	00002517          	auipc	a0,0x2
ffffffffc0201c78:	95450513          	addi	a0,a0,-1708 # ffffffffc02035c8 <buddy_pmm_manager+0x118>
ffffffffc0201c7c:	e406                	sd	ra,8(sp)
ffffffffc0201c7e:	f32fe0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0201c82 <kmem_cache_destroy>:
    return listelm->next;
ffffffffc0201c82:	650c                	ld	a1,8(a0)
{
ffffffffc0201c84:	1101                	addi	sp,sp,-32
ffffffffc0201c86:	e822                	sd	s0,16(sp)
ffffffffc0201c88:	ec06                	sd	ra,24(sp)
ffffffffc0201c8a:	e426                	sd	s1,8(sp)
ffffffffc0201c8c:	e04a                	sd	s2,0(sp)
ffffffffc0201c8e:	842a                	mv	s0,a0
    while (le != head)
ffffffffc0201c90:	00b50a63          	beq	a0,a1,ffffffffc0201ca4 <kmem_cache_destroy+0x22>
ffffffffc0201c94:	6584                	ld	s1,8(a1)
        kmem_slab_destroy(cachep, le2slab(temp, page_link));
ffffffffc0201c96:	8522                	mv	a0,s0
ffffffffc0201c98:	15a1                	addi	a1,a1,-24
ffffffffc0201c9a:	b59ff0ef          	jal	ra,ffffffffc02017f2 <kmem_slab_destroy>
ffffffffc0201c9e:	85a6                	mv	a1,s1
    while (le != head)
ffffffffc0201ca0:	fe941ae3          	bne	s0,s1,ffffffffc0201c94 <kmem_cache_destroy+0x12>
ffffffffc0201ca4:	6c0c                	ld	a1,24(s0)
    head = &(cachep->slabs_partial);
ffffffffc0201ca6:	01040913          	addi	s2,s0,16
    while (le != head)
ffffffffc0201caa:	00b90a63          	beq	s2,a1,ffffffffc0201cbe <kmem_cache_destroy+0x3c>
ffffffffc0201cae:	6584                	ld	s1,8(a1)
        kmem_slab_destroy(cachep, le2slab(temp, page_link));
ffffffffc0201cb0:	8522                	mv	a0,s0
ffffffffc0201cb2:	15a1                	addi	a1,a1,-24
ffffffffc0201cb4:	b3fff0ef          	jal	ra,ffffffffc02017f2 <kmem_slab_destroy>
ffffffffc0201cb8:	85a6                	mv	a1,s1
    while (le != head)
ffffffffc0201cba:	fe991ae3          	bne	s2,s1,ffffffffc0201cae <kmem_cache_destroy+0x2c>
ffffffffc0201cbe:	740c                	ld	a1,40(s0)
    head = &(cachep->slabs_free);
ffffffffc0201cc0:	02040913          	addi	s2,s0,32
    while (le != head)
ffffffffc0201cc4:	01258a63          	beq	a1,s2,ffffffffc0201cd8 <kmem_cache_destroy+0x56>
ffffffffc0201cc8:	6584                	ld	s1,8(a1)
        kmem_slab_destroy(cachep, le2slab(temp, page_link));
ffffffffc0201cca:	8522                	mv	a0,s0
ffffffffc0201ccc:	15a1                	addi	a1,a1,-24
ffffffffc0201cce:	b25ff0ef          	jal	ra,ffffffffc02017f2 <kmem_slab_destroy>
ffffffffc0201cd2:	85a6                	mv	a1,s1
    while (le != head)
ffffffffc0201cd4:	ff249ae3          	bne	s1,s2,ffffffffc0201cc8 <kmem_cache_destroy+0x46>
    kmem_cache_free(&(cache_cache), cachep);
ffffffffc0201cd8:	85a2                	mv	a1,s0
}
ffffffffc0201cda:	6442                	ld	s0,16(sp)
ffffffffc0201cdc:	60e2                	ld	ra,24(sp)
ffffffffc0201cde:	64a2                	ld	s1,8(sp)
ffffffffc0201ce0:	6902                	ld	s2,0(sp)
    kmem_cache_free(&(cache_cache), cachep);
ffffffffc0201ce2:	00005517          	auipc	a0,0x5
ffffffffc0201ce6:	32e50513          	addi	a0,a0,814 # ffffffffc0207010 <edata>
}
ffffffffc0201cea:	6105                	addi	sp,sp,32
    kmem_cache_free(&(cache_cache), cachep);
ffffffffc0201cec:	eb9ff06f          	j	ffffffffc0201ba4 <kmem_cache_free>

ffffffffc0201cf0 <kmem_cache_reap>:
}

// kmem_cache_reap - reap all free slabs
// 遍历仓库链表，对每一个仓库进行kmem_cache_shrink操作
int kmem_cache_reap()
{
ffffffffc0201cf0:	7139                	addi	sp,sp,-64
ffffffffc0201cf2:	e05a                	sd	s6,0(sp)
ffffffffc0201cf4:	00005b17          	auipc	s6,0x5
ffffffffc0201cf8:	384b0b13          	addi	s6,s6,900 # ffffffffc0207078 <cache_chain>
ffffffffc0201cfc:	e852                	sd	s4,16(sp)
ffffffffc0201cfe:	008b3a03          	ld	s4,8(s6)
ffffffffc0201d02:	e456                	sd	s5,8(sp)
ffffffffc0201d04:	fc06                	sd	ra,56(sp)
ffffffffc0201d06:	f822                	sd	s0,48(sp)
ffffffffc0201d08:	f426                	sd	s1,40(sp)
ffffffffc0201d0a:	f04a                	sd	s2,32(sp)
ffffffffc0201d0c:	ec4e                	sd	s3,24(sp)
    int count = 0;
ffffffffc0201d0e:	4a81                	li	s5,0
    list_entry_t *le = &(cache_chain);
    while ((le = list_next(le)) != &(cache_chain))
ffffffffc0201d10:	036a0a63          	beq	s4,s6,ffffffffc0201d44 <kmem_cache_reap+0x54>
ffffffffc0201d14:	fd0a3583          	ld	a1,-48(s4)
    while (le != &(cachep->slabs_free))
ffffffffc0201d18:	fc8a0913          	addi	s2,s4,-56
        count += kmem_cache_shrink(to_struct(le, struct kmem_cache_t, cache_link));
ffffffffc0201d1c:	fa8a0993          	addi	s3,s4,-88
    while (le != &(cachep->slabs_free))
ffffffffc0201d20:	01258e63          	beq	a1,s2,ffffffffc0201d3c <kmem_cache_reap+0x4c>
    int count = 0;
ffffffffc0201d24:	4401                	li	s0,0
ffffffffc0201d26:	6584                	ld	s1,8(a1)
        kmem_slab_destroy(cachep, le2slab(temp, page_link));
ffffffffc0201d28:	854e                	mv	a0,s3
ffffffffc0201d2a:	15a1                	addi	a1,a1,-24
ffffffffc0201d2c:	ac7ff0ef          	jal	ra,ffffffffc02017f2 <kmem_slab_destroy>
        count++;
ffffffffc0201d30:	85a6                	mv	a1,s1
ffffffffc0201d32:	2405                	addiw	s0,s0,1
    while (le != &(cachep->slabs_free))
ffffffffc0201d34:	ff2499e3          	bne	s1,s2,ffffffffc0201d26 <kmem_cache_reap+0x36>
ffffffffc0201d38:	01540abb          	addw	s5,s0,s5
ffffffffc0201d3c:	008a3a03          	ld	s4,8(s4)
    while ((le = list_next(le)) != &(cache_chain))
ffffffffc0201d40:	fd6a1ae3          	bne	s4,s6,ffffffffc0201d14 <kmem_cache_reap+0x24>
    return count;
}
ffffffffc0201d44:	70e2                	ld	ra,56(sp)
ffffffffc0201d46:	7442                	ld	s0,48(sp)
ffffffffc0201d48:	8556                	mv	a0,s5
ffffffffc0201d4a:	74a2                	ld	s1,40(sp)
ffffffffc0201d4c:	7902                	ld	s2,32(sp)
ffffffffc0201d4e:	69e2                	ld	s3,24(sp)
ffffffffc0201d50:	6a42                	ld	s4,16(sp)
ffffffffc0201d52:	6aa2                	ld	s5,8(sp)
ffffffffc0201d54:	6b02                	ld	s6,0(sp)
ffffffffc0201d56:	6121                	addi	sp,sp,64
ffffffffc0201d58:	8082                	ret

ffffffffc0201d5a <kmalloc>:

// 找到大小最合适的内置仓库，申请一个对象。
void *
kmalloc(size_t size)
{
    assert(size <= SIZED_CACHE_MAX);
ffffffffc0201d5a:	6785                	lui	a5,0x1
ffffffffc0201d5c:	80078793          	addi	a5,a5,-2048 # 800 <BASE_ADDRESS-0xffffffffc01ff800>
ffffffffc0201d60:	02a7ea63          	bltu	a5,a0,ffffffffc0201d94 <kmalloc+0x3a>
    size_t rsize = ROUNDUP(size, 2);
ffffffffc0201d64:	0505                	addi	a0,a0,1
    for (int t = rsize / 32; t; t /= 2)
ffffffffc0201d66:	9979                	andi	a0,a0,-2
ffffffffc0201d68:	47c1                	li	a5,16
ffffffffc0201d6a:	02f56363          	bltu	a0,a5,ffffffffc0201d90 <kmalloc+0x36>
ffffffffc0201d6e:	8115                	srli	a0,a0,0x5
ffffffffc0201d70:	0005079b          	sext.w	a5,a0
    int index = 0;
ffffffffc0201d74:	4701                	li	a4,0
    for (int t = rsize / 32; t; t /= 2)
ffffffffc0201d76:	c501                	beqz	a0,ffffffffc0201d7e <kmalloc+0x24>
ffffffffc0201d78:	8785                	srai	a5,a5,0x1
        index++;
ffffffffc0201d7a:	2705                	addiw	a4,a4,1
    for (int t = rsize / 32; t; t /= 2)
ffffffffc0201d7c:	fff5                	bnez	a5,ffffffffc0201d78 <kmalloc+0x1e>
    return kmem_cache_alloc(sized_caches[kmem_sized_index(size)]);
ffffffffc0201d7e:	070e                	slli	a4,a4,0x3
ffffffffc0201d80:	00005797          	auipc	a5,0x5
ffffffffc0201d84:	30878793          	addi	a5,a5,776 # ffffffffc0207088 <sized_caches>
ffffffffc0201d88:	973e                	add	a4,a4,a5
ffffffffc0201d8a:	6308                	ld	a0,0(a4)
ffffffffc0201d8c:	b43ff06f          	j	ffffffffc02018ce <kmem_cache_alloc>
    for (int t = rsize / 32; t; t /= 2)
ffffffffc0201d90:	4541                	li	a0,16
ffffffffc0201d92:	bff1                	j	ffffffffc0201d6e <kmalloc+0x14>
{
ffffffffc0201d94:	1141                	addi	sp,sp,-16
    assert(size <= SIZED_CACHE_MAX);
ffffffffc0201d96:	00002697          	auipc	a3,0x2
ffffffffc0201d9a:	8a268693          	addi	a3,a3,-1886 # ffffffffc0203638 <buddy_pmm_manager+0x188>
ffffffffc0201d9e:	00001617          	auipc	a2,0x1
ffffffffc0201da2:	69a60613          	addi	a2,a2,1690 # ffffffffc0203438 <commands+0x880>
ffffffffc0201da6:	17800593          	li	a1,376
ffffffffc0201daa:	00002517          	auipc	a0,0x2
ffffffffc0201dae:	8be50513          	addi	a0,a0,-1858 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
{
ffffffffc0201db2:	e406                	sd	ra,8(sp)
    assert(size <= SIZED_CACHE_MAX);
ffffffffc0201db4:	dfcfe0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0201db8 <kfree>:
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0201db8:	00002797          	auipc	a5,0x2
ffffffffc0201dbc:	ed078793          	addi	a5,a5,-304 # ffffffffc0203c88 <nbase>
ffffffffc0201dc0:	6394                	ld	a3,0(a5)
    return KADDR(page2pa(page));
ffffffffc0201dc2:	00005797          	auipc	a5,0x5
ffffffffc0201dc6:	74678793          	addi	a5,a5,1862 # ffffffffc0207508 <npage>
ffffffffc0201dca:	577d                	li	a4,-1
ffffffffc0201dcc:	639c                	ld	a5,0(a5)
ffffffffc0201dce:	8331                	srli	a4,a4,0xc
ffffffffc0201dd0:	8f75                	and	a4,a4,a3
}

// 释放内置仓库对象。
void kfree(void *objp)
{
    void *base = slab2kva(pages);
ffffffffc0201dd2:	00005617          	auipc	a2,0x5
ffffffffc0201dd6:	78660613          	addi	a2,a2,1926 # ffffffffc0207558 <pages>
ffffffffc0201dda:	6210                	ld	a2,0(a2)
    return page2ppn(page) << PGSHIFT;
ffffffffc0201ddc:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0201dde:	02f77c63          	bleu	a5,a4,ffffffffc0201e16 <kfree+0x5e>
ffffffffc0201de2:	00005797          	auipc	a5,0x5
ffffffffc0201de6:	76e78793          	addi	a5,a5,1902 # ffffffffc0207550 <va_pa_offset>
ffffffffc0201dea:	6398                	ld	a4,0(a5)
    void *kva = ROUNDDOWN(objp, PGSIZE);
ffffffffc0201dec:	77fd                	lui	a5,0xfffff
ffffffffc0201dee:	8fe9                	and	a5,a5,a0
ffffffffc0201df0:	96ba                	add	a3,a3,a4
    struct slab_t *slab = (struct slab_t *)&pages[(kva - base) / PGSIZE];
ffffffffc0201df2:	40d786b3          	sub	a3,a5,a3
ffffffffc0201df6:	6705                	lui	a4,0x1
ffffffffc0201df8:	177d                	addi	a4,a4,-1
ffffffffc0201dfa:	43f6d793          	srai	a5,a3,0x3f
ffffffffc0201dfe:	8ff9                	and	a5,a5,a4
ffffffffc0201e00:	97b6                	add	a5,a5,a3
ffffffffc0201e02:	87b1                	srai	a5,a5,0xc
    kmem_cache_free(slab->cachep, objp);
ffffffffc0201e04:	00279713          	slli	a4,a5,0x2
ffffffffc0201e08:	97ba                	add	a5,a5,a4
ffffffffc0201e0a:	078e                	slli	a5,a5,0x3
ffffffffc0201e0c:	97b2                	add	a5,a5,a2
ffffffffc0201e0e:	85aa                	mv	a1,a0
ffffffffc0201e10:	6788                	ld	a0,8(a5)
ffffffffc0201e12:	d93ff06f          	j	ffffffffc0201ba4 <kmem_cache_free>
{
ffffffffc0201e16:	1141                	addi	sp,sp,-16
ffffffffc0201e18:	00001617          	auipc	a2,0x1
ffffffffc0201e1c:	67060613          	addi	a2,a2,1648 # ffffffffc0203488 <commands+0x8d0>
ffffffffc0201e20:	06100593          	li	a1,97
ffffffffc0201e24:	00001517          	auipc	a0,0x1
ffffffffc0201e28:	7a450513          	addi	a0,a0,1956 # ffffffffc02035c8 <buddy_pmm_manager+0x118>
ffffffffc0201e2c:	e406                	sd	ra,8(sp)
ffffffffc0201e2e:	d82fe0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc0201e32 <kmem_int>:
// 初始化内置仓库：初始化8个固定大小的内置仓库。
void kmem_int()
{

    // Init cache for kmem_cache
    cache_cache.objsize = sizeof(struct kmem_cache_t);
ffffffffc0201e32:	002607b7          	lui	a5,0x260
{
ffffffffc0201e36:	7119                	addi	sp,sp,-128
    // 算num的时候还要考虑前面int16_t的信息
    cache_cache.num = PGSIZE / (sizeof(int16_t) + sizeof(struct kmem_cache_t));
    cache_cache.ctor = NULL;
    cache_cache.dtor = NULL;
    memcpy(cache_cache.name, cache_cache_name, CACHE_NAMELEN);
ffffffffc0201e38:	00002597          	auipc	a1,0x2
ffffffffc0201e3c:	84058593          	addi	a1,a1,-1984 # ffffffffc0203678 <buddy_pmm_manager+0x1c8>
    cache_cache.objsize = sizeof(struct kmem_cache_t);
ffffffffc0201e40:	0687879b          	addiw	a5,a5,104
    memcpy(cache_cache.name, cache_cache_name, CACHE_NAMELEN);
ffffffffc0201e44:	4641                	li	a2,16
ffffffffc0201e46:	00005517          	auipc	a0,0x5
ffffffffc0201e4a:	21250513          	addi	a0,a0,530 # ffffffffc0207058 <edata+0x48>
    cache_cache.objsize = sizeof(struct kmem_cache_t);
ffffffffc0201e4e:	00005717          	auipc	a4,0x5
ffffffffc0201e52:	1ef72923          	sw	a5,498(a4) # ffffffffc0207040 <edata+0x30>
{
ffffffffc0201e56:	f8a2                	sd	s0,112(sp)
ffffffffc0201e58:	f4a6                	sd	s1,104(sp)
ffffffffc0201e5a:	f0ca                	sd	s2,96(sp)
ffffffffc0201e5c:	ecce                	sd	s3,88(sp)
    cache_cache.ctor = NULL;
ffffffffc0201e5e:	00005797          	auipc	a5,0x5
ffffffffc0201e62:	1e07b523          	sd	zero,490(a5) # ffffffffc0207048 <edata+0x38>
    cache_cache.dtor = NULL;
ffffffffc0201e66:	00005797          	auipc	a5,0x5
ffffffffc0201e6a:	1e07b523          	sd	zero,490(a5) # ffffffffc0207050 <edata+0x40>
{
ffffffffc0201e6e:	fc86                	sd	ra,120(sp)
ffffffffc0201e70:	e8d2                	sd	s4,80(sp)
ffffffffc0201e72:	e4d6                	sd	s5,72(sp)
ffffffffc0201e74:	e0da                	sd	s6,64(sp)
ffffffffc0201e76:	fc5e                	sd	s7,56(sp)
ffffffffc0201e78:	f862                	sd	s8,48(sp)
ffffffffc0201e7a:	f466                	sd	s9,40(sp)
ffffffffc0201e7c:	f06a                	sd	s10,32(sp)
ffffffffc0201e7e:	ec6e                	sd	s11,24(sp)
    memcpy(cache_cache.name, cache_cache_name, CACHE_NAMELEN);
ffffffffc0201e80:	401000ef          	jal	ra,ffffffffc0202a80 <memcpy>
    elm->prev = elm->next = elm;
ffffffffc0201e84:	00005617          	auipc	a2,0x5
ffffffffc0201e88:	19c60613          	addi	a2,a2,412 # ffffffffc0207020 <edata+0x10>
ffffffffc0201e8c:	00005697          	auipc	a3,0x5
ffffffffc0201e90:	1a468693          	addi	a3,a3,420 # ffffffffc0207030 <edata+0x20>
    prev->next = next->prev = elm;
ffffffffc0201e94:	00005717          	auipc	a4,0x5
ffffffffc0201e98:	1d470713          	addi	a4,a4,468 # ffffffffc0207068 <edata+0x58>
    cache_cache.objsize = sizeof(struct kmem_cache_t);
ffffffffc0201e9c:	00005417          	auipc	s0,0x5
ffffffffc0201ea0:	17440413          	addi	s0,s0,372 # ffffffffc0207010 <edata>
ffffffffc0201ea4:	00005797          	auipc	a5,0x5
ffffffffc0201ea8:	1d478793          	addi	a5,a5,468 # ffffffffc0207078 <cache_chain>
    elm->prev = elm->next = elm;
ffffffffc0201eac:	00005597          	auipc	a1,0x5
ffffffffc0201eb0:	16c5be23          	sd	a2,380(a1) # ffffffffc0207028 <edata+0x18>
ffffffffc0201eb4:	00005597          	auipc	a1,0x5
ffffffffc0201eb8:	16c5b623          	sd	a2,364(a1) # ffffffffc0207020 <edata+0x10>
ffffffffc0201ebc:	00005597          	auipc	a1,0x5
ffffffffc0201ec0:	1485be23          	sd	s0,348(a1) # ffffffffc0207018 <edata+0x8>
ffffffffc0201ec4:	00005617          	auipc	a2,0x5
ffffffffc0201ec8:	16d63a23          	sd	a3,372(a2) # ffffffffc0207038 <edata+0x28>
ffffffffc0201ecc:	00005617          	auipc	a2,0x5
ffffffffc0201ed0:	16d63223          	sd	a3,356(a2) # ffffffffc0207030 <edata+0x20>
ffffffffc0201ed4:	00005597          	auipc	a1,0x5
ffffffffc0201ed8:	1285be23          	sd	s0,316(a1) # ffffffffc0207010 <edata>
    prev->next = next->prev = elm;
ffffffffc0201edc:	00005697          	auipc	a3,0x5
ffffffffc0201ee0:	18e6be23          	sd	a4,412(a3) # ffffffffc0207078 <cache_chain>
ffffffffc0201ee4:	00005697          	auipc	a3,0x5
ffffffffc0201ee8:	18e6be23          	sd	a4,412(a3) # ffffffffc0207080 <cache_chain+0x8>
    elm->next = next;
ffffffffc0201eec:	00005497          	auipc	s1,0x5
ffffffffc0201ef0:	19c48493          	addi	s1,s1,412 # ffffffffc0207088 <sized_caches>
ffffffffc0201ef4:	00005717          	auipc	a4,0x5
ffffffffc0201ef8:	16f73e23          	sd	a5,380(a4) # ffffffffc0207070 <edata+0x60>
    elm->prev = prev;
ffffffffc0201efc:	00005717          	auipc	a4,0x5
ffffffffc0201f00:	16f73623          	sd	a5,364(a4) # ffffffffc0207068 <edata+0x58>
    list_init(&(cache_cache.slabs_free));
    list_init(&(cache_chain));
    list_add(&(cache_chain), &(cache_cache.cache_link));

    // Init sized cache
    for (int i = 0, size = 16; i < SIZED_CACHE_NUM; i++, size *= 2)
ffffffffc0201f04:	00005997          	auipc	s3,0x5
ffffffffc0201f08:	1c498993          	addi	s3,s3,452 # ffffffffc02070c8 <buf>
ffffffffc0201f0c:	4441                	li	s0,16
        sized_caches[i] = kmem_cache_create(sized_cache_name, size, NULL, NULL);
ffffffffc0201f0e:	00001917          	auipc	s2,0x1
ffffffffc0201f12:	77290913          	addi	s2,s2,1906 # ffffffffc0203680 <buddy_pmm_manager+0x1d0>
ffffffffc0201f16:	85a2                	mv	a1,s0
ffffffffc0201f18:	4681                	li	a3,0
ffffffffc0201f1a:	4601                	li	a2,0
ffffffffc0201f1c:	854a                	mv	a0,s2
ffffffffc0201f1e:	ba7ff0ef          	jal	ra,ffffffffc0201ac4 <kmem_cache_create>
ffffffffc0201f22:	e088                	sd	a0,0(s1)
ffffffffc0201f24:	04a1                	addi	s1,s1,8
    for (int i = 0, size = 16; i < SIZED_CACHE_NUM; i++, size *= 2)
ffffffffc0201f26:	0014141b          	slliw	s0,s0,0x1
ffffffffc0201f2a:	ff3496e3          	bne	s1,s3,ffffffffc0201f16 <kmem_int+0xe4>
    size_t fp = nr_free_pages();
ffffffffc0201f2e:	e80ff0ef          	jal	ra,ffffffffc02015ae <nr_free_pages>
ffffffffc0201f32:	8aaa                	mv	s5,a0
    struct kmem_cache_t *cp0 = kmem_cache_create(test_object_name, sizeof(struct test_object), test_ctor, test_dtor);
ffffffffc0201f34:	00000697          	auipc	a3,0x0
ffffffffc0201f38:	8ac68693          	addi	a3,a3,-1876 # ffffffffc02017e0 <test_dtor>
ffffffffc0201f3c:	00000617          	auipc	a2,0x0
ffffffffc0201f40:	89060613          	addi	a2,a2,-1904 # ffffffffc02017cc <test_ctor>
ffffffffc0201f44:	7fe00593          	li	a1,2046
ffffffffc0201f48:	00001517          	auipc	a0,0x1
ffffffffc0201f4c:	74050513          	addi	a0,a0,1856 # ffffffffc0203688 <buddy_pmm_manager+0x1d8>
ffffffffc0201f50:	b75ff0ef          	jal	ra,ffffffffc0201ac4 <kmem_cache_create>
ffffffffc0201f54:	842a                	mv	s0,a0
    assert(cp0 != NULL);
ffffffffc0201f56:	4e050f63          	beqz	a0,ffffffffc0202454 <kmem_int+0x622>
    assert(kmem_cache_size(cp0) == sizeof(struct test_object));
ffffffffc0201f5a:	03055703          	lhu	a4,48(a0)
ffffffffc0201f5e:	7fe00793          	li	a5,2046
ffffffffc0201f62:	4cf71963          	bne	a4,a5,ffffffffc0202434 <kmem_int+0x602>
    assert(strcmp(kmem_cache_name(cp0), test_object_name) == 0);
ffffffffc0201f66:	00001597          	auipc	a1,0x1
ffffffffc0201f6a:	72258593          	addi	a1,a1,1826 # ffffffffc0203688 <buddy_pmm_manager+0x1d8>
ffffffffc0201f6e:	04850513          	addi	a0,a0,72
ffffffffc0201f72:	2b5000ef          	jal	ra,ffffffffc0202a26 <strcmp>
ffffffffc0201f76:	89aa                	mv	s3,a0
ffffffffc0201f78:	3c051e63          	bnez	a0,ffffffffc0202354 <kmem_int+0x522>
    assert((p0 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc0201f7c:	8522                	mv	a0,s0
ffffffffc0201f7e:	951ff0ef          	jal	ra,ffffffffc02018ce <kmem_cache_alloc>
ffffffffc0201f82:	8baa                	mv	s7,a0
ffffffffc0201f84:	3a050863          	beqz	a0,ffffffffc0202334 <kmem_int+0x502>
    assert((p1 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc0201f88:	8522                	mv	a0,s0
ffffffffc0201f8a:	945ff0ef          	jal	ra,ffffffffc02018ce <kmem_cache_alloc>
ffffffffc0201f8e:	8caa                	mv	s9,a0
ffffffffc0201f90:	44050263          	beqz	a0,ffffffffc02023d4 <kmem_int+0x5a2>
    assert((p2 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc0201f94:	8522                	mv	a0,s0
ffffffffc0201f96:	939ff0ef          	jal	ra,ffffffffc02018ce <kmem_cache_alloc>
ffffffffc0201f9a:	e02a                	sd	a0,0(sp)
ffffffffc0201f9c:	40050c63          	beqz	a0,ffffffffc02023b4 <kmem_int+0x582>
    assert((p3 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc0201fa0:	8522                	mv	a0,s0
ffffffffc0201fa2:	92dff0ef          	jal	ra,ffffffffc02018ce <kmem_cache_alloc>
ffffffffc0201fa6:	8b2a                	mv	s6,a0
ffffffffc0201fa8:	3e050663          	beqz	a0,ffffffffc0202394 <kmem_int+0x562>
    assert((p4 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc0201fac:	8522                	mv	a0,s0
ffffffffc0201fae:	921ff0ef          	jal	ra,ffffffffc02018ce <kmem_cache_alloc>
ffffffffc0201fb2:	8a2a                	mv	s4,a0
ffffffffc0201fb4:	44050063          	beqz	a0,ffffffffc02023f4 <kmem_int+0x5c2>
        assert(p[i] == TEST_OBJECT_CTVAL);
ffffffffc0201fb8:	00054703          	lbu	a4,0(a0)
ffffffffc0201fbc:	02200793          	li	a5,34
ffffffffc0201fc0:	1cf71a63          	bne	a4,a5,ffffffffc0202194 <kmem_int+0x362>
ffffffffc0201fc4:	00150493          	addi	s1,a0,1
ffffffffc0201fc8:	7fe50913          	addi	s2,a0,2046
ffffffffc0201fcc:	87a6                	mv	a5,s1
ffffffffc0201fce:	02200693          	li	a3,34
ffffffffc0201fd2:	0007c703          	lbu	a4,0(a5)
ffffffffc0201fd6:	1ad71f63          	bne	a4,a3,ffffffffc0202194 <kmem_int+0x362>
ffffffffc0201fda:	0785                	addi	a5,a5,1
    for (int i = 0; i < sizeof(struct test_object); i++)
ffffffffc0201fdc:	fef91be3          	bne	s2,a5,ffffffffc0201fd2 <kmem_int+0x1a0>
    assert((p5 = kmem_cache_zalloc(cp0)) != NULL);
ffffffffc0201fe0:	8522                	mv	a0,s0
ffffffffc0201fe2:	b9dff0ef          	jal	ra,ffffffffc0201b7e <kmem_cache_zalloc>
ffffffffc0201fe6:	8c2a                	mv	s8,a0
ffffffffc0201fe8:	22050663          	beqz	a0,ffffffffc0202214 <kmem_int+0x3e2>
        assert(p[i] == 0);
ffffffffc0201fec:	00054783          	lbu	a5,0(a0)
ffffffffc0201ff0:	1c079263          	bnez	a5,ffffffffc02021b4 <kmem_int+0x382>
ffffffffc0201ff4:	00150793          	addi	a5,a0,1
ffffffffc0201ff8:	7fe50693          	addi	a3,a0,2046
ffffffffc0201ffc:	0007c703          	lbu	a4,0(a5)
ffffffffc0202000:	1a071a63          	bnez	a4,ffffffffc02021b4 <kmem_int+0x382>
ffffffffc0202004:	0785                	addi	a5,a5,1
    for (int i = 0; i < sizeof(struct test_object); i++)
ffffffffc0202006:	fed79be3          	bne	a5,a3,ffffffffc0201ffc <kmem_int+0x1ca>
    assert(nr_free_pages() + 3 == fp);
ffffffffc020200a:	da4ff0ef          	jal	ra,ffffffffc02015ae <nr_free_pages>
ffffffffc020200e:	050d                	addi	a0,a0,3
ffffffffc0202010:	1eaa9263          	bne	s5,a0,ffffffffc02021f4 <kmem_int+0x3c2>
    assert(list_empty(&(cp0->slabs_free)));
ffffffffc0202014:	741c                	ld	a5,40(s0)
ffffffffc0202016:	02040713          	addi	a4,s0,32
ffffffffc020201a:	2ef71d63          	bne	a4,a5,ffffffffc0202314 <kmem_int+0x4e2>
    assert(list_empty(&(cp0->slabs_partial)));
ffffffffc020201e:	6c1c                	ld	a5,24(s0)
ffffffffc0202020:	01040d93          	addi	s11,s0,16
ffffffffc0202024:	2cfd9863          	bne	s11,a5,ffffffffc02022f4 <kmem_int+0x4c2>
    return listelm->next;
ffffffffc0202028:	00843d03          	ld	s10,8(s0)
    while ((le = list_next(le)) != listelm)
ffffffffc020202c:	3e8d0463          	beq	s10,s0,ffffffffc0202414 <kmem_int+0x5e2>
    size_t len = 0;
ffffffffc0202030:	4781                	li	a5,0
ffffffffc0202032:	008d3d03          	ld	s10,8(s10)
        len++;
ffffffffc0202036:	0785                	addi	a5,a5,1
    while ((le = list_next(le)) != listelm)
ffffffffc0202038:	ffa41de3          	bne	s0,s10,ffffffffc0202032 <kmem_int+0x200>
    assert(list_length(&(cp0->slabs_full)) == 3);
ffffffffc020203c:	468d                	li	a3,3
ffffffffc020203e:	3cd79b63          	bne	a5,a3,ffffffffc0202414 <kmem_int+0x5e2>
    kmem_cache_free(cp0, p3);
ffffffffc0202042:	85da                	mv	a1,s6
ffffffffc0202044:	8522                	mv	a0,s0
ffffffffc0202046:	e43a                	sd	a4,8(sp)
ffffffffc0202048:	b5dff0ef          	jal	ra,ffffffffc0201ba4 <kmem_cache_free>
    kmem_cache_free(cp0, p4);
ffffffffc020204c:	85d2                	mv	a1,s4
ffffffffc020204e:	8522                	mv	a0,s0
ffffffffc0202050:	b55ff0ef          	jal	ra,ffffffffc0201ba4 <kmem_cache_free>
    kmem_cache_free(cp0, p5);
ffffffffc0202054:	85e2                	mv	a1,s8
ffffffffc0202056:	8522                	mv	a0,s0
ffffffffc0202058:	b4dff0ef          	jal	ra,ffffffffc0201ba4 <kmem_cache_free>
ffffffffc020205c:	740c                	ld	a1,40(s0)
    while ((le = list_next(le)) != listelm)
ffffffffc020205e:	6722                	ld	a4,8(sp)
ffffffffc0202060:	24b70a63          	beq	a4,a1,ffffffffc02022b4 <kmem_int+0x482>
ffffffffc0202064:	8b2e                	mv	s6,a1
    size_t len = 0;
ffffffffc0202066:	4781                	li	a5,0
ffffffffc0202068:	008b3b03          	ld	s6,8(s6)
        len++;
ffffffffc020206c:	0785                	addi	a5,a5,1
    while ((le = list_next(le)) != listelm)
ffffffffc020206e:	ff671de3          	bne	a4,s6,ffffffffc0202068 <kmem_int+0x236>
    assert(list_length(&(cp0->slabs_free)) == 1);
ffffffffc0202072:	4705                	li	a4,1
ffffffffc0202074:	24e79063          	bne	a5,a4,ffffffffc02022b4 <kmem_int+0x482>
ffffffffc0202078:	6c1c                	ld	a5,24(s0)
    size_t len = 0;
ffffffffc020207a:	4701                	li	a4,0
    while ((le = list_next(le)) != listelm)
ffffffffc020207c:	3efd8c63          	beq	s11,a5,ffffffffc0202474 <kmem_int+0x642>
ffffffffc0202080:	679c                	ld	a5,8(a5)
        len++;
ffffffffc0202082:	0705                	addi	a4,a4,1
    while ((le = list_next(le)) != listelm)
ffffffffc0202084:	fefd9ee3          	bne	s11,a5,ffffffffc0202080 <kmem_int+0x24e>
    assert(list_length(&(cp0->slabs_partial)) == 1);
ffffffffc0202088:	4785                	li	a5,1
ffffffffc020208a:	3ef71563          	bne	a4,a5,ffffffffc0202474 <kmem_int+0x642>
ffffffffc020208e:	008d3783          	ld	a5,8(s10)
    size_t len = 0;
ffffffffc0202092:	4701                	li	a4,0
    while ((le = list_next(le)) != listelm)
ffffffffc0202094:	24fd0063          	beq	s10,a5,ffffffffc02022d4 <kmem_int+0x4a2>
ffffffffc0202098:	679c                	ld	a5,8(a5)
        len++;
ffffffffc020209a:	0705                	addi	a4,a4,1
    while ((le = list_next(le)) != listelm)
ffffffffc020209c:	fefd1ee3          	bne	s10,a5,ffffffffc0202098 <kmem_int+0x266>
    assert(list_length(&(cp0->slabs_full)) == 1);
ffffffffc02020a0:	4785                	li	a5,1
ffffffffc02020a2:	22f71963          	bne	a4,a5,ffffffffc02022d4 <kmem_int+0x4a2>
ffffffffc02020a6:	0085bd03          	ld	s10,8(a1)
        kmem_slab_destroy(cachep, le2slab(temp, page_link));
ffffffffc02020aa:	8522                	mv	a0,s0
ffffffffc02020ac:	15a1                	addi	a1,a1,-24
ffffffffc02020ae:	f44ff0ef          	jal	ra,ffffffffc02017f2 <kmem_slab_destroy>
        count++;
ffffffffc02020b2:	85ea                	mv	a1,s10
ffffffffc02020b4:	2985                	addiw	s3,s3,1
    while (le != &(cachep->slabs_free))
ffffffffc02020b6:	ffab18e3          	bne	s6,s10,ffffffffc02020a6 <kmem_int+0x274>
    assert(kmem_cache_shrink(cp0) == 1);
ffffffffc02020ba:	4785                	li	a5,1
ffffffffc02020bc:	0af99c63          	bne	s3,a5,ffffffffc0202174 <kmem_int+0x342>
    assert(nr_free_pages() + 2 == fp);
ffffffffc02020c0:	ceeff0ef          	jal	ra,ffffffffc02015ae <nr_free_pages>
ffffffffc02020c4:	0509                	addi	a0,a0,2
ffffffffc02020c6:	1aaa9763          	bne	s5,a0,ffffffffc0202274 <kmem_int+0x442>
    assert(list_empty(&(cp0->slabs_free)));
ffffffffc02020ca:	741c                	ld	a5,40(s0)
ffffffffc02020cc:	18fb1463          	bne	s6,a5,ffffffffc0202254 <kmem_int+0x422>
        assert(p[i] == TEST_OBJECT_DTVAL);
ffffffffc02020d0:	000a4703          	lbu	a4,0(s4)
ffffffffc02020d4:	47c5                	li	a5,17
ffffffffc02020d6:	0ef71f63          	bne	a4,a5,ffffffffc02021d4 <kmem_int+0x3a2>
ffffffffc02020da:	4745                	li	a4,17
ffffffffc02020dc:	0004c783          	lbu	a5,0(s1)
ffffffffc02020e0:	0ee79a63          	bne	a5,a4,ffffffffc02021d4 <kmem_int+0x3a2>
ffffffffc02020e4:	0485                	addi	s1,s1,1
    for (int i = 0; i < sizeof(struct test_object); i++)
ffffffffc02020e6:	fe991be3          	bne	s2,s1,ffffffffc02020dc <kmem_int+0x2aa>
    kmem_cache_free(cp0, p0);
ffffffffc02020ea:	85de                	mv	a1,s7
ffffffffc02020ec:	8522                	mv	a0,s0
ffffffffc02020ee:	ab7ff0ef          	jal	ra,ffffffffc0201ba4 <kmem_cache_free>
    kmem_cache_free(cp0, p1);
ffffffffc02020f2:	85e6                	mv	a1,s9
ffffffffc02020f4:	8522                	mv	a0,s0
ffffffffc02020f6:	aafff0ef          	jal	ra,ffffffffc0201ba4 <kmem_cache_free>
    kmem_cache_free(cp0, p2);
ffffffffc02020fa:	6582                	ld	a1,0(sp)
ffffffffc02020fc:	8522                	mv	a0,s0
ffffffffc02020fe:	aa7ff0ef          	jal	ra,ffffffffc0201ba4 <kmem_cache_free>
    assert(kmem_cache_reap() == 2);
ffffffffc0202102:	befff0ef          	jal	ra,ffffffffc0201cf0 <kmem_cache_reap>
ffffffffc0202106:	4789                	li	a5,2
ffffffffc0202108:	12f51663          	bne	a0,a5,ffffffffc0202234 <kmem_int+0x402>
    assert(nr_free_pages() == fp);
ffffffffc020210c:	ca2ff0ef          	jal	ra,ffffffffc02015ae <nr_free_pages>
ffffffffc0202110:	26aa9263          	bne	s5,a0,ffffffffc0202374 <kmem_int+0x542>
    kmem_cache_destroy(cp0);
ffffffffc0202114:	8522                	mv	a0,s0
ffffffffc0202116:	b6dff0ef          	jal	ra,ffffffffc0201c82 <kmem_cache_destroy>
    assert((p0 = kmalloc(2048)) != NULL);
ffffffffc020211a:	6505                	lui	a0,0x1
ffffffffc020211c:	80050513          	addi	a0,a0,-2048 # 800 <BASE_ADDRESS-0xffffffffc01ff800>
ffffffffc0202120:	c3bff0ef          	jal	ra,ffffffffc0201d5a <kmalloc>
ffffffffc0202124:	842a                	mv	s0,a0
ffffffffc0202126:	3a050763          	beqz	a0,ffffffffc02024d4 <kmem_int+0x6a2>
    assert(nr_free_pages() + 1 == fp);
ffffffffc020212a:	c84ff0ef          	jal	ra,ffffffffc02015ae <nr_free_pages>
ffffffffc020212e:	0505                	addi	a0,a0,1
ffffffffc0202130:	38aa9263          	bne	s5,a0,ffffffffc02024b4 <kmem_int+0x682>
    kfree(p0);
ffffffffc0202134:	8522                	mv	a0,s0
ffffffffc0202136:	c83ff0ef          	jal	ra,ffffffffc0201db8 <kfree>
    assert(kmem_cache_reap() == 1);
ffffffffc020213a:	bb7ff0ef          	jal	ra,ffffffffc0201cf0 <kmem_cache_reap>
ffffffffc020213e:	4785                	li	a5,1
ffffffffc0202140:	14f51a63          	bne	a0,a5,ffffffffc0202294 <kmem_int+0x462>
    assert(nr_free_pages() == fp);
ffffffffc0202144:	c6aff0ef          	jal	ra,ffffffffc02015ae <nr_free_pages>
ffffffffc0202148:	34aa9663          	bne	s5,a0,ffffffffc0202494 <kmem_int+0x662>

    // 进行测试
    check_kmem();
}
ffffffffc020214c:	7446                	ld	s0,112(sp)
ffffffffc020214e:	70e6                	ld	ra,120(sp)
ffffffffc0202150:	74a6                	ld	s1,104(sp)
ffffffffc0202152:	7906                	ld	s2,96(sp)
ffffffffc0202154:	69e6                	ld	s3,88(sp)
ffffffffc0202156:	6a46                	ld	s4,80(sp)
ffffffffc0202158:	6aa6                	ld	s5,72(sp)
ffffffffc020215a:	6b06                	ld	s6,64(sp)
ffffffffc020215c:	7be2                	ld	s7,56(sp)
ffffffffc020215e:	7c42                	ld	s8,48(sp)
ffffffffc0202160:	7ca2                	ld	s9,40(sp)
ffffffffc0202162:	7d02                	ld	s10,32(sp)
ffffffffc0202164:	6de2                	ld	s11,24(sp)
    cprintf("check_kmem() succeeded!\n");
ffffffffc0202166:	00002517          	auipc	a0,0x2
ffffffffc020216a:	8ba50513          	addi	a0,a0,-1862 # ffffffffc0203a20 <buddy_pmm_manager+0x570>
}
ffffffffc020216e:	6109                	addi	sp,sp,128
    cprintf("check_kmem() succeeded!\n");
ffffffffc0202170:	f4bfd06f          	j	ffffffffc02000ba <cprintf>
    assert(kmem_cache_shrink(cp0) == 1);
ffffffffc0202174:	00001697          	auipc	a3,0x1
ffffffffc0202178:	7c468693          	addi	a3,a3,1988 # ffffffffc0203938 <buddy_pmm_manager+0x488>
ffffffffc020217c:	00001617          	auipc	a2,0x1
ffffffffc0202180:	2bc60613          	addi	a2,a2,700 # ffffffffc0203438 <commands+0x880>
ffffffffc0202184:	0ae00593          	li	a1,174
ffffffffc0202188:	00001517          	auipc	a0,0x1
ffffffffc020218c:	4e050513          	addi	a0,a0,1248 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202190:	a20fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
        assert(p[i] == TEST_OBJECT_CTVAL);
ffffffffc0202194:	00001697          	auipc	a3,0x1
ffffffffc0202198:	64468693          	addi	a3,a3,1604 # ffffffffc02037d8 <buddy_pmm_manager+0x328>
ffffffffc020219c:	00001617          	auipc	a2,0x1
ffffffffc02021a0:	29c60613          	addi	a2,a2,668 # ffffffffc0203438 <commands+0x880>
ffffffffc02021a4:	09d00593          	li	a1,157
ffffffffc02021a8:	00001517          	auipc	a0,0x1
ffffffffc02021ac:	4c050513          	addi	a0,a0,1216 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02021b0:	a00fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
        assert(p[i] == 0);
ffffffffc02021b4:	00001697          	auipc	a3,0x1
ffffffffc02021b8:	66c68693          	addi	a3,a3,1644 # ffffffffc0203820 <buddy_pmm_manager+0x370>
ffffffffc02021bc:	00001617          	auipc	a2,0x1
ffffffffc02021c0:	27c60613          	addi	a2,a2,636 # ffffffffc0203438 <commands+0x880>
ffffffffc02021c4:	0a100593          	li	a1,161
ffffffffc02021c8:	00001517          	auipc	a0,0x1
ffffffffc02021cc:	4a050513          	addi	a0,a0,1184 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02021d0:	9e0fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
        assert(p[i] == TEST_OBJECT_DTVAL);
ffffffffc02021d4:	00001697          	auipc	a3,0x1
ffffffffc02021d8:	7a468693          	addi	a3,a3,1956 # ffffffffc0203978 <buddy_pmm_manager+0x4c8>
ffffffffc02021dc:	00001617          	auipc	a2,0x1
ffffffffc02021e0:	25c60613          	addi	a2,a2,604 # ffffffffc0203438 <commands+0x880>
ffffffffc02021e4:	0b300593          	li	a1,179
ffffffffc02021e8:	00001517          	auipc	a0,0x1
ffffffffc02021ec:	48050513          	addi	a0,a0,1152 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02021f0:	9c0fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(nr_free_pages() + 3 == fp);
ffffffffc02021f4:	00001697          	auipc	a3,0x1
ffffffffc02021f8:	63c68693          	addi	a3,a3,1596 # ffffffffc0203830 <buddy_pmm_manager+0x380>
ffffffffc02021fc:	00001617          	auipc	a2,0x1
ffffffffc0202200:	23c60613          	addi	a2,a2,572 # ffffffffc0203438 <commands+0x880>
ffffffffc0202204:	0a200593          	li	a1,162
ffffffffc0202208:	00001517          	auipc	a0,0x1
ffffffffc020220c:	46050513          	addi	a0,a0,1120 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202210:	9a0fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p5 = kmem_cache_zalloc(cp0)) != NULL);
ffffffffc0202214:	00001697          	auipc	a3,0x1
ffffffffc0202218:	5e468693          	addi	a3,a3,1508 # ffffffffc02037f8 <buddy_pmm_manager+0x348>
ffffffffc020221c:	00001617          	auipc	a2,0x1
ffffffffc0202220:	21c60613          	addi	a2,a2,540 # ffffffffc0203438 <commands+0x880>
ffffffffc0202224:	09e00593          	li	a1,158
ffffffffc0202228:	00001517          	auipc	a0,0x1
ffffffffc020222c:	44050513          	addi	a0,a0,1088 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202230:	980fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(kmem_cache_reap() == 2);
ffffffffc0202234:	00001697          	auipc	a3,0x1
ffffffffc0202238:	76468693          	addi	a3,a3,1892 # ffffffffc0203998 <buddy_pmm_manager+0x4e8>
ffffffffc020223c:	00001617          	auipc	a2,0x1
ffffffffc0202240:	1fc60613          	addi	a2,a2,508 # ffffffffc0203438 <commands+0x880>
ffffffffc0202244:	0b800593          	li	a1,184
ffffffffc0202248:	00001517          	auipc	a0,0x1
ffffffffc020224c:	42050513          	addi	a0,a0,1056 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202250:	960fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(list_empty(&(cp0->slabs_free)));
ffffffffc0202254:	00001697          	auipc	a3,0x1
ffffffffc0202258:	5fc68693          	addi	a3,a3,1532 # ffffffffc0203850 <buddy_pmm_manager+0x3a0>
ffffffffc020225c:	00001617          	auipc	a2,0x1
ffffffffc0202260:	1dc60613          	addi	a2,a2,476 # ffffffffc0203438 <commands+0x880>
ffffffffc0202264:	0b000593          	li	a1,176
ffffffffc0202268:	00001517          	auipc	a0,0x1
ffffffffc020226c:	40050513          	addi	a0,a0,1024 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202270:	940fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(nr_free_pages() + 2 == fp);
ffffffffc0202274:	00001697          	auipc	a3,0x1
ffffffffc0202278:	6e468693          	addi	a3,a3,1764 # ffffffffc0203958 <buddy_pmm_manager+0x4a8>
ffffffffc020227c:	00001617          	auipc	a2,0x1
ffffffffc0202280:	1bc60613          	addi	a2,a2,444 # ffffffffc0203438 <commands+0x880>
ffffffffc0202284:	0af00593          	li	a1,175
ffffffffc0202288:	00001517          	auipc	a0,0x1
ffffffffc020228c:	3e050513          	addi	a0,a0,992 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202290:	920fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(kmem_cache_reap() == 1);
ffffffffc0202294:	00001697          	auipc	a3,0x1
ffffffffc0202298:	77468693          	addi	a3,a3,1908 # ffffffffc0203a08 <buddy_pmm_manager+0x558>
ffffffffc020229c:	00001617          	auipc	a2,0x1
ffffffffc02022a0:	19c60613          	addi	a2,a2,412 # ffffffffc0203438 <commands+0x880>
ffffffffc02022a4:	0c100593          	li	a1,193
ffffffffc02022a8:	00001517          	auipc	a0,0x1
ffffffffc02022ac:	3c050513          	addi	a0,a0,960 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02022b0:	900fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(list_length(&(cp0->slabs_free)) == 1);
ffffffffc02022b4:	00001697          	auipc	a3,0x1
ffffffffc02022b8:	60c68693          	addi	a3,a3,1548 # ffffffffc02038c0 <buddy_pmm_manager+0x410>
ffffffffc02022bc:	00001617          	auipc	a2,0x1
ffffffffc02022c0:	17c60613          	addi	a2,a2,380 # ffffffffc0203438 <commands+0x880>
ffffffffc02022c4:	0aa00593          	li	a1,170
ffffffffc02022c8:	00001517          	auipc	a0,0x1
ffffffffc02022cc:	3a050513          	addi	a0,a0,928 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02022d0:	8e0fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(list_length(&(cp0->slabs_full)) == 1);
ffffffffc02022d4:	00001697          	auipc	a3,0x1
ffffffffc02022d8:	63c68693          	addi	a3,a3,1596 # ffffffffc0203910 <buddy_pmm_manager+0x460>
ffffffffc02022dc:	00001617          	auipc	a2,0x1
ffffffffc02022e0:	15c60613          	addi	a2,a2,348 # ffffffffc0203438 <commands+0x880>
ffffffffc02022e4:	0ac00593          	li	a1,172
ffffffffc02022e8:	00001517          	auipc	a0,0x1
ffffffffc02022ec:	38050513          	addi	a0,a0,896 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02022f0:	8c0fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(list_empty(&(cp0->slabs_partial)));
ffffffffc02022f4:	00001697          	auipc	a3,0x1
ffffffffc02022f8:	57c68693          	addi	a3,a3,1404 # ffffffffc0203870 <buddy_pmm_manager+0x3c0>
ffffffffc02022fc:	00001617          	auipc	a2,0x1
ffffffffc0202300:	13c60613          	addi	a2,a2,316 # ffffffffc0203438 <commands+0x880>
ffffffffc0202304:	0a400593          	li	a1,164
ffffffffc0202308:	00001517          	auipc	a0,0x1
ffffffffc020230c:	36050513          	addi	a0,a0,864 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202310:	8a0fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(list_empty(&(cp0->slabs_free)));
ffffffffc0202314:	00001697          	auipc	a3,0x1
ffffffffc0202318:	53c68693          	addi	a3,a3,1340 # ffffffffc0203850 <buddy_pmm_manager+0x3a0>
ffffffffc020231c:	00001617          	auipc	a2,0x1
ffffffffc0202320:	11c60613          	addi	a2,a2,284 # ffffffffc0203438 <commands+0x880>
ffffffffc0202324:	0a300593          	li	a1,163
ffffffffc0202328:	00001517          	auipc	a0,0x1
ffffffffc020232c:	34050513          	addi	a0,a0,832 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202330:	880fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p0 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc0202334:	00001697          	auipc	a3,0x1
ffffffffc0202338:	3dc68693          	addi	a3,a3,988 # ffffffffc0203710 <buddy_pmm_manager+0x260>
ffffffffc020233c:	00001617          	auipc	a2,0x1
ffffffffc0202340:	0fc60613          	addi	a2,a2,252 # ffffffffc0203438 <commands+0x880>
ffffffffc0202344:	09600593          	li	a1,150
ffffffffc0202348:	00001517          	auipc	a0,0x1
ffffffffc020234c:	32050513          	addi	a0,a0,800 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202350:	860fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(strcmp(kmem_cache_name(cp0), test_object_name) == 0);
ffffffffc0202354:	00001697          	auipc	a3,0x1
ffffffffc0202358:	38468693          	addi	a3,a3,900 # ffffffffc02036d8 <buddy_pmm_manager+0x228>
ffffffffc020235c:	00001617          	auipc	a2,0x1
ffffffffc0202360:	0dc60613          	addi	a2,a2,220 # ffffffffc0203438 <commands+0x880>
ffffffffc0202364:	09200593          	li	a1,146
ffffffffc0202368:	00001517          	auipc	a0,0x1
ffffffffc020236c:	30050513          	addi	a0,a0,768 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202370:	840fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(nr_free_pages() == fp);
ffffffffc0202374:	00001697          	auipc	a3,0x1
ffffffffc0202378:	63c68693          	addi	a3,a3,1596 # ffffffffc02039b0 <buddy_pmm_manager+0x500>
ffffffffc020237c:	00001617          	auipc	a2,0x1
ffffffffc0202380:	0bc60613          	addi	a2,a2,188 # ffffffffc0203438 <commands+0x880>
ffffffffc0202384:	0b900593          	li	a1,185
ffffffffc0202388:	00001517          	auipc	a0,0x1
ffffffffc020238c:	2e050513          	addi	a0,a0,736 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202390:	820fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p3 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc0202394:	00001697          	auipc	a3,0x1
ffffffffc0202398:	3f468693          	addi	a3,a3,1012 # ffffffffc0203788 <buddy_pmm_manager+0x2d8>
ffffffffc020239c:	00001617          	auipc	a2,0x1
ffffffffc02023a0:	09c60613          	addi	a2,a2,156 # ffffffffc0203438 <commands+0x880>
ffffffffc02023a4:	09900593          	li	a1,153
ffffffffc02023a8:	00001517          	auipc	a0,0x1
ffffffffc02023ac:	2c050513          	addi	a0,a0,704 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02023b0:	800fe0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p2 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc02023b4:	00001697          	auipc	a3,0x1
ffffffffc02023b8:	3ac68693          	addi	a3,a3,940 # ffffffffc0203760 <buddy_pmm_manager+0x2b0>
ffffffffc02023bc:	00001617          	auipc	a2,0x1
ffffffffc02023c0:	07c60613          	addi	a2,a2,124 # ffffffffc0203438 <commands+0x880>
ffffffffc02023c4:	09800593          	li	a1,152
ffffffffc02023c8:	00001517          	auipc	a0,0x1
ffffffffc02023cc:	2a050513          	addi	a0,a0,672 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02023d0:	fe1fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p1 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc02023d4:	00001697          	auipc	a3,0x1
ffffffffc02023d8:	36468693          	addi	a3,a3,868 # ffffffffc0203738 <buddy_pmm_manager+0x288>
ffffffffc02023dc:	00001617          	auipc	a2,0x1
ffffffffc02023e0:	05c60613          	addi	a2,a2,92 # ffffffffc0203438 <commands+0x880>
ffffffffc02023e4:	09700593          	li	a1,151
ffffffffc02023e8:	00001517          	auipc	a0,0x1
ffffffffc02023ec:	28050513          	addi	a0,a0,640 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02023f0:	fc1fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p4 = kmem_cache_alloc(cp0)) != NULL);
ffffffffc02023f4:	00001697          	auipc	a3,0x1
ffffffffc02023f8:	3bc68693          	addi	a3,a3,956 # ffffffffc02037b0 <buddy_pmm_manager+0x300>
ffffffffc02023fc:	00001617          	auipc	a2,0x1
ffffffffc0202400:	03c60613          	addi	a2,a2,60 # ffffffffc0203438 <commands+0x880>
ffffffffc0202404:	09a00593          	li	a1,154
ffffffffc0202408:	00001517          	auipc	a0,0x1
ffffffffc020240c:	26050513          	addi	a0,a0,608 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202410:	fa1fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(list_length(&(cp0->slabs_full)) == 3);
ffffffffc0202414:	00001697          	auipc	a3,0x1
ffffffffc0202418:	48468693          	addi	a3,a3,1156 # ffffffffc0203898 <buddy_pmm_manager+0x3e8>
ffffffffc020241c:	00001617          	auipc	a2,0x1
ffffffffc0202420:	01c60613          	addi	a2,a2,28 # ffffffffc0203438 <commands+0x880>
ffffffffc0202424:	0a500593          	li	a1,165
ffffffffc0202428:	00001517          	auipc	a0,0x1
ffffffffc020242c:	24050513          	addi	a0,a0,576 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202430:	f81fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(kmem_cache_size(cp0) == sizeof(struct test_object));
ffffffffc0202434:	00001697          	auipc	a3,0x1
ffffffffc0202438:	26c68693          	addi	a3,a3,620 # ffffffffc02036a0 <buddy_pmm_manager+0x1f0>
ffffffffc020243c:	00001617          	auipc	a2,0x1
ffffffffc0202440:	ffc60613          	addi	a2,a2,-4 # ffffffffc0203438 <commands+0x880>
ffffffffc0202444:	09100593          	li	a1,145
ffffffffc0202448:	00001517          	auipc	a0,0x1
ffffffffc020244c:	22050513          	addi	a0,a0,544 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202450:	f61fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(cp0 != NULL);
ffffffffc0202454:	00001697          	auipc	a3,0x1
ffffffffc0202458:	23c68693          	addi	a3,a3,572 # ffffffffc0203690 <buddy_pmm_manager+0x1e0>
ffffffffc020245c:	00001617          	auipc	a2,0x1
ffffffffc0202460:	fdc60613          	addi	a2,a2,-36 # ffffffffc0203438 <commands+0x880>
ffffffffc0202464:	09000593          	li	a1,144
ffffffffc0202468:	00001517          	auipc	a0,0x1
ffffffffc020246c:	20050513          	addi	a0,a0,512 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202470:	f41fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(list_length(&(cp0->slabs_partial)) == 1);
ffffffffc0202474:	00001697          	auipc	a3,0x1
ffffffffc0202478:	47468693          	addi	a3,a3,1140 # ffffffffc02038e8 <buddy_pmm_manager+0x438>
ffffffffc020247c:	00001617          	auipc	a2,0x1
ffffffffc0202480:	fbc60613          	addi	a2,a2,-68 # ffffffffc0203438 <commands+0x880>
ffffffffc0202484:	0ab00593          	li	a1,171
ffffffffc0202488:	00001517          	auipc	a0,0x1
ffffffffc020248c:	1e050513          	addi	a0,a0,480 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc0202490:	f21fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(nr_free_pages() == fp);
ffffffffc0202494:	00001697          	auipc	a3,0x1
ffffffffc0202498:	51c68693          	addi	a3,a3,1308 # ffffffffc02039b0 <buddy_pmm_manager+0x500>
ffffffffc020249c:	00001617          	auipc	a2,0x1
ffffffffc02024a0:	f9c60613          	addi	a2,a2,-100 # ffffffffc0203438 <commands+0x880>
ffffffffc02024a4:	0c200593          	li	a1,194
ffffffffc02024a8:	00001517          	auipc	a0,0x1
ffffffffc02024ac:	1c050513          	addi	a0,a0,448 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02024b0:	f01fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert(nr_free_pages() + 1 == fp);
ffffffffc02024b4:	00001697          	auipc	a3,0x1
ffffffffc02024b8:	53468693          	addi	a3,a3,1332 # ffffffffc02039e8 <buddy_pmm_manager+0x538>
ffffffffc02024bc:	00001617          	auipc	a2,0x1
ffffffffc02024c0:	f7c60613          	addi	a2,a2,-132 # ffffffffc0203438 <commands+0x880>
ffffffffc02024c4:	0bf00593          	li	a1,191
ffffffffc02024c8:	00001517          	auipc	a0,0x1
ffffffffc02024cc:	1a050513          	addi	a0,a0,416 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02024d0:	ee1fd0ef          	jal	ra,ffffffffc02003b0 <__panic>
    assert((p0 = kmalloc(2048)) != NULL);
ffffffffc02024d4:	00001697          	auipc	a3,0x1
ffffffffc02024d8:	4f468693          	addi	a3,a3,1268 # ffffffffc02039c8 <buddy_pmm_manager+0x518>
ffffffffc02024dc:	00001617          	auipc	a2,0x1
ffffffffc02024e0:	f5c60613          	addi	a2,a2,-164 # ffffffffc0203438 <commands+0x880>
ffffffffc02024e4:	0be00593          	li	a1,190
ffffffffc02024e8:	00001517          	auipc	a0,0x1
ffffffffc02024ec:	18050513          	addi	a0,a0,384 # ffffffffc0203668 <buddy_pmm_manager+0x1b8>
ffffffffc02024f0:	ec1fd0ef          	jal	ra,ffffffffc02003b0 <__panic>

ffffffffc02024f4 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02024f4:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02024f8:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02024fa:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02024fe:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0202500:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0202504:	f022                	sd	s0,32(sp)
ffffffffc0202506:	ec26                	sd	s1,24(sp)
ffffffffc0202508:	e84a                	sd	s2,16(sp)
ffffffffc020250a:	f406                	sd	ra,40(sp)
ffffffffc020250c:	e44e                	sd	s3,8(sp)
ffffffffc020250e:	84aa                	mv	s1,a0
ffffffffc0202510:	892e                	mv	s2,a1
ffffffffc0202512:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0202516:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
ffffffffc0202518:	03067e63          	bleu	a6,a2,ffffffffc0202554 <printnum+0x60>
ffffffffc020251c:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc020251e:	00805763          	blez	s0,ffffffffc020252c <printnum+0x38>
ffffffffc0202522:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0202524:	85ca                	mv	a1,s2
ffffffffc0202526:	854e                	mv	a0,s3
ffffffffc0202528:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc020252a:	fc65                	bnez	s0,ffffffffc0202522 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020252c:	1a02                	slli	s4,s4,0x20
ffffffffc020252e:	020a5a13          	srli	s4,s4,0x20
ffffffffc0202532:	00001797          	auipc	a5,0x1
ffffffffc0202536:	69e78793          	addi	a5,a5,1694 # ffffffffc0203bd0 <error_string+0x38>
ffffffffc020253a:	9a3e                	add	s4,s4,a5
}
ffffffffc020253c:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020253e:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0202542:	70a2                	ld	ra,40(sp)
ffffffffc0202544:	69a2                	ld	s3,8(sp)
ffffffffc0202546:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0202548:	85ca                	mv	a1,s2
ffffffffc020254a:	8326                	mv	t1,s1
}
ffffffffc020254c:	6942                	ld	s2,16(sp)
ffffffffc020254e:	64e2                	ld	s1,24(sp)
ffffffffc0202550:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0202552:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0202554:	03065633          	divu	a2,a2,a6
ffffffffc0202558:	8722                	mv	a4,s0
ffffffffc020255a:	f9bff0ef          	jal	ra,ffffffffc02024f4 <printnum>
ffffffffc020255e:	b7f9                	j	ffffffffc020252c <printnum+0x38>

ffffffffc0202560 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0202560:	7119                	addi	sp,sp,-128
ffffffffc0202562:	f4a6                	sd	s1,104(sp)
ffffffffc0202564:	f0ca                	sd	s2,96(sp)
ffffffffc0202566:	e8d2                	sd	s4,80(sp)
ffffffffc0202568:	e4d6                	sd	s5,72(sp)
ffffffffc020256a:	e0da                	sd	s6,64(sp)
ffffffffc020256c:	fc5e                	sd	s7,56(sp)
ffffffffc020256e:	f862                	sd	s8,48(sp)
ffffffffc0202570:	f06a                	sd	s10,32(sp)
ffffffffc0202572:	fc86                	sd	ra,120(sp)
ffffffffc0202574:	f8a2                	sd	s0,112(sp)
ffffffffc0202576:	ecce                	sd	s3,88(sp)
ffffffffc0202578:	f466                	sd	s9,40(sp)
ffffffffc020257a:	ec6e                	sd	s11,24(sp)
ffffffffc020257c:	892a                	mv	s2,a0
ffffffffc020257e:	84ae                	mv	s1,a1
ffffffffc0202580:	8d32                	mv	s10,a2
ffffffffc0202582:	8ab6                	mv	s5,a3
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0202584:	5b7d                	li	s6,-1
        lflag = altflag = 0;

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0202586:	00001a17          	auipc	s4,0x1
ffffffffc020258a:	4b6a0a13          	addi	s4,s4,1206 # ffffffffc0203a3c <buddy_pmm_manager+0x58c>
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc020258e:	05e00b93          	li	s7,94
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0202592:	00001c17          	auipc	s8,0x1
ffffffffc0202596:	606c0c13          	addi	s8,s8,1542 # ffffffffc0203b98 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020259a:	000d4503          	lbu	a0,0(s10)
ffffffffc020259e:	02500793          	li	a5,37
ffffffffc02025a2:	001d0413          	addi	s0,s10,1
ffffffffc02025a6:	00f50e63          	beq	a0,a5,ffffffffc02025c2 <vprintfmt+0x62>
            if (ch == '\0') {
ffffffffc02025aa:	c521                	beqz	a0,ffffffffc02025f2 <vprintfmt+0x92>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02025ac:	02500993          	li	s3,37
ffffffffc02025b0:	a011                	j	ffffffffc02025b4 <vprintfmt+0x54>
            if (ch == '\0') {
ffffffffc02025b2:	c121                	beqz	a0,ffffffffc02025f2 <vprintfmt+0x92>
            putch(ch, putdat);
ffffffffc02025b4:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02025b6:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc02025b8:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02025ba:	fff44503          	lbu	a0,-1(s0)
ffffffffc02025be:	ff351ae3          	bne	a0,s3,ffffffffc02025b2 <vprintfmt+0x52>
ffffffffc02025c2:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc02025c6:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc02025ca:	4981                	li	s3,0
ffffffffc02025cc:	4801                	li	a6,0
        width = precision = -1;
ffffffffc02025ce:	5cfd                	li	s9,-1
ffffffffc02025d0:	5dfd                	li	s11,-1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02025d2:	05500593          	li	a1,85
                if (ch < '0' || ch > '9') {
ffffffffc02025d6:	4525                	li	a0,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02025d8:	fdd6069b          	addiw	a3,a2,-35
ffffffffc02025dc:	0ff6f693          	andi	a3,a3,255
ffffffffc02025e0:	00140d13          	addi	s10,s0,1
ffffffffc02025e4:	20d5e563          	bltu	a1,a3,ffffffffc02027ee <vprintfmt+0x28e>
ffffffffc02025e8:	068a                	slli	a3,a3,0x2
ffffffffc02025ea:	96d2                	add	a3,a3,s4
ffffffffc02025ec:	4294                	lw	a3,0(a3)
ffffffffc02025ee:	96d2                	add	a3,a3,s4
ffffffffc02025f0:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc02025f2:	70e6                	ld	ra,120(sp)
ffffffffc02025f4:	7446                	ld	s0,112(sp)
ffffffffc02025f6:	74a6                	ld	s1,104(sp)
ffffffffc02025f8:	7906                	ld	s2,96(sp)
ffffffffc02025fa:	69e6                	ld	s3,88(sp)
ffffffffc02025fc:	6a46                	ld	s4,80(sp)
ffffffffc02025fe:	6aa6                	ld	s5,72(sp)
ffffffffc0202600:	6b06                	ld	s6,64(sp)
ffffffffc0202602:	7be2                	ld	s7,56(sp)
ffffffffc0202604:	7c42                	ld	s8,48(sp)
ffffffffc0202606:	7ca2                	ld	s9,40(sp)
ffffffffc0202608:	7d02                	ld	s10,32(sp)
ffffffffc020260a:	6de2                	ld	s11,24(sp)
ffffffffc020260c:	6109                	addi	sp,sp,128
ffffffffc020260e:	8082                	ret
    if (lflag >= 2) {
ffffffffc0202610:	4705                	li	a4,1
ffffffffc0202612:	008a8593          	addi	a1,s5,8
ffffffffc0202616:	01074463          	blt	a4,a6,ffffffffc020261e <vprintfmt+0xbe>
    else if (lflag) {
ffffffffc020261a:	26080363          	beqz	a6,ffffffffc0202880 <vprintfmt+0x320>
        return va_arg(*ap, unsigned long);
ffffffffc020261e:	000ab603          	ld	a2,0(s5)
ffffffffc0202622:	46c1                	li	a3,16
ffffffffc0202624:	8aae                	mv	s5,a1
ffffffffc0202626:	a06d                	j	ffffffffc02026d0 <vprintfmt+0x170>
            goto reswitch;
ffffffffc0202628:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc020262c:	4985                	li	s3,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020262e:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0202630:	b765                	j	ffffffffc02025d8 <vprintfmt+0x78>
            putch(va_arg(ap, int), putdat);
ffffffffc0202632:	000aa503          	lw	a0,0(s5)
ffffffffc0202636:	85a6                	mv	a1,s1
ffffffffc0202638:	0aa1                	addi	s5,s5,8
ffffffffc020263a:	9902                	jalr	s2
            break;
ffffffffc020263c:	bfb9                	j	ffffffffc020259a <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020263e:	4705                	li	a4,1
ffffffffc0202640:	008a8993          	addi	s3,s5,8
ffffffffc0202644:	01074463          	blt	a4,a6,ffffffffc020264c <vprintfmt+0xec>
    else if (lflag) {
ffffffffc0202648:	22080463          	beqz	a6,ffffffffc0202870 <vprintfmt+0x310>
        return va_arg(*ap, long);
ffffffffc020264c:	000ab403          	ld	s0,0(s5)
            if ((long long)num < 0) {
ffffffffc0202650:	24044463          	bltz	s0,ffffffffc0202898 <vprintfmt+0x338>
            num = getint(&ap, lflag);
ffffffffc0202654:	8622                	mv	a2,s0
ffffffffc0202656:	8ace                	mv	s5,s3
ffffffffc0202658:	46a9                	li	a3,10
ffffffffc020265a:	a89d                	j	ffffffffc02026d0 <vprintfmt+0x170>
            err = va_arg(ap, int);
ffffffffc020265c:	000aa783          	lw	a5,0(s5)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0202660:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0202662:	0aa1                	addi	s5,s5,8
            if (err < 0) {
ffffffffc0202664:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0202668:	8fb5                	xor	a5,a5,a3
ffffffffc020266a:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020266e:	1ad74363          	blt	a4,a3,ffffffffc0202814 <vprintfmt+0x2b4>
ffffffffc0202672:	00369793          	slli	a5,a3,0x3
ffffffffc0202676:	97e2                	add	a5,a5,s8
ffffffffc0202678:	639c                	ld	a5,0(a5)
ffffffffc020267a:	18078d63          	beqz	a5,ffffffffc0202814 <vprintfmt+0x2b4>
                printfmt(putch, putdat, "%s", p);
ffffffffc020267e:	86be                	mv	a3,a5
ffffffffc0202680:	00001617          	auipc	a2,0x1
ffffffffc0202684:	60060613          	addi	a2,a2,1536 # ffffffffc0203c80 <error_string+0xe8>
ffffffffc0202688:	85a6                	mv	a1,s1
ffffffffc020268a:	854a                	mv	a0,s2
ffffffffc020268c:	240000ef          	jal	ra,ffffffffc02028cc <printfmt>
ffffffffc0202690:	b729                	j	ffffffffc020259a <vprintfmt+0x3a>
            lflag ++;
ffffffffc0202692:	00144603          	lbu	a2,1(s0)
ffffffffc0202696:	2805                	addiw	a6,a6,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0202698:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020269a:	bf3d                	j	ffffffffc02025d8 <vprintfmt+0x78>
    if (lflag >= 2) {
ffffffffc020269c:	4705                	li	a4,1
ffffffffc020269e:	008a8593          	addi	a1,s5,8
ffffffffc02026a2:	01074463          	blt	a4,a6,ffffffffc02026aa <vprintfmt+0x14a>
    else if (lflag) {
ffffffffc02026a6:	1e080263          	beqz	a6,ffffffffc020288a <vprintfmt+0x32a>
        return va_arg(*ap, unsigned long);
ffffffffc02026aa:	000ab603          	ld	a2,0(s5)
ffffffffc02026ae:	46a1                	li	a3,8
ffffffffc02026b0:	8aae                	mv	s5,a1
ffffffffc02026b2:	a839                	j	ffffffffc02026d0 <vprintfmt+0x170>
            putch('0', putdat);
ffffffffc02026b4:	03000513          	li	a0,48
ffffffffc02026b8:	85a6                	mv	a1,s1
ffffffffc02026ba:	e03e                	sd	a5,0(sp)
ffffffffc02026bc:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc02026be:	85a6                	mv	a1,s1
ffffffffc02026c0:	07800513          	li	a0,120
ffffffffc02026c4:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02026c6:	0aa1                	addi	s5,s5,8
ffffffffc02026c8:	ff8ab603          	ld	a2,-8(s5)
            goto number;
ffffffffc02026cc:	6782                	ld	a5,0(sp)
ffffffffc02026ce:	46c1                	li	a3,16
            printnum(putch, putdat, num, base, width, padc);
ffffffffc02026d0:	876e                	mv	a4,s11
ffffffffc02026d2:	85a6                	mv	a1,s1
ffffffffc02026d4:	854a                	mv	a0,s2
ffffffffc02026d6:	e1fff0ef          	jal	ra,ffffffffc02024f4 <printnum>
            break;
ffffffffc02026da:	b5c1                	j	ffffffffc020259a <vprintfmt+0x3a>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc02026dc:	000ab603          	ld	a2,0(s5)
ffffffffc02026e0:	0aa1                	addi	s5,s5,8
ffffffffc02026e2:	1c060663          	beqz	a2,ffffffffc02028ae <vprintfmt+0x34e>
            if (width > 0 && padc != '-') {
ffffffffc02026e6:	00160413          	addi	s0,a2,1
ffffffffc02026ea:	17b05c63          	blez	s11,ffffffffc0202862 <vprintfmt+0x302>
ffffffffc02026ee:	02d00593          	li	a1,45
ffffffffc02026f2:	14b79263          	bne	a5,a1,ffffffffc0202836 <vprintfmt+0x2d6>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02026f6:	00064783          	lbu	a5,0(a2)
ffffffffc02026fa:	0007851b          	sext.w	a0,a5
ffffffffc02026fe:	c905                	beqz	a0,ffffffffc020272e <vprintfmt+0x1ce>
ffffffffc0202700:	000cc563          	bltz	s9,ffffffffc020270a <vprintfmt+0x1aa>
ffffffffc0202704:	3cfd                	addiw	s9,s9,-1
ffffffffc0202706:	036c8263          	beq	s9,s6,ffffffffc020272a <vprintfmt+0x1ca>
                    putch('?', putdat);
ffffffffc020270a:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc020270c:	18098463          	beqz	s3,ffffffffc0202894 <vprintfmt+0x334>
ffffffffc0202710:	3781                	addiw	a5,a5,-32
ffffffffc0202712:	18fbf163          	bleu	a5,s7,ffffffffc0202894 <vprintfmt+0x334>
                    putch('?', putdat);
ffffffffc0202716:	03f00513          	li	a0,63
ffffffffc020271a:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020271c:	0405                	addi	s0,s0,1
ffffffffc020271e:	fff44783          	lbu	a5,-1(s0)
ffffffffc0202722:	3dfd                	addiw	s11,s11,-1
ffffffffc0202724:	0007851b          	sext.w	a0,a5
ffffffffc0202728:	fd61                	bnez	a0,ffffffffc0202700 <vprintfmt+0x1a0>
            for (; width > 0; width --) {
ffffffffc020272a:	e7b058e3          	blez	s11,ffffffffc020259a <vprintfmt+0x3a>
ffffffffc020272e:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0202730:	85a6                	mv	a1,s1
ffffffffc0202732:	02000513          	li	a0,32
ffffffffc0202736:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0202738:	e60d81e3          	beqz	s11,ffffffffc020259a <vprintfmt+0x3a>
ffffffffc020273c:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc020273e:	85a6                	mv	a1,s1
ffffffffc0202740:	02000513          	li	a0,32
ffffffffc0202744:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0202746:	fe0d94e3          	bnez	s11,ffffffffc020272e <vprintfmt+0x1ce>
ffffffffc020274a:	bd81                	j	ffffffffc020259a <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020274c:	4705                	li	a4,1
ffffffffc020274e:	008a8593          	addi	a1,s5,8
ffffffffc0202752:	01074463          	blt	a4,a6,ffffffffc020275a <vprintfmt+0x1fa>
    else if (lflag) {
ffffffffc0202756:	12080063          	beqz	a6,ffffffffc0202876 <vprintfmt+0x316>
        return va_arg(*ap, unsigned long);
ffffffffc020275a:	000ab603          	ld	a2,0(s5)
ffffffffc020275e:	46a9                	li	a3,10
ffffffffc0202760:	8aae                	mv	s5,a1
ffffffffc0202762:	b7bd                	j	ffffffffc02026d0 <vprintfmt+0x170>
ffffffffc0202764:	00144603          	lbu	a2,1(s0)
            padc = '-';
ffffffffc0202768:	02d00793          	li	a5,45
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020276c:	846a                	mv	s0,s10
ffffffffc020276e:	b5ad                	j	ffffffffc02025d8 <vprintfmt+0x78>
            putch(ch, putdat);
ffffffffc0202770:	85a6                	mv	a1,s1
ffffffffc0202772:	02500513          	li	a0,37
ffffffffc0202776:	9902                	jalr	s2
            break;
ffffffffc0202778:	b50d                	j	ffffffffc020259a <vprintfmt+0x3a>
            precision = va_arg(ap, int);
ffffffffc020277a:	000aac83          	lw	s9,0(s5)
            goto process_precision;
ffffffffc020277e:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0202782:	0aa1                	addi	s5,s5,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0202784:	846a                	mv	s0,s10
            if (width < 0)
ffffffffc0202786:	e40dd9e3          	bgez	s11,ffffffffc02025d8 <vprintfmt+0x78>
                width = precision, precision = -1;
ffffffffc020278a:	8de6                	mv	s11,s9
ffffffffc020278c:	5cfd                	li	s9,-1
ffffffffc020278e:	b5a9                	j	ffffffffc02025d8 <vprintfmt+0x78>
            goto reswitch;
ffffffffc0202790:	00144603          	lbu	a2,1(s0)
            padc = '0';
ffffffffc0202794:	03000793          	li	a5,48
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0202798:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020279a:	bd3d                	j	ffffffffc02025d8 <vprintfmt+0x78>
                precision = precision * 10 + ch - '0';
ffffffffc020279c:	fd060c9b          	addiw	s9,a2,-48
                ch = *fmt;
ffffffffc02027a0:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02027a4:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02027a6:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02027aa:	0006089b          	sext.w	a7,a2
                if (ch < '0' || ch > '9') {
ffffffffc02027ae:	fcd56ce3          	bltu	a0,a3,ffffffffc0202786 <vprintfmt+0x226>
            for (precision = 0; ; ++ fmt) {
ffffffffc02027b2:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc02027b4:	002c969b          	slliw	a3,s9,0x2
                ch = *fmt;
ffffffffc02027b8:	00044603          	lbu	a2,0(s0)
                precision = precision * 10 + ch - '0';
ffffffffc02027bc:	0196873b          	addw	a4,a3,s9
ffffffffc02027c0:	0017171b          	slliw	a4,a4,0x1
ffffffffc02027c4:	0117073b          	addw	a4,a4,a7
                if (ch < '0' || ch > '9') {
ffffffffc02027c8:	fd06069b          	addiw	a3,a2,-48
                precision = precision * 10 + ch - '0';
ffffffffc02027cc:	fd070c9b          	addiw	s9,a4,-48
                ch = *fmt;
ffffffffc02027d0:	0006089b          	sext.w	a7,a2
                if (ch < '0' || ch > '9') {
ffffffffc02027d4:	fcd57fe3          	bleu	a3,a0,ffffffffc02027b2 <vprintfmt+0x252>
ffffffffc02027d8:	b77d                	j	ffffffffc0202786 <vprintfmt+0x226>
            if (width < 0)
ffffffffc02027da:	fffdc693          	not	a3,s11
ffffffffc02027de:	96fd                	srai	a3,a3,0x3f
ffffffffc02027e0:	00ddfdb3          	and	s11,s11,a3
ffffffffc02027e4:	00144603          	lbu	a2,1(s0)
ffffffffc02027e8:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02027ea:	846a                	mv	s0,s10
ffffffffc02027ec:	b3f5                	j	ffffffffc02025d8 <vprintfmt+0x78>
            putch('%', putdat);
ffffffffc02027ee:	85a6                	mv	a1,s1
ffffffffc02027f0:	02500513          	li	a0,37
ffffffffc02027f4:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02027f6:	fff44703          	lbu	a4,-1(s0)
ffffffffc02027fa:	02500793          	li	a5,37
ffffffffc02027fe:	8d22                	mv	s10,s0
ffffffffc0202800:	d8f70de3          	beq	a4,a5,ffffffffc020259a <vprintfmt+0x3a>
ffffffffc0202804:	02500713          	li	a4,37
ffffffffc0202808:	1d7d                	addi	s10,s10,-1
ffffffffc020280a:	fffd4783          	lbu	a5,-1(s10)
ffffffffc020280e:	fee79de3          	bne	a5,a4,ffffffffc0202808 <vprintfmt+0x2a8>
ffffffffc0202812:	b361                	j	ffffffffc020259a <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0202814:	00001617          	auipc	a2,0x1
ffffffffc0202818:	45c60613          	addi	a2,a2,1116 # ffffffffc0203c70 <error_string+0xd8>
ffffffffc020281c:	85a6                	mv	a1,s1
ffffffffc020281e:	854a                	mv	a0,s2
ffffffffc0202820:	0ac000ef          	jal	ra,ffffffffc02028cc <printfmt>
ffffffffc0202824:	bb9d                	j	ffffffffc020259a <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0202826:	00001617          	auipc	a2,0x1
ffffffffc020282a:	44260613          	addi	a2,a2,1090 # ffffffffc0203c68 <error_string+0xd0>
            if (width > 0 && padc != '-') {
ffffffffc020282e:	00001417          	auipc	s0,0x1
ffffffffc0202832:	43b40413          	addi	s0,s0,1083 # ffffffffc0203c69 <error_string+0xd1>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0202836:	8532                	mv	a0,a2
ffffffffc0202838:	85e6                	mv	a1,s9
ffffffffc020283a:	e032                	sd	a2,0(sp)
ffffffffc020283c:	e43e                	sd	a5,8(sp)
ffffffffc020283e:	1c2000ef          	jal	ra,ffffffffc0202a00 <strnlen>
ffffffffc0202842:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0202846:	6602                	ld	a2,0(sp)
ffffffffc0202848:	01b05d63          	blez	s11,ffffffffc0202862 <vprintfmt+0x302>
ffffffffc020284c:	67a2                	ld	a5,8(sp)
ffffffffc020284e:	2781                	sext.w	a5,a5
ffffffffc0202850:	e43e                	sd	a5,8(sp)
                    putch(padc, putdat);
ffffffffc0202852:	6522                	ld	a0,8(sp)
ffffffffc0202854:	85a6                	mv	a1,s1
ffffffffc0202856:	e032                	sd	a2,0(sp)
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0202858:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc020285a:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020285c:	6602                	ld	a2,0(sp)
ffffffffc020285e:	fe0d9ae3          	bnez	s11,ffffffffc0202852 <vprintfmt+0x2f2>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0202862:	00064783          	lbu	a5,0(a2)
ffffffffc0202866:	0007851b          	sext.w	a0,a5
ffffffffc020286a:	e8051be3          	bnez	a0,ffffffffc0202700 <vprintfmt+0x1a0>
ffffffffc020286e:	b335                	j	ffffffffc020259a <vprintfmt+0x3a>
        return va_arg(*ap, int);
ffffffffc0202870:	000aa403          	lw	s0,0(s5)
ffffffffc0202874:	bbf1                	j	ffffffffc0202650 <vprintfmt+0xf0>
        return va_arg(*ap, unsigned int);
ffffffffc0202876:	000ae603          	lwu	a2,0(s5)
ffffffffc020287a:	46a9                	li	a3,10
ffffffffc020287c:	8aae                	mv	s5,a1
ffffffffc020287e:	bd89                	j	ffffffffc02026d0 <vprintfmt+0x170>
ffffffffc0202880:	000ae603          	lwu	a2,0(s5)
ffffffffc0202884:	46c1                	li	a3,16
ffffffffc0202886:	8aae                	mv	s5,a1
ffffffffc0202888:	b5a1                	j	ffffffffc02026d0 <vprintfmt+0x170>
ffffffffc020288a:	000ae603          	lwu	a2,0(s5)
ffffffffc020288e:	46a1                	li	a3,8
ffffffffc0202890:	8aae                	mv	s5,a1
ffffffffc0202892:	bd3d                	j	ffffffffc02026d0 <vprintfmt+0x170>
                    putch(ch, putdat);
ffffffffc0202894:	9902                	jalr	s2
ffffffffc0202896:	b559                	j	ffffffffc020271c <vprintfmt+0x1bc>
                putch('-', putdat);
ffffffffc0202898:	85a6                	mv	a1,s1
ffffffffc020289a:	02d00513          	li	a0,45
ffffffffc020289e:	e03e                	sd	a5,0(sp)
ffffffffc02028a0:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc02028a2:	8ace                	mv	s5,s3
ffffffffc02028a4:	40800633          	neg	a2,s0
ffffffffc02028a8:	46a9                	li	a3,10
ffffffffc02028aa:	6782                	ld	a5,0(sp)
ffffffffc02028ac:	b515                	j	ffffffffc02026d0 <vprintfmt+0x170>
            if (width > 0 && padc != '-') {
ffffffffc02028ae:	01b05663          	blez	s11,ffffffffc02028ba <vprintfmt+0x35a>
ffffffffc02028b2:	02d00693          	li	a3,45
ffffffffc02028b6:	f6d798e3          	bne	a5,a3,ffffffffc0202826 <vprintfmt+0x2c6>
ffffffffc02028ba:	00001417          	auipc	s0,0x1
ffffffffc02028be:	3af40413          	addi	s0,s0,943 # ffffffffc0203c69 <error_string+0xd1>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02028c2:	02800513          	li	a0,40
ffffffffc02028c6:	02800793          	li	a5,40
ffffffffc02028ca:	bd1d                	j	ffffffffc0202700 <vprintfmt+0x1a0>

ffffffffc02028cc <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02028cc:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc02028ce:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02028d2:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02028d4:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02028d6:	ec06                	sd	ra,24(sp)
ffffffffc02028d8:	f83a                	sd	a4,48(sp)
ffffffffc02028da:	fc3e                	sd	a5,56(sp)
ffffffffc02028dc:	e0c2                	sd	a6,64(sp)
ffffffffc02028de:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02028e0:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02028e2:	c7fff0ef          	jal	ra,ffffffffc0202560 <vprintfmt>
}
ffffffffc02028e6:	60e2                	ld	ra,24(sp)
ffffffffc02028e8:	6161                	addi	sp,sp,80
ffffffffc02028ea:	8082                	ret

ffffffffc02028ec <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc02028ec:	715d                	addi	sp,sp,-80
ffffffffc02028ee:	e486                	sd	ra,72(sp)
ffffffffc02028f0:	e0a2                	sd	s0,64(sp)
ffffffffc02028f2:	fc26                	sd	s1,56(sp)
ffffffffc02028f4:	f84a                	sd	s2,48(sp)
ffffffffc02028f6:	f44e                	sd	s3,40(sp)
ffffffffc02028f8:	f052                	sd	s4,32(sp)
ffffffffc02028fa:	ec56                	sd	s5,24(sp)
ffffffffc02028fc:	e85a                	sd	s6,16(sp)
ffffffffc02028fe:	e45e                	sd	s7,8(sp)
    if (prompt != NULL) {
ffffffffc0202900:	c901                	beqz	a0,ffffffffc0202910 <readline+0x24>
        cprintf("%s", prompt);
ffffffffc0202902:	85aa                	mv	a1,a0
ffffffffc0202904:	00001517          	auipc	a0,0x1
ffffffffc0202908:	37c50513          	addi	a0,a0,892 # ffffffffc0203c80 <error_string+0xe8>
ffffffffc020290c:	faefd0ef          	jal	ra,ffffffffc02000ba <cprintf>
readline(const char *prompt) {
ffffffffc0202910:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0202912:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0202914:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0202916:	4aa9                	li	s5,10
ffffffffc0202918:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc020291a:	00004b97          	auipc	s7,0x4
ffffffffc020291e:	7aeb8b93          	addi	s7,s7,1966 # ffffffffc02070c8 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0202922:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0202926:	80dfd0ef          	jal	ra,ffffffffc0200132 <getchar>
ffffffffc020292a:	842a                	mv	s0,a0
        if (c < 0) {
ffffffffc020292c:	00054b63          	bltz	a0,ffffffffc0202942 <readline+0x56>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0202930:	00a95b63          	ble	a0,s2,ffffffffc0202946 <readline+0x5a>
ffffffffc0202934:	029a5463          	ble	s1,s4,ffffffffc020295c <readline+0x70>
        c = getchar();
ffffffffc0202938:	ffafd0ef          	jal	ra,ffffffffc0200132 <getchar>
ffffffffc020293c:	842a                	mv	s0,a0
        if (c < 0) {
ffffffffc020293e:	fe0559e3          	bgez	a0,ffffffffc0202930 <readline+0x44>
            return NULL;
ffffffffc0202942:	4501                	li	a0,0
ffffffffc0202944:	a099                	j	ffffffffc020298a <readline+0x9e>
        else if (c == '\b' && i > 0) {
ffffffffc0202946:	03341463          	bne	s0,s3,ffffffffc020296e <readline+0x82>
ffffffffc020294a:	e8b9                	bnez	s1,ffffffffc02029a0 <readline+0xb4>
        c = getchar();
ffffffffc020294c:	fe6fd0ef          	jal	ra,ffffffffc0200132 <getchar>
ffffffffc0202950:	842a                	mv	s0,a0
        if (c < 0) {
ffffffffc0202952:	fe0548e3          	bltz	a0,ffffffffc0202942 <readline+0x56>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0202956:	fea958e3          	ble	a0,s2,ffffffffc0202946 <readline+0x5a>
ffffffffc020295a:	4481                	li	s1,0
            cputchar(c);
ffffffffc020295c:	8522                	mv	a0,s0
ffffffffc020295e:	f90fd0ef          	jal	ra,ffffffffc02000ee <cputchar>
            buf[i ++] = c;
ffffffffc0202962:	009b87b3          	add	a5,s7,s1
ffffffffc0202966:	00878023          	sb	s0,0(a5)
ffffffffc020296a:	2485                	addiw	s1,s1,1
ffffffffc020296c:	bf6d                	j	ffffffffc0202926 <readline+0x3a>
        else if (c == '\n' || c == '\r') {
ffffffffc020296e:	01540463          	beq	s0,s5,ffffffffc0202976 <readline+0x8a>
ffffffffc0202972:	fb641ae3          	bne	s0,s6,ffffffffc0202926 <readline+0x3a>
            cputchar(c);
ffffffffc0202976:	8522                	mv	a0,s0
ffffffffc0202978:	f76fd0ef          	jal	ra,ffffffffc02000ee <cputchar>
            buf[i] = '\0';
ffffffffc020297c:	00004517          	auipc	a0,0x4
ffffffffc0202980:	74c50513          	addi	a0,a0,1868 # ffffffffc02070c8 <buf>
ffffffffc0202984:	94aa                	add	s1,s1,a0
ffffffffc0202986:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc020298a:	60a6                	ld	ra,72(sp)
ffffffffc020298c:	6406                	ld	s0,64(sp)
ffffffffc020298e:	74e2                	ld	s1,56(sp)
ffffffffc0202990:	7942                	ld	s2,48(sp)
ffffffffc0202992:	79a2                	ld	s3,40(sp)
ffffffffc0202994:	7a02                	ld	s4,32(sp)
ffffffffc0202996:	6ae2                	ld	s5,24(sp)
ffffffffc0202998:	6b42                	ld	s6,16(sp)
ffffffffc020299a:	6ba2                	ld	s7,8(sp)
ffffffffc020299c:	6161                	addi	sp,sp,80
ffffffffc020299e:	8082                	ret
            cputchar(c);
ffffffffc02029a0:	4521                	li	a0,8
ffffffffc02029a2:	f4cfd0ef          	jal	ra,ffffffffc02000ee <cputchar>
            i --;
ffffffffc02029a6:	34fd                	addiw	s1,s1,-1
ffffffffc02029a8:	bfbd                	j	ffffffffc0202926 <readline+0x3a>

ffffffffc02029aa <sbi_console_putchar>:
    );
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
ffffffffc02029aa:	00004797          	auipc	a5,0x4
ffffffffc02029ae:	65e78793          	addi	a5,a5,1630 # ffffffffc0207008 <SBI_CONSOLE_PUTCHAR>
    __asm__ volatile (
ffffffffc02029b2:	6398                	ld	a4,0(a5)
ffffffffc02029b4:	4781                	li	a5,0
ffffffffc02029b6:	88ba                	mv	a7,a4
ffffffffc02029b8:	852a                	mv	a0,a0
ffffffffc02029ba:	85be                	mv	a1,a5
ffffffffc02029bc:	863e                	mv	a2,a5
ffffffffc02029be:	00000073          	ecall
ffffffffc02029c2:	87aa                	mv	a5,a0
}
ffffffffc02029c4:	8082                	ret

ffffffffc02029c6 <sbi_set_timer>:

void sbi_set_timer(unsigned long long stime_value) {
    sbi_call(SBI_SET_TIMER, stime_value, 0, 0);
ffffffffc02029c6:	00005797          	auipc	a5,0x5
ffffffffc02029ca:	b5278793          	addi	a5,a5,-1198 # ffffffffc0207518 <SBI_SET_TIMER>
    __asm__ volatile (
ffffffffc02029ce:	6398                	ld	a4,0(a5)
ffffffffc02029d0:	4781                	li	a5,0
ffffffffc02029d2:	88ba                	mv	a7,a4
ffffffffc02029d4:	852a                	mv	a0,a0
ffffffffc02029d6:	85be                	mv	a1,a5
ffffffffc02029d8:	863e                	mv	a2,a5
ffffffffc02029da:	00000073          	ecall
ffffffffc02029de:	87aa                	mv	a5,a0
}
ffffffffc02029e0:	8082                	ret

ffffffffc02029e2 <sbi_console_getchar>:

int sbi_console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
ffffffffc02029e2:	00004797          	auipc	a5,0x4
ffffffffc02029e6:	61e78793          	addi	a5,a5,1566 # ffffffffc0207000 <SBI_CONSOLE_GETCHAR>
    __asm__ volatile (
ffffffffc02029ea:	639c                	ld	a5,0(a5)
ffffffffc02029ec:	4501                	li	a0,0
ffffffffc02029ee:	88be                	mv	a7,a5
ffffffffc02029f0:	852a                	mv	a0,a0
ffffffffc02029f2:	85aa                	mv	a1,a0
ffffffffc02029f4:	862a                	mv	a2,a0
ffffffffc02029f6:	00000073          	ecall
ffffffffc02029fa:	852a                	mv	a0,a0
ffffffffc02029fc:	2501                	sext.w	a0,a0
ffffffffc02029fe:	8082                	ret

ffffffffc0202a00 <strnlen>:
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
ffffffffc0202a00:	c185                	beqz	a1,ffffffffc0202a20 <strnlen+0x20>
ffffffffc0202a02:	00054783          	lbu	a5,0(a0)
ffffffffc0202a06:	cf89                	beqz	a5,ffffffffc0202a20 <strnlen+0x20>
    size_t cnt = 0;
ffffffffc0202a08:	4781                	li	a5,0
ffffffffc0202a0a:	a021                	j	ffffffffc0202a12 <strnlen+0x12>
    while (cnt < len && *s ++ != '\0') {
ffffffffc0202a0c:	00074703          	lbu	a4,0(a4)
ffffffffc0202a10:	c711                	beqz	a4,ffffffffc0202a1c <strnlen+0x1c>
        cnt ++;
ffffffffc0202a12:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0202a14:	00f50733          	add	a4,a0,a5
ffffffffc0202a18:	fef59ae3          	bne	a1,a5,ffffffffc0202a0c <strnlen+0xc>
    }
    return cnt;
}
ffffffffc0202a1c:	853e                	mv	a0,a5
ffffffffc0202a1e:	8082                	ret
    size_t cnt = 0;
ffffffffc0202a20:	4781                	li	a5,0
}
ffffffffc0202a22:	853e                	mv	a0,a5
ffffffffc0202a24:	8082                	ret

ffffffffc0202a26 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0202a26:	00054783          	lbu	a5,0(a0)
ffffffffc0202a2a:	0005c703          	lbu	a4,0(a1)
ffffffffc0202a2e:	cb91                	beqz	a5,ffffffffc0202a42 <strcmp+0x1c>
ffffffffc0202a30:	00e79c63          	bne	a5,a4,ffffffffc0202a48 <strcmp+0x22>
        s1 ++, s2 ++;
ffffffffc0202a34:	0505                	addi	a0,a0,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0202a36:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
ffffffffc0202a3a:	0585                	addi	a1,a1,1
ffffffffc0202a3c:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0202a40:	fbe5                	bnez	a5,ffffffffc0202a30 <strcmp+0xa>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0202a42:	4501                	li	a0,0
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0202a44:	9d19                	subw	a0,a0,a4
ffffffffc0202a46:	8082                	ret
ffffffffc0202a48:	0007851b          	sext.w	a0,a5
ffffffffc0202a4c:	9d19                	subw	a0,a0,a4
ffffffffc0202a4e:	8082                	ret

ffffffffc0202a50 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0202a50:	00054783          	lbu	a5,0(a0)
ffffffffc0202a54:	cb91                	beqz	a5,ffffffffc0202a68 <strchr+0x18>
        if (*s == c) {
ffffffffc0202a56:	00b79563          	bne	a5,a1,ffffffffc0202a60 <strchr+0x10>
ffffffffc0202a5a:	a809                	j	ffffffffc0202a6c <strchr+0x1c>
ffffffffc0202a5c:	00b78763          	beq	a5,a1,ffffffffc0202a6a <strchr+0x1a>
            return (char *)s;
        }
        s ++;
ffffffffc0202a60:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0202a62:	00054783          	lbu	a5,0(a0)
ffffffffc0202a66:	fbfd                	bnez	a5,ffffffffc0202a5c <strchr+0xc>
    }
    return NULL;
ffffffffc0202a68:	4501                	li	a0,0
}
ffffffffc0202a6a:	8082                	ret
ffffffffc0202a6c:	8082                	ret

ffffffffc0202a6e <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0202a6e:	ca01                	beqz	a2,ffffffffc0202a7e <memset+0x10>
ffffffffc0202a70:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0202a72:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0202a74:	0785                	addi	a5,a5,1
ffffffffc0202a76:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0202a7a:	fec79de3          	bne	a5,a2,ffffffffc0202a74 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0202a7e:	8082                	ret

ffffffffc0202a80 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0202a80:	ca19                	beqz	a2,ffffffffc0202a96 <memcpy+0x16>
ffffffffc0202a82:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc0202a84:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc0202a86:	0585                	addi	a1,a1,1
ffffffffc0202a88:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0202a8c:	0785                	addi	a5,a5,1
ffffffffc0202a8e:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc0202a92:	fec59ae3          	bne	a1,a2,ffffffffc0202a86 <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc0202a96:	8082                	ret
