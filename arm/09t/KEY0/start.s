	
@按键控制LED灯的亮灭
@按下KEY1 --> LED1亮
@松开KEY1 --> LED1灭
@按下KEY2 --> LED2亮
@松开KEY2 --> LED2灭
@按下KEY3 --> LED3亮
@松开KEY3 --> LED3灭
@按下KEY4 --> LED4亮
@松开KEY4 --> LED4灭


	.section	.text
	.align	2
	.global	_start
_start:
	stmfd sp!, {lr}

	adr r0, .LC0
	mov lr, pc
	ldr pc, =0xc3e11ad0

	bl	led_config
	bl	key_config
	bl	beep_config

	ldr r0, =0x11000C64
	ldr r1, [r0]
	lsr	r1, #2
	and r4, r1, #0xf

loop:
	bl	key_check

	b	loop

	ldmfd sp!, {pc}


	@按键参数初始化GPX3_2 - GPX3_5为输入模式
	.align	2
	.global	key_config
key_config:
	stmfd sp!, {lr}

	@配置GPX3_2 - GPX3_5为输入
	ldr r0, =0x11000C60
	ldr r1, [r0]
	ldr r2, =0xFFFF00		@清除8-23位，设置GPX3_2 - GPX3_5为输入模式
	bic r1, r1, r2
	str r1, [r0]

	ldmfd sp!, {pc}


	@检测按键按下
	.align	2
	.global	key_check
key_check:
	stmfd sp!, {r4, lr}

check_loop:
	ldr r0, =0x11000C64
	ldr r1, [r0]
	lsr	r1, #2
	and r1, r1, #0xf
	@cmp	r1, r4
	@beq	check_loop

	mov r4, r1

	tst r1, #1
	beq	key1_down

	tst r1, #(1<<1)
	beq	key2_down

	tst r1, #(1<<2)
	beq	key3_down

	tst r1, #(1<<3)
	beq	key4_down

	bl	no_key_down

	ldmfd sp!, {r4, pc}


	@无按键按下
	.align	2
	.global	no_key_down
no_key_down:
	stmfd sp!, {lr}

	bl	led_all_off
	bl	beep_off

	ldmfd sp!, {pc}


	@按键KEY1按下
	.align	2
	.global	key1_down
key1_down:
	stmfd sp!, {lr}

	adr r0, .LC1
	mov lr, pc
	ldr pc, =0xc3e11ad0

	bl	led1_on

	ldmfd sp!, {pc}


	@按键KEY2按下
	.align	2
	.global	key2_down
key2_down:
	stmfd sp!, {lr}

	adr r0, .LC2
	mov lr, pc
	ldr pc, =0xc3e11ad0
	
	bl	led2_on

	ldmfd sp!, {pc}


	@按键KEY3按下
	.align	2
	.global	key3_down
key3_down:
	stmfd sp!, {lr}

	adr r0, .LC3
	mov lr, pc
	ldr pc, =0xc3e11ad0

	bl	led3_on

	ldmfd sp!, {pc}


	@按键KEY4按下
	.align	2
	.global	key4_down
key4_down:
	stmfd sp!, {lr}

	adr r0, .LC4
	mov lr, pc
	ldr pc, =0xc3e11ad0

	bl	led4_on

	ldmfd sp!, {pc}


	@蜂鸣器参数初始化GPD0_0为输出模式
	.align	2
	.global	beep_config
beep_config:
	stmfd sp!, {lr}

	ldr r0, =0x114000A0
	ldr r1, [r0]
	ldr r2, =0xF
	bic r1, r1, r2
	orr	r1, r1, #0x1
	str r1, [r0]

	ldmfd sp!, {pc}


	@蜂鸣器开
	.align	2
	.global	beep_on
beep_on:
	stmfd sp!, {lr}

	ldr r0, =0x114000A4
	ldr r1, [r0]
	orr r1, r1, #0x1 
	str r1, [r0]

	ldmfd sp!, {pc}


	@蜂鸣器关
	.align	2
	.global	beep_off
beep_off:
	stmfd sp!, {lr}

	ldr r0, =0x114000A4
	ldr r1, [r0]
	bic r1, r1, #0x1 
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED灯参数初始化GPM4_0 - GPM4_3为输出模式
	.align	2
	.global	led_config
led_config:
	stmfd sp!, {lr}

	ldr r0, =0x110002E0
	ldr r1, [r0]
	ldr r2, =0xFFFF
	bic r1, r1, r2
	ldr r3, =0x1111
	orr r1, r1, r3
	str r1, [r0]

	ldmfd sp!, {pc}

	@LED1 - LED4全开
	.align	2
	.global	led_all_on
led_all_on:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xF
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED1 - LED4全关
	.align	2
	.global	led_all_off
led_all_off:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED1开
	.align	2
	.global	led1_on
led1_on:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	bic r1, r1, #0x1
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED1关
	.align	2
	.global	led1_off
led1_off:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED2开
	.align	2
	.global	led2_on
led2_on:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	bic r1, r1, #(1<<1)
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED2关
	.align	2
	.global	led2_off
led2_off:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED3开
	.align	2
	.global	led3_on
led3_on:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	bic r1, r1, #(1<<2)
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED3关
	.align	2
	.global	led3_off
led3_off:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	str r1, [r0]

	ldmfd sp!, {pc}



	@LED4开
	.align	2
	.global	led4_on
led4_on:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	bic r1, r1, #(1<<3)
	str r1, [r0]

	ldmfd sp!, {pc}


	@LED4关
	.align	2
	.global	led4_off
led4_off:
	stmfd sp!, {lr}

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	str r1, [r0]

	ldmfd sp!, {pc}


	@打印输出
	.align	2
.LC0:
	.string	"Key check test!\n"
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




