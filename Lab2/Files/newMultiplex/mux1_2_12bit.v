module mux1_2_12bit(
	input sel,
	input [11:0] dado[1:0],
	output [11:0] saida
	);
	
	always @(*)
		case (sel)
			1'b0: saida = dado[0];
			1'b1: saida = dado[1];
			default: saida = 12'b0;
		endcase
			
endmodule
	