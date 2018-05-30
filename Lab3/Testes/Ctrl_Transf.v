`ifndef PARAM
	`include "Parametros.v"
`endif
 
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
            begin
              case(iFunct3)
                `BRANCH_EQ:
                    oCTransf = (iZero) ? 2'b01 : 2'b00;
                `BRANCH_NE:
                    oCTransf = (!iZero) ? 2'b01 : 2'b00;
                `BRANCH_LT:
                    oCTransf = (!iZero) ? 2'b01 : 2'b00;
                `BRANCH_GE:
                    oCTransf = (iZero) ? 2'b01 : 2'b00;
                `BRANCH_LTU:
                    oCTransf = (!iZero) ? 2'b01 : 2'b00;
                `BRANCH_GEU:
                    oCTransf = (iZero) ? 2'b01 : 2'b00;
              endcase
            end
        2'b10:// 10 -> Jal
            oCTransf = 2'b10;
        2'b11:// 11 -> Jalr
            oCTransf = 2'b11;
        default:
            oCTransf = 2'b00;
    endcase
end

endmodule