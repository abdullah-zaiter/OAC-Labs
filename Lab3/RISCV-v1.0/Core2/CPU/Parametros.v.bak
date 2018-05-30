////////////////////////////////////////////////////////////////////////////////
//                         RISC-V SiMPLE - Constantes                         //
//                                                                            //
//   Baseado no codigo de https://github.com/arthurbeggs/riscv-simple         //
//                            BSD 3-Clause License                            //
////////////////////////////////////////////////////////////////////////////////


// Opcodes das instruções de 32 bits
`define    OPC_LOAD        7'b0000011
`define    OPC_OP_IMM      7'b0010011
`define    OPC_AUIPC       7'b0010111
`define    OPC_OP_IMM_32   7'b0011011
`define    OPC_STORE       7'b0100011

`define    OPC_OP          7'b0110011
`define    OPC_LUI         7'b0110111
`define    OPC_OP_32       7'b0111011

`define    OPC_BRANCH      7'b1100011
`define    OPC_JALR        7'b1100111
`define    OPC_JAL         7'b1101111


// Interpretação do campo funct3 para a Unidade Lógica e Aritmética
`define    ALU_ADD_SUB     3'b000
`define    ALU_SLL         3'b001
`define    ALU_SLT         3'b010
`define    ALU_SLTU        3'b011
`define    ALU_XOR         3'b100
`define    ALU_SHIFTR      3'b101
`define    ALU_OR          3'b110
`define    ALU_AND         3'b111

// Interpretação do campo funct3 para Branches
`define    BRANCH_EQ       3'b000
`define    BRANCH_NE       3'b001
`define    BRANCH_LT       3'b100
`define    BRANCH_GE       3'b101
`define    BRANCH_LTU      3'b110
`define    BRANCH_GEU      3'b111

// Valor inicial de pc
`define    INITIAL_PC      32'b0

// Intervalos de memória //FIXME: Colocar valores não arbitrários
`define     DATA_BEGIN      32'h07000000
`define     DATA_END        32'h070003FF
`define     TEXT_BEGIN      32'h00000000
`define     TEXT_END        32'h000001FF
