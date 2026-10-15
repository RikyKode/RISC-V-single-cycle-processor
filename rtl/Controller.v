`timescale 1ns / 1ps

// Controller implemented by Ricky Chen.
// Based on the EECS 31L course template.

module Controller (
    input      [6:0] Opcode,
    output reg       ALUSrc,
    output reg       MemtoReg,
    output reg       RegWrite,
    output reg       MemRead,
    output reg       MemWrite,
    output reg [1:0] ALUOp
);

    always @(*) begin
        // Default: disable register and memory writes.
        ALUSrc   = 1'b0;
        MemtoReg = 1'b0;
        RegWrite = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        ALUOp    = 2'b00;

        case (Opcode)
            // Register arithmetic
            7'b0110011: begin
                RegWrite = 1'b1;
                ALUOp    = 2'b10;
            end

            // Immediate arithmetic
            7'b0010011: begin
                ALUSrc   = 1'b1;
                RegWrite = 1'b1;
                ALUOp    = 2'b00;
            end

            // Loads
            7'b0000011: begin
                ALUSrc   = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead  = 1'b1;
                ALUOp    = 2'b01;
            end

            // Stores
            7'b0100011: begin
                ALUSrc   = 1'b1;
                MemWrite = 1'b1;
                ALUOp    = 2'b01;
            end

            default: begin
                // Keep the default control values.
            end
        endcase
    end

endmodule