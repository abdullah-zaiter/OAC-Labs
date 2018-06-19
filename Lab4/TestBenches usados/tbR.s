	#Valores de teste
	li t2, 2
	li t3, 3
	li t4, -4
	
	#Tipo R
	add t1, t2, t3		# t1 = 5
	sub t1, t3, t2		# t1 = 1
	and t1, t2, t3		# t1 = 2   ( b10 && b11 = b10)
	or t1, t2, t3		# t1 = 3   ( b10 || b11 = b11)
	xor t1, t2, t3		# t1 = 1   ( b10 xor b11 = b01)
	slt t1, t2, t3		# t1 = 1
	sltu t1, t4, t3		# t1 = 0
	sll t1, t3, t2		# t1 = 12
	srl t1, t1, t3		# t1 = 1  
	sra t1, t4, t2		# t1 = -1