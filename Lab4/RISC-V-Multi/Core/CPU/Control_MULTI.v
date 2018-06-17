// `ifndef PARAM
// 	`include "Parametros.v"
// `endif

/*
 * Bloco de Controle MULTICICLO
 *
 */			
module Control_MULTI (
	/* I/O type definition */
	input wire 			iCLK, iRST,
	input wire 	[6:0] 	iOp,
	output wire 		oIRWrite, oMemWrite, oMemRead, oIorD, oPCWrite,oRegWrite, oALUSrcA,
	output wire [1:0] 	oALUOp, oALUSrcB, oPCSource, oMemtoReg,
	output wire [3:0] 	oState
);

logic	[14:0] 	word;				// sinais de controle do caminho de dados
reg 	[3:0] 	pr_state;		// present state
logic   [3:0] 	nx_state;		// next state


assign	oIorD					= word[0];
assign	oIRWrite				= word[1];
assign	oPCWrite				= word[2];
assign	oMemWrite			    = word[3];
assign	oMemRead				= word[4];
assign	oMemtoReg			    = word[6:5];
assign	oRegWrite			    = word[7];
assign	oALUSrcB				= word[9:8];
assign	oALUSrcA				= word[10];
assign	oALUOp			    	= word[12:11];
assign	oPCSource		    	= word[14:13];


assign	oState		= pr_state;


initial
begin
	pr_state	<= STATE_FETCH;
end

/* Main control block */
always @(posedge iCLK or posedge iRST)
begin
	if (iRST)
		pr_state	<= STATE_FETCH;
	else
		pr_state	<= nx_state;
end

always @(*)
begin
	case (pr_state)
		STATE_FETCH:
		begin
            word		<= 15'b000000100010110;
			nx_state	<= STATE_DECODE;
		end
		
		STATE_DECODE:
		begin
			word		<= 15'b000001100000000;
			case (iOp)
				OPC_STORE,
				OPC_LOAD:
					nx_state <= STATE_LWSW;
				OPC_OP:
					nx_state <= STATE_R1;
				OPC_OP_IMM,
				OPC_AUIPC,
				OPC_LUI:
					nx_state <= STATE_IMM;
				OPC_BRANCH:
					nx_state <= STATE_BRANCH;
				OPC_JAL:
					nx_state <= STATE_JAL;
				OPC_JALR:
					nx_state <= STATE_JALR;
				default:
					nx_state <= STATE_R1;
			endcase
		end
		STATE_LWSW:
		begin
			word		<= 15'b000011000000000;
			nx_state <= (iOp==OPC_LOAD) ? STATE_LW : STATE_SW ;
		end
		STATE_LW:
		begin
		  	word		<= 15'b000000000010001;
			nx_state 	<= STATE_LW2;
		end 
		STATE_SW:
		begin
		  	word		<= 15'b000000000001001;
			nx_state	<= STATE_FETCH;
		end
		STATE_LW2:
		begin
		  	word		<= 15'b000000011000000;
			nx_state	<= STATE_FETCH;
		end
		STATE_R1:
		begin
		  	word		<= 15'b001010000000000;
			nx_state	<= STATE_R2;
		end
		STATE_R2:
		begin
		  	word		<= 15'b000000010000000;
			nx_state	<= STATE_FETCH;
		end
		STATE_BRANCH:
		begin
		  	word		<= 15'b010110000000000;
			nx_state	<= STATE_FETCH;
		end
		STATE_JAL:
		begin
		  	word		<= 15'b100000010100100;
			nx_state	<= STATE_FETCH;
		end
		STATE_IMM:
		begin
		  	word		<= 15'b001001000000000;
			nx_state	<= STATE_R2;
		end
		STATE_JALR:
		begin
		  	word		<= 15'b000011011100100;
			nx_state	<= STATE_FETCH;
		end
	endcase
end

endmodule
