.data
	const: 	.word 0xFF00FF00

.text
	li	t1, 10
	addi	t2, zero, 10
	beq	t1, t2, continua1
	jal	ra, ERRO
	continua1:	# Teste do OR
	li	t0, 0xFFFF0000
	li	t1, 0x0000FFFF
	li	t2, 0XFFFFFFFF
	or	t0, t0, t1
	beq	t0, t2, continua2
	jal	ra, ERRO
	continua2:	# Teste do LW
	la	t0, const
	lw	t1, 0(t0)
	li	t2, 0xFF00FF00
	beq	t1, t2, continua3
	jal	ra, ERRO
	continua3:	# Teste do SLLI
	li	t0, 2
	slli	t0, t0, 4
	li	t1, 32
	beq	t0, t1, continua4
	jal	ra, ERRO
	continua4:	# Teste do LB
	la	t0, const
	lb	t1, 1(t0)
	addi	t2, zero, -1
	beq	t1, t2, continua5
	jal	ra, ERRO
	continua5:	# Teste do SW
	addi	t0, zero, 10
	sw	t0, 0(sp)
	addi	t1, zero, 5
	lw	t1, 0(sp)
	beq	t0, t1, continua6
	jal	ra, ERRO
	continua6:	# Teste do BGEU
	addi	t0, zero, -4
	addi	t1, zero, 4
	bgeu	t0, t1, continua7
	jal	ra, ERRO
	continua7:	# Teste do SB
	addi	t0, zero, 10
	sb	t0, 0(sp)
	lb	t1, 0(sp)
	beq	t0, t1, continua8
	jal	ra, ERRO
	continua8:	# Teste do jalr
	jal	ra, temp
	temp:	addi	ra, ra, 12
	jr	ra
	jal	ra, ERRO
	continua9:	jal	zero, EXIT
	
ERRO:	addi	t0, ra, -8
	li	t0, 27
	
EXIT:


