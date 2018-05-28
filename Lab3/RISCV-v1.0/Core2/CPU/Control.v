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
				OPBJ = 1'b0;
        `OPC_OP_IMM:     // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;

        `OPC_AUIPC:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;

        `OPC_AUIPC:       // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;

        `OPC_LUI:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;
        `OPC_BRANCH:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;
        `OPC_JAL:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;
			`OPC_JALR:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;
			`OPC_LOAD:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;
        `OPC_STORE:    // Opcodes 
            OrigALU = 1'b0;
				MemparaReg = 3'b000;
				EscreveReg = 1'b1;
				LeMem = 1'b0;
				EscreveMem = 1'b0;
				OpALU = 2'b10;
				OrigPC = 2'b00;
				OPBJ = 1'bX;

        default:
            // Tipo U possui o menor fanout para o bit opc[31];
            //immediate = {opc[31:12], 12'b0};
    endcase
end


endmodule