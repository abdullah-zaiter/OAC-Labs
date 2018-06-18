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
	bne t2, t3, END
	addi t2, t3, 4
END: 
	j BEGIN
