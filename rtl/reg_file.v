`timescale 1ns / 1ps

module RegFile(
input clk,
input reset,
input rg_wrt_en,
input [4:0] rg_wrt_addr,
input [4:0] rg_rd_addr1,
input [4:0] rg_rd_addr2,
input [31:0] rg_wrt_data,
output wire [31:0] rg_rd_data1,
output wire [31:0] rg_rd_data2
    );

reg [31:0] register_file [31:0];
integer i;

always @(posedge clk or posedge reset) begin
if (reset) 
    for (i = 0; i < 32; i = i + 1)
        register_file[i] <= 32'h0;
    
 else if (rg_wrt_en)
     register_file[rg_wrt_addr] <= rg_wrt_data;
end

assign rg_rd_data1 = register_file[rg_rd_addr1];
assign rg_rd_data2 = register_file[rg_rd_addr2];
 
 
endmodule


