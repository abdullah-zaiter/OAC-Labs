module mux1_16(
	input [2:0] sel,
	input dado [15:0],
	output saida
	);
	
	always @(*)
		case (sel)
			4'b0000: saida = dado[0];
			4'b0001: saida = dado[1];
			4'b0010: saida = dado[2];
			4'b0011: saida = dado[3];
			4'b0100: saida = dado[4];
			4'b0101: saida = dado[5];
			4'b0110: saida = dado[6];
			4'b0111: saida = dado[7];
			4'b1000: saida = dado[8];
			4'b1001: saida = dado[9];
			4'b1010: saida = dado[10];
			4'b1011: saida = dado[11];
			4'b1100: saida = dado[12];
			4'b1101: saida = dado[13];
			4'b1110: saida = dado[14];
			4'b1111: saida = dado[15];			
			
			default: saida = 4'b0000;
		endcase
			
endmodule
	