module mux1_32_32bit(
	input [4:0] sel,
	input [31:0] dado[31:0],
	output [31:0]saida
	);
	
	always @(*)
		case (sel)
		
			5'b00000: saida = dado[0];
			5'b00001: saida = dado[1];
			5'b00010: saida = dado[2];
			5'b00011: saida = dado[3];
			5'b00100: saida = dado[4];
			5'b00101: saida = dado[5];
			5'b00110: saida = dado[6];
			5'b00111: saida = dado[7];
			5'b01000: saida = dado[8];
			5'b01001: saida = dado[9];
			5'b01010: saida = dado[10];
			5'b01011: saida = dado[11];
			5'b01100: saida = dado[12];
			5'b01101: saida = dado[13];
			5'b01110: saida = dado[14];
			5'b01111: saida = dado[15];

			5'b10000: saida = dado[16];
			5'b10001: saida = dado[17];
			5'b10010: saida = dado[18];
			5'b10011: saida = dado[19];
			5'b10100: saida = dado[20];
			5'b10101: saida = dado[21];
			5'b10110: saida = dado[22];
			5'b10111: saida = dado[23];
			5'b11000: saida = dado[24];
			5'b11001: saida = dado[25];
			5'b11010: saida = dado[26];
			5'b11011: saida = dado[27];
			5'b11100: saida = dado[28];
			5'b11101: saida = dado[29];
			5'b11110: saida = dado[30];
			5'b11111: saida = dado[31];		
			
			
			default: saida = 31'b0;
			
		endcase
			
endmodule