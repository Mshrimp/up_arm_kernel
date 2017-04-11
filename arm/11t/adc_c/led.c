	
#include <gpio.h>

/*
 *    .section	.text
 *
 *
 *    @LED灯参数初始化GPM4_0 - GPM4_3为输出模式
 *    .align	2
 *    .global	led_config
 *led_config:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =LED_CON
 *    ldr r1, [r0]
 *    ldr r2, =0xFFFF
 *    bic r1, r1, r2
 *    ldr r3, =0x1111
 *    orr r1, r1, r3
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 */

void led_config(void)
{
	*(volatile unsigned int *)LED_CON &= ~(0xFFFF);
	*(volatile unsigned int *)LED_CON |= 0x1111;
}

/*
 *    .align	2
 *    .global	led_set
 *led_set:
 *    mov r2, r0
 *    ldr r0, =LED_DAT
 *    ldr r1, [r0]
 *    mvn	r3, #0
 *    and r3, r2
 *    orr r1, #0xF
 *    and r1, r3
 *    str r1, [r0]
 *    mov pc, lr
 */

void led_set(unsigned int val)
{
	*(volatile unsigned int *)LED_DAT |= 0xF;
	*(volatile unsigned int *)LED_DAT &= (val | 0xFFFFFFF0);
}

/*
 *    .align	2
 *    .global	led_get
 *led_get:
 *    ldr r1, =LED_DAT
 *    ldr r0, [r1]
 *    and r0, #0xF
 *    mov pc, lr
 */

unsigned int led_get(void)
{
	return *(volatile unsigned int *)LED_DAT &= 0xF; 
}

typedef enum {one, two, three, four} LED_NUM;

void led_on(LED_NUM num)
{
	*(volatile unsigned int *)LED_DAT &= ~(1<<num);
}

void led_off(LED_NUM num)
{
	*(volatile unsigned int *)LED_DAT |= (1<<num);
}



/*
 *    @LED1 - LED4全开
 *    .align	2
 *    .global	led_all_on
 *led_all_on:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =LED_DAT
 *    ldr r1, [r0]
 *    bic r1, r1, #0xF
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 */

void led_all_on(void)
{
	*(volatile unsigned int *)LED_DAT &= ~0xF;
}


/*
 *    @LED1 - LED4全关
 *    .align	2
 *    .global	led_all_off
 *led_all_off:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 */

void led_all_off(void)
{
	*(volatile unsigned int *)LED_DAT |= 0xF;
}


/*
 *    @LED1开
 *    .align	2
 *    .global	led1_on
 *led1_on:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    bic r1, r1, #0x1
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 *
 *
 *    @LED1关
 *    .align	2
 *    .global	led1_off
 *led1_off:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 *
 *
 *    @LED2开
 *    .align	2
 *    .global	led2_on
 *led2_on:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    bic r1, r1, #(1<<1)
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 *
 *
 *    @LED2关
 *    .align	2
 *    .global	led2_off
 *led2_off:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 *
 *
 *    @LED3开
 *    .align	2
 *    .global	led3_on
 *led3_on:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    bic r1, r1, #(1<<2)
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 *
 *
 *    @LED3关
 *    .align	2
 *    .global	led3_off
 *led3_off:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 *
 *
 *
 *    @LED4开
 *    .align	2
 *    .global	led4_on
 *led4_on:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    bic r1, r1, #(1<<3)
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 *
 *
 *    @LED4关
 *    .align	2
 *    .global	led4_off
 *led4_off:
 *    stmfd sp!, {lr}
 *
 *    ldr r0, =0x110002E4
 *    ldr r1, [r0]
 *    orr r1, r1, #0xF
 *    str r1, [r0]
 *
 *    ldmfd sp!, {pc}
 */


/*
 *    @打印输出
 *    .align	2
 *.LC0:
 *    .string	"Key check test!\n"
 *    .align	2
 *.LC1:
 *    .string	"Key1 down!\n"
 *    .align	2
 *.LC2:
 *    .string	"Key2 down!\n"
 *    .align	2
 *.LC3:
 *    .string	"Key3 down!\n"
 *    .align	2
 *.LC4:
 *    .string	"Key4 down!\n"
 *    .align	2
 */




