# Teste dos syscalls 1xx que usam o SYSTEMv1.s
# Conectar o BitMap Display e o KD MMIO para executar
# na DE1-SoC e no Rars deve ter o mesmo comportamento sem alterar nada!

.include "macros.s"


.data
#float: .float 3.14159265659# SKIRA: nao cabe isso tudo
float: .float 3.1415926
msg1: .string "Organizacao Arquitetura de Computadores 2017/2 !"
msg2: .string "Digite seu Nome:"
msg3: .string "Digite sua Idade:"
msg4: .string "Digite seu peso:"
msg5: .string "Numero Randomico:"
msg6: .string "Tempo do Sistema:"
buffer: .string "                                "

.text	
	M_SetEcall(exceptionHandling)	# Macro de SetEcall
	
	#jal PRINTSTR1
	#jal CLS
	#jal PrintSTR2
	#jal ReadChar	
	#jal PRINTSTR1
	#jal ra, TOCAR
	jal PrintFloat
	li a7, 10
	ecall
	
PrintFloat: 
	li a7, 102
	la t0, float
	flw fa0, 0(t0)

	li a1, 0
	li a2 ,0
	li a3, 0xFF0000FF
	ecall

	#li a7, 2
	#la t0, float
	#flw fa0, 0(t0)# SKIRA: Ta certo
	#ecall

	jr ra
	
	
PrintSTR2: li a7, 104
	la a0, msg2
	li a1, 0
	li a2 ,0
	li a3, 0xFF0000FF
	ecall
	jr ra
	
ReadChar: li a7, 112
	ecall
	jr ra
	
CLS: li a7, 148
     li a0, 0xFF0000FF
     ecall
     jr ra
# syscall print string
PRINTSTR1: li a7,104
	la a0,msg1
	li a1,0
	li a2,0
	li a3,0xFF0000FF
	ecall
	jr ra
	
TOCAR:	li a0,62
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	
	
	
	ret


.include "template.s"






