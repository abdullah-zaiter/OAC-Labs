#Valores de teste
	li t2, 2
	li t3, 3
	li t4, -4
	#Tipo I
	addi t1, t2, 14		# t1 = 16
	andi t1, t2, 6		# t1 = 2
	ori t1, t2, 4		# t1 = 6
	xori t1, t2, 6		# t1 = 4
	slti t1, t2, 3		# t1 = 1
	sltiu t1, t4, 3		# t1 = 0
	slli t1, t2, 1		# t1 = 4
	srli t1, t2, 1		# t1 = 1
	srai t1, t4, 2		# t1 = -1
	
	auipc t1, 44		# t1 = pc da proxima instr
	lui t1, 1		# t1 = 4096   (h1000)