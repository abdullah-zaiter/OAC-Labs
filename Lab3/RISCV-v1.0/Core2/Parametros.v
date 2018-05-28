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