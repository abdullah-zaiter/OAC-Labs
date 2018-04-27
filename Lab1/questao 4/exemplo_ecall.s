.include "macros.s"	# inclui arquivos de macros no inicio do programa
.data
	STR: .string "Digite um Numero:"

.text
main: 	M_SetEcall(ECALL)	# Macro de SetEcall

	la a0,STR		# Define a0 = endereço STR
	li a7,4			# Define a7 = 4
	ecall			# Chama o serviço original Print String
	
	li a7,5			# Define a7 = 5
	ecall			# Chama o serviço original Read Int

	li a7,104		# Define a7 = 104
 	ecall			# Chama o novo serviço 104

 	li a7,10		# Define a7 = 10
 	ecall			# chama o serviço de Exit

.include "ECALL.s"	# inclui arquivo ECALLv1.s no final do programa
