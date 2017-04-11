
#include <config.h>

	.section	.rodata
	.align	2
.LC0:
	.string	"cpsr = %p\n"
	.align	2
.LC1:
	.string	"syscall num = %d\n"
	.align	2
.LC2:
	.string	"r14_abt = %p\n"


	.section	.text
	.align	2
	.global	vector_start
vector_start:
	nop				@0x0	0xffff0000
	b	undef		@0x4	0xffff0004
	b	swi			@0x8	0xffff0008
	b	pabort		@0xc	0xffff000c
	b	dabort		@0x10	0xffff0010
	nop				@0x14	0xffff0014
	b	irq			@0x18	0xffff0018
	b	firq		@0x1c	0xffff001c

undef:
	mov sp, #0x7f000000
	stmfd sp!, {r0-r12, lr}
	mrs r1, cpsr
	ldr r0, .L0	
	mov lr, pc
	ldr pc, .L0+4
	ldmfd sp!, {r0-r12, lr}
	movs pc, lr

swi:
	stmfd sp!, {r0-r12, lr}

	sub r1, lr, #4
	ldr r1, [r1]
	bic r1, r1, #0xff000000
	ldr r0, .L0+8
	mov lr, pc
	ldr pc, .L0+4

	mrs r1, cpsr
	ldr r0, .L0	
	mov lr, pc
	ldr pc, .L0+4
	ldmfd sp!, {r0-r12, lr}
	movs pc, lr

pabort:
	b	pabort

dabort:
	mov sp, #0x7f000000		@各种模式有自己的sp;
	stmfd sp!, {r0-r12, lr}	@r0-r12是各个模式公用的, 切换模式时保存;
	
	mov r1, lr
	ldr r0, .L0+12
	mov lr, pc
	ldr pc, .L0+4

	mrs r1, cpsr
	ldr r0, .L0	
	mov lr, pc
	ldr pc, .L0+4

	@ldr r0, .L0+16
	@ldr r0, [r0]
	@mov r1, #0xc0000000
	@mov r2, #0x70000000
	@mov lr, pc
	@ldr pc, .L0+20			@绝对跳转;	0xffff00xx -> 0x500000xx
	@bl	mmu_l1_mmap			@相对跳转;	+/-32M

	ldmfd sp!, {r0-r12, lr}
	@subs pc, lr, #8			@解决异常, 重新执行异常指令;
	subs pc, lr, #4			@跳过异常指令;

irq:
	b	irq

firq:
	b	firq

.L0:
	.word	.LC0
	.word	printf
	.word	.LC1
	.word	.LC2
	.word	ttb1
	.word	mmu_l1_mmap

	.align	2
	.global	vector_end
vector_end:
	nop


