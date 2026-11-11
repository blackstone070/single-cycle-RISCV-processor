`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2026 01:22:13
// Design Name: 
// Module Name: imm_gen_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module immediate_gen_tb();

    reg [31:0] current_pc;

    wire [31:0] instruction;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [31:0] immediate;

    // Instruction Memory
    Instruction_mem uut1 (
        .current_pc(current_pc),
        .instruction(instruction)
    );

    // Instruction Decoder
    instruction_decoder uut2 (
        .instruction(instruction),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );

    // Immediate Generator
    immediate_gen uut3 (
        .instruction(instruction),
        .opcode(opcode),
        .immediate(immediate)
    );

    // Monitor
    initial begin
        $monitor("Time=%0t | PC=%0d | Instr=%h | Opcode=%b | Immediate=%0d (%h)",
                  $time,
                  current_pc,
                  instruction,
                  opcode,
                  $signed(immediate),
                  immediate);
    end

    integer i;

    initial begin
        for(i = 0; i < 12; i = i + 1) begin
            current_pc = i * 4;
            #10;
        end

        $finish;
    end

endmodule