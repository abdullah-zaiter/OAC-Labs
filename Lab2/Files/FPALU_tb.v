
`ifndef PARAM
	`include "Parametros.v"
`endif

`timescale 1 ns / 1 ps

module FPALU_tb;

reg ICLOCK;
reg [31:0] IA, IB;
reg [4:0] ICONTROL;
wire [31:0] ORESULT;
wire OZERO,ONAN,OOVERFLOW,OUNDERFLOW,OCOMPRESULT;

always
	#5 ICLOCK = ~ICLOCK;	// T=5+5 Clock de 100MHz

FPALU fpalu0 (
	.iclock(ICLOCK),
	.idataa(IA),
	.idatab(IB),
	.icontrol(ICONTROL),
	.oresult(ORESULT),
	.onan(ONAN),
	.ozero(OZERO), 
	.ooverflow(OOVERFLOW), 
	.ounderflow(OUNDERFLOW),
	.oCompResult(OCOMPRESULT)
	);

	
initial
	begin
	
		//$display(" << Inicio da Simulacao >> ");
		ICLOCK=1'b0;
		$display($time, "<< Operacoes com resultados comuns >>");
		$display("<< ADD >>");
		IA = 32'h3F800001; // 1.0
		IB = 32'h40000000; // 2.0
		ICONTROL = FOPADD;
	
		#200 
		$display("<< SUB >>");
		IA = 32'h40000000;  //2.0 
		IB = 32'h40800000;  // 4.0
		ICONTROL = FOPSUB;
		
		#200
		$display("<< MUL >>");
		IA = 32'h40400000;  //3.0
		IB = 32'h3FC00000;  // 1.5
		ICONTROL = FOPMUL;
		
		#200
		$display("<< DIV >>");
		IA = 32'h40400000; // 3.0
		IB = 32'h40000000; // 2.0
		ICONTROL = FOPDIV;

		#200
		$display("<< SQRT >>");
		IA = 32'h41500000; // 13.0
		IB = 32'h0;
		ICONTROL = FOPSQRT;

		#200
		$display("<< ABS >>");
		IA = 32'hBF800000;  //-1.0
		IB = 32'h0;
		ICONTROL = FOPABS;
		
		#200
		$display("<< NEG >>");
		IA = 32'h3F800000;  //1.0
		IB = 32'h0;
		ICONTROL = FOPNEG;
		
		#200
		$display("<< CEQ >>");
		IA = 32'h3F800000;	//1.0
		IB = -32'h3F800000;  //1.0
		ICONTROL = FOPCEQ;
		
		#200
		$display("<< CLT >>");
		IA = 32'h3F800000;  // 1.0
		IB = 32'h40000000;  //2.0
		ICONTROL = FOPCLT;
		
		#200
		$display("<< CLE >>");
		IA = 32'h3F800000;  // 1.0
		IB = 32'h40000000;  // 2.0
		ICONTROL = FOPCLE;
		
		#200
		$display("<< CVTSW >>");
		IA = 32'h4;			// 4
		IB = 32'h0;
		ICONTROL = FOPCVTSW;

		#200
		$display("<< CVTWS >>");
		IA = 32'h40800000; // 4.0
		IB = 32'h0;
		ICONTROL = FOPCVTWS;
		
		
		

		
		#200 
		$display($time, "<< Operacoes com resultados singulares >>");
		$display("<< ADD entre um numero muito grande e um muito pequeno >>");
		IA = 32'h7F000000;  	// 2^127
		IB = 32'h00800000;	// 2^(-126)	exemplo de erro de arredondamento
		ICONTROL = FOPADD;
		
		#200
		$display("<< Divisao por zero >>");
		IA = 32'h40400000;  	// 3.0
		IB = 32'h00000000;  	// 0.0	exemplo de divisao por zero
		ICONTROL = FOPDIV;
		
		#200
		$display("<< MUL de (2^127)*(2^127) resulta em Overflow >>");
		IA = 32'h7F000000;  	// 2^127
		IB = 32'h7f000000; 	// 2^127  exemplo de OVERFLOW
		ICONTROL = FOPMUL;
		
		#200
		$display("<< Divisao de 2^(-126) por 2^8 resulta em Underflow >>");
		IA = 32'h00800000;	// 2^(-126)
		IB = 32'h43800000;	// 2^8		EXEMPLO DE UNDERFLOW
		ICONTROL = FOPDIV;
		
		#200
		$display("<< Resultado de 5-5 = 0 >>");
		IA = 32'h40A00000;	// 5
		IB = 32'hC0A00000;	// -5			exemplo de resultado zero
		ICONTROL = FOPADD;
		
		#200
		$display($time, "<< Final da Simulacao >>");
		$stop;
	end

	
initial
	begin
//		$display("                 time, Clock, iA,       iB,       iControl, oResult,      oZero, oNaN, oVerflow, oUnderflow, oCompResult"); 
//		$monitor("%d,   %b,    %h, %h, %d,       %h,      %b,    %b,    %b,        %b,          %b",$time, ICLOCK, IA, IB, ICONTROL, ORESULT, 
//				   OZERO,ONAN,OOVERFLOW,OUNDERFLOW,OCOMPRESULT);	
					
		$display("                 time, iA,       iB,       iControl, oResult,      oZero, oNaN, oVerflow, oUnderflow, oCompResult"); 
		$monitor("%d,  %h, %h, %d,       %h,      %b,    %b,    %b,        %b,          %b",$time, IA, IB, ICONTROL, ORESULT, 
				   OZERO,ONAN,OOVERFLOW,OUNDERFLOW,OCOMPRESULT);	
	
	end


endmodule
