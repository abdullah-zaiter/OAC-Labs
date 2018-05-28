////////////////////////////////////////////////////////////////////////////////
//                    RISC-V SiMPLE - Geração de Imediatos                    //
//                                                                            //
//   Baseado no codigo de https://github.com/arthurbeggs/riscv-simple         //
//                            BSD 3-Clause License                            //
////////////////////////////////////////////////////////////////////////////////


module imm_generator (
    input  [31:0] inst,
    output reg [31:0] immediate
);

always @ ( * ) begin
    case (inst[6:0]) // Opcode
        `OPC_LOAD,
        `OPC_OP_IMM
        `OPC_OP_IMM_32,
        `OPC_JALR:      // Opcodes com imediato do tipo I
            immediate = {{20{inst[31]}}, ins[31:20]};

        `OPC_STORE:     // Opcodes com imediato do tipo S
            immediate = {{20{inst[31]}}, inst[31:25], inst[11:7]};

        `OPC_BRANCH:    // Opcodes com imediato do tipo SB
            immediate = {{19{inst[31]}}, inst[31],inst[7], inst[30:25], inst[11:8], 1'b0};

        `OPC_AUIPC,
        `OPC_LUI:       // Opcodes com imediato do tipo U
            immediate = {inst[31:12], 12'b0};

        `OPC_JAL:    // Opcodes com imediato do tipo UJ
            immediate = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};

        default:
            // Tipo U possui o menor fanout para o bit inst[31];
            immediate = {inst[31:12], 12'b0};
    endcase
end


endmodule