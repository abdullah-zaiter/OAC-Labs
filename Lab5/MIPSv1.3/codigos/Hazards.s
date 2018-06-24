.data
	const: .word 0xB0DEB0B0 0x004000BC
.text
	#li	$s0, 1
	#li	$s1, 2
	
	#addi	$t4, $zero, 2
	#addi	$t0, $zero, 1
	#addi	$t1, $t0, 1		# Hazard rs1=rd(EX/MEM)
	#addi	$t2, $t0, 2		# Hazard rs1=rd(MEM/WB)
	#addi	$t3, $zero, 7	
	#add	$t1, $t0, $t3		# Hazard rs2=rd(EX/MEM)
	#add	$t2, $t1, $t3		# Hazard rs2=rd(MEM/WB)

	#lui	$t0, 0x1001
	#ori	$t0, 0x0000
	#lw	$t1, 0($t0)
	#addi	$t2, $t1, 1		# Hazard rs1=rd(EX/MEM) com load word
	#addi	$t2, $t1, 2		# Hazard rs1=rd(MEM/WB) com load word
	#lw	$t3, 0($t0)
	#add	$t5, $s0, $t3		# Hazard rs2=rd(EX/MEM) com load word
	#add	$t5, $s1, $t3		# Hazard rs2=rd(MEM/WB) com load word
	
	###### Hazards de controle ##############################################################################
	
	li	$t0, 10
	li	$t1, 5
	li	$s0, 1
	beq	$zero, $zero, Pulo1	# Salto é tomado
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
Pulo1:	beq	$zero, $t0, Pulo2	# Salto não é tomado
	addi	$t0, $t0, -1
	addi	$t0, $t0, -1	
Pulo2:	bne	$zero, $t0, Pulo3	# Salto é tomado
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
Pulo3:	bne	$zero, $zero, Pulo4	# Salto não é tomado
	addi	$t0, $t0, -1
	addi	$t0, $t0, -1		
Pulo4:	jal	Pulo5
	addi	$t0, $t0, -1
	j	Pulo6	
Pulo5: jr $ra
Pulo6: 	lui	$t1, 0x1001
	lw	$t1, 4($t1)
	jr	$t1
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
FIM:	addi	$t0, $t0, -5