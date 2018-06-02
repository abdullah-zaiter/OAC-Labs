/*
 * ALU
 *
 */

module ALU (
	input [4:0] iControl,
	input signed [31:0] iA, 
	input signed [31:0] iB,
	output reg oZero,
	output reg [31:0] oALUresult
	);

//wire [4:0] iControl=OPLUI;

assign oZero = (oALUresult == ZERO);

wire [63:0] aux;
always @(*)
begin
    case (iControl)
		OPAND:
			oALUresult  = iA & iB;
		OPOR:
			oALUresult  = iA | iB;
		OPXOR:
			oALUresult  = iA ^ iB;
		OPADD:
			oALUresult  = iA + iB;
		OPSUB:
			oALUresult  = iA - iB;
		OPSLT:
			oALUresult  = iA < iB;
		OPSLTU:
			oALUresult  = $unsigned(iA) < $unsigned(iB);
		OPSLL:
			oALUresult  = iA << iB[4:0];
		OPSRL:
			oALUresult  = iA >> iB[4:0];
		OPSRA:
			oALUresult  = iA >>> iB[4:0];
		OPLUI:
			oALUresult  = iB;
		OPMUL:
		begin
			aux = (iA*iB);
			oALUresult  = aux[31:0];
		end
		OPMULH:
		begin
			aux = (iA*iB);
			oALUresult  = aux[63:32];
		end
		OPMULHU:
		begin
			aux = ($unsigned(iA)*$unsigned(iB));
			oALUresult  = aux[63:32];
		end
		OPMULHSU:
		begin
			aux = ($unsigned(iA)*iB);
			oALUresult  = aux[63:32];	
		end
		OPDIV:
			oALUresult  = iA / iB;
		OPDIVU:
			oALUresult  = $unsigned(iA) / $unsigned(iB);
		OPREM:
			oALUresult  = iA % iB;
		OPREMU:
			oALUresult  = $unsigned(iA) % $unsigned(iB);
		default:
			oALUresult  = ZERO;
    endcase
end

endmodule