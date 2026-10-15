`timescale 1ns / 1ps

// Instruction memory provided by Mahmoud Elfar, EECS 31L, Spring 2026.
// 64 words of 32 bits with asynchronous reads.

module InstMem (
    input  [7:0]  addr,
    output [31:0] instruction
);

    reg [31:0] memory [63:0];

    // Convert the byte address to a word index.
    assign instruction = memory[addr[7:2]];

    initial begin
        // Startup instruction used by the course design.
        memory[0]  = 32'h00000000;

        memory[1]  = 32'h00007033; // and  x0, x0, x0
        memory[2]  = 32'h00100093; // addi x1, x0, 1
        memory[3]  = 32'h00200113; // addi x2, x0, 2
        memory[4]  = 32'h00308193; // addi x3, x1, 3
        memory[5]  = 32'h00408213; // addi x4, x1, 4
        memory[6]  = 32'h00510293; // addi x5, x2, 5
        memory[7]  = 32'h00610313; // addi x6, x2, 6
        memory[8]  = 32'h00718393; // addi x7, x3, 7

        memory[9]  = 32'h00208433; // add  x8, x1, x2
        memory[10] = 32'h404404b3; // sub  x9, x8, x4
        memory[11] = 32'h00317533; // and  x10, x2, x3
        memory[12] = 32'h0041e5b3; // or   x11, x3, x4
        memory[13] = 32'h0041a633; // slt  x12, x3, x4

        // Course labels these NOR/NORI; standard encodings are XOR/XORI.
        memory[14] = 32'h007346b3; // xor  x13, x6, x7

        memory[15] = 32'h4d34f713; // andi x14, x9, 0x4D3
        memory[16] = 32'h8d35e793; // ori  x15, x11, -1837
        memory[17] = 32'h4d26a813; // slti x16, x13, 0x4D2
        memory[18] = 32'h4d244893; // xori x17, x8, 0x4D2

        memory[19] = 32'h02b02823; // sw   x11, 48(x0)
        memory[20] = 32'h03002603; // lw   x12, 48(x0)
    end

endmodule