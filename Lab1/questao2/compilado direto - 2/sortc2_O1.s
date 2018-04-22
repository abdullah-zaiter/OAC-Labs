	.file	"sortc2.c"
	.option nopic
	.text
	.align	2
	.globl	show
	.type	show, @function
show:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	sw	s1,4(sp)
	sw	s2,0(sp)
	blez	a1,.L2
	mv	s0,a0
	slli	a1,a1,2
	add	s1,a0,a1
	lui	s2,%hi(.LC1)
.L3:
	lw	a1,0(s0)
	addi	a0,s2,%lo(.LC1)
	call	printf
	addi	s0,s0,4
	bne	s0,s1,.L3
.L2:
	li	a0,10
	call	putchar
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	lw	s2,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	show, .-show
	.align	2
	.globl	swap
	.type	swap, @function
swap:
	slli	a1,a1,2
	add	a5,a0,a1
	lw	a4,0(a5)
	addi	a1,a1,4
	add	a0,a0,a1
	lw	a3,0(a0)
	sw	a3,0(a5)
	sw	a4,0(a0)
	ret
	.size	swap, .-swap
	.align	2
	.globl	sort
	.type	sort, @function
sort:
	blez	a1,.L15
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	sw	s2,16(sp)
	sw	s3,12(sp)
	sw	s4,8(sp)
	sw	s5,4(sp)
	sw	s6,0(sp)
	mv	s2,a0
	mv	s4,a0
	addi	s6,a1,-1
	li	s5,0
	li	s3,-1
	j	.L9
.L10:
	addi	s5,s5,1
	addi	s4,s4,4
.L9:
	mv	s0,s5
	beq	s5,s6,.L18
	bltz	s0,.L10
	lw	a4,0(s4)
	lw	a5,4(s4)
	ble	a4,a5,.L10
	mv	s1,s4
.L11:
	mv	a1,s0
	mv	a0,s2
	call	swap
	addi	s0,s0,-1
	beq	s0,s3,.L10
	lw	a4,-4(s1)
	addi	s1,s1,-4
	lw	a5,4(s1)
	bgt	a4,a5,.L11
	j	.L10
.L18:
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	lw	s5,4(sp)
	lw	s6,0(sp)
	addi	sp,sp,32
	jr	ra
.L15:
	ret
	.size	sort, .-sort
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64
	sw	ra,60(sp)
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	lw	t3,0(a5)
	lw	t1,4(a5)
	lw	a7,8(a5)
	lw	a6,12(a5)
	lw	a0,16(a5)
	lw	a1,20(a5)
	lw	a2,24(a5)
	lw	a3,28(a5)
	lw	a4,32(a5)
	lw	a5,36(a5)
	sw	t3,8(sp)
	sw	t1,12(sp)
	sw	a7,16(sp)
	sw	a6,20(sp)
	sw	a0,24(sp)
	sw	a1,28(sp)
	sw	a2,32(sp)
	sw	a3,36(sp)
	sw	a4,40(sp)
	sw	a5,44(sp)
	li	a1,10
	addi	a0,sp,8
	call	show
	li	a1,10
	addi	a0,sp,8
	call	sort
	li	a1,10
	addi	a0,sp,8
	call	show
	lw	ra,60(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
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
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC1:
	.string	"%d\t"
	.ident	"GCC: (GNU) 7.2.0"
