#include <config.h>
#include <board.h>
#include <string.h>

#define Struct_Section  __attribute__ ((unused,section (".mdata")))
int abc[4] Struct_Section = {0x11111111, 0x22222222, 0x33333333, 0x44444444};
int ar[1024] = {1,2,3,4};	//.data
int br[1024] = {};			//.bss系统加载内存时清空;
							//.bss裸板不会清空;
int count = 0;				//.bss很多; 

//extern void __bss_start(void);	//
//extern void __bss_end(void);		//
extern unsigned int __bss_start;	//&__bss_start;
extern unsigned int __bss_end;		//&__bss_end;

int main(void)				//.text
{
	int i;
/*
	int cr[100] = {};		//memset
	count = 0;
*/
	//memset(__bss_start, 0, __bss_end - __bss_start);	
	
	memset(&__bss_start, 0, (int)&__bss_end - (int)&__bss_start);

	((print_t)printf)("count = %p\n", count);

	for(i = 0; i < 10; i++)	//.rodata
		((print_t)printf)("ar[%d] = %d\n", i, ar[i]);

	for(i = 0; i < 4; i++)
		((print_t)printf)("abc[%d] = %p\n", i, abc[i]);
		
	for(i = 0; i < 10; i++)
		((print_t)printf)("br[%d] = %p\n", i, br[i]);

#if 0
	bell_config();
	while(1)
	{
		bell_on();
		delay(10000000);
	
		bell_off();
		delay(10000000);
	}
#endif
	return 0;
}	




