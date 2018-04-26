

#################################
# printFloat                    #
# imprime Float em f12         #
# na posicao (a1,a2)	cor a3 #
#################################


printFloat:	addi 	sp, sp, -4
		sw 	ra, 0(sp)
		la 	s0, TempBuffer

		# Encontra o sinal do número e coloca no Buffer
		li 	t0, '+'			# define sinal '+'
		fmv.x.s s1, f12
		#mfc1 	s1, f12			# recupera o numero float
		lui 	s10, 0x8000
		slli	s10, s10, 4
		and 	s1, s1, s10		# mascara com 1000
		beq 	s1, zero, ehposprintFloat	# eh positivo s0=0
		li 	s1, 1				# numero eh negativo s0=1
		li 	t0, '-'			# define sinal '-'
ehposprintFloat: sb 	t0, 0(s0)			# coloca sinal no buffer
		addi 	s0, s0,1			# incrementa o endereco do buffer

		# Encontra o expoente em t0
		 fmv.x.s t0, f12			# recupera o numero float
		 lui	s10, 0x7F80
		 slli	s10, s10, 4
		 ori	s10, s10, 0x0000
		 and 	t0, t0, s10  		# mascara com 0111 1111 1000 0000 0000 0000...
		 li	s10, 1
		 sll 	t0, t0, s10			# tira o sinal do numero
		 li	s10, 24
		 srl 	t0, t0, s10			# recupera o expoente

		# Encontra a fracao em t1
		fmv.x.s 	t1, f12			# recupera o numero float 
		
		add	s10, zero, zero
		ori	s10, s10, 0x7F
		slli	s10, s10, 8
		ori	s10, s10, 0xFF
		slli	s10, s10, 8
		ori	s10, s10, 0xFF
		and 	t1, t1, s10		# mascara com 0000 0000 0111 1111 1111... 		 
			 
		beq 	t0, zero, ehExp0printFloat	# Expoente = 0
		li	s10, 255
		beq 	t0, s10, ehExp255printFloat	# Expoente = 255
		
		# Eh um numero float normal  t0 eh o expoente e t1 eh a mantissa
		# Encontra o E tal que 10^E <= x <10^(E+1)
		fabs.s 	f0, f12		# f0 recebe o módulo  de x
		lui 	t0, 0x3F800
		fmv.x.s 	t0, f1		# f1 recebe o numero 1.0
		lui 	t0, 0x41200
		fmv.x.s 	t0, f10		# f10 recebe o numero 10.0
		
		#c.lt.s 	1, f0, f1		# f0 < 1.0(f1) ? Flag 1 indica se f0<1 ou seja E deve ser negativo
		#bc1t 	1, menor1printFloat
		
		flt.s 	s10, f0, f1
		addi	s10, s10, -1
		beqz	s10, menor1printFloat
		
		fmv.s 	f2, f10		# f2  fator de multiplicaçao = 10
		j 	cont2printFloat		# vai para expoente positivo
menor1printFloat: fdiv.s f2,f1,f10		# f2 fator multiplicativo = 0.1

			# calcula o expoente negativo de 10
cont1printFloat: 	fmv.s 	f4, f0			# inicia com o numero x 
		 	fmv.s 	f3, f1			# contador começa em 1
loop1printFloat: 	fdiv.s 	f4, f4, f2			# divide o numero pelo fator multiplicativo
		 	#c.le.s 	0, f4, f1			# o numero eh > que 1? entao fim
		 	#bc1f 	0, fimloop1printFloat
		 	fle.s 	s10, f4, f1
		 	addi	s10, s10, -1
		 	beqz	s10, fimloop1printFloat
		 	
		 	fadd.s 	f3, f3, f1			# incrementa o contador
		 	j 	loop1printFloat			# volta ao loop
fimloop1printFloat: 	fdiv.s 	f4, f4, f2			# ajusta o numero
		 	j 	intprintFloat			# vai para imprimir a parte inteira

			# calcula o expoente positivo de 10
cont2printFloat:	fmv.s 	f4, f0			# inicia com o numero x 
		 	fmv.x.s 	zero, f3			# contador começa em 0
loop2printFloat:  	
			#c.lt.s 	0, f4, f10			# resultado eh < que 10? entao fim
		 	flt.s	s10, f4, f10
		 	fdiv.s 	f4, f4, f2			# divide o numero pelo fator multiplicativo
		 	#bc1t 	0 ,intprintFloat
			addi	s10, s10, -1
		 	beqz	s10, intprintFloat
		 	fadd.s 	f3, f3, f1			# incrementa o contador
		 	j 	loop2printFloat

		# Neste ponto tem-se no flag 1 se f0<1, em f3 o expoente de 10 e f0 0 módulo do numero e s1 o sinal
		# e em f4 um número entre 1 e 10 que multiplicado por Ef3 deve voltar ao numero		
		
	  		# imprime parte inteira (o sinal já está no buffer)
intprintFloat:		fmul.s 		f4, f4, f2		# ajusta o numero
		  	#floor.w.s 	f5, f4		# menor inteiro
		  	#mfc1 		t0, f5		# passa para t5
		  	fcvt.w.s	t0, f4
		  	addi 		t0, t0, 48		# converte para ascii
		  	sb 		t0, 0(s0)		# coloca no buffer
		  	addi 		s0, s0, 1		# incrementta o buffer
		  
		  	# imprime parte fracionaria
		  	li 	t0, '.'			# carrega o '.'
		  	sb 	t0, 0(s0)			# coloca no buffer
		  	addi 	s0, s0, 1			# incrementa o buffer
		  
		  	# f4 contem a mantissa com 1 casa não decimal
		  	li 		t1, 8				# contador de digitos  -  8 casas decimais
loopfracprintFloat:  	beq 		t1, zero, fimfracprintFloat	# fim dos digitos?
		  	#floor.w.s 	f5, f4			# menor inteiro
		  	#fcvt.w.s	f5, f4
		  	
		  	#fcvt.s.w 	f5, f5			# parte inteira		
		  	fsub.s 		f5, f4, f5			# parte fracionaria
		  	fmul.s 		f5, f5, f10			# mult x 10
		  	#floor.w.s 	f6, f5			# converte para inteiro
		  	fmv.x.s 		t0, f6			# passa para t0
		  	addi 		t0, t0, 48			# converte para ascii
		  	sb 		t0, 0(s0)			# coloca no buffer
		  	addi 		s0, s0, 1			# incrementa endereco
		  	addi 		t1, t1, -1			# decrementa contador
		  	fmv.s 		f4, f5			# coloca o numero em f4
		  	j 		loopfracprintFloat		# volta ao loop
		  
		  	# imprime 'E'		  
fimfracprintFloat: 	li 	t0,'E'			# carrega 'E'
			sb 	t0, 0(s0)		# coloca no buffer
			addi 	s0, s0, 1		# incrementa endereco
			
		  	# imprime sinal do expoente
		  	li 	t0, '+'				# carrega '+'
		  	bc1f 	1, expposprintFloat			# nao eh negativo?
		  	li 	t0, '-'				# carrega '-'
expposprintFloat: 	sb 	t0, 0(s0)				# coloca no buffer
		  	addi 	s0, s0, 1				#incrementa endereco
				    
		  	# imprimeo expoente com 2 digitos (maximo E+38)
			li 	t1, 10				# carrega 10
			cvt.w.s f3, f3			# converte f3 em inteiro	
			mfc1 	t0, f3			# passa f3 para t0
			div 	t1, t0, t1			# divide por 10
		
			addi 	t1, t1, 48			# converte para ascii
			sb 	t1, 0(s0)			# coloca no buffer
			li 	t1, 10
			rem 	t0, t0, t1			# resto (unidade)
			addi 	t0, t0, 48			# converte para ascii
			sb 	t0, 1(s0)			# coloca no buffer
			sb 	zero, 2(s0)			# insere \NULL da string
			la 	a0, TempBuffer			# endereco do Buffer										
	  		j 	fimprintFloat			# imprime a string
								
ehExp0printFloat: 	beq 	t1, zero, eh0printFloat	# Verifica se eh zero
		
ehDesnormprintFloat: 	la 	a0, NumDesnormP		# string numero desnormalizado positivo
			beq 	s1, zero, fimprintFloat	# o sinal eh 1? entao é negativo
		 	la 	a0, NumDesnormN		# string numero desnormalizado negativo
			j 	fimprintFloat			# imprime a string

eh0printFloat:		la 	a0, NumZero			# string do zero
			j 	fimprintFloat 	 		# imprime a string
		 		 		 		 
ehExp255printFloat: 	beq 	t1, zero, ehInfprintFloat	# se mantissa eh zero entao eh Infinito

ehNaNprintfFloat:	la 	a0, NumNaN			# string do NaN
			j 	fimprintFloat			# imprime string

ehInfprintFloat:	la 	a0, NumInfP			# string do infinito positivo
			beq 	s1, zero, fimprintFloat	# o sinal eh 1? entao eh negativo
			la 	a0, NumInfN			# string do infinito negativo
								# imprime string
		
fimprintFloat:		jal 	printString			# imprime a string em a0
			lw 	ra, 0(sp)			# recupera ra
			addi 	sp, sp, 4			# libera sepaco
			jr 	ra				# retorna


#################################
# readFloat       	 	#
# f0 = float digitado        	#
# 2017/2			#
#################################

readFloat: addi sp, sp, -4			# aloca espaco
	sw 	ra, 0(sp)			# salva ra
	la 	a0, TempBuffer			# endereco do FloatBuffer
	li 	a1, 32				# numero maximo de caracteres
	jal	readString			# le string, retorna s8 ultimo endereco e s9 numero de caracteres
	mv 	s0, s8			# ultimo endereco da string (antes do \0)
	mv 	s1, s9			# numero de caracteres digitados
	la	s7, TempBuffer			# Endereco do primeiro caractere
	
lePrimeiroreadFloat:	mv 	t0, s7		# Endereco de Inicio
	lb 	t1, 0(t0)				# le primeiro caractere
	li	s10, 'e'
	beq 	t1, s10, insere0AreadFloat		# insere '0' antes
	li	s10, 'E'
	beq 	t1, s10, insere0AreadFloat		# insere '0' antes
	li	s10, '.'
	beq 	t1, s10, insere0AreadFloat		#  insere '0' antes
	li	s10, '+'
	beq 	t1, s10, pulaPrimreadChar		# pula o primeiro caractere
	li	s10, '-'
	beq 	t1, s10, pulaPrimreadChar
	j leUltimoreadFloat

pulaPrimreadChar: addi s7,s7,1		# incrementa o endereco inicial
		  j lePrimeiroreadFloat		# volta a testar o novo primeiro caractere
		  
insere0AreadFloat: mv t0, s0		# endereco do ultimo caractere
		   addi s0, s0, 1		# desloca o ultimo endereco para o proximo
	   	   addi s1, s1, 1		# incrementa o num. caracteres
	   	   sb 	zero, 1(s0)		# \NULL do final de string
	   	   mv a6, s7		# primeiro caractere
insere0Aloop:	   beq 	t0, a6, saiinsere0AreadFloat	# chegou no inicio entao fim
		   lb 	t1, 0(t0)		# le caractere
		   sb 	t1, 1(t0)		# escreve no proximo
		   addi t0, t0, -1		# decrementa endereco
		   j insere0Aloop		# volta ao loop
saiinsere0AreadFloat: li t1, '0'		# ascii '0'
		   sb t1, 0(t0)		# escreve '0' no primeiro caractere

leUltimoreadFloat: lb  	t1,0(s0)			# le ultimo caractere
		li	s10, 'e'
		beq 	t1, s10, insere0PreadFloat	# insere '0' depois
		li	s10, 'E'
		beq 	t1,s10, insere0PreadFloat	# insere '0' depois
		li	s10, '.'
		beq 	t1,s10 , insere0PreadFloat	# insere '0' depois
		j 	inicioreadFloat
	
insere0PreadFloat: addi	s0, s0, 1		# desloca o ultimo endereco para o proximo
	   	   addi	s1, s1, 1		# incrementa o num. caracteres
		   li 	t1,'0'			# ascii '0'
		   sb 	t1,0(s0)		# escreve '0' no ultimo
		   sb 	zero,1(s0)		# \null do final de string

inicioreadFloat:  fmv.x.s 	zero,f0		# f0 Resultado inicialmente zero
		li 	t0, 10			# inteiro 10	
		fmv.x.s 	t0, f10		# passa para o C1
		fcvt.s.w f10, f10		# f10 contem sempre o numero cte 10.0000
		li 	t0, 1			# inteiro 1
		fmv.x.s 	t0, f1		# passa para o C1
		fcvt.s.w f1, f1		# f1 contem sempre o numero cte 1.0000
	
##### Verifica se tem 'e' ou 'E' na string  resultado em s3			
procuraEreadFloat:	add 	s3, s0, 1			# inicialmente nao tem 'e' ou 'E' na string (fora da string)
			mv 	t0, s7			# endereco inicial
loopEreadFloat: 	beq 	t0, s0, naotemEreadFloat	# sai se nao encontrou 'e'
			lb 	t1, 0(t0)			# le o caractere
			beq 	t1, 'e', ehEreadFloat		# tem 'e'
			beq	t1, 'E', ehEreadFloat		# tem 'E'
			addi 	t0, t0, 1			# incrementa endereco
			j 	loopEreadFloat			# volta ao loop
ehEreadFloat: 		mv 	s3, t0			# endereco do 'e' ou 'E' na string
naotemEreadFloat:						# nao tem 'e' ou 'E' s3 eh o endereco do \0 da string

##### Verifica se tem '.' na string resultado em s2 espera-se que nao exista ponto no expoente
procuraPontoreadFloat:	mv 	s2, s3			# local inicial do ponto na string (='e' se existir) ou fora da string	
			mv 	t0, s7			# endereco inicial
loopPontoreadFloat: 	beq 	t0, s0, naotemPontoreadFloat	# sai se nao encontrou '.'
			lb 	t1, 0(t0)			# le o caractere
			beq 	t1, '.', ehPontoreadFloat	# tem '.'
			addi 	t0, t0, 1			# incrementa endereco
			j 	loopPontoreadFloat		# volta ao loop
ehPontoreadFloat: 	mv 	s2, t0			# endereco do '.' na string
naotemPontoreadFloat:						# nao tem '.' s2 = local do 'e' ou \0 da string

### Encontra a parte inteira em f0
intreadFloat:		fmv.x.s 	zero, f2			# zera parte inteira
			addi 	t0, s2, -1			# endereco do caractere antes do ponto
			fmv.s 	f3, f1			# f3 contem unidade/dezenas/centenas		
			mv 	a6, s7			# Primeiro Endereco
loopintreadFloat: 	blt 	t0, a6, fimintreadFloat	# sai se o enderefo for < inicio da string
			lb 	t1, 0(t0)			# le o caracter
			blt 	t1, '0', erroreadFloat		# nao eh caractere valido para numero
			bgt 	t1, '9', erroreadFloat		# nao eh caractere valido para numero
			addi 	t1, t1, -48			# converte ascii para decimal
			fmv.x.s	t1, f2			# passa para 0 C1
			fcvt.s.w f2, f2			# digito lido em float

			fmul.s 	f2,f2,f3			# multiplcica por un/dezena/centena
			fadd.s 	f0,f0,f2			# soma no resultado
			fmul.s 	f3,f3,f10			# proxima dezena/centena

			add t0,t0,-1				# endereco anterior
			j loopintreadFloat			# volta ao loop
fimintreadFloat:

### Encontra a parte fracionaria  ja em f0							
fracreadFloat:		mtc1 	zero, f2			# zera parte fracionaria
			addi 	t0, s2, 1			# endereco depois do ponto
			fdiv.s 	f3, f1, f10			# f3 inicial 0.1
	
loopfracreadFloat: 	bge 	t0, s3, fimfracreadFloat	# endereco eh 'e' 'E' ou >ultimo
			lb 	t1, 0(t0)			# le o caracter
			blt 	t1, '0', erroreadFloat		# nao eh valido
			bgt 	t1, '9', erroreadFloat		# nao eh valido
			addi 	t1, t1, -48			# converte ascii para decimal
			mtc1 	t1, f2			# passa para C1				
			cvt.s.w f2, f2			# digito lido em float

			fmul.s 	f2, f2, f3			# multiplica por ezena/centena
			add.s 	f0, f0, f2			# soma no resultado
			fdiv.s 	f3, f3, f10			# proxima frac un/dezena/centena
	
			addi 	t0, t0, 1			# proximo endereco
			j 	loopfracreadFloat		# volta ao loop		
fimfracreadFloat:

### Encontra a potencia em f2																																																																																																																																																							
potreadFloat:		mtc1 	zero, f2			# zera potencia
			addi 	t0, s3, 1			# endereco seguinte ao 'e'
			li 	s4, 0				# sinal do expoente positivo
			lb 	t1, 0(t0)			# le o caractere seguinte ao 'e'
			beq	t1, '-', potsinalnegreadFloat	# sinal do expoente esta escrito e eh positivo
			beq 	t1, '+', potsinalposreadFloat	# sinal do expoente eh negativo
			j 	pulapotsinalreadFloat		# nao esta escrito o sinal do expoente
potsinalnegreadFloat:	li 	s4, 1				# s4=1 expoente negativo
potsinalposreadFloat:	addi 	t0, t0, 1			# se tiver '-' ou '+' avanca para o proximo endereco
pulapotsinalreadFloat:	mv 	s5, t0 			# Neste ponto s5 contem o endereco do primeiro digito da pot e s4 o sinal do expoente		

			fmv.s 	f3, f1		# f3 un/dez/cen = 1
	
### Encontra o expoente inteiro em t2
expreadFloat:		li 	t2, 0			# zera expoente
			mv 	t0, s0		# endereco do ultimo caractere da string
			li 	t3, 10			# numero dez
			li 	t4, 1			# und/dez/cent
				
loopexpreadFloat:	blt 	t0, s5, fimexpreadFloat	# ainda nao eh o endereco do primeiro digito?
			lb 	t1, 0(t0)			# le o caracter
			addi 	t1, t1, -48			# converte ascii para decimal
			mul 	t1, t1, t4			# mul digito
			add 	t2, t2, t1			# soma ao exp
			mul 	t4, t4, t3			# proxima casa decimal
			add 	t0, t0, -1			# endereco anterior
			j loopexpreadFloat			# volta ao loop
fimexpreadFloat:
																																																								
# calcula o numero em f2 o numero 10^exp
			fmv.s 	f2, f1			# numero 10^exp  inicial=1
			fmv.s 	f3, f10			# se o sinal for + f3 eh 10
			beq 	s4, 0, sinalexpPosreadFloat	# se sinal exp positivo
			fdiv.s 	f3, f1, f10			# se o final for - f3 eh 0.1
sinalexpPosreadFloat:	li 	t0, 0				# contador 
sinalexpreadFloat: 	beq 	t0, t2, fimsinalexpreadFloat	# se chegou ao fim
			fmul.s 	f2, f2, f3			# multiplica pelo fator 10 ou 0.1
			addi 	t0, t0, 1			# incrementa o contador
			j 	sinalexpreadFloat
fimsinalexpreadFloat:

		fmul.s 	f0, f0, f2		# multiplicacao final!
	
		la 	t0, TempBuffer		# ajuste final do sinal do numero
		lb 	t1, 0(t0)		# le primeiro caractere
		bne 	t1, '-', fimreadFloat	# nao eh '-' entao fim
		neg.s 	f0, f0		# nega o numero float

erroreadFloat:		
fimreadFloat: 	lw 	ra, 0(sp)		# recupera ra
		addi 	sp, sp, 4		# libera espaco
		jr 	ra			# retorna
																														

