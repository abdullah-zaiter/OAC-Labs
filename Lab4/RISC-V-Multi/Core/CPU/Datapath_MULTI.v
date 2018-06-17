/*
 * Caminho de Dados do Processador MIPS Multiciclo
 *
 */

module Datapath_MULTI (
// Inputs e clocks
input  wire 			iCLK, iCLK50, iRST,
input  wire [31:0] 	iInitialPC,


// Para monitoramento
output wire [31:0] wDebug,
input  wire [4:0] 	iRegDispSelect,
output wire [31:0] 	oPC, oDebug, oInstr, oRegDisp, 
input  wire	[4:0] 	wVGASelect,
output wire [31:0] 	wVGARead,
output wire [31:0] 	wBRReadA,
output wire [31:0] 	wBRReadB,
output wire [31:0] 	wBRWrite,
output wire [31:0] 	wULA,    
output wire wCTransf,

//Sinais Controle
output wire [5:0] 	owControlState,
output wire [1:0]  wCMem2Reg,
output wire [1:0] 	oALUOp, oALUSrcA,
output wire [2:0] 	oALUSrcB,
output wire 			oIRWrite, oIorD, oPCWrite, oRegWrite,
output wire [1:0] oPCSource,
//Sinais Instrução

//Load/STORES

//Barramento de Dados
output wire [31:0] DwAddress, DwWriteData,
input  wire	[31:0] DwReadData,
output wire DwWriteEnable, DwReadEnable,
output wire [3:0] DwByteEnable

);


//Adicionado no semestre 2014/1 para os load/stores
wire [2:0] 	wLoadCase;
wire [1:0] 	wWriteCase;
wire [3:0] 	wByteEnabler;
wire [31:0] wTreatedToMemory;
wire [31:0] wTreatedToRegister;
	
/* ****************************************************** */
/* Definicao dos fios e registradores							 */
reg [31:0] A, B, MDR, IR, ALUOut;


wire [2:0] wFunct3;
wire [6:0] wFunct7;
wire [6:0]  wOpcode;

reg  [31:0] PC, PCBack;        // registrador do PC
wire [31:0] wPC4;
wire [31:0] wiPC, wInstr;
wire [31:0] wImm;					//Saida Imediato

/* ****************************************************** */
/* Inicializacao dos registradores		  						 */
initial
begin
	PC			<= BEGINNING_TEXT;
	IR			<= 32'b0;
	ALUOut	<= 32'b0;
	MDR 		<= 32'b0;
	A 			<= 32'b0;
	B 			<= 32'b0;
end

/*
 * Local wires
 */

wire [1:0] 	ALUOp, ALUSrcA;
wire [2:0] 	ALUSrcB, Store;
wire [1:0] PCSource;
wire [4:0] 	wALUControl;

wire [4:0] 	wRs1, wRs2, wRD;

wire [31:0] wALUMuxA, wALUMuxB, wALUResult, wReadData1, wReadData2, wRegWriteData, wMemorALU, wMemWriteData, wMemReadData, wMemAddress, wPCMux;
/* ****************************************************** */
/* Definicao das estruturas assign		  						 */

assign wBRReadA		= wReadData1;
assign wBRReadB		= wReadData2;
assign wBRWrite		= wTreatedToRegister;
assign wULA			= wALUResult;


// /* Barramento da Memoria de Instrucoes */
// assign    IwReadEnable      = ON;
// assign    IwWriteEnable     = wCodeMemoryWrite;
// assign    IwByteEnable      = wMemEnable;
// assign    IwAddress         = wPC;
// assign    IwWriteData       = ZERO;

/* Output wires */
assign oPC			= PC;
assign oALUOp		= ALUOp;
assign oPCSource	= PCSource;
assign oALUSrcB	= ALUSrcB;
assign oIRWrite	= IRWrite;
assign oIorD		= IorD;
assign oPCWrite	= PCWrite;
assign oALUSrcA	= ALUSrcA;
assign oRegWrite	= RegWrite;
assign oInstr 		= IR;

/* Barramento da memoria de dados - RAM Memory bus module */

assign DwAddress 		= wMemAddress;
assign DwWriteData 		= wTreatedToMemory;
assign wMemReadData 	= DwReadData;
assign DwWriteEnable 	= MemWrite;
assign DwReadEnable 	= MemRead;
assign DwByteEnable 	= wByteEnabler;

//Condicionais
assign wMemAddress	= IorD ? ALUOut : PC;

/* ****************************************************** */
/* Inicializacao dos registradores		  						 */

/* Inicializacao */

assign wPC4         = wPC + 32'h4;                          /* Calculo PC+4 */
assign wPC          = PC;
assign wOpcode      = IR[6:0];
assign wRs1      	= IR[19:15];
assign wRs2     	= IR[24:20];
assign wRD       	= IR[11:7];
assign wFunct3      = IR[14:12];
assign wFunct7      = IR[31:25];
assign wInstr      	= IR;
assign wCodeMemoryWrite     = ((PC >= BEGINNING_BOOT && PC <= END_BOOT) ? 1'b1 : 1'b0);
assign wMemWriteData  =	B;
		

/* ****************************************************** */
/* Instanciacao das estruturas 	 		  						 */


Control_MULTI CrlMULTI (
	.iCLK(iCLK),
	.iRST(iRST),
	.iOp(wOpcode),
	.oIRWrite(IRWrite),
	.oMemtoReg(MemtoReg),
	.oMemWrite(MemWrite),
	.oMemRead(MemRead),
	.oIorD(IorD),
	.oPCWrite(PCWrite),
	.oPCSource(PCSource),
	.oALUOp(wCALUOp),
	.oALUSrcB(ALUSrcB),
	.oALUSrcA(ALUSrcA),
	.oRegWrite(RegWrite),
	.oState(owControlState),
	);

/* Register bank module */
Registers RegsMULTI (
	.iCLK(iCLK),
	.iCLR(iRST),
	.iReadRegister1(wRs1),
	.iReadRegister2(wRs2),
	.iWriteRegister(wRD),
	.iWriteData(wTreatedToRegister),//wRegWriteData),
	.iRegWrite(RegWrite),
	.oReadData1(wReadData1),
	.oReadData2(wReadData2),
	.iRegDispSelect(iRegDispSelect),
	.oRegDisp(oRegDisp),
	.iVGASelect(wVGASelect),
	.oVGARead(wVGARead)
	);

/*Immediate Generator*/
Imm_Generator ImmGen(
    .inst(wInstr),
    .oImm(wImm)
	);

/* Arithmetic Logic Unit module */
ALU ALUunit(
    .iControl(wALUControl),
    .iA(wALUMuxA),
    .iB(wALUMuxB),
    .oALUresult(wALUResult),
    .oZero(wZero)
	);


/* Arithmetic Logic Unit CTRL */
ALUControl ALUControlunit (
    .iFunct3(wFunct3),
    .iFunct7(wFunct7),
    .iOpcode(wOpcode),
    .iALUOp(wCALUOp),
    .oControlSignal(wALUControl)
	);


Ctrl_Transf CtrlT(
    .iFunct3(wFunct3),
    .iCOrigPC(PCSource), 
	.iZero(wZero),
    .oCTransf(wCTransf)
    );

MemStore MemStore0 (
	.iAlignment(wMemAddress[1:0]),
    .iWriteTypeF(STORE_TYPE_DUMMY),
    .iFunct3(wFunct3),
	.iData(wMemWriteData),
	.oData(wTreatedToMemory),
	.oByteEnable(wByteEnabler),
	.oException()
	);

MemLoad MemLoad0 (
    .iAlignment(wMemAddress[1:0]),
    .iLoadTypeF(LOAD_TYPE_DUMMY),
    .iFunct3(wFunct3),
	.iData(wRegWriteData),
	.oData(wTreatedToRegister),
	.oException()
	);

/* ****************************************************** */
/* multiplexadores							  						 */




// Mux WriteData
always @(*)
	case(MemtoReg)
		2'd0: wRegWriteData <= ALUOut;
		2'd1: wRegWriteData <= PC;
		2'd2: wRegWriteData <= MDR;
	endcase

// Mux OrigPC
always @(*)
	case (wCTransf)//PCSource)
		1'd0: wPCMux <= wALUResult;//PC+4 - Normal		
		1'd1: wPCMux <= ALUOut;//Valor calculado pra pular				 					
		default: wPCMux <= 32'd0;
	endcase





// Mux ALU input 'A'
always @(*)
	case (ALUSrcA)
		2'd0: wALUMuxA <= PC;
		2'd1: wALUMuxA <= A;
		default: wALUMuxA <= 32'd0;
	endcase


// Mux ALU input 'B'
always @(*)
	case (ALUSrcB)
		3'd0: wALUMuxB <= B;
		3'd1: wALUMuxB <= 32'h4;
		3'd2: wALUMuxB <= wImm;
		3'd3: wALUMuxB <= wImm;
		default: wALUMuxB <= 32'd0;
	endcase


/* ****************************************************** */
/* A cada ciclo de clock					  						 */

always @(posedge iCLK or posedge iRST)
begin
	if (iRST)
	begin
		PC			<= iInitialPC;
		PCBack		<= 32'b0;
		IR			<= 32'b0;
		ALUOut	<= 32'b0;
		MDR 		<= 32'b0;
		A 			<= 32'b0;
		B 			<= 32'b0;
	end
	else
	begin
		/* Unconditional */
		PCBack <= PC;
		ALUOut	<= wALUResult;
		A			<= wReadData1;
		B			<= wReadData2;
		MDR		<= wMemReadData;
		/* Conditional */
		//if((owControlState != STATE_BRANCH)&&(owControlState != STATE_JAL)&&(owControlState != STATE_JALR))//precisa disso nao
		if (PCWrite || wCTransf)//wCTransf já sinaliza se tem que escrever pc ou nao
			PC	<= wPCMux;

		if (IRWrite)
			IR	<= wMemReadData;

	end
end



endmodule
