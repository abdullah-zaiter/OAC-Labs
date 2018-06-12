`ifndef PARAM
	`include "../Parametros.v"
`endif

/*
 * Bloco de Controle MULTICICLO
 *
 */		

module Control_MULTI (
	/* I/O type definition */
	input wire 				iCLK, iRST,
	input wire 	[6:0] 	iOp, iFunct7,
	output wire 			oIRWrite, oMemtoReg, oMemWrite, oMemRead, oIorD, 
								oPCWrite, oPCWriteBEQ, oPCWriteBNE,oRegWrite, 
	output wire [1:0] 	oALUOp, oALUSrcA,
	output wire [2:0] 	oALUSrcB, oPCSource, oStore,
	output wire [5:0] 	oState,
	output wire [2:0] 	oLoadCase,
	output wire [1:0] 	oWriteCase
	);


logic	[40:0] 	word;				// sinais de controle do caminho de dados
reg 	[5:0] 	pr_state;		// present state
logic [5:0] 	nx_state;		// next state

assign	oWriteCase 			= word[39:38];
assign	oLoadCase		 	= word[37:35];
assign	oStore				= word[22:20];
assign	oPCWrite				= word[19];
assign	oPCWriteBNE			= word[18];
assign	oPCWriteBEQ			= word[17];
assign	oIorD					= word[16];
assign	oMemRead				= word[15];
assign	oMemWrite			= word[14];
assign	oIRWrite				= word[13];
assign	oMemtoReg			= word[12];
assign	oPCSource			= word[11:9];
assign	oALUOp				= word[8:7];
assign	oALUSrcB				= word[6:4];
assign	oALUSrcA				= word[3:2];
assign	oRegWrite			= word[1];

assign	oState		= pr_state;


initial
begin
	pr_state	<= FETCH;
end



/* Main control block */
always @(posedge iCLK or posedge iRST)
begin
	if (iRST)
		pr_state	<= FETCH;
	else
		pr_state	<= nx_state;
end



always @(*)
begin
	
	case (pr_state)
	
		FETCH:
		begin
			word		<= 41'b00000000000000000000010001010000000010000;
			nx_state	<= DECODE;
		end
		
		DECODE:
		begin
			word		<= 41'b00000000000000000000000000000000000110000;
			case (iOp)
						
				OPCRFMT:
					case (iFunct)
						FUNJR:
							nx_state <= JR;
						FUNSLL, 
						FUNSRL, 
						FUNSRA: 						
							nx_state	<= SHIFT;
						FUNSYS:
							nx_state	<= iCOP0UserMode ? COP0EXC : FETCH;
						default:
							nx_state	<= RFMT;
					endcase
									
				OPCJMP:
					nx_state	<= JUMP;
					
				OPCBEQ:
					nx_state	<= BEQ;
					
				OPCLB,
				OPCLBU,
				OPCLH,
				OPCLHU,
				OPCSB,
				OPCSH,
				OPCLW,
				OPCSW,
				OPCLWC1,	//Load e Store da FPU
				OPCSWC1:
					nx_state	<= LWSW;

				OPCANDI,
				OPCORI,
				OPCXORI:
					nx_state	<= IFMTL;
					
				OPCADDI,
				OPCADDIU,
				OPCSLTI,
				OPCSLTIU,
				OPCLUI:
					nx_state	<= IFMTA;
					
		
		LWSW:
		begin
			word	<= 41'b00000000000000000000000000000000000100100;
			case (iOp)
				OPCLW,				
				OPCLB,
				OPCLBU,
				OPCLH,
				OPCLHU:
				OPCSB:								
					nx_state <= STATE_SB;		
				OPCSH:								
					nx_state <= STATE_SH;		
				OPCSW:
					nx_state	<= SW;
				default:
					nx_state	<= ERRO;
			endcase
		end
		
		LW:
		begin
			word	<= 41'b00000000000000000000000011000000000000000;
			case (iOp)
				OPCLW:
					nx_state	<= LW2;
				OPCLB:
					nx_state <= STATE_LB;
				OPCLBU:
					nx_state <= STATE_LBU;
				OPCLH:
					nx_state <= STATE_LH;
				OPCLHU:
					nx_state <= STATE_LHU;
				default:
					nx_state	<= ERRO;
			endcase
		end
		
		
		LW2:
		begin
			word		<= 41'b00000000000000000000000000001000000000010;
			nx_state	<= FETCH;
		end
		
		STATE_LB:
		begin
			word		<= 41'b00001100000000000000000000001000000000010;
			nx_state	<= FETCH;
		end
		
		STATE_LBU:
		begin
			word		<= 41'b00010000000000000000000000001000000000010;
			nx_state	<= FETCH;
		end
		
		STATE_LH:
		begin
			word	<= 41'b00000100000000000000000000001000000000010;
			nx_state	<= FETCH;
		end
		
		STATE_LHU:
		begin
			word		<= 41'b00001000000000000000000000001000000000010;
			nx_state	<= FETCH;
		end
		
		STATE_SB:
		begin
			word	<= 41'b01000000000000000000000010100000000000000;
			nx_state	<= FETCH;
		end
		
		STATE_SH:
		begin
			word	<= 41'b00100000000000000000000010100000000000000;
			nx_state	<= FETCH;
		end
		
		SW:
		begin
			word		<= 41'b00000000000000000000000010100000000000000;
			nx_state	<= FETCH;
		end
				
		RFMT:
		begin
			word		<= 41'b00000000000000000000000000000000100000100;
			case (iFunct)
				FUNMULT,
				FUNDIV,
				FUNMULTU,
				FUNDIVU:
					nx_state	<= FETCH;
				default:
					nx_state	<= RFMT2;
			endcase
		end
		
		RFMT2:
		begin
			word		<= 41'b00000000000000000000000000000000000000011;
			nx_state	<= ((iFunct == FUNADD || iFunct == FUNSUB) && iCOP0ALUoverflow && ~iCOP0ExcLevel) || wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		SHIFT:
		begin
			word		<= 41'b00000000000000000000000000000000100001000;
			nx_state	<= RFMT2;
		end
		
		IFMTL:
		begin
			word		<= 41'b00000000000000000000000000000000111000100;
			nx_state	<= IFMT2;
		end
		
		IFMTA:
		begin
			word		<= 41'b00000000000000000000000000000000110100100;
			nx_state	<= IFMT2;
		end
		
		IFMT2:
		begin
			word		<= 41'b00000000000000000000000000000000000000010;
			nx_state	<= (iOp == OPCADDI && iCOP0ALUoverflow && ~iCOP0ExcLevel) || wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		BEQ:
		begin
			word		<= 41'b00000000000000000000000100000001010000100;
			nx_state	<= FETCH;
		end

		BNE:
		begin
			word		<= 41'b00000000000000000000001000000001010000100;
			nx_state	<= FETCH;
		end

		JUMP:
		begin
			word		<= 41'b00000000000000000000010000000010000000000;
			nx_state	<= FETCH;
		end

		JAL:
		begin
			word		<= 41'b00000000000000000000110000000010111010010;
			nx_state	<= FETCH;
		end		
		
		JR:
		begin
			word		<= 41'b00000000000000000000010000000011000000000;
			nx_state	<= FETCH;
		end
						
		ERRO:
		begin
			word  	<= 41'b00000000000000000000000000000000000000001;
			nx_state	<= ERRO;
		end

		default:
		begin
			word		<= 41'b0;
			nx_state	<= ERRO;
		end
		endcase
	endcase
end

endmodule
