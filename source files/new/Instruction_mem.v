`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Akash Bera 
// Engineer: Akash Bera 
// 
// Create Date: 10.07.2026 14:04:06
// Design Name: RISC-V
// Module Name: Instruction_mem
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


module Instruction_mem(
    input [31:0] current_pc,
    output [31:0] instruction
    );
    reg [31:0] instruction_memory[0:255];
    
    initial begin 
    // include program file in the project folder for instructions.
        $readmemh("program.mem" , instruction_memory);
    end
    /* converting pc (byte address to memory index .
    The pc is 32 bit long i.e. 4 bytes.
    so dividing it by 4 or in digital system, right shifting the binary number by 2 bit positions will result in index*/
    wire [31:0] index ;
    assign index = current_pc[9:2];
    assign instruction = instruction_memory[index];
endmodule
