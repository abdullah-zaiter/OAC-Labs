////////////////////////////////////////////////////////////////////////////////
//                    RISC-V SiMPLE - Controle                    				//
////////////////////////////////////////////////////////////////////////////////

`ifndef PARAM
	`include "Parametros.v"
`endif
 
module control (
    input  [6:0] opc,
    output wire OrigALU,
	 output wire [3:0] MemparaReg,
	 output wire EscreveReg,
	 output wire LeMem,
	 output wire EscreveMem,
	 output wire [2:0] OpALU,
	 output wire [2:0] OrigPC,
	 output wire OPBJ
);

always @ ( * ) begin
    case (opc[6:0]) // Opcode
        `OPC_OP:      // Opcodes do tipo R
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bx;
				
        `OPC_OP_IMM:     // Opcodes com uso de imediatos
            OrigALU = 1'b1;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b11;
				OrigPC = 2'b00;
				OPBJ = 1'bx;

        `OPC_AUIPC:    // Opcode dp auiPC 
            OrigALU = 1'bx;
				MemparaReg = 3'b100;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'bxx;
				OrigPC = 2'b00;
				OPBJ = 1'b0;

        `OPC_LUI:    // Opcode do lui
            OrigALU = 1'b1;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'bxx;
				OrigPC = 2'b00;
				OPBJ = 1'b0;
				
        `OPC_BRANCH:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'bxxx;
				EscreveReg = 1'b0;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b01;
				OrigPC = 2'b01;
				OPBJ = 1'b0;
				
        `OPC_JAL:    // Opcodes 
            OrigALU = 1'bx;
				MemparaReg = 3'b010;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'bx;
				OrigPC = 2'b10;
				OPBJ = 1'b0;
				
			`OPC_JALR:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b010;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'bxx;
				OrigPC = 2'b11;
				OPBJ = 1'b1;
				
			`OPC_LOAD:    // Opcodes 
            OrigALU = 1'b1;
				MemparaReg = 3'b001;
				EscreveReg = 1'b1;
				LeMem = 1'b1;
				EscreveMem = 1'b0;
				OpALU = 2'b00;
				OrigPC = 2'b00;
				OPBJ = 1'b0;
				
        `OPC_STORE:    // Opcodes 
            OrigALU = 1'b1;
				MemparaReg = 3'bxxx;
				EscreveReg = 1'b0;
				LeMem = 1'b0;
				EscreveMem = 1'b1;
				OpALU = 2'b00;
				OrigPC = 2'b00;
				OPBJ = 1'b0;

        default:
            //resta fazer essa parte, não sei o que vem aqui
    endcase
end


endmodule