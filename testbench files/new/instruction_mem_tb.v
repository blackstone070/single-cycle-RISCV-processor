`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 14:32:00
// Design Name: 
// Module Name: instruction_mem_tb
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

module instruction_mem_tb;

    // Inputs
    reg [31:0] current_pc;

    // Outputs
    wire [31:0] instruction;
    
    Instruction_mem uut (
        .current_pc(current_pc),
        .instruction(instruction)
    );

    initial begin
        $monitor("Time = %0t ns | PC = %d | Instruction = %h",
                  $time, current_pc, instruction);
    end
    
    initial begin

        // Read first instruction
        current_pc = 32'd0;
        #10;

        // Read second instruction
        current_pc = 32'd4;
        #10;

        // Read third instruction
        current_pc = 32'd8;
        #10;

        // Read fourth instruction
        current_pc = 32'd12;
        #10;

        // Read fifth instruction
        current_pc = 32'd16;
        #10;

        // Read sixth instruction
        current_pc = 32'd20;
        #10;

        // Read seventh instruction
        current_pc = 32'd24;
        #10;

        // Read eighth instruction
        current_pc = 32'd28;
        #10;

        $finish;

    end

endmodule

