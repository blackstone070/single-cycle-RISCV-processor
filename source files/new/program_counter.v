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

//with synchronous reset signal 

module program_counter( input clk, input reset , input [31:0]next_pc , output reg [31:0]current_pc);
    always @(posedge clk)begin
        if(reset) begin
            current_pc <= 32'b0;
        end
        else
            current_pc <= next_pc;
    end
endmodule