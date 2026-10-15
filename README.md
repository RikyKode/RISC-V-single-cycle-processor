# Single-Cycle Processor in Verilog

A 32-bit single-cycle processor developed for EECS 31L at the University of California, Irvine. The design implements a subset of RISC-V instructions with course-specific NOR/NORI operations.

## Highlights

- Modular Verilog design with separate datapath and control units.
- Supports register arithmetic, immediate arithmetic, and word load/store operations.
- Includes a self-checking processor testbench.
- Passed all 20 supplied testbench checks using Cadence Xcelium through EDA Playground.

## Overview

The processor fetches an instruction, decodes its control signals, reads register operands, performs an ALU operation, and writes results to the register file or data memory.

The design includes a 32-bit datapath, an 8-bit program counter, 64-word instruction memory, and 128-word data memory. The program counter advances by four bytes per instruction.

This project demonstrates instruction decoding, combinational and sequential logic, module integration, and simulation-based verification.

## Supported Instructions

| Category | Instructions |
|---|---|
| Register arithmetic | ADD, SUB, SLT |
| Register logic | AND, OR, custom NOR |
| Immediate arithmetic | ADDI, SLTI |
| Immediate logic | ANDI, ORI, custom NORI |
| Memory access | LW, SW |

### Course-Specific NOR/NORI

NOR computes the bitwise complement of OR:

```verilog
Result = ~(A | B);
```

NORI uses a sign-extended immediate as its second operand.

This course design uses the standard RISC-V XOR/XORI instruction encodings for NOR/NORI behavior. It therefore does not implement a fully standard RISC-V instruction set.

## Repository Structure

| Path | Description |
|---|---|
| `rtl/processor.v` | Top-level integration |
| `rtl/Controller.v` | Main instruction decoder |
| `rtl/ALUController.v` | ALU operation decoder |
| `rtl/data_path.v` | Datapath connections |
| `rtl/alu32.v` | 32-bit arithmetic logic unit |
| `rtl/reg_file.v` | Register file |
| `rtl/data_mem.v` | Data memory |
| `rtl/InstMem.v` | Instruction memory and test program |
| `rtl/ImmGen.v` | Immediate extraction and extension |
| `rtl/FlipFlop.v` | Program counter register |
| `rtl/mux_32.v` | 32-bit multiplexer |
| `sim/tb_processor.v` | Processor testbench |

## Running the Simulation

1. Open https://www.edaplayground.com/.
2. Select Verilog/SystemVerilog and Cadence Xcelium.
3. Copy `sim/tb_processor.v` into the testbench pane.
4. Add each file from `rtl/` as a design tab, preserving its filename.
5. Paste the following include statements into the main design pane.
6. Click **Run**.

```verilog
`include "Controller.v"
`include "ALUController.v"
`include "processor.v"
`include "data_path.v"
`include "data_mem.v"
`include "alu32.v"
`include "FlipFlop.v"
`include "mux_32.v"
`include "reg_file.v"
`include "InstMem.v"
`include "ImmGen.v"
```

The testbench generates the clock and reset, checks expected ALU results, and creates `dump.vcd` for waveform inspection.

## Simulation Results

The current design passed all 20 testbench checks:

```text
PASS: All 20 checks passed.
Score: 80
```

The simulation completed normally at 450 ns.

The checks cover arithmetic and logic results, including the course-specific NOR/NORI operations. The LW and SW checks verify the calculated memory address; they do not independently verify stored data or load writeback.

## Current Limitations

- Branches and jumps are not implemented.
- Only word loads and stores are supported.
- Only instruction-memory entries 0–20 are initialized.
- Data memory currently uses an unclocked write process.
- Some module widths are fixed despite datapath parameter declarations.
- ALU carry-flag behavior requires additional verification.
- Passing the supplied testbench does not establish full instruction-set compliance or FPGA readiness.

## Author and Acknowledgments

Developed by **Ricky Chen** as part of EECS 31L at UC Irvine.

The project builds on course templates and materials provided by **Professor Mahmoud Elfar**. The instruction memory, immediate generator, and original processor testbench were provided with the course.

Student work includes the ALU, register file, data memory, multiplexer, program counter register, control logic, and processor integration, developed within the course framework.

The repository includes formatting and documentation cleanup, controller fixes, and a refactored version of the supplied testbench. Attribution is retained for professor-provided components.
