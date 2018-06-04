.text
	li	t0, 10
	li	t1, 7
	li	t2, 70
	mul	t3, t0, t1
	beq	t3, t2, pulo1		########### Bloco de teste de instruções do módulo MUL/DIV ###########
	jal	ra, ERRO
	pulo1:	div	t3, t0, t1
		li	t2, 1
		beq	t2, t3, pulo2
		jal	ra, ERRO
	pulo2:	rem	t3, t0, t1
		li	t2, 3
		beq	t2, t3, pulo3
		jal	ra, ERRO
	pulo3:	