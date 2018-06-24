# Teste para verificacao da simulacao por forma de onda e na DE1-SoC
.data
	WORD: .word 0xB0DEB0B0, 0xF0CAF0FA, 0x00400068 #0x00400074 
.text
	lui $t0,0x1001
	ori $t0,$t0,0x0000
	add $t1,$zero,$t0
	lw $t0,0($t1)		# carrega bodebobo em $t0
	addi $t0,$t0,1		# t0 <- bodebob1
	beq $t0,$zero,PULA	# nao pula
	nop
	addi $t0,$t0,1		# t0 <- bodebob2
	addi $t0,$t0,1		# t0 <- bodebob3
PULA:	lw $t2,0($t1)		# t2 <- bodebobo
	bne $t0,$t2,PULA2	
	addi $t0,$t1,-1
	addi $t0,$t0,-1
PULA2:  addi $t0,$t0,1		# t0 <- bodebob4
	jal PROC
	lw $t2,8($t1)		# t2 <- 0x00400068
	#nop
	nop
	nop			# funciona com dois nops
	jr $t2
VOLTA:	addi $t0,$t0,1
	j FIM1
	addi $t0,$t0,-1
	addi $t0,$t0,-1
PROC:	nop
	jr $ra
	addi $t0,$t0,-1
PROC1:	lw $t1,4($t1)		# t1 <- focafofa
	div $t0,$t1		
	mfhi $t1
	add $t0,$t0,$t1
	j VOLTA
	addi $t0,$t0,-1
FIM1: 	j FIM1
	addi $t0,$t0,-1
