`timescale 1ns / 1ps

// ALU controller implemented by Ricky Chen.
// Based on the EECS 31L course template.

module ALUController (
    input  [1:0] ALUOp,
    input  [6:0] Funct7,
    input  [2:0] Funct3,
    output [3:0] Operation
);

    assign Operation[0] =
        (Funct3 == 3'b110) ||
        ((Funct3 == 3'b010) && !ALUOp[0]);

    assign Operation[1] =
        ((ALUOp == 2'b10) &&
         ((Funct3 == 3'b000) || (Funct3 == 3'b010))) ||
        ((ALUOp == 2'b00) &&
         ((Funct3 == 3'b010) || (Funct3 == 3'b000))) ||
        ((ALUOp == 2'b01) && (Funct3 == 3'b010));

    assign Operation[2] =
        ((ALUOp == 2'b10) &&
         ((Funct3 == 3'b100) || (Funct3 == 3'b010))) ||
        ((ALUOp == 2'b10) &&
         (Funct3 == 3'b000) && (Funct7 == 7'b0100000)) ||
        ((ALUOp == 2'b00) &&
         ((Funct3 == 3'b100) || (Funct3 == 3'b010)));

    assign Operation[3] =
        ((ALUOp == 2'b10) && (Funct3 == 3'b100)) ||
        ((ALUOp == 2'b00) && (Funct3 == 3'b100));

endmodule