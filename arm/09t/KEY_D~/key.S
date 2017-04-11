	
#include <gpio.h>

	.section	.text

	@按键参数初始化GPX3_2 - GPX3_5为输入模式
	.align	2
	.global	key_config
key_config:
	stmfd sp!, {lr}

	@配置GPX3_2 - GPX3_5为输入
	ldr r0, =KEY_CON
	ldr r1, [r0]
	ldr r2, =0xFFFF00		@清除8-23位，设置GPX3_2 - GPX3_5为输入模式
	bic r1, r1, r2
	str r1, [r0]

	ldmfd sp!, {pc}


	@获取键值
	.align	2
	.global	key_get
key_get:
	ldr r0, =KEY_DAT
	ldr r1, [r0]
	lsr r1, #2
	and r0, r1, #0xF
	mov pc, lr


	@检测按键按下
	.align	2
	.global	key_check
key_check:
	stmfd sp!, {r4, lr}

check_loop:
	ldr r0, =KEY_DAT
	ldr r1, [r0]
	lsr	r1, #2
	and r1, r1, #0xf
	@cmp	r1, r4
	@beq	check_loop

	mov r4, r1
key1:
	tst r1, #1
	beq	key1_down_bak
key2:
	tst r1, #(1<<1)
	beq	key2_down_bak
key3:
	tst r1, #(1<<2)
	beq	key3_down_bak
key4:
	tst r1, #(1<<3)
	beq	key4_down_bak

	bl	no_key_down_bak

	ldmfd sp!, {r4, pc}


	@无按键按下
	.align	2
	.global	no_key_down_bak
no_key_down_bak:
	stmfd sp!, {lr}

	bl	led_all_off
	bl	beep_off

	ldmfd sp!, {pc}


	@按键KEY1按下
	.align	2
	.global	key1_down_bak
key1_down_bak:
	stmfd sp!, {lr}

	adr r0, .LC1
	mov lr, pc
	ldr pc, =0xc3e11ad0

	bl	led1_on
	b	key2
	ldmfd sp!, {pc}


	@按键KEY2按下
	.align	2
	.global	key2_down_bak
key2_down_bak:
	stmfd sp!, {lr}

	adr r0, .LC2
	mov lr, pc
	ldr pc, =0xc3e11ad0
	
	bl	led2_on
	b	key3

	ldmfd sp!, {pc}


	@按键KEY3按下
	.align	2
	.global	key3_down_bak
key3_down_bak:
	stmfd sp!, {lr}

	adr r0, .LC3
	mov lr, pc
	ldr pc, =0xc3e11ad0

	bl	led3_on
	b	key4

	ldmfd sp!, {pc}


	@按键KEY4按下
	.align	2
	.global	key4_down_bak
key4_down_bak:
	stmfd sp!, {lr}

	adr r0, .LC4
	mov lr, pc
	ldr pc, =0xc3e11ad0

	bl	led4_on

	ldmfd sp!, {pc}



	@打印输出
	.align	2
.LC1:
	.string	"Key1 down!\n"
	.align	2
.LC2:
	.string	"Key2 down!\n"
	.align	2
.LC3:
	.string	"Key3 down!\n"
	.align	2
.LC4:
	.string	"Key4 down!\n"
	.align	2




