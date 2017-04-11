#include <config.h>
#include <board.h>
#include <string.h>

int main(void)
{
	u32 val = get_mode();
	printf("mode: %p\n", val & 0x1f);

	//set_mode(0x11);

	printf("mode: %p\n", get_mode() & 0x1f);
	return 0;
}	

