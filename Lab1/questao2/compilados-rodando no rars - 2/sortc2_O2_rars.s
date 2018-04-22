	.file	"sortc2.c"
	.option nopic
	.text
#	.align	2
	.globl	show
#	.type	show, @function
printf: li a7,1
	mv a0,a1
	ecall
	li a7,11
	li a0,9
	ecall
	ret
	
putchar: li a7,11
	ecall
	ret
	
show:
	blez	a1,.L6
	addi	sp,sp,-16
	sw	s1,4(sp)
	slli	s1,a1,2
	sw	s0,8(sp)
	sw	s2,0(sp)
	sw	ra,12(sp)
	mv	s0,a0
	add	s1,a0,s1
	lui	s2,%hi(.LC1)
.L3:
	lw	a1,0(s0)
	addi	a0,s2,%lo(.LC1)
	addi	s0,s0,4
	call	printf
	bne	s1,s0,.L3
	lw	s0,8(sp)
	lw	ra,12(sp)
	lw	s1,4(sp)
	lw	s2,0(sp)
	li	a0,10
	addi	sp,sp,16
	tail	putchar
.L6:
	li	a0,10
	tail	putchar
	.size	show, .-show
#	.align	2
	.globl	swap
#	.type	swap, @function
swap:
	slli	a1,a1,2
	addi	a5,a1,4
	add	a5,a0,a5
	lw	a3,0(a5)
	add	a0,a0,a1
	lw	a4,0(a0)
	sw	a3,0(a0)
	sw	a4,0(a5)
	ret
	.size	swap, .-swap
#	.align	2
	.globl	sort
#	.type	sort, @function
sort:
	blez	a1,.L11
	li	a7,0
	addi	t3,a1,-1
	li	a6,-1
	mv	a4,a7
	beq	a7,t3,.L11
.L16:
	lw	a3,0(a0)
	lw	a2,4(a0)
	addi	t1,a0,4
	mv	a1,t1
	mv	a5,a0
	bgt	a3,a2,.L15
	j	.L14
.L20:
	lw	a3,-4(a5)
	lw	a2,0(a5)
	addi	a0,a0,-4
	addi	a5,a5,-4
	addi	a1,a1,-4
	ble	a3,a2,.L14
.L15:
	sw	a2,0(a0)
	sw	a3,0(a1)
	addi	a4,a4,-1
	bne	a4,a6,.L20
.L14:
	addi	a7,a7,1
	mv	a0,t1
	mv	a4,a7
	bne	a7,t3,.L16
.L11:
	ret
	.size	sort, .-sort
	.section	.text.startup,"ax",progbits
#	.align	2
	.globl	main
#	.type	main, @function
main:
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	lw	t5,0(a5)
	lw	t4,4(a5)
	lw	t3,8(a5)
	lw	t1,12(a5)
	lw	a7,16(a5)
	lw	a6,20(a5)
	lw	a2,24(a5)
	lw	a3,28(a5)
	lw	a4,32(a5)
	lw	a5,36(a5)
	addi	sp,sp,-64
	addi	a0,sp,8
	li	a1,10
	sw	ra,60(sp)
	sw	t5,8(sp)
	sw	t4,12(sp)
	sw	t3,16(sp)
	sw	t1,20(sp)
	sw	a7,24(sp)
	sw	a6,28(sp)
	sw	a2,32(sp)
	sw	a3,36(sp)
	sw	a4,40(sp)
	sw	a5,44(sp)
	call	show
	addi	a0,sp,8
	li	a1,10
	call	sort
	addi	a0,sp,8
	li	a1,10
	call	show
	lw	ra,60(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.section	.rodata
#	.align	2
	.set	.LANCHOR0,. + 0
.data
.LC0:
	.word	5
	.word	8
	.word	3
	.word	4
	.word	7
	.word	6
	.word	8
	.word	0
	.word	1
	.word	9
	.section	.rodata.str1.4,"aMS",progbits,1
	.align	2
.LC1:
	.string	"%d\t"
	.ident	"GCC: (GNU) 7.2.0"
