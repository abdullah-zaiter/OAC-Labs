
`ifndef PARAM
	`include "Parametros.v"
`endif

`timescale 1 ns / 1 ps

module ALU_tb;

reg [31:0] IA, IB;
reg [4:0] ICONTROL;
wire [31:0] ORESULT;
wire OZERO;

ALU alu0 (
	.iA(IA),
	.iB(IB),
	.iControl(ICONTROL),
	.oResult(ORESULT),
	.oZero(OZERO)
	);
	
initial
	begin
	
		$display($time, " << Starting Simulation >> ");
		
		
		$display($time, " << AND >> ");
	
		IA = 32'hFFFFFFFF;
		IB = 32'hFFFFFFFF;
		ICONTROL = OPAND;
		
		#10
		IA = 32'h55555555;
		IB = 32'hAAAAAAAA;
		ICONTROL = OPAND;
		
		#10
		IA = 32'h00000000;
		IB = 32'h00000000;
		ICONTROL = OPAND;
		
		#10
		
		$display($time, " << OR >> ");
		
		IA = 32'hFFFFFFFF;
		IB = 32'hFFFFFFFF;
		ICONTROL = OPAND;
	
		#10 
		IA = 32'h55555555;
		IB = 32'hAAAAAAAA;
		ICONTROL = OPOR;
		
		#10
		IA = 32'h00000000;
		IB = 32'h00000000;
		ICONTROL = OPAND;
	
		
		
		#10
		
		$display($time, " << XOR >> ");
		
		IA = 32'hFFFFFFFF;
		IB = 32'hFFFFFFFF;
		ICONTROL = OPXOR;
	
		#10 
		IA = 32'h55555555;
		IB = 32'hAAAAAAAA;
		ICONTROL = OPXOR;
		
		#10
		IA = 32'h00000000;
		IB = 32'h00000000;
		ICONTROL = OPXOR;
		
		
		
		#10
		
		$display($time, " << ADD >> ");
		
		IA = 32'sd12;
		IB = 32'd13;
		ICONTROL = OPADD;
		
		#10
		IA = 32'd12;
		IB = 32'd12;
		ICONTROL = OPADD;
		
		#10
		IA = 32'hFFFFFFFFF;
		IB = 32'hFFFFFFFFF;
		ICONTROL = OPADD;
		

		#10
		
		$display($time, " << SUB >> ");

		IA = 32'd0;
		IB = 32'd1;
		ICONTROL = OPSUB;
		
		#10
		IA = 32'hFFFFFFFFF;
		IB = 32'hFFFFFFFFF;
		ICONTROL = OPSUB;
		
		
		#10
		$display($time, " << SLT >> ");

		
		IA = 32'd5;
		IB = 32'd3;
		ICONTROL = OPSLT;
		
		IA = 32'd3;
		IB = 32'd5;
		ICONTROL = OPSLT;
		
		#10
		$display($time, " << SLTU >> ");

		
		IA = 32'd7;
		IB = 32'shFFFFFFFF;
		ICONTROL = OPSLTU;
		
		
		#10
		$display($time, " << GE >> ");

		
		IA = 32'd3;
		IB = 32'd1;
		ICONTROL = OPGE;
		
		IA = 32'd1;
		IB = 32'd3;
		ICONTROL = OPGE;
		
		IA = 32'd3;
		IB = 32'shFFFFFFF0;//deve dar verdadeir
		ICONTROL = OPGE;
		
		#10
		$display($time, " << GEU >> ");
		
		IA = 32'd3;
		IB = 32'shFFFFFFF0;//falso
		ICONTROL = OPGEU;
		
		IA = 32'd3;
		IB = 32'd1;
		ICONTROL = OPGE;
		
		IA = 32'd1;
		IB = 32'd3;
		ICONTROL = OPGE;
		
		IA = 32'd0;
		IB = 32'd1;
		ICONTROL = OPGEU;
		
		
		#10
		$display($time, " << SLL >> ");

		IA = 32'd0;
		IB = 32'd1;
		ICONTROL = OPSLL;
		
		#10
		IA = 32'd3;
		IB = 32'd32;
		ICONTROL = OPSLL;
		
		#10
		IA = 32'd3;
		IB = 32'd2;
		ICONTROL = OPSLL;
		
		#10
		$display($time, " << SRL >> ");

		
		IA = 32'hFFFFFFFF;
		IB = 32'sh3;
		ICONTROL = OPSRL;
		
		#10
		IA = 32'd3;
		IB = 32'd32;
		ICONTROL = OPSRL;
		
		#10
		IA = 32'd3;
		IB = 32'd2;
		ICONTROL = OPSRL;
		
		
		#10
		$display($time, " << SRA >> ");

		IA = 32'hFFFFFFFF;
		IB = 32'sh3;
		ICONTROL = OPSRA;
		
		#10
		IA = 32'd3;
		IB = 32'd32;
		ICONTROL = OPSRA;
		
		#10
		IA = 32'd3;
		IB = 32'd2;
		ICONTROL = OPSRA;
		
		#10
		$display($time, " << LUI >> ");

		IA = 32'd0;
		IB = 32'd1;
		ICONTROL = OPLUI;
		
		#10
		IA = 32'hFFFF5000;
		IB = 32'b0;
		ICONTROL = OPLUI;
		
		
		#10
		$display($time, " << MUL >> ");		

		IA = 32'd2;
		IB = 32'd0;
		ICONTROL = OPMUL;
		
		#10
		IA = 32'hFFFFFFFF;
		IB = 32'd3;
		ICONTROL = OPMUL;	
			
		#10
		$display($time, " << MULH >> ");

		IA = 32'd2;
		IB = 32'd2;
		ICONTROL = OPMULH;
		
		#10
		IA = 32'hFFFFFFFF;
		IB = 32'd3;
		
		#10
		IA = 32'shFFFFFFFF;
		IB = 32'd3;
		
		#10
		$display($time, " << MULHU >> ");
		
		IA = 32'd2;
		IB = 32'd2;
		ICONTROL = OPMULHU;
		
		#10
		IA = 32'shFFFFFFFF;
		IB = 32'd3;
		
		#10
		IA = 32'd2;
		IB = 32'd1;
		ICONTROL = OPMULHU;
		
		#10
		IA = 32'd4;
		IB = -32'd2;
		ICONTROL = OPMULHU;
		
		#10
		$display($time, " << MULHSU >> ");

		IA = 32'd2;
		IB = 32'd2;
		ICONTROL = OPMULHSU;
		
		#10
		IA = 32'shFFFFFFFF;
		IB = 32'd3;
		ICONTROL = OPMULHSU;
		
		#10
		IA = 32'd2;
		IB = 32'd1;
		ICONTROL = OPMULHSU;
		
		#10
		IA = 32'd4;
		IB = -32'd2;
		ICONTROL = OPMULHSU;
		
		#10
		$display($time, " << DIV >> ");	
		IA = 32'd4;
		IB = 32'd2;
		ICONTROL = OPDIV;
		
		#10
		IA = 32'd8;
		IB = 32'd3;
		ICONTROL = OPDIV;
			
		#10	
		$display($time, " << DIVU >> ");	
		IA = 32'hFFFFFFF0;
		IB = 32'd4;
		ICONTROL = OPDIVU;
		
		#10
		IA = 32'hFFFFFFF0;
		IB = 32'hFFFFFFF0;
		ICONTROL = OPDIVU;
		
		#10
		$display($time, " << REM >> ");	
		IA = 32'd4;
		IB = 32'd2;
		ICONTROL = OPREM;
		
		#10
		IA = 32'd8;
		IB = 32'd3;
		ICONTROL = OPREM;
		
		#10
		IA = 32'hFFFFFFF0;
		IB = 32'd12;
		ICONTROL = OPREMU;
		
		
		#10
		$display($time, " << REMU >> ");	
		IA = 32'd4;
		IB = 32'd2;
		ICONTROL = OPREMU;
		
		#10
		IA = 32'hFFFFFFF0;
		IB = 32'd12;
		ICONTROL = OPREMU;
		
		
		#100;
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

	
initial
	begin
		$display("\t\ttime,\tiA,\tiB,\tiControl,\toResult,\toZero"); 
		$monitor("%d,\t%h,\t%h,\t%h,\t%h,\t%h,",$time, IA, IB, ICONTROL, ORESULT, OZERO);	
	end


endmodule
