# Teste para verificacao da simulacao por forma de onda e na DE1-SoC
.data
	WORD: .word 0xB0DEB0B0, 0xF0CAF0FA, 0x00400058
.text
	lui $t0,0x1001
	ori $t0,$t0,0x0000	# combinação lui+ori para carregar $t0 <- 0x10010000
	add $t1,$zero,$t0	# $t1 <- 0x10010000
	lw $t0,0($t1)		# $t0 <- 0xB0DEB0B0
	addi $t0,$t0,1		# $t0 <- 0xB0DEB0B1
	beq $t0,$zero,PULA	# não pula, pois $t0!=0x00
	addi $t0,$t0,1		# $t0 <- 0xB0DEB0B2
	addi $t0,$t0,1		# $t0 <- 0xB0DEB0B3
PULA:	lw $t2,0($t1)		# $t2 <- 0xB0DEB0B0
	bne $t0,$t2,PULA2	# Pula pois $t0!=$t2
	addi $t0,$t1,-1
	addi $t0,$t0,-1
PULA2:  addi $t0,$t0,1		# $t0 <- 0xB0DEB0B4
	jal PROC		# jump and link PROC
	lw $t2,8($t1)		# $t2 <- 0x00400058
	jr $t2			# jump register $t2, pula para PROC1
VOLTA:	addi $t0,$t0,1		# $t0 <- 0xADC6AC87	(Valor final de $t0 se execução for correta)
	j FIM1
	addi $t0,$t0,-1
	addi $t0,$t0,-1
PROC:	jr $ra			# jump register $ra, pula para a instrução "lw $t2, 8($t1)"
	addi $t0,$t0,-1
PROC1:	lw $t1,4($t1)		# $t1 <- 0xF0CAF0FA
	div $t0,$t1		
	mfhi $t1		# $t1 <- ($t0)%($t1)
	add $t0,$t0,$t1		# $t0 <- 0xADC6AC86
	j VOLTA
	addi $t0,$t0,-1
FIM1: 	j FIM1			# fica preso neste loop
	addi $t0,$t0,-1
