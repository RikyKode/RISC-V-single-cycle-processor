`timescale 1ns / 1ps

// Immediate generator provided with the EECS 31L course template.
// Professor: Mahmoud Elfar.

module ImmGen (
    input      [31:0] InstCode,
    output reg [31:0] ImmOut
);

    always @(*) begin
        case (InstCode[6:0])
            // I-type: loads and immediate arithmetic
            7'b0000011,
            7'b0010011:
                ImmOut = {{20{InstCode[31]}}, InstCode[31:20]};

            // S-type: stores
            7'b0100011:
                ImmOut = {
                    {20{InstCode[31]}},
                    InstCode[31:25],
                    InstCode[11:7]
                };

            // U-type: AUIPC
            7'b0010111:
                ImmOut = {InstCode[31:12], 12'b0};

            default:
                ImmOut = 32'b0;
        endcase
    end

endmodule
