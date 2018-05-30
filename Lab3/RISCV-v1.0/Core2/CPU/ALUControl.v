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
				FUNBEQ:
					oControlSignal  = OPSUB;
				FUNBNE:
					oControlSignal  = OPSUB;
				FUNBGE:
					oControlSignal  = OPSLT;
				FUNBGEU:
					oControlSignal  = OPSLTU;
				FUNBLT:
					oControlSignal  = OPSLT;
				FUNBLTU:
					oControlSignal  = OPSLTU;
				default:
					oControlSignal  = 5'b00000;
			endcase	 
        2'b10:
            case (iFunct3)
                FUNSLL:
                    oControlSignal  = OPSLL;
                FUNSRLeSRA:
						  case (iFunct7)
								FUN7SRA:
									oControlSignal  = OPSRA;
								FUN7SRL:
									oControlSignal  = OPSRL;
								default:
									oControlSignal  = 5'b00000;
						  endcase    
                FUNADD:
                    oControlSignal  = OPADD;
                FUNSUB:
                    oControlSignal  = OPSUB;
                FUNAND:
                    oControlSignal  = OPAND;
                FUNOR:
                    oControlSignal  = OPOR;
                FUNXOR:
                    oControlSignal  = OPXOR;
                FUNSLT:
                    oControlSignal  = OPSLT;
                FUNSLTU:
                    oControlSignal  = OPSLTU;
                default:
                    oControlSignal  = 5'b00000;
            endcase
        2'b11:
			oControlSignal  = OPLUI;
	endcase
end

endmodule
