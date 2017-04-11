#include <config.h>

typedef int (*func_t)(const char *, ...);

int main(void)
{
	int ret;
	int tmp;
	led_config();
	key_config();

	//__udelay(1000000);
	//((func_t)printf)("&ret = %p\n", &ret);

	ret = key_get();
	while(1)
	{
		if((tmp = key_get()) == ret)
			continue;

		ret = tmp;
		if((tmp & 1) == 0)
		{
			led_set(led_get() ^ 1);
		}
		if((tmp & 1<<1) == 0)
		{
			led_set(led_get() ^ (1<<1));
		}
		if((tmp & 1<<2) == 0)
		{
			led_set(led_get() ^ (1<<2));
		}
		if((tmp & 1<<3) == 0)
		{
			led_set(led_get() ^ (1<<3));
		}
		delay(0x20000);
	}

	return 0;
}	




