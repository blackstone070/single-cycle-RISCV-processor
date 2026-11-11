`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2026 18:16:48
// Design Name: 
// Module Name: instruction_decoder
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


module instruction_decoder(
    input [31:0] instruction,
    output [2:0] funct3,
    output [6:0] funct7,
    output [6:0] opcode
    );
    
        assign opcode = instruction[6:0];
        assign funct3 = instruction[14:12];
        assign funct7 = instruction[31:25];
        
endmodule
