	
	.section	.text
	.align	2
	.global	_start
_start:
	stmfd sp!, {lr}

	adr r0, .LC0
	mov lr, pc
	ldr r0, =0xc3e11ad0

	bl	key_config

loop:
	bl	key_check

	b	loop

	ldmfd sp!, {pc}


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


	.align	2
	.global	key_check
key_check:
	stmfd sp!, {lr}

	ldr r0, =0x11000C64
	ldr r1, [r0]
	lsr	r1, #2
	and r1, r1, #0xf

	tst r1, #0x1

	beq	key1_down

	ldmfd sp!, {pc}


	.align	2
	.global	key1_down
key1_down:
	stmfd sp!, {lr}

	adr r0, .LC1
	mov lr, pc
	ldr r0, =0xc3e11ad0

	ldmfd sp!, {pc}


	.align	2
.LC0:
	.string	"Key check test!\n"

	.align	2
.LC1:
	.string	"Key1 down!\n"
	.align	2




