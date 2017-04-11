	
//按键控制LED灯的亮灭
//按下KEY1 --> LED1亮
//按下KEY1 --> LED1灭
//按下KEY2 --> LED2亮
//按下KEY2 --> LED2灭
//按下KEY3 --> LED3亮
//按下KEY3 --> LED3灭
//按下KEY4 --> LED4亮
//按下KEY4 --> LED4灭
//多个LED灯可以同时亮


#include <gpio.h>
#include <config.h>

typedef int (*func_t)(const char *, ...);

int main(void)
{
	int ret;
	int tmp;

	/*adr r0, .LC0*/
	/*mov lr, pc*/
	/*ldr pc, =ubtprintf*/
	//((func_t)ubtprintf)("Key_led test!\n");
	
	/*bl	led_config*/
	/*bl	key_config*/
	/*bl	beep_config*/
	led_config();
	key_config();
	beep_config();

	//bl	key_get
	tmp = key_get();

	//mov r4, r0

//check_loop:
	while (1)
	{
		/*bl	key_get*/
		/*cmp r0, r4*/
		/*beq check_loop*/
		if((ret = key_get()) == tmp)
			continue;

		//mov r4, r0
		//mov r5, r0
		tmp = ret;

	//key1:
		/*tst r5, #1*/
		/*beq key1_down*/
		if ((tmp & 1) == 0)
		{
			led_set(led_get() ^ 1);	
		}

	/*key2:*/
		/*tst r5, #(1<<1)*/
		/*beq key2_down*/
		if ((tmp & (1<<1)) == 0)
		{
			led_set(led_get() ^ (1<<1));	
		}

	/*key3:*/
		/*tst r5, #(1<<2)*/
		/*beq key3_down*/
		if ((tmp & (1<<2)) == 0)
		{
			led_set(led_get() ^ (1<<2));	
		}

	/*key4:*/
		/*tst r5, #(1<<3)*/
		/*beq key4_down*/
		if ((tmp & (1<<3)) == 0)
		{
			led_set(led_get() ^ (1<<3));	
		}

	//b	check_loop
	}

/*
 *key1_down:
 *    bl	led_get
 *    eor r0, #1
 *    bl	led_set
 *
 *    b	key2
 *
 *key2_down:
 *    bl	led_get
 *    eor r0, #(1<<1)
 *    bl	led_set
 *
 *    b	key3
 *
 *key3_down:
 *    bl	led_get
 *    eor r0, #(1<<2)
 *    bl	led_set
 *
 *    b	key4
 *
 *key4_down:
 *    bl	led_get
 *    eor r0, #(1<<3)
 *    bl	led_set
 *
 *    b	check_loop	
 */

	return 0;
}



/*
 *    .align	2
 *.LC0:
 *    .string	"Key test!\n"
 *    .align	2
 */


