
#include <xbook/debug.h>
#include <arch/memory.h>
#include <xbook/kernel.h>

// ARDS信息地址，loader中读取通过BIOS读取信息放到该内存中
#define ARDS_NR_ADDR    (KERN_BASE_VIR_ADDR + 0x000001000)
#define ARDS_START_ADDR (KERN_BASE_VIR_ADDR + 0x00001004)
#ifdef GRUB2
#define GRUB2_READ_MEMORY_BYTES_ADDR (KERN_BASE_VIR_ADDR + 0x000001000)
#endif /* GRUB2 */

#define ARDS_MAX_NR 12 //最大有12个ards结构

struct ards_struct {
	unsigned int base_low;       //基址低32位
	unsigned int base_high;
	unsigned int length_low;     //长度低32位
	unsigned int length_high;
	unsigned int type;          //该结构的类型(1可以被系统使用)
};

unsigned int phy_mem_get_size_from_hardware()
{
	unsigned int totalSize = 0;

#ifdef GRUB2
	totalSize = *((unsigned int *) GRUB2_READ_MEMORY_BYTES_ADDR);
#else
	unsigned int ards_num =  *((unsigned int *) ARDS_NR_ADDR);

	if (ards_num > ARDS_MAX_NR) {
		ards_num = ARDS_MAX_NR;
	}
	struct ards_struct *ards = (struct ards_struct *) (ARDS_START_ADDR);
	int i;
	for(i = 0; i < ards_num; i++){
		if(ards->type == 1){
			if(ards->base_low+ards->length_low > totalSize){
				totalSize = ards->base_low+ards->length_low;
			}
		}
		keprint(PRINT_DEBUG "phymem: ards: base %8x length %8x type:%d\n",ards->base_low, ards->length_low, ards->type);
		ards++;
	}
#endif /* GRUB2 */
	keprint(PRINT_INFO "phymem: memory size total:%x byte, %d MB\n", totalSize, totalSize / (1024*1024));
	return totalSize;
}
