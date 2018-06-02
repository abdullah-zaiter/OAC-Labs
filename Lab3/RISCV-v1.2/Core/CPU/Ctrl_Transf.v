
module Ctrl_Transf (
    input  [2:0] iFunct3,
    input [1:0] iCOrigPC,
    input iZero,    
    output oCTransf
);
assign oCTransf = 1'b0;
/*
always @ ( * ) begin
    case (iCOrigPC)  
        2'b00:// 00 -> Normal
            oCTransf = 1'b0;
        2'b01:// 01 -> Branch 
			  case(iFunct3)
				 F3_BEQ:
					  oCTransf = (iZero) ? 1'b1 : 1'b0;
				 F3_BNE:
					  oCTransf = (!iZero) ? 1'b1 : 1'b0;
				 F3_BLT:
					  oCTransf = (!iZero) ? 1'b1 : 1'b0;
				 F3_BGE:
					  oCTransf = (iZero) ? 1'b1 : 1'b0;
				 F3_BLTU:
					  oCTransf = (!iZero) ? 1'b1 : 1'b0;
				 F3_BGEU:
					  oCTransf = (iZero) ? 1'b1 : 1'b0;
			  endcase
        2'b10:// 10 -> Jal 
            oCTransf = 1'b1;
        2'b11:// 11 -> Jalr
            oCTransf = 1'b1;
        default:
            oCTransf = 1'b0;
    endcase
end
*/
endmodule