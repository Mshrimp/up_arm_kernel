	
	.section	.text
	.align	2
	.global	_start
_start:
	stmfd sp!, {r4, r5, lr}

	@配置GPX3_2-GPM3_5为输入;
	ldr r0, =0x11000C60
	ldr r1, [r0]
	ldr r2, =0xFFFF00	@清除8-23位;
	bic	r1, r1, r2
	str r1, [r0]

	ldr r0, =0x11000C64
	ldr r1, [r0]
	lsr r1, #2
	and r4, r1, #0xf
1:
	ldr r0, =0x11000C64
	ldr r1, [r0]
	lsr r1, #2
	and r1, r1, #0xf
	cmp	r1, r4
	beq	1b

	mov r4, r1
	mov r5, r1

	tst r5, #1
	beq	key1_down
2:
	tst r5, #(1<<1)
	beq	key2_down
3:
	tst r5, #(1<<2)
	beq	key3_down
4:
	tst r5, #(1<<3)
	beq	key4_down
	b	out
key1_down:
	adr r0, .LC0
	mov lr, pc
	ldr pc, =0x43e11a2c
	b	2b

key2_down:
	adr r0, .LC1
	mov lr, pc
	ldr pc, =0x43e11a2c
	b	3b

key3_down:
	adr r0, .LC2		@add r0, pc, #?
	mov lr, pc
	ldr pc, =0x43e11a2c
	b	4b
key4_down:
	adr r0, .LC3		@add r0, pc, #?
	mov lr, pc
	ldr pc, =0x43e11a2c
	b	out
out:

	b	1b

	ldmfd sp!, {r4, r5, pc}
	.align	2
.LC0:
	.string "key1 down\n"
	.align	2
.LC1:
	.string "key2 down\n"
	.align	2
.LC2:
	.string "key3 down\n"
	.align	2
.LC3:
	.string "key4 down\n"
	.align	2


	




