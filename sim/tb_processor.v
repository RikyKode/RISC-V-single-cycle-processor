`timescale 1ns / 1ps

// Testbench provided by Mahmoud Elfar, EECS 31L, Spring 2026.
// Checks ALU results for the instruction-memory test program.

module tb_processor ();

    reg clk;
    reg rst;
    wire [31:0] tb_Result;

    integer point = 0;

    processor processor_inst (
        .clk    (clk),
        .reset  (rst),
        .Result (tb_Result)
    );

    // Generate a clock with a 20 ns period.
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    // Hold reset through two falling clock edges.
    initial begin
        rst = 1'b1;
        repeat (2) @(negedge clk);
        rst = 1'b0;
    end

    // Check one ALU result at the next falling clock edge.
    task check_result;
        input [31:0] expected;
        input [8*4-1:0] instruction_name;
        begin
            @(negedge clk);

            if (tb_Result == expected)
                point = point + 1;
            else
                $display(
                    "FAIL: %s expected 0x%08x, got 0x%08x",
                    instruction_name, expected, tb_Result
                );
        end
    endtask

    initial begin
        @(negedge rst);
        @(posedge clk);

        check_result(32'h00000000, "AND");
        check_result(32'h00000001, "ADDI");
        check_result(32'h00000002, "ADDI");
        check_result(32'h00000004, "ADDI");
        check_result(32'h00000005, "ADDI");
        check_result(32'h00000007, "ADDI");
        check_result(32'h00000008, "ADDI");
        check_result(32'h0000000b, "ADDI");
        check_result(32'h00000003, "ADD");
        check_result(32'hfffffffe, "SUB");
        check_result(32'h00000000, "AND");
        check_result(32'h00000005, "OR");
        check_result(32'h00000001, "SLT");
        check_result(32'hfffffff4, "NOR");
        check_result(32'h000004d2, "ANDI");
        check_result(32'hfffff8d7, "ORI");
        check_result(32'h00000001, "SLTI");
        check_result(32'hfffffb2c, "NORI");

        // These check memory addresses, not stored or loaded data.
        check_result(32'h00000030, "SW");
        check_result(32'h00000030, "LW");

        if (point == 20)
            $display("PASS: All 20 checks passed.");
        else
            $display("FAIL: %0d of 20 checks passed.", point);

        $display("Score: %0d", 4 * point);

        #10;
        $finish;
    end

    // Save waveforms.
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_processor);
    end

    // Stop if the test sequence does not finish in time.
    initial begin
        #500;
        $display("FAIL: Simulation timed out.");
        $finish;
    end

endmodule