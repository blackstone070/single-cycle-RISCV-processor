`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 11:29:57
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input clk,
    input [31:0]address,
    input mem_write,
    input mem_read,
    input [31:0] write_data,
    output reg [31:0] read_data
    );
    
    reg[31:0] data_mem[0:255];
    integer i;
    initial begin
        for(i=0 ;i<256;i=i+1) begin
            data_mem[i] = 32'b0;
        end
    end 
    
    always@(posedge clk) begin  // using clk edge because we want our mem to be changed during posedge only 
        if(mem_write) data_mem[address[9:2]] <= write_data;
    end
    
    always@(*) begin  // using * because we want our read data to be updated whenever there is address change or any other variable change 
        if(mem_read) read_data = data_mem[address[9:2]];
        else read_data = 32'b0;
    end
endmodule
