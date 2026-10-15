`timescale 1ns / 1ps

// 128-word, 32-bit data memory.
module DataMem (
    input             MemRead,
    input             MemWrite,
    input      [8:0]  addr,
    input      [31:0] write_data,
    output reg [31:0] read_data
);

    reg [31:0] memory [127:0];

    // Convert the byte address to a word index using addr[8:2].
    always @(*) begin
        read_data = 32'h0;

        if (MemWrite == 1'b1)
            memory[addr[8:2]] = write_data;

        if (MemRead == 1'b1)
            read_data = memory[addr[8:2]];
    end

endmodule