# Single-Cycle RISC-V Processor

## Overview

This repository presents the design and ASIC implementation of a **32-bit Single-Cycle RISC-V (RV32I) Processor** using **Verilog HDL**. The processor has been successfully implemented through the complete **RTL-to-GDSII** ASIC design flow using the **OpenLane** framework and the **SkyWater SKY130 (130 nm) Process Design Kit (PDK)**.

The project demonstrates the complete digital ASIC implementation flow, beginning with RTL design and functional verification, followed by logic synthesis, floorplanning, placement, clock tree synthesis, routing, timing analysis, physical verification, and final GDSII layout generation.

---

## Features

- 32-bit Single-Cycle RISC-V Processor
- RV32I Base Integer Instruction Set
- Modular Verilog HDL implementation
- Functional simulation and verification
- Instruction Fetch, Decode, Execute, Memory Access and Write-Back stages
- Register File
- Immediate Generator
- Main Control Unit
- ALU Control Unit
- Arithmetic Logic Unit (ALU)
- Branch and Jump Logic
- Data Memory
- RTL Synthesis
- Floorplanning
- Placement
- Clock Tree Synthesis (CTS)
- Global Routing
- Detailed Routing
- Static Timing Analysis (STA)
- Design Rule Check (DRC)
- Layout Versus Schematic (LVS)
- GDSII Layout Generation

---

# Supported RV32I Instructions

## R-Type

- ADD
- SUB
- AND
- OR
- XOR
- SLL
- SRL
- SRA
- SLT
- SLTU

## I-Type

- ADDI
- LW
- JALR

## S-Type

- SW

## B-Type

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

## U-Type

- LUI
- AUIPC

## J-Type

- JAL

---

# ASIC Design Flow

The processor RTL was successfully implemented using the complete **OpenLane RTL-to-GDSII ASIC flow** with the **SkyWater SKY130 (130 nm) Standard Cell Library**.

The implementation flow includes:

- RTL Synthesis
- Static Timing Analysis
- Floorplanning
- Power Distribution Network (PDN) Generation
- Placement
- Clock Tree Synthesis (CTS)
- Global Routing
- Detailed Routing
- RC Extraction
- Signoff Timing Analysis
- Design Rule Check (DRC)
- Layout Versus Schematic (LVS)
- GDSII Layout Generation

---

# Design Modules

## Instruction Fetch (IF)

- Program Counter
- PC Updater
- Instruction Memory

## Instruction Decode (ID)

- Instruction Decoder
- Register File
- Immediate Generator
- Main Control Unit
- ALU Control Unit

## Execute (EX)

- Arithmetic Logic Unit (ALU)
- Operand Selection Multiplexers
- Branch Logic
- Jump Logic

## Memory (MEM)

- Data Memory
- Load/Store Operations

## Write Back (WB)

- Register File Write-Back Logic

---

# ASIC Implementation Results

| Parameter | Value |
|-----------|-------|
| **Technology Node** | SkyWater SKY130 (130 nm) |
| **ASIC Flow** | OpenLane |
| **Standard Cell Library** | sky130_fd_sc_hd |
| **RTL Language** | Verilog HDL |
| **Synthesized Logic Cells** | 42,411 |
| **Total Placed Standard Cells** | 182,832 |
| **Core Area** | 1,554,110.52 μm² (1.554 mm²) |
| **Die Area** | 1.598 mm² |
| **Placement Utilization** | 30.67% |
| **Routing Wire Length** | 3,585,071 μm |
| **Total Vias** | 401,345 |
| **Critical Path Delay** | 10.47 ns |
| **Clock Period** | 20 ns |
| **Maximum Operating Frequency** | 95.5 MHz |
| **Setup Worst Negative Slack (WNS)** | +5.28 ns |
| **Hold Worst Negative Slack (WNS)** | +0.35 ns |
| **Total Negative Slack (TNS)** | 0 ns |

---

# Power Analysis (Typical Corner)

| Parameter | Value |
|-----------|-------|
| **Internal Power** | 60.9 mW |
| **Switching Power** | 59.4 mW |
| **Leakage Power** | 0.353 μW |
| **Total Power** | 120.3 mW |

### Power Distribution

| Logic Type | Contribution |
|------------|--------------|
| Sequential Logic | 22.4% |
| Combinational Logic | 77.6% |
| Leakage Power | Negligible |

---

# Timing Summary

| Metric | Value |
|--------|-------|
| Clock Period | 20 ns |
| Critical Path Delay | 10.47 ns |
| Maximum Frequency | 95.5 MHz |
| Setup WNS | +5.28 ns |
| Hold WNS | +0.35 ns |
| Total Negative Slack | 0 ns |

The design successfully meets the specified timing constraints with **zero setup and hold timing violations**.

---

# Physical Verification

- ✅ Global and Detailed Routing Completed
- ✅ Static Timing Analysis Passed
- ✅ Design Rule Check (DRC) Passed
- ✅ Layout Versus Schematic (LVS) Passed
- ✅ GDSII Layout Successfully Generated

---

# Tools Used

- Verilog HDL
- Vivado
- OpenLane
- OpenROAD
- Magic
- Netgen
- KLayout
- SkyWater SKY130 PDK

---

## Future Improvements

- Multi-cycle implementation
- Five-stage pipelined RISC-V processor
- Hazard Detection Unit
- Data Forwarding Unit
- Branch Prediction
- Cache Memory Integration
- RV32M Extension Support
- FPGA implementation and benchmarking
