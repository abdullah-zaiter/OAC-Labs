.data
	const: .word 0xB0DEB0B0 0xA
.text
	################################################# Forwards totalmente funcionais #############################################################################################
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
	
	################################################# Erros no tratamento dos hazards de controle do branch #############################################################################################
	
	li	$t1, 10
	la	$t2, const
	lw	$t0, 4($t2)
	beq	$t0, $zero, FIM
	addi	$t0, $t0, 1
	addi	$t0, $t0, 1
	lw	$t0, 4($t2)
	beq	$t0, $t1, FIM_BRANCHS
	addi	$t0, $t0, -1
	addi	$t0, $t0, -1
	
	################################################# Erro do Forward do $ra do jump and link para o "jr $ra" ############################################################################

FIM_BRANCHS:	li	$t0, 0
		jal	go_on4
		addi	$t0, $t0, 1
		addi	$t0, $t0, 1
		addi	$t0, $t0, 1
		addi	$t0, $t0, 1
		j	FIM
go_on4:		jr	$ra	
FIM:




