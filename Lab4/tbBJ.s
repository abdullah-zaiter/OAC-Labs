	#Valores de teste
	li t2, 2
	li t3, 3
	li t4, -4
	
	#branch e jumps
	beq t2, t3, END		# 2 != 3 -> nao pula
	bne t2, t3, NXBNE	# 2 != 3 -> pula
	j END
NXBNE:	bge t2, t3, END		# 2 < 3 -> nao pula
	bgeu t2, t4, END	# |2| < |-4| -> nao pula
	blt t2, t3, NXBLT	# 2 < 3 -> pula
JALDST:	jalr t1, t5, 0		# t1 = PC / PC = PC + 12-> instr depois de jal
NXBLT:	bltu t4, t2, END	# |-4| > |2| -> nao pula
	jal t5, JALDST		# t1 = PC+4
	