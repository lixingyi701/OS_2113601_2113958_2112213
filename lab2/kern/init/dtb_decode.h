
#ifndef __DECODE_DTB_H__
#define __DECODE_DTB_H__


#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <defs.h>

typedef struct {
    uint32_t magic;
    uint32_t totalsize;
    uint32_t off_dt_struct;
    uint32_t off_dt_strings;
    uint32_t off_mem_rsvmap;
    uint32_t version;
    uint32_t last_comp_version;
    uint32_t boot_cpuid_phys;
    uint32_t size_dt_strings;
    uint32_t size_dt_struct;
} fdt_header_t;

typedef struct {
    uint64_t address;
    uint64_t size;
} fdt_reserve_entry_t;


typedef struct {
    uint32_t len;
    uint32_t nameoff;
} fdt_prop_data_t;

#define FDT_MAGIC           0xedfe0dd0
#define FDT_BEGIN_NODE      0x01000000
#define FDT_END_NODE        0x02000000
#define FDT_PROP            0x03000000
#define FDT_NOP             0x04000000
#define FDT_END             0x09000000

void select_dtb(fdt_header_t* fdt_header);




uint32_t my_bswap32(uint32_t x) {
    return ((x & 0xFF000000) >> 24) |
           ((x & 0x00FF0000) >> 8)  |
           ((x & 0x0000FF00) << 8)  |
           ((x & 0x000000FF) << 24);
}

void select_dtb(fdt_header_t* fdt_header){
    assert(fdt_header->magic == FDT_MAGIC);
    //end address
    uint64_t fdt_end_addr =
        (uint64_t)fdt_header + my_bswap32(fdt_header->totalsize);
    //structure block address
    uint64_t structure_block_addr =
        (uint64_t)fdt_header + my_bswap32(fdt_header->off_dt_struct);
    //string block address
    uint64_t strings_block_addr =
        (uint64_t)fdt_header + my_bswap32(fdt_header->off_dt_strings);




    uint32_t* p = (uint32_t*)structure_block_addr;
    bool in_memory_node = 0; 

    for (;;) {//unlimited loop
        uint32_t marker = *p;

        switch (marker) {
            case FDT_NOP: {// if meet nop ,just move on
                p++;
                break;
            }
            case FDT_BEGIN_NODE: {
                p++;
                // 检查是否进入memory节点
                if (strcmp((char*)p, "memory@80000000") == 0) {
                    in_memory_node = 1;
                }
                if (in_memory_node) {
                    cprintf("%s {\n", (char*)p);
                }
                p += strlen((char*)p) / sizeof(uint32_t) + 1;//将指针 p 向前移动相应的距离，跳过节点的名字。
                break;
            }
            case FDT_END_NODE: {
                if (in_memory_node) {
                    cprintf("}\n\n\n");
                    in_memory_node = 0; 
                }
                p++;
                break;
            }
            case FDT_PROP: { //当标志位是FDT_PROP，表示当前是一个节点属性
                p++; //移动到下一个四字节数据，通常为属性的长度或名称
                if (in_memory_node) { 
                    fdt_prop_data_t* prop_data = (fdt_prop_data_t*)p; //将当前指针转化为fdt_prop_data_t类型，获取属性数据
                    p += sizeof(fdt_prop_data_t) / sizeof(uint32_t); //移动指针，跳过属性的数据头
                    //通过偏移量获取属性的名称，并打印出来
                    cprintf("%s: ", (char*)(strings_block_addr + my_bswap32(prop_data->nameoff)));
                    uint8_t* prop_value = (uint8_t*)p; //获取属性的值的指针
                    //遍历属性的值，按照字节打印其16进制表示
                    for (size_t i = 0; i < my_bswap32(prop_data->len); i++) {
                        uint8_t c = prop_value[i];
                        cprintf("%02x", c);
                        if (i % 4 == 3) cprintf(" "); //每四个字节，输出一个空格，使得打印结果更加整齐
                    }
                    //找到下一个四字节对齐的地址。
                    p += (my_bswap32(prop_data->len) + 3) / sizeof(uint32_t); 
                    cprintf("\n");
                } else {
                    //如果当前不在"memory@80000000"节点内部，跳过这个属性，不进行处理
                    fdt_prop_data_t* prop_data = (fdt_prop_data_t*)p; //获取属性数据
                    p += sizeof(fdt_prop_data_t) / sizeof(uint32_t) + (my_bswap32(prop_data->len) + 3) / sizeof(uint32_t);
                }
                break;
            }
            case FDT_END: {
                return;
            }
            default: {
                cprintf("unknown marker: 0x%08x\n", marker);
                assert(0);
                return;
            }
        }
        if ((uint64_t)p >= fdt_end_addr) return;
    }
}



#endif