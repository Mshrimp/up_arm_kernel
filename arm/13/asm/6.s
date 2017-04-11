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
	.file	"6.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"sum = %d\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #12
	mov	r3, #10
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
#APP
@ 6 "6.c" 1
	add r4, r3, #1
	
@ 0 "" 2
	str	r4, [fp, #-16]
	ldr	r3, .L2
	mov	r0, r3
	ldr	r1, [fp, #-16]
	bl	printf
	ldr	r3, [fp, #-16]
	mov	r4, r3
#APP
@ 12 "6.c" 1
	add r4, r4, #1
	
@ 0 "" 2
	str	r4, [fp, #-16]
	ldr	r3, .L2
	mov	r0, r3
	ldr	r1, [fp, #-16]
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, pc}
.L3:
	.align	2
.L2:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (ctng-1.8.1-FA) 4.5.1"
	.section	.note.GNU-stack,"",%progbits
