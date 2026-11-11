`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 13:48:35
// Design Name: 
// Module Name: PC_updater
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


module PC_updater(
        input [31:0] current_pc,
        output [31:0] next_pc                  
    );
    assign next_pc = current_pc+4;
endmodule
