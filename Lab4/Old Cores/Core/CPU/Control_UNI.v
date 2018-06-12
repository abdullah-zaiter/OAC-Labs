////////////////////////////////////////////////////////////////////////////////
//                    RISC-V SiMPLE - Controle                    				//
////////////////////////////////////////////////////////////////////////////////

 
module Control_UNI(
    input  [6:0] iopc,
    output wire oOrigALU,
	 output wire [1:0] oMem2Reg,
	 output wire oRegWrite,
	 output wire oMemRead,
	 output wire oMemWrite,
	 output wire [1:0] oALUOp,
	 output wire [1:0] oOrigPC,
	 output wire oOPBJ,
	 output [1:0] oCStore
);

always @ ( * ) begin
    case (iopc[6:0]) // Opcode
        OPC_OP:      // Opcodes do tipo R
        begin

					oOrigALU = 1'b0;
					oMem2Reg = 2'b00;
					oRegWrite = 1'b1;
					oMemRead = 1'b0;
					oMemWrite = 1'b0;
					oALUOp = 2'b10;
					oOrigPC = 2'b00;
					oOPBJ = 1'bx;
					oCStore = 2'b00;
				end
        OPC_OP_IMM:     // Opcodes com uso de imediatos
				begin
					
					oCStore = 2'b00;
					oOrigALU = 1'b1;
					oMem2Reg = 2'b00;
					oRegWrite = 1'b1;
					oMemRead = 1'b0;
					oMemWrite = 1'b0;
					oALUOp = 2'b10;
					oOrigPC = 2'b00;
					oOPBJ = 1'bx;
				end
        OPC_AUIPC:    // Opcode do auiPC 
				begin
					
					oCStore = 2'b00;
					oOrigALU = 1'bx;
					oMem2Reg = 2'b11;
					oRegWrite = 1'b1;
					oMemRead = 1'b0;
					oMemWrite = 1'b0;
					oALUOp = 2'bxx;
					oOrigPC = 2'b00;
					oOPBJ = 1'b0;
				end
        OPC_LUI:    // Opcode do lui
				begin
					
					oCStore = 2'b00;
					oOrigALU = 1'b1;
					oMem2Reg = 2'b00;
					oRegWrite = 1'b1;
					oMemRead = 1'b0;
					oMemWrite = 1'b0;
					oALUOp = 2'b11;
					oOrigPC = 2'b00;
					oOPBJ = 1'b0;
				end	
        OPC_BRANCH:    // Opcodes 
				begin
					
					oCStore = 2'b00;
					oOrigALU = 1'b0;
					oMem2Reg = 2'bxx;
					oRegWrite = 1'b0;
					oMemRead = 1'b0;
					oMemWrite = 1'b0;
					oALUOp = 2'b01;
					oOrigPC = 2'b01;
					oOPBJ = 1'b0;
				end	
        OPC_JAL:    // Opcodes 
				begin
					
					oCStore = 2'b00;
					oOrigALU = 1'bx;
					oMem2Reg = 2'b10;
					oRegWrite = 1'b1;
					oMemRead = 1'b0;
					oMemWrite = 1'b0;
					oALUOp = 2'bxx;
					oOrigPC = 2'b10;
					oOPBJ = 1'b0;
				end	
			OPC_JALR:    // Opcodes 
				begin
					
					oCStore = 2'b00;
					oOrigALU = 1'bx;
					oMem2Reg = 2'b10;
					oRegWrite = 1'b1;
					oMemRead = 1'b0;
					oMemWrite = 1'b0;
					oALUOp = 2'bxx;
					oOrigPC = 2'b11;
					oOPBJ = 1'b1;
				end	
			OPC_LOAD:    // Opcodes 
				begin
					
					oCStore = 2'b00;
					oOrigALU = 1'b1;
					oMem2Reg = 2'b01;
					oRegWrite = 1'b1;
					oMemRead = 1'b1;
					oMemWrite = 1'b0;
					oALUOp = 2'b00;
					oOrigPC = 2'b00;
					oOPBJ = 1'b0;
				end	
        OPC_STORE:    // Opcodes 
				begin
          oCStore = 2'b10;
					oOrigALU = 1'b1;
					oMem2Reg = 2'bxx;
					oRegWrite = 1'b0;
					oMemRead = 1'b0;
					oMemWrite = 1'b1;
					oALUOp = 2'b00;
					oOrigPC = 2'b00;
					oOPBJ = 1'b0;
				end
        default:
				begin
					
          oCStore = 2'b00;
					oOrigALU = 1'b0;
					oMem2Reg = 2'b00;
					oRegWrite = 1'b0;
					oMemRead = 1'b0;
					oMemWrite = 1'b0;
					oALUOp = 2'b00;
					oOrigPC = 2'b00;
					oOPBJ = 1'b0;
				end
            //resta fazer essa parte, n�o sei o que vem aqui
    endcase
end


endmodule