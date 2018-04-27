#########################################################################
# Rotina de tratamento de excecao e interrupcao		v1.0		#
# Lembre-se: Os sycalls originais do Rars possuem precedencia sobre	#
# 	     estes definidos aqui					#
# Os syscalls 1XX usam o BitMap Display e Keyboard Display MMIO Tools	#
#									#
# Marcus Vinicius Lamar							#
# 2018/1								#
#########################################################################

#definicao do mapa de enderecamento de MMIO
.eqv VGAADDRESSINI      0xFF000000
.eqv VGAADDRESSFIM      0xFF012C00
.eqv NUMLINHAS          240
.eqv NUMCOLUNAS         320

.eqv KDMMIO_Ctrl	0xFF200000
.eqv KDMMIO_Data	0xFF200004

.eqv Buffer0Teclado     0xFF200100
.eqv Buffer1Teclado     0xFF200104

.eqv TecladoxMouse      0xFF200110
.eqv BufferMouse        0xFF200114

.eqv AudioBase		0xFF200160
.eqv AudioINL           0xFF200160
.eqv AudioINR           0xFF200164
.eqv AudioOUTL          0xFF200168
.eqv AudioOUTR          0xFF20016C
.eqv AudioCTRL1         0xFF200170
.eqv AudioCTRL2         0xFF200174

# Sintetizador - 2015/1
.eqv NoteData           0xFF200178
.eqv NoteClock          0xFF20017C
.eqv NoteMelody         0xFF200180
.eqv MusicTempo         0xFF200184
.eqv MusicAddress       0xFF200188


.eqv IrDA_CTRL 		0xFF20 0500	
.eqv IrDA_RX 		0xFF20 0504
.eqv IrDA_TX		0xFF20 0508

.eqv STOPWATCH		0xFF200510

.eqv LFSR		0xFF200514

.eqv KeyMap0		0xFF200520
.eqv KeyMap1		0xFF200524
.eqv KeyMap2		0xFF200528
.eqv KeyMap3		0xFF20052C

######### Macro que verifica se eh a DE2 ###############
.macro DE2(%salto)
	addi sp, sp, -4
	sw s10, 0(sp)
	li s10, 0x10008000
	bne gp,s10,%salto
.end_macro

.data   # endereço 0x9000 0000

# Tabela de caracteres desenhados segundo a fonte do ZX-Spectrum
LabelTabChar:
.word 	0x00000000, 0x00000000, 0x10101010, 0x00100010, 0x00002828, 0x00000000, 0x28FE2828, 0x002828FE, 
	0x38503C10, 0x00107814, 0x10686400, 0x00004C2C, 0x28102818, 0x003A4446, 0x00001010, 0x00000000, 
	0x20201008, 0x00081020, 0x08081020, 0x00201008, 0x38549210, 0x00109254, 0xFE101010, 0x00101010, 
	0x00000000, 0x10081818, 0xFE000000, 0x00000000, 0x00000000, 0x18180000, 0x10080402, 0x00804020, 
	0x54444438, 0x00384444, 0x10103010, 0x00381010, 0x08044438, 0x007C2010, 0x18044438, 0x00384404, 
	0x7C482818, 0x001C0808, 0x7840407C, 0x00384404, 0x78404438, 0x00384444, 0x1008047C, 0x00202020, 
	0x38444438, 0x00384444, 0x3C444438, 0x00384404, 0x00181800, 0x00001818, 0x00181800, 0x10081818, 
	0x20100804, 0x00040810, 0x00FE0000, 0x000000FE, 0x04081020, 0x00201008, 0x08044438, 0x00100010, 
	0x545C4438, 0x0038405C, 0x7C444438, 0x00444444, 0x78444478, 0x00784444, 0x40404438, 0x00384440,
	0x44444478, 0x00784444, 0x7840407C, 0x007C4040, 0x7C40407C, 0x00404040, 0x5C404438, 0x00384444, 
	0x7C444444, 0x00444444, 0x10101038, 0x00381010, 0x0808081C, 0x00304848, 0x70484444, 0x00444448, 
	0x20202020, 0x003C2020, 0x92AAC682, 0x00828282, 0x54546444, 0x0044444C, 0x44444438, 0x00384444, 
	0x38242438, 0x00202020, 0x44444438, 0x0C384444, 0x78444478, 0x00444850, 0x38404438, 0x00384404, 
	0x1010107C, 0x00101010, 0x44444444, 0x00384444, 0x28444444, 0x00101028, 0x54828282, 0x00282854, 
	0x10284444, 0x00444428, 0x10284444, 0x00101010, 0x1008047C, 0x007C4020, 0x20202038, 0x00382020, 
	0x10204080, 0x00020408, 0x08080838, 0x00380808, 0x00442810, 0x00000000, 0x00000000, 0xFE000000, 
	0x00000810, 0x00000000, 0x3C043800, 0x003A4444, 0x24382020, 0x00582424, 0x201C0000, 0x001C2020, 
	0x48380808, 0x00344848, 0x44380000, 0x0038407C, 0x70202418, 0x00202020, 0x443A0000, 0x38043C44, 
	0x64584040, 0x00444444, 0x10001000, 0x00101010, 0x10001000, 0x60101010, 0x28242020, 0x00242830, 
	0x08080818, 0x00080808, 0x49B60000, 0x00414149, 0x24580000, 0x00242424, 0x44380000, 0x00384444, 
	0x24580000, 0x20203824, 0x48340000, 0x08083848, 0x302C0000, 0x00202020, 0x201C0000, 0x00380418, 
	0x10381000, 0x00101010, 0x48480000, 0x00344848, 0x44440000, 0x00102844, 0x82820000, 0x0044AA92, 
	0x28440000, 0x00442810, 0x24240000, 0x38041C24, 0x043C0000, 0x003C1008, 0x2010100C, 0x000C1010, 
	0x10101010, 0x00101010, 0x04080830, 0x00300808, 0x92600000, 0x0000000C, 0x243C1818, 0xA55A7E3C, 
	0x99FF5A81, 0x99663CFF, 0x10280000, 0x00000028, 0x10081020, 0x00081020

# scancode -> ascii
LabelScanCode:
#  	0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
.byte 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, # 00 a 0F
	0x00, 0x00, 0x00, 0x00, 0x00, 0x71, 0x31, 0x00, 0x00, 0x00, 0x7a, 0x73, 0x61, 0x77, 0x32, 0x00, # 10 a 1F 
	0x00, 0x63, 0x78, 0x64, 0x65, 0x34, 0x33, 0x00, 0x00, 0x20, 0x76, 0x66, 0x74, 0x72, 0x35, 0x00, # 20 a 2F  29 espaco => 20
	0x00, 0x6e, 0x62, 0x68, 0x67, 0x79, 0x36, 0x00, 0x00, 0x00, 0x6d, 0x6a, 0x75, 0x37, 0x38, 0x00, # 30 a 3F 
	0x00, 0x2c, 0x6b, 0x69, 0x6f, 0x30, 0x39, 0x00, 0x00, 0x2e, 0x2f, 0x6c, 0x3b, 0x70, 0x2d, 0x00, # 40 a 4F 
	0x00, 0x00, 0x27, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x5b, 0x00, 0x5d, 0x00, 0x00, # 50 a 5F   5A enter => 0A (= ao Mars)
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x31, 0x00, 0x34, 0x37, 0x00, 0x00, 0x00, # 60 a 6F 
	0x30, 0x2e, 0x32, 0x35, 0x36, 0x38, 0x00, 0x00,	0x00, 0x2b, 0x33, 0x2d, 0x2a, 0x39, 0x00, 0x00, # 70 a 7F 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00						   		# 80 a 85
# scancode -> ascii (com shift)
LabelScanCodeShift:
.byte   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x51, 0x21, 0x00, 0x00, 0x00, 0x5a, 0x53, 0x41, 0x57, 0x40, 0x00, 
	0x00, 0x43, 0x58, 0x44, 0x45, 0x24, 0x23, 0x00, 0x00, 0x00, 0x56, 0x46, 0x54, 0x52, 0x25, 0x00, 
	0x00, 0x4e, 0x42, 0x48, 0x47, 0x59, 0x5e, 0x00, 0x00, 0x00, 0x4d, 0x4a, 0x55, 0x26, 0x2a, 0x00, 
	0x00, 0x3c, 0x4b, 0x49, 0x4f, 0x29, 0x28, 0x00, 0x00, 0x3e, 0x3f, 0x4c, 0x3a, 0x50, 0x5f, 0x00, 
	0x00, 0x00, 0x22, 0x00, 0x00, 0x2b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7b, 0x00, 0x7d, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00

#instructionMessage:     .ascii  "   Instrucao    "
#                        .asciiz "   Invalida!    "

.align 2

#buffer do ReadString, ReadFloat, SDread, etc. 512 caracteres/bytes
TempBuffer:
.space 512

# tabela de conversao hexa para ascii
TabelaHexASCII:		.asciz "0123456789ABCDEF  "
NumDesnormP:		.asciz "+desnorm"
NumDesnormN:		.asciz "-desnorm"
NumZero:		.asciz "0.00000000"
NumInfP:		.asciz "+Infinity"
NumInfN:		.asciz "-Infinity"
NumNaN:			.asciz "NaN"
teste:			.asciz "PrintString deu certo!!"

.align 2
# variaveis para implementar a fila de eventos de input
eventQueueBeginAddr:    .word 0x90000E00
eventQueueEndAddr:      .word 0x90001000
eventQueueBeginPtr:     .word 0x90000E00
eventQueueEndPtr:       .word 0x90000E00


##MOUSE
#DATA_X:         .word 0
#DATA_Y:         .word 0
#DATA_CLICKS:    .word 0

##### Preparado para considerar syscall similar a jal ktext  para o pipeline

### Obs.: a forma 'LABEL: instrução' embora fique feio facilita o debug no Rars, por favor não reformatar!!!

.text

exceptionHandling:

############# interrupcao de SYSCALL ###################
syscallException:     addi    sp, sp, -264              # Salva todos os registradores na pilha
    sw      x1,     0(sp)
    sw      x2,     4(sp)
    sw      x3,     8(sp)
    sw      x4,    12(sp)
    sw      x5,    16(sp)
    sw      x6,    20(sp)				
    sw      x7,    24(sp)
    sw      x8,    28(sp)
    sw      x9,    32(sp)
    sw      x10,   36(sp)
    sw      x11,   40(sp)
    sw      x12,   44(sp)
    sw      x13,   48(sp)
    sw      x14,   52(sp)
    sw      x15,   56(sp)
    sw      x16,   60(sp)
    sw      x17,   64(sp)
    sw      x18,   68(sp)
    sw      x19,   72(sp)
    sw      x20,   76(sp)
    sw      x21,   80(sp)
    sw      x22,   84(sp)
    sw      x23,   88(sp)
    sw      x24,   92(sp)
    sw      x25,   96(sp)
    sw      x26,  100(sp)
    sw      x27,  104(sp)
    sw      x28,  108(sp)
    sw      x29,  112(sp)
    sw      x30,  116(sp)
    sw      x31,  120(sp)
    fsw    f0,  124(sp)
    fsw    f1,  128(sp)
    fsw    f2,  132(sp)
    fsw    f3,  136(sp)
    fsw    f4,  140(sp)
    fsw    f5,  144(sp)
    fsw    f6,  148(sp)
    fsw    f7,  152(sp)
    fsw    f8,  156(sp)
    fsw    f9,  160(sp)
    fsw    f10, 164(sp)
    fsw    f11, 168(sp)
    fsw    f12, 172(sp)
    fsw    f13, 176(sp)
    fsw    f14, 180(sp)
    fsw    f15, 184(sp)
    fsw    f16, 188(sp)
    fsw    f17, 192(sp)
    fsw    f18, 196(sp)
    fsw    f19, 200(sp)
    fsw    f20, 204(sp)
    fsw    f21, 208(sp)
    fsw    f22, 212(sp)
    fsw    f23, 216(sp)
    fsw    f24, 220(sp)
    fsw    f25, 224(sp)
    fsw    f26, 228(sp)
    fsw    f27, 232(sp)
    fsw    f28, 236(sp)
    fsw    f29, 240(sp)
    fsw    f30, 244(sp)
    fsw    f31, 248(sp)
    
    
    # Zera os valores dos registradores temporarios - 2015/1
    add     t0, zero, zero
    add     t1, zero, zero
    add     t2, zero, zero
    add     t3, zero, zero
    add     t4, zero, zero
    add     t5, zero, zero
    add     t6, zero, zero
    
    ###############################				##############################################################################################
    # Add chamada de ecall aqui #				# PrintChar, PrintString, PrintHex funcionando
    ###############################				##############################################################################################
    li a0, 1234
    li	a7, 1
    																
    								#####################################################################################################
# Verifica o o numero da chamada do sistema			# Apos traduzir e adicionar alguma funcao, descomentar as linhas correspondentes a funcao traduzida #
    #addi    $t0, zero, 10					#####################################################################################################
    #beq     $t0, $v0, goToExit          # syscall exit
    #addi    $t0, zero, 110
    #beq     $t0, $v0, goToExit          # syscall exit
    
    addi    t0, zero, 1               # sycall 1 = print int
    beq     t0, a7, goToPrintInt
    addi    t0, zero, 101             # sycall 1 = print int
    beq     t0, a7, goToPrintInt

    addi    t0, zero, 2               # syscall 2 = print float
    beq     t0, a7, goToPrintFloat
    addi    t0, zero, 102             # syscall 2 = print float
    beq     t0, a7, goToPrintFloat

    addi    t0, zero, 4               # syscall 4 = print string
    beq     t0, a7, goToPrintString
    addi    t0, zero, 104             # syscall 4 = print string
    beq     t0, a7, goToPrintString

    #addi    $t0, zero, 5               # syscall 5 = read int
    #beq     $t0, $v0, goToReadInt
    #addi    $t0, zero, 105             # syscall 5 = read int
    #beq     $t0, $v0, goToReadInt

    #addi    $t0, zero, 6               # syscall 6 = read float
    #beq     $t0, $v0, goToReadFloat
    #addi    $t0, zero, 106             # syscall 6 = read float
    #beq     $t0, $v0, goToReadFloat

    #addi    $t0, zero, 8               # syscall 8 = read string
    #beq     $t0, $v0, goToReadString
    #addi    $t0, zero, 108             # syscall 8 = read string
    #beq     $t0, $v0, goToReadString

    addi    t0, zero, 11              # syscall 11 = print char
    beq     t0, a7, goToPrintChar
    addi    t0, zero, 111             # syscall 11 = print char
    beq     t0, a7, goToPrintChar

    #addi    $t0, zero, 12              # syscall 12 = read char
    #beq     $t0, $v0, goToReadChar
    #addi    $t0, zero, 112             # syscall 12 = read char
    #beq     $t0, $v0, goToReadChar

    #addi    $t0, zero, 30              # syscall 30 = time
    #beq     $t0, $v0, goToTime
    #addi    $t0, zero, 130             # syscall 30 = time
    #beq     $t0, $v0, goToTime
    
    #addi    $t0, zero, 32              # syscall 32 = sleep
    #beq     $t0, $v0, goToSleep
    #addi    $t0, zero, 132             # syscall 32 = sleep
    #beq     $t0, $v0, goToSleep

    #addi    $t0, zero, 41              # syscall 41 = random
    #beq     $t0, $v0, goToRandom
    #addi    $t0, zero, 141             # syscall 41 = random
    #beq     $t0, $v0, goToRandom

    addi    t0, zero, 34       	# syscall 34 = print hex
    beq     t0, a7, goToPrintHex
    addi    t0, zero, 134		# syscall 41 = print hex
    beq     t0, a7, goToPrintHex
    
    #addi    $t0, zero, 31              # syscall 31 = MIDI out
    #beq     $t0, $v0, goToMidiOut       # Generate tone and return immediately
    #addi    $t0, zero, 131             # syscall 31 = MIDI out
    #beq     $t0, $v0, goToMidiOut

    #addi    $t0, zero, 33              # syscall 33 = MIDI out synchronous
    #beq     $t0, $v0, goToMidiOutSync   # Generate tone and return upon tone completion
    #addi    $t0, zero, 133             # syscall 33 = MIDI out synchronous
    #beq     $t0, $v0, goToMidiOutSync

#    addi    $t0, zero, 49              # syscall 49 = SD Card read
#    beq     $t0, $v0, goToSDread
#    addi    $t0, zero, 149              # syscall 49 = SD Card read
#    beq     $t0, $v0, goToSDread

    #addi    $t0, zero, 48              # syscall 48 = CLS
    #beq     $t0, $v0, goToCLS
    #addi    $t0, zero, 148              # syscall 48 = CLS
    #beq     $t0, $v0, goToCLS
    
    #addi    $t0, zero, 150             # syscall 150 = pop event
    #beq     $t0, $v0, goToPopEvent


endSyscall:	lw	x1, 0(sp)  # recupera QUASE todos os registradores na pilha
#   lw	    x2,   4(sp)	# $v0 retorno de valor
#   lw 	    x3,   8(sp)	# $v1 retorno de valor
#   lw	    x4,  12(sp)      	# $a0 as vezes usado como retorno de valor
#   lw	    x5,  16(sp)      	# $a1 
    lw	    x6,  20(sp)	
    lw      x7,  24(sp)
    lw 	    x8,  28(sp)
    lw      x9,    32(sp)
    lw      x10,   36(sp)
    lw      x11,   40(sp)
    lw      x12,   44(sp)
    lw      x13,   48(sp)
    lw      x14,   52(sp)
    lw      x15,   56(sp)
    lw      x16,   60(sp)
    lw      x17,   64(sp)
    lw      x18,   68(sp)
    lw      x19,   72(sp)
    lw      x20,   76(sp)
    lw      x21,   80(sp)
    lw      x22,   84(sp)
    lw      x23,   88(sp)
    lw      x24,   92(sp)
    lw      x25,   96(sp)
    lw      x26,  100(sp)
    lw      x27,  104(sp)
    lw      x28,  108(sp)
    lw      x29,  112(sp)
    lw      x30,  116(sp)
    lw      x31,  120(sp)
#   flw    f0,   124(sp) 	# f0 retorno de valor
    flw    f1,  128(sp)
    flw    f2,  132(sp)
    flw    f3,  136(sp)
    flw    f4,  140(sp)
    flw    f5,  144(sp)
    flw    f6,  148(sp)
    flw    f7,  152(sp)
    flw    f8,  156(sp)
    flw    f9,  160(sp)
    flw    f10, 164(sp)
    flw    f11, 168(sp)
    flw    f12, 172(sp)
    flw    f13, 176(sp)
    flw    f14, 180(sp)
    flw    f15, 184(sp)
    flw    f16, 188(sp)
    flw    f17, 192(sp)
    flw    f18, 196(sp)
    flw    f19, 200(sp)
    flw    f20, 204(sp)
    flw    f21, 208(sp)
    flw    f22, 212(sp)
    flw    f23, 216(sp)
    flw    f24, 220(sp)
    flw    f25, 224(sp)
    flw    f26, 228(sp)
    flw    f27, 232(sp)
    flw    f28, 236(sp)
    flw    f29, 240(sp)
    flw    f30, 244(sp)
    flw    f31, 248(sp)
    
    
    addi    sp, sp, 264
    j endException

										#####################################################################################################
#goToExit:   	DE2(goToExitDE2)	# se for a DE2				# Apos traduzir e adicionar alguma funcao, descomentar as linhas correspondentes a funcao traduzida #
#  		li 	$v0, 10		# chama o syscal normal do Mars		#####################################################################################################
#  		syscall			# exit syscall
  		
#goToExitDE2:	j       goToExitDE2     ########### syscall 10 ou 110

goToPrintInt:	jal     printInt               	# chama printInt
		j       endSyscall

goToPrintString: jal     printString           	# chama printString
    		j       endSyscall

goToPrintChar:	jal     printChar		# chama printChar
    		j       endSyscall

goToPrintFloat:	jal     printFloat		# chama printFloat
    		j       endSyscall

#goToReadChar:	jal     readChar              	# chama readChar
#    		j       endSyscall

#goToReadInt:   	jal     readInt                 # chama readInt
#    		j       endSyscall

#goToReadString:	jal     readString              # chama readString
#    		j       endSyscall

#goToReadFloat:	jal     readFloat               # chama readFloat
#		j       endSyscall

goToPrintHex:	jal     printHex                # chama printHex
		j       endSyscall
	
#goToMidiOut:	jal     midiOut                 # chama MIDIout
#    		j       endSyscall

#goToMidiOutSync:     	jal     midiOutSync   	# chama MIDIoutSync
#    			j       endSyscall

#goToSDread:     jal     sdRead                  # Chama sdRead
#    		j       endSyscall

#goToPopEvent:	jal     popEvent                # chama popEvent
#    		j       endSyscall

#goToTime:	jal     time                    # chama time
#    		j       endSyscall

#goToSleep:	jal     sleep                  	# chama sleep
#		j       endSyscall

#goToRandom:	jal     random                 	# chama random
#    		j       endSyscall

#goToCLS:	jal     clsCLS                 	# chama CLS
#    		j       endSyscall

####################################################################################################################################################
#### Colocar as funcoes traduzidas a partir deste ponto ############################################################################################
####################################################################################################################################################




#####################################
#  PrintSring                       #
#  $a0    =  endereco da string     #
#  $a1    =  x                      #
#  $a2    =  y                      #
#  $a3    =  cor		    #
#####################################

printString:	addi	sp, sp, -12			# aloca espaco
    		sw	ra, 0(sp)			# salva $ra
    		sw	s0, 4(sp)			# salva $s0
    		sw	s10, 8(sp)
    		mv	s0, a0              		# $s0 = endereco do caractere na string

loopprintString: lb	a0, 0(s0)                 	# le em $a0 o caracter a ser impresso
    		beq     a0, zero, fimloopprintString   # string ASCIIZ termina com NULL

    		jal     printChar       		# imprime char
    		
		addi    a1, a1, 8                 	# incrementa a coluna	
		li 	s10, 313	
		blt	a1, s10, NaoPulaLinha	    	# se ainda tiver lugar na linha
    		addi    a2, a2, 8                 	# incrementa a linha
    		mv    a1, zero			# volta a coluna zero

NaoPulaLinha:	addi    s0, s0, 1			# proximo caractere
    		j       loopprintString       		# volta ao loop

fimloopprintString:	lw      ra, 0(sp)    		# recupera $ra
			lw 	s0, 4(sp)		# recupera $s0
			lw	s10,8(sp)
    			addi    sp, sp, 12		# libera espaco
fimprintString:		jr      ra             	# retorna


#########################################################
#  PrintChar                                            #
#  $a0 = char(ASCII)                                    #
#  $a1 = x                                              #
#  $a2 = y                                              #
#########################################################
#   $t0 = i                                             #
#   $t1 = j                                             #
#   $t2 = endereco do char na memoria                   #
#   $t3 = metade do char (2a e depois 1a)               #
#   $t4 = endereco para impressao                       #
#   $t5 = background color                              #
#   $t6 = foreground color                              #
#   $t7 = 2                                             #
#########################################################
#   Trocas realizadas                                   #
#							#
#   $at <=> s8                                          #
#   temporários <=> s10					#
#########################################################

printChar:   
	li	a3, 0xFF0000FF
	
	addi 	sp, sp, -8			# Guarda valor de s10 e s8 na pilha e recupera ao final da rotina #
	sw 	s10, 0(sp)
	sw 	s8, 4(sp)
	li	s10, 0xFF00
	and    t5, a3, s10         # cor fundo
	li 	s10, 0x00FF
    	and    t6, a3, s10             	# cor frente
    	srli    t5, t5, 8			# numero da cor de fundo

	li	s10, ' '
	blt 	a0, s10, NAOIMPRIMIVEL		# ascii menor que 32 nao eh imprimivel
	li	s10, '~'
	bgt	a0, s10, NAOIMPRIMIVEL		# ascii Maior que 126  nao eh imprimivel
    	j       IMPRIMIVEL
    
NAOIMPRIMIVEL:     li      a0, 32		# Imprime espaco

IMPRIMIVEL:	li	s8, NUMCOLUNAS		# Num colunas 320
    	mul    	t4, s8, a2			# multiplica $a2x320
    						# $t4 = coordenada y
    	add     t4, t4,	a1               	# $t4 = 320*y + x
    	addi    t4, t4, 7                 	# t4 = 320*y + (x+7)
    	li      s10, 0xFF000000          	# Endereco de inicio da memoria VGA
    	add     t4, t4, s10               	# t4 = endereco de impressao do ultimo pixel da primeira linha do char
    	addi    t2, a0, -32               	# indice do char na memoria
    	slli     t2, t2, 3                 	# offset em bytes em relacao ao endereco inicial
	la      t3, LabelTabChar		# endereco dos caracteres na memoria
    	add     t2, t2, t3               	# endereco do caractere na memoria
	lw      t3, 0(t2)                 	# carrega a primeira word do char
	li 	t0, 4				# i=4

forChar1I:	beq     t0, zero, endForChar1I	# if(i == 0) end for i
    		addi    t1, zero, 8               	# j = 8

	forChar1J:      beq     t1, zero, endForChar1J    	# if(j == 0) end for j
        		andi    s10, t3, 0x0001		# primeiro bit do caracter
        		srli     t3, t3, 1             	# retira o primeiro bit
        		beq     s10, zero, printCharPixelbg1	# pixel eh fundo?
        		sb      t6, 0(t4)             	# imprime pixel com cor de frente
        		j       endCharPixel1
printCharPixelbg1:     	sb      t5, 0(t4)                 	# imprime pixel com cor de fundo
endCharPixel1:     	addi    t1, t1, -1                	# j--
    			addi    t4, t4, -1                	# t4 aponta um pixel para a esquerda
    			j       forChar1J			# vollta novo pixel

endForChar1J: 	addi    t0, t0, -1 		# i--
    		addi    t4, t4, 328           # 2**12 + 8
    		j       forChar1I		# volta ao loop

endForChar1I:	lw      t3, 4(t2)           	# carrega a segunda word do char
		li 	t0, 4			# i = 4
forChar2I:     	beq     t0, zero, endForChar2I    	# if(i == 0) end for i
    		addi    t1, zero, 8               # j = 8

	forChar2J:	beq	t1, zero, endForChar2J    	# if(j == 0) end for j
        		andi    s10, t3, 0x0001	    	# pixel a ser impresso
        		srli     t3, t3, 1                 	# desloca para o proximo
        		beq     s10, zero, printCharPixelbg2	# pixel eh fundo?
        		sb      t6, 0(t4)			# imprime cor frente
        		j       endCharPixel2			# volta ao loop

printCharPixelbg2:     	sb      t5, 0(t4)			# imprime cor de fundo

endCharPixel2:     	addi    t1, t1, -1			# j--
    			addi    t4, t4, -1                	# t4 aponta um pixel para a esquerda
    			j       forChar2J

endForChar2J:	addi	t0, t0, -1 		# i--
    		addi    t4, t4, 328		#
    		j       forChar2I		# volta ao loop

endForChar2I:	
		lw s10, 0(sp)
		lw s8, 4(sp)
		addi sp, sp, 8
		jr ra				# retorna
		

#############################################
#  PrintHex                                 #
#  $a0    =    valor inteiro                #
#  $a1    =    x                            #
#  $a2    =    y                            #
#  $a3    =    cor			    #
#############################################

printHex:	addi    sp, sp, -4    		# aloca espaco
    		sw      ra, 0(sp)			# salva $ra
		mv 	t0, a0			# Inteiro de 32 bits a ser impresso em Hexa
		la 	t1, TabelaHexASCII		# endereco da tabela HEX->ASCII
		la 	t2, TempBuffer			# onde a string sera montada

		li 	t3,'0'			# Caractere '0'
		sb 	t3,0(t2)		# Escreve '0' no Buffer da String
		li 	t3,'x'			# Caractere 'x'
		sb 	t3,1(t2)		# Escreve 'x' no Buffer da String
		addi 	t2,t2,2		# novo endereco inicial da string

		li 	t3, 28			# contador de nibble   inicio = 28
loopprintHex:	blt 	t3, zero, fimloopprintHex	# terminou? $t3<0?
		srl 	t4, t0, t3		# desloca o nibble para direita
		andi 	t4, t4, 0x000F	# mascara o nibble	
		add 	t4, t1, t4		# endereco do ascii do nibble
		lb 	t4, 0(t4)		# le ascii do nibble
		sb 	t4, 0(t2)		# armazena o ascii do nibble no buffer da string
		addi 	t2, t2, 1		# incrementa o endereco do buffer
		addi 	t3, t3, -4		# decrementa o numero do nibble
		j 	loopprintHex
		
fimloopprintHex: sb 	zero,0(t2)		# grava \null na string
		la 	a0, TempBuffer		# Argumento do print String
    		jal	printString		# Chama o print string
    			
		lw 	ra, 0(sp)		# recupera $ra
		addi 	sp, sp, 4		# libera espaco
fimprintHex:	jr 	ra			# retorna


#################################
#    CLS                        #
#  Clear Screen                 #
#  $a0 = cor                    #
#################################

clsCLS:	li      t1, 0xFF000000           # Memoria VGA
   	li      t2, 0xFF012C00
    	andi    a0, a0, 0x00FF
    	li 	t0, 0x01010101
    	mul	a0, t0, a0
    	
forCLS:	beq     t1, t2, fimCLS
	sw      a0, 0(t1)
    	addi    t1, t1, 4
    	j       forCLS
    	
fimCLS:	jr      ra



#############################################
#  PrintInt                                 #
#  $a0    =    valor inteiro                #
#  $a1    =    x                            #
#  $a2    =    y  			    #
#  $a3    =    cor                          #
#############################################


printInt:	addi 	sp, sp, -4			# Aloca espaco
		sw 	ra, 0(sp)			# salva $ra
		la 	t0, TempBuffer			# carrega o Endereco do Buffer da String
		
		bge 	a0, zero, ehposprintInt	# Se eh positvo
		li 	t1, '-'			# carrega o sinal -
		sb 	t1, 0(t0)			# coloca no buffer
		addi 	t0, t0, 1			# incrementa endereco do buffer
		sub 	a0, zero, a0			# torna o numero positivo
		
ehposprintInt:  li 	t2, 10				# carrega numero 10
		li 	t1, 0				# carrega numero de digitos com 0
		
loop1printInt:	div 	t4,a0, t2			# divide por 10 e obtém o quociente
		rem 	t3, a0, t2			# resto
		addi 	sp, sp, -4			# aloca espaco na pilha
		sw 	t3, 0(sp)			# coloca resto na pilha
		add 	a0, zero, t4			# atualiza o numero com o quociente
		addi 	t1, t1, 1			# incrementa o contador de digitos
		bne 	a0, zero, loop1printInt	# verifica se o numero eh zero
				
loop2printInt:	lw 	t2, 0(sp)			# le digito da pilha
		addi 	sp, sp, 4			# libera espaco
		addi 	t2, t2, 48			# converte o digito para ascii
		sb 	t2, 0(t0)			# coloca caractere no buffer
		addi 	t0, t0, 1			# incrementa endereco do buffer
		addi 	t1, t1, -1			# decrementa contador de digitos
		bne 	t1, zero, loop2printInt	# eh o ultimo?
		sb 	zero, 0(t0)			# insere \NULL na string
		
		la 	a0, TempBuffer			# Endereco do buffer da srting
		jal 	printString			# chama o print string
				
		lw 	ra, 0(sp)			# recupera $a
		addi 	sp, sp, 4			# libera espaco

fimprintInt:	jr 	ra				# retorna

#################################
# printFloat                    #
# imprime Float em $f12         #
# na posicao ($a1,$a2)	cor $a3 #
#################################


printFloat:	addi 	sp, sp, -4
		sw 	ra, 0(sp)
		la 	s0, TempBuffer

		# Encontra o sinal do número e coloca no Buffer
		li 	t0, '+'			# define sinal '+'
		fmv.x.s 	s1, f12			# recupera o numero float
		li t2, 0x80000000
		and 	s1, s1, t2		# mascara com 1000 - andi s1, s1, 0x80000000
		beq 	s1, zero, ehposprintFloat	# eh positivo $s0=0
		li 	s1, 1				# numero eh negativo $s0=1
		li 	t0, '-'			# define sinal '-'
ehposprintFloat: sb 	t0, 0(s0)			# coloca sinal no buffer
		addi 	s0, s0,1			# incrementa o endereco do buffer

		# Encontra o expoente em $t0
		 fmv.x.s 	t0, f12			# recupera o numero float
		 li	t2, 0x7F800000
		 and 	t0, t0, t2   		# mascara com 0111 1111 1000 0000 0000 0000... - andi 	t0, t0, 0x7F800000
		 slli 	t0, t0, 1			# tira o sinal do numero
		 srli 	t0, t0, 24			# recupera o expoente

		# Encontra a fracao em $t1
		fmv.x.s 	t1, f12			# recupera o numero float 
		li t3, 0x007FFFFF
		and 	t1, t1, t2		# mascara com 0000 0000 0111 1111 1111... - andi t1, t1, 0x007FFFFF 		 
			 
		beq 	t0, zero, ehExp0printFloat	# Expoente = 0
		li 	t3, 255
		beq 	t0, t3, ehExp255printFloat	# Expoente = 255
		
		# Eh um numero float normal  $t0 eh o expoente e $t1 eh a mantissa
		# Encontra o E tal que 10^E <= x <10^(E+1)
		fabs.s 	f0, f12		# $f0 recebe o módulo  de x
		lui 	t0, 0x3F80
		fmv.s.x 	f1, t0		# $f1 recebe o numero 1.0
		lui 	t0, 0x4120
		fmv.s.x 	f10,t0		# $f10 recebe o numero 10.0
		
		flt.s 	t6, f0, f1		# $f0 < f1, t6=1 c.c t6=0
		li t5, 1			# t5=1
		beq  t6,t5, menor1printFloat	# t6=1?
		fmv.s 	f2, f10		# $f2  fator de multiplicaçao = 10
		j 	cont2printFloat		# vai para expoente positivo
menor1printFloat: fdiv.s f2,f1,f10		# $f2 fator multiplicativo = 0.1

			# calcula o expoente negativo de 10
cont1printFloat: 	fmv.s 	f4, f0			# inicia com o numero x 
		 	fmv.s 	f3, f1			# contador começa em 1
loop1printFloat: 	fdiv.s 	f4, f4, f2			# divide o numero pelo fator multiplicativo
		 	fle.s 	t6, f4, f1	# equivalente a c.le.s 	0, f4, f1
		 	li t5, 0
		 	beq t6,t5, fimloop1printFloat   	#  equivalente a bc1f 0, fimloop1printFloat
		 	fadd.s 	f3, f3, f1			# incrementa o contador
		 	j 	loop1printFloat			# volta ao loop
fimloop1printFloat: 	fdiv.s 	f4, f4, f2			# ajusta o numero
		 	j 	intprintFloat			# vai para imprimir a parte inteira

			# calcula o expoente positivo de 10
cont2printFloat:	fmv.s 	f4, f0			# inicia com o numero x 
		 	fmv.s.x f3, zero			# contador começa em 0
loop2printFloat:  	flt.s 	t6, f4, f10			# resultado eh < que 10? entao fim
		 	fdiv.s 	f4, f4, f2			# divide o numero pelo fator multiplicativo
		 	li t5, 1
		 	beq t5,t6, intprintFloat			
		 	fadd.s 	f3, f3, f1			# incrementa o contador
		 	j 	loop2printFloat

		# Neste ponto tem-se no flag 1 se $f0<1, em $f3 o expoente de 10 e $f0 0 módulo do numero e $s1 o sinal
		# e em $f4 um número entre 1 e 10 que multiplicado por E$f3 deve voltar ao numero		
		
	  		# imprime parte inteira (o sinal já está no buffer)
intprintFloat:		fmul.s 		f4, f4, f2		# ajusta o numero
			fcvt.w.s 	t4, f4				# floor.w.s f5, f4 em 2 inst de conversão
		  	fcvt.s.w	f5,t4 				#menor inteiro
		  	fmv.x.s 		t0, f5		# passa para $t5
		  	addi 		t0, t0, 48		# converte para ascii
		  	sb 		t0, 0(s0)		# coloca no buffer
		  	addi 		s0, s0, 1		# incrementta o buffer
		  
		  	# imprime parte fracionaria
		  	li 	t0, '.'			# carrega o '.'
		  	sb 	t0, 0(s0)			# coloca no buffer
		  	addi 	s0, s0, 1			# incrementa o buffer
		  
		  	# $f4 contem a mantissa com 1 casa não decimal
		  	li 		t1, 8				# contador de digitos  -  8 casas decimais
loopfracprintFloat:  	beq 		t1, zero, fimfracprintFloat	# fim dos digitos?
		  	fcvt.w.s 	t4, f4				# floor.w.s em 2 inst de conversão
		  	fcvt.s.w	f5,t4 				#menor inteiro		
		  	fsub.s 		f5, f4, f5			# parte fracionaria
		  	fmul.s 		f5, f5, f10			# mult x 10
		  	fcvt.w.s	t4,f5			#floor.w.s f6, f5
		  	fcvt.s.w	f6,t4			#converte para inteiro
		  	fmv.x.s 		t0, f6			# passa para $t0
		  	addi 		t0, t0, 48			# converte para ascii
		  	sb 		t0, 0(s0)			# coloca no buffer
		  	addi 		s0, s0, 1			# incrementa endereco
		  	addi 		t1, t1, -1			# decrementa contador
		  	fmv.s 		f4, f5			# coloca o numero em $f4
		  	j 		loopfracprintFloat		# volta ao loop
		  
		  	# imprime 'E'		  
fimfracprintFloat: 	li 	t0,'E'			# carrega 'E'
			sb 	t0, 0(s0)		# coloca no buffer
			addi 	s0, s0, 1		# incrementa endereco
			
		  	# imprime sinal do expoente
		  	li 	t0, '+'				# carrega '+'
		  	li t5, 1
		  	beq t6,t5, expposprintFloat
		  	li 	t0, '-'				# carrega '-'
expposprintFloat: 	sb 	t0, 0(s0)				# coloca no buffer
		  	addi 	s0, s0, 1				#incrementa endereco
				    
		  	# imprimeo expoente com 2 digitos (maximo E+38)
			li 	t1, 10				# carrega 10
			fcvt.w.s t3, f3			# converte $f3 em inteiro	
			fmv.x.s 	t0, f3			# passa $f3 para $t0
			div 	t0, t0, t1				# quociente (dezena)
			addi 	t0, t0, 48			# converte para ascii
			sb 	t0, 0(s0)			# coloca no buffer
			rem 	t0, t0,t1			# resto (unidade)
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
		
fimprintFloat:		jal 	printString			# imprime a string em $a0
			lw 	ra, 0(sp)			# recupera $ra
			addi 	sp, sp, 4			# libera sepaco
			jr 	ra				# retorna





endException:
