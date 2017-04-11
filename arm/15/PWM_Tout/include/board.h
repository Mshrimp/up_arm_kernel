#ifndef	__BOARD_H__
#define __BOARD_H__

typedef int (*print_t)(const char *, ...);
typedef void (*delay_t)(unsigned int);

typedef unsigned int u32;
typedef unsigned short u16;
typedef unsigned char u8;
typedef volatile u32 v32;
typedef volatile u16 v16;
typedef volatile u8	v8;

#define	set_one(reg, bit)	\
			*(v32 *)reg	|= (1<<bit)

#define set_zero(reg, bit)	\
			*(v32 *)reg &= ~(1<<bit)

#define set_bit(reg, bit, val)	\
			*(v32 *)reg = ((*(v32 *)reg &~(1<<bit)) | (val<<bit))

#define set_2bit(reg, bit, val)	\
			*(v32 *)reg = ((*(v32 *)reg &~(3<<bit)) | ((val&0x3)<<bit))

#define set_nbit(reg, bit, n, val)	\
			*(v32 *)reg = ((*(v32 *)reg &~(((1<<n)-1)<<bit)) | ((val&((1<<n)-1))<<bit))

#define set_val(reg, val)	\
			*(v32 *)reg = (val)

#define get_val(reg)	\
			*(v32 *)reg
#define get_bit(reg, bit)	\
			((*(v32 *)reg & (1<<bit)) >> bit)
#define get_2bit(reg, bit)	\
			((*(v32 *)reg & (3<<bit)) >> bit)
#define get_nbit(reg, bit, n)	\
			((*(v32 *)reg & ( ((1<<n)-1) <<bit)) >> bit)

#define Struct_Section  __attribute__ ((unused,section (".mdata")))

#undef	printf
#define printf	((void (*)(const char *, ...))0xc3e11ad0)

#undef	udelay	
#define udelay	((void (*)(unsigned int))0xc3e26588)



#endif
