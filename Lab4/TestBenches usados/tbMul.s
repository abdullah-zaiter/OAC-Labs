	#Valores de teste
	li t2, 2
	li t3, 3
	li t4, -4
	
	#ISA RV32IM
	mul t1, t2, t4		# t1 = -8 (c2)
	mulh t1, t2, t4		# t1 = -1   (o sinal eh estendido, fazendo os 32bits mais significativos todos 1)
	mulhu t1, t2, t4	# t1 = 1    (sem o sinal estendido, o valor de t4 eh shiftado para a esquerda, saindo 1 bit nos 32 bits mais significativos)
	mulhsu t1, t4, t2	# t1 = -1   (com sinal estendido em t4, negativo, os 32 bits mais significativos sao todos 1 -> -1 em complemento de 2)
	div t1, t4, t2		# t1 = -2 (c2)
	divu t1, t4, t2		# t1 = h7ffffffe (-4 em c2 shiftado para a direita, sem extensao de sinal)
	rem t1, t4, t3		# t1 = -1
	remu t1, t4, t2		# t1 = 0
	