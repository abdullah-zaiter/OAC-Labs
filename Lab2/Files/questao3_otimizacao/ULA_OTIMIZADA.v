/*
 * ALU
 *
 */

`ifndef PARAM
	`include "Parametros.v"
`endif
 
module ALU (
	input [4:0] iControl,
	input signed [31:0] iA, 
	input signed [31:0] iB,
	output reg oZero,
	output reg [31:0] oResult
	);

//wire [4:0] iControl=OPLUI;

assign oZero = (oResult == ZERO);

wire [63:0] aux;
always @(*)
begin
    case (iControl)
		OPAND:
			oResult  = iA & iB;
		OPOR:
			oResult  = iA | iB;
		OPXOR:
			oResult  = iA ^ iB;
		OPADD:
			oResult  = iA + iB;
		OPSUB:
			oResult  = iA - iB;
		OPSLT:
			oResult  = iA < iB;
		OPSLTU:
			oResult  = $unsigned(iA) < $unsigned(iB);
		OPGE:
			oResult = iA >= iB;
		OPGEU:
			oResult  = $unsigned(iA) >= $unsigned(iB);
		OPSLL:
			oResult  = iA << iB[4:0];
		OPSRL:
			oResult  = iA >> iB[4:0];
		OPSRA:
			oResult  = iA >>> iB[4:0];
		OPLUI:
			oResult  = {iA[31:12],12'b0};
		OPMUL:
		begin
			aux = (iA*iB);
			oResult  = aux[31:0];
		end
		OPMULH:
		begin
			aux = (iA*iB);
			oResult  = aux[63:32];
		end
		OPMULHU:
		begin
			aux = ($unsigned(iA)*$unsigned(iB));
			oResult  = aux[63:32];
		end
		OPMULHSU:
		begin
			aux = ($unsigned(iA)*iB);
			oResult  = aux[63:32];	
		end
		OPDIV:
			oResult  = iA / iB;
		OPDIVU:
			oResult  = $unsigned(iA) / $unsigned(iB);
		OPREM:
			oResult  = iA % iB;
		OPREMU:
			oResult  = $unsigned(iA) % $unsigned(iB);
		default:
			oResult  = ZERO;
    endcase
end

endmodule