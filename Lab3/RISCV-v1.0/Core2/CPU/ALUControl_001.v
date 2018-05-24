/*
 * ALUcontrol_001.v
 *
 * Arithmetic Logic Unit control module.
 * Generates control signal to the ALU depending on the opcode and the funct field in the
 * current operation and on the signal sent by the processor control module.
 *
 * ALUOp    |    Control signal
 * -------------------------------------------
 * 00        |    The ALU performs an add operation.
 * 01        |    The ALU performs a subtract operation.
 * 10        |    The funct field determines the ALU operation.
 * 11        |    The opcode field (and the funct, of necessary) determines the ALU operation.
 */
// Deem Ctrl+F e procurem "TODO"
//Feito: iRt ===> iRs2
 
 
module ALUControl (
  input wire [5:0] iFunct, iOpcode, iRs2,   // 1/2016. Adicionado iRt.
    input wire [6:0] iFunct7,//TODO
    input wire [2:0] iFunct3,//TODO
  input wire [1:0] iALUOp,
  output reg [4:0] oControlSignal
  );
  
always @(*)
begin
    case (iALUOp)
        2'b00:
            oControlSignal  = OPADD;
        2'b01:
            oControlSignal  = OPSUB;
        2'b10:
        begin
            case (iFunct)
                FUNSLL:
                    oControlSignal  = OPSLL;
                FUNSRL:
                    oControlSignal  = OPSRL;
                FUNSRA:
                    oControlSignal  = OPSRA;
                FUNMFHI:
                    oControlSignal  = OPMFHI;                // 2015/1
                FUNMTHI:
                    oControlSignal  = OPMTHI;
                FUNMFLO:
                    oControlSignal  = OPMFLO;                // 2015/1
                FUNMTLO:
                    oControlSignal  = OPMTLO;
                FUNMULT:
                    oControlSignal  = OPMULT;
                FUNDIV:
                    oControlSignal  = OPDIV;
                FUNMULTU:
                    oControlSignal  = OPMULTU;
                FUNDIVU:
                    oControlSignal  = OPDIVU;
                FUNADD: