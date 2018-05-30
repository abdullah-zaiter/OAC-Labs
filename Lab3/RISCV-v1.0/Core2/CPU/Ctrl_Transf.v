
module ctrl_transf (
    input  [2:0] iFunct3,
    input [1:0] iOrigPC,
    input iZero,    
    output reg [1:0] oCTransf
);

always @ ( * ) begin
    case (iOrigPC)  
        2'b00:// 00 -> Normal
            oCTransf = 2'b00;
        2'b01:// 01 -> Branch
			  case(iFunct3)
				 F3BEQ:
					  oCTransf = (iZero) ? 2'b01 : 2'b00;
				 F3BNE:
					  oCTransf = (!iZero) ? 2'b01 : 2'b00;
				 F3BLT:
					  oCTransf = (!iZero) ? 2'b01 : 2'b00;
				 F3BGE:
					  oCTransf = (iZero) ? 2'b01 : 2'b00;
				 F3BLTU:
					  oCTransf = (!iZero) ? 2'b01 : 2'b00;
				 F3BGEU:
					  oCTransf = (iZero) ? 2'b01 : 2'b00;
			  endcase
        2'b10:// 10 -> Jal
            oCTransf = 2'b10;
        2'b11:// 11 -> Jalr
            oCTransf = 2'b11;
        default:
            oCTransf = 2'b00;
    endcase
end

endmodule