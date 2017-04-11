	
#include <gpio.h>

/*
 *    .section	.text
 *
 *
 *    @蜂鸣器参数初始化GPD0_0为输出模式
 *    .align	2
 *    .global	beep_config
 *beep_config:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =BEEP_CON
 *    ldr r1, [r0]
 *    ldr r2, =0xF
 *    bic r1, r1, r2
 *    orr	r1, r1, #0x1
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 */

void beep_config(void)
{
	*(volatile unsigned int *)BEEP_CON &= ~0xF;
	*(volatile unsigned int *)BEEP_CON |= 0x1;
}

/*
 *    @蜂鸣器开
 *    .align	2
 *    .global	beep_on
 *beep_on:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =BEEP_DAT
 *    ldr r1, [r0]
 *    orr r1, r1, #0x1 
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 */

void beep_on(void)
{
	*(volatile unsigned int *)BEEP_DAT |= 0x1;
}

/*
 *    @蜂鸣器关
 *    .align	2
 *    .global	beep_off
 *beep_off:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =BEEP_DAT
 *    ldr r1, [r0]
 *    bic r1, r1, #0x1 
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 */

void beep_off(void)
{
	*(volatile unsigned int *)BEEP_DAT &= ~0x1;
}




