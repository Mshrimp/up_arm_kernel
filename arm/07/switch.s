	.cpu arm1176jzf-s
	.eabi_attribute 27, 3
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"switch.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"i = %d\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r3, #10
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #5
	cmp	r3, #14
	ldrls	pc, [pc, r3, asl #2]
	b	.L2
.L11:
	.word	.L3
	.word	.L4
	.word	.L2
	.word	.L5
	.word	.L6
	.word	.L7
	.word	.L2
	.word	.L2
	.word	.L8
	.word	.L9
	.word	.L2
	.word	.L2
	.word	.L2
	.word	.L2
	.word	.L10
.L3:
	ldr	r3, .L12
	mov	r0, r3
	ldr	r1, [fp, #-8]
	bl	printf
	b	.L2
.L4:
	ldr	r3, .L12
	mov	r0, r3
	ldr	r1, [fp, #-8]
	bl	printf
	b	.L2
.L5:
	ldr	r3, .L12
	mov	r0, r3
	ldr	r1, [fp, #-8]
	bl	printf
	b	.L2
.L9:
	ldr	r3, .L12
	mov	r0, r3
	ldr	r1, [fp, #-8]
	bl	printf
	b	.L2
.L6:
	ldr	r3, .L12
	mov	r0, r3
	ldr	r1, [fp, #-8]
	bl	printf
	b	.L2
.L8:
	ldr	r3, .L12
	mov	r0, r3
	ldr	r1, [fp, #-8]
	bl	printf
	b	.L2
.L7:
	ldr	r3, .L12
	mov	r0, r3
	ldr	r1, [fp, #-8]
	bl	printf
	b	.L2
.L10:
	ldr	r3, .L12
	mov	r0, r3
	ldr	r1, [fp, #-8]
	bl	printf
	mov	r0, r0	@ nop
.L2:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L13:
	.align	2
.L12:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (ctng-1.8.1-FA) 4.5.1"
	.section	.note.GNU-stack,"",%progbits
