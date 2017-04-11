
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


/*
	.section	.text
	.align	2
	.global	vector_start
vector_start:
	nop					@0x0	0xffff0000
	ldr	pc, _undef		@0x4	0xffff0004
	ldr pc, _swi		@0x8	0xffff0008
	ldr pc,	_pabort		@0xc	0xffff000c
	ldr pc, _dabort		@0x10	0xffff0010
	nop					@0x14	0xffff0014
	ldr pc, _irq		@0x18	0xffff0018
	ldr pc, _firq		@0x1c	0xffff001c

_undef:
	.word	undef
_swi:
	.word	swi
_pabort:
	.word	pabort
_dabort:
	.word	dabort
_irq:
	.word	irq
_firq:
	.word	firq

	.align	2
	.global	vector_end
vector_end:
	nop
*/

	.section	.text
	.align	2
	.global	undef
undef:
	mov sp, #0x7f000000
	stmfd sp!, {r0-r12, lr}

	@sub r0, lr, #4
	@ldr r4, [r0]

	mrs r1, cpsr
	ldr r0, =.LC0
	mov lr, pc
	ldr pc, =printf
	
	@mov r0, r4
	@bl	do_undef

	ldmfd sp!, {r0-r12, pc}^
	@movs pc, lr

	.global	swi
swi:
	stmfd sp!, {r0-r12, lr}

	sub r1, lr, #4
	ldr r1, [r1]
	bic r1, r1, #0xff000000
	mov r4, r1
	ldr r0, =.LC1
	mov lr, pc
	ldr pc, =printf


	mrs r1, cpsr
	ldr r0, =.LC0
	mov lr, pc
	ldr pc, =printf

	mov r0, r4
	bl	do_swi

	ldmfd sp!, {r0-r12, pc}^
	@movs pc, lr

	.global	pabort
pabort:
	mov sp, #0x7f000000		@各种模式有自己的sp;
	stmfd sp!, {r0-r12, lr}
	
	mov r1, lr
	ldr r0, =.LC2
	mov lr, pc
	ldr pc, =printf

	mrs r1, cpsr
	ldr r0, =.LC0	
	mov lr, pc
	ldr pc, =printf

	ldmfd sp!, {r0-r12, pc}^

	.global	dabort
dabort:
	mov sp, #0x7f000000		@各种模式有自己的sp;
	stmfd sp!, {r0-r12, lr}	@r0-r12是各个模式公用的, 切换模式时保存;
	
	mov r1, lr
	ldr r0, =.LC2
	mov lr, pc
	ldr pc, =printf

	mrs r1, cpsr
	ldr r0, =.LC0	
	mov lr, pc
	ldr pc, =printf

	ldmfd sp!, {r0-r12, lr}
	subs pc, lr, #4			@跳过异常指令;

	.global	 irq
irq:
	mov sp, #0x7f000000
	stmfd sp!, {r0-r12, lr}
	/*
	mrs r1, cpsr
	ldr r0, =.LC0	
	mov lr, pc
	ldr pc, =printf
	*/

	bl	do_irq

	ldmfd sp!, {r0-r12, lr}
	subs pc, lr, #4

	.global	firq
firq:
	mov sp, #0x7f000000
	stmfd sp!, {lr}
	mrs r1, cpsr
	ldr r0, =.LC0	
	mov lr, pc
	ldr pc, =printf

	bl	do_firq
		
	ldmfd sp!, {lr}
	subs pc, lr, #4



