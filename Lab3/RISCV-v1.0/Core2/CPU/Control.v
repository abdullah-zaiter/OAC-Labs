////////////////////////////////////////////////////////////////////////////////
//                    RISC-V SiMPLE - Controle                    				//
////////////////////////////////////////////////////////////////////////////////

 
module control (
    input  [6:0] opc,
    output wire OrigALU,
	 output wire [1:0] MemparaReg,
	 output wire EscreveReg,
	 output wire LeMem,
	 output wire EscreveMem,
	 output wire [1:0] OpALU,
	 output wire [1:0] OrigPC,
	 output wire OPBJ
);

always @ ( * ) begin
    case (opc[6:0]) // Opcode
        OPC_OP:      // Opcodes do tipo R
        begin
					OrigALU = 1'b0;
					MemparaReg = 2'b00;
					EscreveReg = 1'b1;
					LeMem = 1'b0;
					EscreveMem = 1'b0;
					OpALU = 2'b10;
					OrigPC = 2'b00;
					OPBJ = 1'bx;
				end
        OPC_OP_IMM:     // Opcodes com uso de imediatos
				begin
					OrigALU = 1'b1;
					MemparaReg = 2'b00;
					EscreveReg = 1'b1;
					LeMem = 1'b0;
					EscreveMem = 1'b0;
					OpALU = 2'b10;
					OrigPC = 2'b00;
					OPBJ = 1'bx;
				end
        OPC_AUIPC:    // Opcode dp auiPC 
				begin
					OrigALU = 1'bx;
					MemparaReg = 2'b11;
					EscreveReg = 1'b1;
					LeMem = 1'b0;
					EscreveMem = 1'b0;
					OpALU = 2'bxx;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end
        OPC_LUI:    // Opcode do lui
				begin
					OrigALU = 1'b1;
					MemparaReg = 2'b00;
					EscreveReg = 1'b1;
					LeMem = 1'b0;
					EscreveMem = 1'b0;
					OpALU = 2'b11;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end	
        OPC_BRANCH:    // Opcodes 
				begin
					OrigALU = 1'b0;
					MemparaReg = 2'bxx;
					EscreveReg = 1'b0;
					LeMem = 1'b0;
					EscreveMem = 1'b0;
					OpALU = 2'b01;
					OrigPC = 2'b01;
					OPBJ = 1'b0;
				end	
        OPC_JAL:    // Opcodes 
				begin
					OrigALU = 1'bx;
					MemparaReg = 2'b10;
					EscreveReg = 1'b1;
					LeMem = 1'b0;
					EscreveMem = 1'b0;
					OpALU = 2'bxx;
					OrigPC = 2'b10;
					OPBJ = 1'b0;
				end	
			OPC_JALR:    // Opcodes 
				begin
					OrigALU = 1'bx;
					MemparaReg = 2'b10;
					EscreveReg = 1'b1;
					LeMem = 1'b0;
					EscreveMem = 1'b0;
					OpALU = 2'bxx;
					OrigPC = 2'b11;
					OPBJ = 1'b1;
				end	
			OPC_LOAD:    // Opcodes 
				begin
					OrigALU = 1'b1;
					MemparaReg = 2'b01;
					EscreveReg = 1'b1;
					LeMem = 1'b1;
					EscreveMem = 1'b0;
					OpALU = 2'b00;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end	
        OPC_STORE:    // Opcodes 
				begin
					OrigALU = 1'b1;
					MemparaReg = 2'bxx;
					EscreveReg = 1'b0;
					LeMem = 1'b0;
					EscreveMem = 1'b1;
					OpALU = 2'b00;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end
        default:
				begin
					OrigALU = 1'b0;
					MemparaReg = 2'b00;
					EscreveReg = 1'b0;
					LeMem = 1'b0;
					EscreveMem = 1'b0;
					OpALU = 2'b00;
					OrigPC = 2'b00;
					OPBJ = 1'b0;
				end
            //resta fazer essa parte, não sei o que vem aqui
    endcase
end


endmodule