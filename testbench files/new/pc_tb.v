`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 12:04:37
// Design Name: 
// Module Name: pc_tb
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


module pc_tb();
    reg  clk ,reset ;
    wire [31:0] next_pc;
    wire [31:0] current_pc;
    
    program_counter uut1(.clk(clk),.reset(reset),.next_pc(next_pc),.current_pc(current_pc));
    PC_updater uut2(.current_pc(current_pc),.next_pc(next_pc));
    initial begin
        clk =0;
        forever #10 clk= ~clk;
    end 
    
    initial begin
        reset  = 1;
        #15 reset = 0;
        #33 reset = 1;
        #43 reset= 0;
        #125 reset = 1;
        #145 reset = 0;
        #100 
        $finish;
        
    end
    
endmodule
