/*
 * Caminho de dados processador Uniciclo
 *
 */

module Datapath_UNI (
    // Inputs e clocks
    input  wire        iCLK, iCLK50, iRST,
    input  wire [31:0] iInitialPC,

    // Para monitoramento
    output wire [31:0] wPC, woInstr, wMuxPC,
    output wire [31:0] wRegDisp,
    input  wire [4:0]  wRegDispSelect,
    output wire [31:0] wDebug,	 
    input  wire [4:0]  wVGASelect,
    output wire [31:0] wVGARead,
    output wire        wCRegWrite,
    output wire [1:0]  wCALUOp,wCOrigALU,
    output wire [1:0]  wCOrigPC,
    output wire wOPBJ, wCTransf,
    
    output wire [1:0]  wCMem2Reg,
	 
	 output wire [31:0] wBRReadA,
	 output wire [31:0] wBRReadB,
	 output wire [31:0] wBRWrite,
	 output wire [31:0] wULA,	 


    //  Barramento de Dados
    output             DwReadEnable, DwWriteEnable,
    output      [3:0]  DwByteEnable,
    output      [31:0] DwAddress, DwWriteData,
    input       [31:0] DwReadData,

    // Barramento de Instrucoes
    output             IwReadEnable, IwWriteEnable,
    output      [3:0]  IwByteEnable,
    output      [31:0] IwAddress, IwWriteData,
    input       [31:0] IwReadData
	);


assign DwReadEnable     = wCMemRead;
assign DwWriteEnable    = wCMemWrite;

assign wBRReadA		= wRead1;
assign wBRReadB		= wRead2;
assign wBRWrite		= wDataReg;
assign wULA				= wALUresult;
assign wDebug[6:0]		= wFunct7;    									// wDebug AQUI !!!!!!!!!!!!!!!!!!!!!!
assign wDebug[30:28]	= wFunct3;
/* Padrao de nomeclatura
 *
 * XXXXX - registrador XXXX
 * wXXXX - wire XXXX
 * wCXXX - wire do sinal de controle XXX
 * memXX - memoria XXXX
 * Xunit - unidade funcional X
 * iXXXX - sinal de entrada/input
 * oXXXX - sinal de saida/output
 */

reg  [31:0] PC, PCgambs;                                    // registrador do PC
wire [31:0] wPC4;
wire [31:0] wiPC;
wire [31:0] wInstr;
wire [31:0] wMemDataWrite;
wire [4:0]  wAddrRs1, wAddrRs2, wAddrRd, wRegDst;// enderecos dos reg rs,rt ,rd e saida do Mux regDst
wire [2:0] wFunct3;
wire [6:0] wFunct7;

wire [31:0] wOrigALU;
wire        wZero;
wire [4:0]  wALUControl;
wire [31:0] wALUresult, wRead1, wRead2, wMemAccess;
wire [31:0] wReadData;
wire [31:0] wDataReg;
wire [31:0] wImm;       //Saida Imediato
wire [31:0] wExtImm;
wire [31:0] wBranchPC;
wire [31:0] wJumpAddr;
wire        wOverflow;
wire [31:0] wExtZeroImm;
wire        wCMemRead, wCMemWrite;
//wire [5:0]  wFunct, // VOU DEIXAR O wFunct PQ ELE ENTRA NO FPALU
wire [6:0]  wOpcode;
wire [1:0] wCStore;

//MemStore
wire [31:0] wMemStore;
wire [3:0]  wMemEnableStore;
wire [3:0]  wMemEnable;

/* ****************************************************** */
/* Inicializacao dos registradores		  						 */

/* Inicializacao */
initial
begin
    PC         <= BEGINNING_TEXT;
    PCgambs    <= BEGINNING_TEXT;
end

assign wPC4         = wPC + 32'h4;                          /* Calculo PC+4 */
assign wPC          = PC;
assign wOpcode      = wInstr[6:0];
assign wAddrRs1      = wInstr[19:15];
assign wAddrRs2      = wInstr[24:20];
assign wAddrRd       = wInstr[11:7];
assign wFunct3       = wInstr[14:12];
assign wFunct7       = wInstr[31:25];
assign woInstr      = wInstr;
assign wCodeMemoryWrite     = ((PC >= BEGINNING_BOOT && PC <= END_BOOT) ? 1'b1 : 1'b0);

/* ****************************************************** */
/* Instanciacao das estruturas 	 		  						 */


/* Barramento da Memoria de Instrucoes */
assign    IwReadEnable      = ON;
assign    IwWriteEnable     = wCodeMemoryWrite;
assign    IwByteEnable      = wMemEnable;
assign    IwAddress         = wPC;
assign    IwWriteData       = ZERO;
assign    wInstr            = IwReadData;


/* Banco de Registradores */
Registers RegsUNI (
    .iCLK(iCLK),
    .iCLR(iRST),
    .iReadRegister1(wAddrRs1),
    .iReadRegister2(wAddrRs2),
    //.iWriteRegister(wRegDst),
	 .iWriteRegister(wAddrRd),
    .iWriteData(wDataReg),
    .iRegWrite(wCRegWrite),
    .oReadData1(wRead1),
    .oReadData2(wRead2),
    .iRegDispSelect(wRegDispSelect),    // seleÃ§Ã£o para display
    .oRegDisp(wRegDisp),                // Reg display
    .iVGASelect(wVGASelect),            // para mostrar Regs na tela
    .oVGARead(wVGARead)                 // para mostrar Regs na tela
	);

/* ALU CTRL */
ALUControl ALUControlunit (
    .iFunct3(wFunct3),
    .iFunct7(wFunct7),
    .iOpcode(wOpcode),
    .iALUOp(wCALUOp),
    .oControlSignal(wALUControl)
	);

/* ALU */
ALU ALUunit(
    .iControl(wALUControl),
    .iA(wRead1),
    .iB(wOrigALU),
    .oALUresult(wALUresult),
    .oZero(wZero)
	);

Imm_Generator ImmGen(
    .inst(wInstr),
    .oImm(wImm)
	);

Ctrl_Transf CtrlT(
    .iFunct3(wFunct3),
    .iCOrigPC(wCOrigPC),
    //.iZero(oZero),  
	 .iZero(wZero),
    .oCTransf(wCTransf)
    );

	
MemStore MemStore0 (
    .iAlignment(wALUresult[1:0]),
    .iWriteTypeF(STORE_TYPE_DUMMY),
    .iFunct3(wFunct3),
    .iData(wRead2),
    .oData(wMemStore),
    .oByteEnable(wMemEnableStore),
    .oException()
	);

/* Barramento da memoria de dados */
assign DwReadEnable     = wCMemRead;
assign DwWriteEnable    = wCMemWrite;
assign DwByteEnable     = wMemEnable;
assign DwWriteData      = wMemDataWrite;
assign wReadData        = DwReadData;
assign DwAddress        = wALUresult;

MemLoad MemLoad0 (
    .iAlignment(wALUresult[1:0]),
    .iLoadTypeF(LOAD_TYPE_DUMMY),
    .iFunct3(wFunct3),
    .iData(wReadData),
    .oData(wMemAccess),
    .oException()
	);

/* Unidade de Controle */
Control_UNI CtrUNI (
    .iopc(wOpcode),
    .oOrigALU(wCOrigALU),
    .oOPBJ(wOPBJ),
    .oMem2Reg(wCMem2Reg),
    .oRegWrite(wCRegWrite),
    .oMemRead(wCMemRead),
    .oMemWrite(wCMemWrite),
    .oALUOp(wCALUOp),
    .oOrigPC(wCOrigPC),
    .oCStore(wCStore)
	);


/*Decide o que entrara na segunda entrada da ULA*/
always @(*)
    case(wCOrigALU)
       	1'b0:
            wOrigALU <= wRead2;
        1'b1:
            wOrigALU <= wImm;
        default:	  wOrigALU <= 5'bx;
    endcase


/*Decide qual sera o proximo PC*/

always @(*)
begin
  case(wOPBJ)
    1'b0:
        wMuxPC <= wPC;
    1'b1:
        wMuxPC <= wRead1;
  endcase
end

always @(*)
begin
    case(wCTransf)//(wCOrigPC)
        1'b0://normal
            wiPC <= wPC4;
        1'b1://BRANCH JAL JALR
            wiPC <= wMuxPC + wImm;
        default:		wiPC <= wPC4;
    endcase
end

/*Decide o que sera escrito no banco de registradores*/
always @(*)
    case(wCMem2Reg)
        2'b00:     wDataReg <= wALUresult;
        2'b01:     wDataReg <= wReadData;//                    32'hE0E0E0E0;            //wReadData;  // Slot vago, LW foi passada para wMemAcess
        2'b10:     wDataReg <= wPC4;
        //2'b11:     wDataReg <= wiPC;//wIPC + AUIPC
        2'b11:		 wDataReg <= wPC + wImm;
		  default:    wDataReg <= 32'b0;
    endcase


/*Decide o que sera escrito na Memoria de Dados*/
always @(*)
    case(wCStore)
        2'b00:                                          // Nao deve estar mais sendo usado para sw
           begin
            wMemDataWrite   <= wRead2;
            wMemEnable      <= 4'b1111;
           end
        2'b01:
           begin
            //wMemDataWrite   <= wRead2FPU;
            wMemEnable      <= 4'b1111;
           end
        2'b10:
           begin
            wMemDataWrite   <= wMemStore;
            wMemEnable      <= wMemEnableStore;
           end
        default:
           begin
            wMemDataWrite   <= 32'b0;
            wMemEnable      <= 4'b1111;
           end
    endcase


/* Para cada ciclo de Clock */

always @(posedge iCLK or posedge iRST)
begin
    if(iRST)
    begin
        PC      <= iInitialPC;
        PCgambs <= iInitialPC;
    end
    else
        PC 	<= wiPC;
end

endmodule
