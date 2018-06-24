	#Valores de teste
	li t2, 2
	li t3, 3
	li t4, -4

	#load/stores
	sb t4, 0(sp)		# salva -4 no endereco de memoria
	sh t2, 4(sp)		# salva 2 (h10000) no endereco de memoria
	sw t1, 8(sp)		# salva o valor de t1 adquirido no jalr no endereco de memoria
	lb t1, 0(sp)		# t1 = -4 (1111 1100) em complemento de 2
	lbu t1, 0(sp)		# t1 = 127 = h87 (1111 1100) sem complemento de 2
	lh t1, 4(sp)		# t1 = 2 
	lhu t1, 4(sp)		# t1 = 2
	lw t1, 8(sp)		# t1 = endereco de NXBLT