/*
 * ALUcontrol.v
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

module ALUControl (
	input wire [5:0] iOpcode,
	input wire [6:0] iFunct7,
	input wire [2:0] iFunct3,
	input wire [1:0] iALUOp,
	output reg [4:0] oControlSignal
	);
	
always @(*)
begin
    case (iALUOp)
        2'b00:
			oControlSignal  = OPADD;
        2'b01:
			case (iFunct3)
				F3_BEQ:
					oControlSignal  = OPSUB;
				F3_BNE:
					oControlSignal  = OPSUB;
				F3_BGE:
					oControlSignal  = OPSLT;
				F3_BGEU:
					oControlSignal  = OPSLTU;
				F3_BLT:
					oControlSignal  = OPSLT;
				F3_BLTU:
					oControlSignal  = OPSLTU;
				default:
					oControlSignal  = 5'b00000;
			endcase	 
        2'b10:
            case (iFunct3)
                F3_SLL:
                    oControlSignal  = OPSLL;
                F3_SRLeSRA:
						  case (iFunct7)
								F7_SRA:
									oControlSignal  = OPSRA;
								F7_SRL:
									oControlSignal  = OPSRL;
								default:
									oControlSignal  = 5'b00000;
						  endcase    
                F3_ADD:
                    oControlSignal  = OPADD;
                F3_SUB:
                    oControlSignal  = OPSUB;
                F3_AND:
                    oControlSignal  = OPAND;
                F3_OR:
                    oControlSignal  = OPOR;
                F3_XOR:
                    oControlSignal  = OPXOR;
                F3_SLT:
                    oControlSignal  = OPSLT;
                F3_SLTU:
                    oControlSignal  = OPSLTU;
                default:
                    oControlSignal  = 5'b00000;
            endcase
        2'b11:
			oControlSignal  = OPLUI;
	endcase
end

endmodule
