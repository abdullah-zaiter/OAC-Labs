`ifndef PARAM
	`include "Parametros.v"
`endif
 
module ctrl_transf (
    input  [2:0] iFunct3,
    input [1:0] iOrigPC,
    input iZero,    
    output reg [31:0] transf
);

always @ ( * ) begin
    case (iOrigPC)  
        2'b00:// 00 -> Normal
            transf = 2'b00;
        2'b01:// 01 -> Branch
            begin
              case(iFunct3)
                `BRANCH_EQ,
                `BRANCH_NE,
                `BRANCH_LT,
                `BRANCH_GE,
                `BRANCH_LTU,
                `BRANCH_GEU:
                   if(iZero == 1'b0) // Se zero = 0, temos que rs1 == rs2
                        transf = 2'b01;
              endcase
            end
        2'b10:// 10 -> Jal
            transf = 2'b10;
        2'b11:// 11 -> Jalr
            transf = 2'b11;
    endcase
end


endmodule