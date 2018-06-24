	#Valores de teste
	li t2, 2
	li t3, 3
	li t4, -4
	j BEGIN
	li t2, 2
	li t3, 3
	li t4, -4
BEGIN:	
	#branch e jumps
	beq t2, t2, TESTBNE
	add t2, t3, t2
TESTBNE:
	bne t2, t3, TESTBGE
	addi t2, t3, 4
TESTBGE:
	bge t3, t2, TESTBLTU #1
TESTBGEU:
	bgeu t3, t2, END # 4
TESTBLT:
	blt t2,t3, TESTBGEU # 3
TESTBLTU:
	bltu t2,t3, TESTBLT # 2
END: 
	j BEGIN
