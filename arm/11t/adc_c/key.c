	
#include <gpio.h>

/*
 *    .section	.text
 *
 *    @按键参数初始化GPX3_2 - GPX3_5为输入模式
 *    .align	2
 *    .global	key_config
 *key_config:
 *    stmfd sp!, {lr}
 *
 *    @配置GPX3_2 - GPX3_5为输入
 *    ldr r0, =KEY_CON
 *    ldr r1, [r0]
 *    ldr r2, =0xFFFF00		@清除8-23位，设置GPX3_2 - GPX3_5为输入模式
 *    bic r1, r1, r2
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 */

void key_config(void)
{
	*(volatile unsigned int *)KEY_CON &= ~(0xFFFF00);
}


/*
 *    @获取键值
 *    .align	2
 *    .global	key_get
 *key_get:
 *    ldr r0, =KEY_DAT
 *    ldr r1, [r0]
 *    lsr r1, #2
 *    and r0, r1, #0xF
 *    mov pc, lr
 */

unsigned int key_get(void)
{
	return (*(volatile unsigned int *)KEY_DAT >> 2) & 0xF;
}

