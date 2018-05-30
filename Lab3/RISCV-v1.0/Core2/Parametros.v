/* Parametros Gerais*/
parameter
    ON          = 1'b1,
    OFF         = 1'b0,
    ZERO        = 32'h0,

/* Operacoes da ULA */
		OPAND		= 5'b00000,					//0
		OPOR		= 5'b00001,					//1
		OPXOR		= 5'b00010,					//2
		OPADD		= 5'b00011,					//3
		OPSUB		= 5'b00100,					//4
		OPSLT		= 5'b00101,					//5
		OPSLTU	= 5'b00110,					//6
		OPGE		= 5'b00111,					//7
		OPGEU		= 5'b01000,					//8
		OPSLL		= 5'b01001,					//9
		OPSRL		= 5'b01010,					//10
		OPSRA		= 5'b01011,					//11
		OPBEQ    = 5'b01100,					//12
		OPBNE    = 5'b01101,					//13
		OPLUI    = 5'b01110,					//14

/* Campo FUNCT */
    FUNSLL      = 10'h001,
    FUNSRL      = 10'h005,
    FUNSRA      = 10'h105,
    FUNADD      = 10'h000,
    FUNSUB      = 10'h100,
    FUNAND      = 10'h007,
    FUNOR       = 10'h006,
    FUNXOR      = 10'h004,
    FUNSLT      = 10'h002,
    FUNSLTU     = 10'h003,
	 FUNSLLI     = 10'h001,
    FUNSRLI     = 10'h005,
    FUNSRAI     = 10'h105,
    FUNADDI     = 3'h0,
	 FUNANDI     = 3'h7,
    FUNORI      = 3'h6,
    FUNXORI     = 3'h4,
    FUNSLTI     = 3'h2,
    FUNSLTIU    = 3'h3,
	 FUNBEQ		 = 3'h0,
	 FUNBNE		 = 3'h1,
	 FUNBGE		 = 3'h5,
	 FUNBGEU		 = 3'h7,
	 FUNBLT		 = 3'h4,
	 FUNBLTU		 = 3'h6,
	 
/* Campo OPCODE */
	
	 OPCLUI       = 6'h37,
	
/* Memory access types ***********************************************************************************************/
    LOAD_TYPE_LW        = 3'b000,
    LOAD_TYPE_LH        = 3'b001,
    LOAD_TYPE_LHU       = 3'b010,
    LOAD_TYPE_LB        = 3'b011,
    LOAD_TYPE_LBU       = 3'b100,
    LOAD_TYPE_DUMMY     = 3'b111,

    STORE_TYPE_SW       = 2'b00,
    STORE_TYPE_SH       = 2'b01,
    STORE_TYPE_SB       = 2'b10,
    STORE_TYPE_DUMMY    = 2'b11,


/* ADDRESS MACROS *****************************************************************************************************/

    BACKGROUND_IMAGE    = "display.mif",

	 BEGINNING_BOOT      = 32'h0000_0000,
	 BOOT_WIDTH				= 9,					// 128 words = 128x4 = 512 bytes
    END_BOOT            = (BEGINNING_BOOT + 2**BOOT_WIDTH) - 1,	 
//    END_BOOT            = 32'h000001FF,	// 128 words

    BEGINNING_TEXT      = 32'h0040_0000,
	 TEXT_WIDTH				= 14,					// 4096 words = 4096x4 = 16384 bytes
    END_TEXT            = (BEGINNING_TEXT + 2**TEXT_WIDTH) - 1,	 
//    END_TEXT            = 32'h00403FFF,	// 4096 words

	 
    BEGINNING_DATA      = 32'h1001_0000,
	 DATA_WIDTH				= 13,					// 2048 words = 2048x4 = 8192 bytes
    END_DATA            = (BEGINNING_DATA + 2**DATA_WIDTH) - 1,	 
//    END_DATA            = 32'h10011FFF,	// 2048 words


	 STACK_ADDRESS       = END_DATA-3,


    BEGINNING_KTEXT     = 32'h8000_0000,
	 KTEXT_WIDTH			= 13,					// 2048 words = 2048x4 = 8192 bytes
    END_KTEXT           = (BEGINNING_KTEXT + 2**KTEXT_WIDTH) - 1,	 	 
//    END_KTEXT           = 32'h80001FFF,	// 2048 words
	 
    BEGINNING_KDATA     = 32'h9000_0000,
	 KDATA_WIDTH			= 12,					// 1024 words = 1024x4 = 4096 bytes
    END_KDATA           = (BEGINNING_KDATA + 2**KDATA_WIDTH) - 1,	 	 
//    END_KDATA           = 32'h900007FF, 	// 1024 words


	/* O que isso faz? 
	 ASCII_MIN           = 32'h00000080,
	 ASCII_MAX           = 32'h0000407F,
	 BACKGROUND          = 32'h00004080,
	 MAIN_COLOR          = 32'h00004084,
	 //LETRAS_MIN = 32'h00000100,
	 //LETRAS_MAX = 32'h00001763,
	 //NUMBER_MIN = 32'h00001764,
	 //NUMBER_MAX = 32'h00002403,*/
	 
    BEGINNING_IODEVICES         = 32'hFF00_0000,
	 
    BEGINNING_VGA               = 32'hFF00_0000,
    END_VGA                     = 32'hFF01_2C00,  // 320 x 240 = 76800 bytes

	 KDMMIO_CTRL_ADDRESS		     = 32'hFF20_0000,	// Para compatibilizar com o KDMMIO
	 KDMMIO_DATA_ADDRESS		  	  = 32'hFF20_0004,
	 
	 BUFFER0_TECLADO_ADDRESS     = 32'hFF20_0100,
    BUFFER1_TECLADO_ADDRESS     = 32'hFF20_0104,
	 
    TECLADOxMOUSE_ADDRESS       = 32'hFF20_0110,
    BUFFERMOUSE_ADDRESS         = 32'hFF20_0114,
	  
	 AUDIO_INL_ADDRESS           = 32'hFF20_0160,
    AUDIO_INR_ADDRESS           = 32'hFF20_0164,
    AUDIO_OUTL_ADDRESS          = 32'hFF20_0168,
    AUDIO_OUTR_ADDRESS          = 32'hFF20_016C,
    AUDIO_CTRL1_ADDRESS         = 32'hFF20_0170,
    AUDIO_CRTL2_ADDRESS         = 32'hFF20_0174,

    NOTE_SYSCALL_ADDRESS        = 32'hFF20_0178,
    NOTE_CLOCK                  = 32'hFF20_017C,
    NOTE_MELODY                 = 32'hFF20_0180,
    MUSIC_TEMPO_ADDRESS         = 32'hFF20_0184,
    MUSIC_ADDRESS               = 32'hFF20_0188,         // Endereco para uso do Controlador do sintetizador
    PAUSE_ADDRESS               = 32'hFF20_018C,
		
	 IRDA_DECODER_ADDRESS		 = 32'hFF20_0500,
	 IRDA_CONTROL_ADDRESS       = 32'hFF20_0504, 	 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
	 IRDA_READ_ADDRESS          = 32'hFF20_0508,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    IRDA_WRITE_ADDRESS         = 32'hFF20_050C,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    
	 STOPWATCH_ADDRESS			 = 32'hFF20_0510,	 //Feito em 2/2016 para servir de cronometro
	 
	 LFSR_ADDRESS					 = 32'hFF20_0514,			// Gerador de numeros aleatorios
	 
	 KEYMAP0_ADDRESS				 = 32'hFF20_0520,			// Mapa do teclado 2017/2
	 KEYMAP1_ADDRESS				 = 32'hFF20_0524,
	 KEYMAP2_ADDRESS				 = 32'hFF20_0528,
	 KEYMAP3_ADDRESS				 = 32'hFF20_052C,
	 
	 BREAK_ADDRESS					 = 32'hFF20_0600,  	  // Buffer do endereço do Break Point
	 
	 
/* STATES ************************************************************************************************************/
    FETCH           = 6'd0,
    DECODE          = 6'd1,
    LWSW            = 6'd2,
    LW              = 6'd3,
    LW2             = 6'd4,
    SW              = 6'd5,
    RFMT            = 6'd6,
    RFMT2           = 6'd7,
    SHIFT           = 6'd8,
    IFMTL           = 6'd9,
    IFMTA           = 6'd10,
    IFMT2           = 6'd11,
    BEQ             = 6'd12,
    BNE             = 6'd13,
    JUMP            = 6'd14,
    JAL             = 6'd15,
    JR              = 6'd16,

    // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
    COP0MTC0        = 6'd17,
    COP0MFC0        = 6'd18,
    COP0ERET        = 6'd19,
    COP0EXC         = 6'd20,
    // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)

    /*Estados da FPU*/
    FPUFRSTART      = 6'd38,
    FPUFR2          = 6'd39,
    FPUMOV          = 6'd40,
    FPUMFC1         = 6'd41,
    FPUMTC1         = 6'd42,
    FPUBC1T         = 6'd43,
    FPUBC1F         = 6'd44,
    FPULWC1         = 6'd45,
    FPUSWC1         = 6'd46,
    FPUCOMP         = 6'd47,    //tava assim, vou manter em homenagem aos semestres anteriores
    FPUFRWAIT       = 6'd48,

    //Adicionados em 1/2014
    STATE_LB        = 6'd49,
    STATE_LBU       = 6'd50,
    STATE_LH        = 6'd51,
    STATE_LHU       = 6'd52,
    STATE_SB        = 6'd53,
    STATE_SH        = 6'd54,

     //Adicionados em 1/2016
     BGEZ           = 6'd55,
     BGEZAL         = 6'd56,
     BLTZ           = 6'd57,
     BLTZAL         = 6'd58,
     BGTZ           = 6'd59,
     BLEZ           = 6'd60,
	  
	  //Adicionados em 2/2016 (Grupo 2)
	  RM				  = 6'd61,

	  ERRO            = 6'd63;  // Estado de Erro
