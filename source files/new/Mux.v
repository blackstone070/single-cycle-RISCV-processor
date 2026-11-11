`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 22:17:31
// Design Name: 
// Module Name: Mux
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

//2X1 MUX ......
module Mux(
    input [31:0]I0,
    input [31:0]I1,
    input sel, 
    output [31:0]out
    );
    
    assign out = (sel==0)?I0:I1;
    
endmodule
