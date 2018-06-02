////////////////////////////////////////////////////////////////////////////////
//                    RISC-V SiMPLE - Controle                    				//
////////////////////////////////////////////////////////////////////////////////

 
module control (
    input  [6:0] opc,
    output wire OrigALU,
	 output wire [1:0] Mem2Reg,
	 output wire RegWrite,
	 output wire MemRead,
	 output wire MemWrite,
	 output wire [1:0] ALUOp,
	 output wire [1:0] OrigPC,
	 output wire OPBJ,
	 output [1:0] oCStore
);

always @ ( * ) begin
    case (opc[6:0]) // Opcode
        OPC_OP:      // Opcodes do tipo R
        begin

					OrigALU = 1'b0;
					Mem2Reg = 2'b00;
					RegWrite = 1'b1;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					ALUOp = 2'b10;
					OrigPC = 2'b00;
					OPBJ = 1'bx;
					oCStore = 2'b00;
				end
        OPC_OP_IMM:     // Opcodes com uso de imediatos
				begin
					
					oCStore = 2'b00;
					OrigALU = 1'b1;
					Mem2Reg = 2'b00;
					RegWrite = 1'b1;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					ALUOp = 2'b10;
					OrigPC = 2'b00;
					OPBJ = 1'bx;
				end
        OPC_AUIPC:    // Opcode dp auiPC 
				begin
					
					oCStore = 2'b00;
					OrigALU = 1'bx;
					Mem2Reg = 2'b11;
					RegWrite = 1'b1;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					ALUOp = 2'bxx;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end
        OPC_LUI:    // Opcode do lui
				begin
					
					oCStore = 2'b00;
					OrigALU = 1'b1;
					Mem2Reg = 2'b00;
					RegWrite = 1'b1;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					ALUOp = 2'b11;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end	
        OPC_BRANCH:    // Opcodes 
				begin
					
					oCStore = 2'b00;
					OrigALU = 1'b0;
					Mem2Reg = 2'bxx;
					RegWrite = 1'b0;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					ALUOp = 2'b01;
					OrigPC = 2'b01;
					OPBJ = 1'b0;
				end	
        OPC_JAL:    // Opcodes 
				begin
					
					oCStore = 2'b00;
					OrigALU = 1'bx;
					Mem2Reg = 2'b10;
					RegWrite = 1'b1;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					ALUOp = 2'bxx;
					OrigPC = 2'b10;
					OPBJ = 1'b0;
				end	
			OPC_JALR:    // Opcodes 
				begin
					
					oCStore = 2'b00;
					OrigALU = 1'bx;
					Mem2Reg = 2'b10;
					RegWrite = 1'b1;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					ALUOp = 2'bxx;
					OrigPC = 2'b11;
					OPBJ = 1'b1;
				end	
			OPC_LOAD:    // Opcodes 
				begin
					
					oCStore = 2'b00;
					OrigALU = 1'b1;
					Mem2Reg = 2'b01;
					RegWrite = 1'b1;
					MemRead = 1'b1;
					MemWrite = 1'b0;
					ALUOp = 2'b00;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end	
        OPC_STORE:    // Opcodes 
				begin
          oCStore = 2'b10;
					OrigALU = 1'b1;
					Mem2Reg = 2'bxx;
					RegWrite = 1'b0;
					MemRead = 1'b0;
					MemWrite = 1'b1;
					ALUOp = 2'b00;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end
        default:
				begin
					
          oCStore = 2'b00;
					OrigALU = 1'b0;
					Mem2Reg = 2'b00;
					RegWrite = 1'b0;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					ALUOp = 2'b00;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end
            //resta fazer essa parte, não sei o que vem aqui
    endcase
end


endmodule