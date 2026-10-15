`timescale 1ns / 1ps

// Processor integration implemented by Ricky Chen.
// Based on the EECS 31L course template.

module processor (
    input         clk,
    input         reset,
    output [31:0] Result
);

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [1:0] ALUOp;
    wire [3:0] ALU_CC;

    wire ALUSrc;
    wire MemtoReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;

    // Generate datapath control signals from the opcode.
    Controller controller_pu (
        .Opcode   (opcode),
        .ALUSrc   (ALUSrc),
        .MemtoReg (MemtoReg),
        .RegWrite (RegWrite),
        .MemRead  (MemRead),
        .MemWrite (MemWrite),
        .ALUOp    (ALUOp)
    );

    // Decode the ALU operation.
    ALUController alucontroller_pu (
        .ALUOp     (ALUOp),
        .Funct7    (funct7),
        .Funct3    (funct3),
        .Operation (ALU_CC)
    );

    // Execute instructions through the datapath.
    data_path data_path_pu (
        .clk        (clk),
        .reset      (reset),
        .reg_write  (RegWrite),
        .mem2reg    (MemtoReg),
        .alu_src    (ALUSrc),
        .mem_write  (MemWrite),
        .mem_read   (MemRead),
        .alu_cc     (ALU_CC),
        .opcode     (opcode),
        .funct7     (funct7),
        .funct3     (funct3),
        .alu_result (Result)
    );

endmodule