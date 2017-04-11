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
	.file	"7.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"sum = %d\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #32
	mov	r3, #0
	str	r3, [fp, #-16]
	mov	r3, #1
	str	r3, [fp, #-20]
	mov	r3, #2
	str	r3, [fp, #-24]
	mov	r3, #3
	str	r3, [fp, #-28]
	mov	r3, #4
	str	r3, [fp, #-32]
	mov	r3, #5
	str	r3, [fp, #-36]
	mov	r3, #6
	str	r3, [fp, #-40]
	mov	r3, #7
	str	r3, [fp, #-44]


	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-24]
	ldr	r1, [fp, #-28]
	ldr	r0, [fp, #-32]
	ldr	ip, [fp, #-36]
	ldr	lr, [fp, #-40]
	ldr	r5, [fp, #-44]
#APP
@ 13 "7.c" 1
	add r4, r3
	add r4, r2
	add r4, r1
	add r4, r0
	add r4, ip
	add r4, lr
	add r4, r5
	
@ 0 "" 2
	str	r4, [fp, #-16]



	ldr	r3, .L2
	mov	r0, r3
	ldr	r1, [fp, #-16]
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp!, {r4, r5, fp, pc}
.L3:
	.align	2
.L2:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (ctng-1.8.1-FA) 4.5.1"
	.section	.note.GNU-stack,"",%progbits
