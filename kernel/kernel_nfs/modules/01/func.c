#include <linux/module.h>

int func_init(void)
//int init_module(void)
{
	printk("hello kernel\n");
	return 0;
}

void func_exit(void)
//void cleanup_module(void)
{
	printk("cleanup module\n");
}

module_init(func_init);
module_exit(func_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("xuwei www.uplooking.com");
MODULE_VERSION("1.0");

