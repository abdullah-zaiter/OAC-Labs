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
	input wire [9:0] iFunct,
	input wire [2:0] iFunct3,
	input wire [1:0] iALUOp,
	output reg [4:0] oControlSignal
	);
	
always @(*)
begin
    case (iALUOp)
        2'b00:
            oControlSignal  = OPADD;
        2'b01: //condições de branch
			case (iFunct3)
				FUNBEQ:
					oControlSignal  = OPBEQ;
				FUNBNE:
					oControlSignal  = OPBNE;
				FUNBGE:
					oControlSignal  = OPGE;
				FUNBGEU:
					oControlSignal  = OPGEU;
				FUNBLT:
					oControlSignal  = OPSLT;
				FUNBLTU:
					oControlSignal  = OPSLTU;
				default:
					oControlSignal  = 5'b00000;
			endcase	 
        2'b10:
				case (iOpcode)
					 OPCLUI:
							oControlSignal = OPLUI;
					 default:
                    oControlSignal  = 5'b00000;
				endcase
            case (iFunct)
                FUNSLL:
                    oControlSignal  = OPSLL;
                FUNSRL:
                    oControlSignal  = OPSRL;
                FUNSRA:
                    oControlSignal  = OPSRA;
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
			begin
				case (iFunct3)
						FUNADDI:
							oControlSignal  = OPADD;
						FUNSLTI:
							oControlSignal  = OPSLT;
						FUNSLTIU:
							oControlSignal  = OPSLTU;
						FUNANDI:
							oControlSignal  = OPAND;
						FUNORI:
							oControlSignal  = OPOR;
						FUNXORI:
							oControlSignal  = OPXOR;
						default:                        //instr. inválida
							oControlSignal  = 5'b00000;
				endcase
				case (iFunct)
						FUNSLLI:
							oControlSignal  = OPSLL;
						FUNSRLI:
							oControlSignal  = OPSRL;
						FUNSRAI:
							oControlSignal  = OPSRA;
						default:                        //instr. inválida
							oControlSignal  = 5'b00000;
				endcase
			end
	endcase
end

endmodule
