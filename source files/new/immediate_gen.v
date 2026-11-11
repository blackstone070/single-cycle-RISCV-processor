`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 19:21:53
// Design Name: 
// Module Name: immediate_gen
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


module immediate_gen(
    input [31:0] instruction,
    input [6:0] opcode,
    output reg [31:0] immediate 
    );
   
    // generally immediates are 12 or 20 bit wide , but our ALU will compute 32 bit data , so it is defined as 32 bit long 
    
    always @(*) begin   
        case (opcode)
            // R-Type (ADD, SUB, AND, OR...).. so immediate
            7'b0110011:
                immediate = 32'b0;
            // I-Type (ADDI, ANDI, ORI etc)
            7'b0010011:
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            // LOAD (LW, LH, LB etc)
            7'b0000011:
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            // JALR
            7'b1100111:
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            // S-Type (SW, SH, SB)
            7'b0100011:
                immediate = {{20{instruction[31]}},
                             instruction[31:25],
                             instruction[11:7]};
            // B-Type (BEQ, BNE etc)
            7'b1100011:
                immediate = {{19{instruction[31]}},
                             instruction[31],
                             instruction[7],
                             instruction[30:25],
                             instruction[11:8],
                             1'b0};
            // LUI
            7'b0110111:
                immediate = {instruction[31:12],12'b0};
            // AUIPC
            7'b0010111:
                immediate = {instruction[31:12],12'b0};
            // J-Type (JAL)
            7'b1101111:
                immediate = {{11{instruction[31]}},
                             instruction[31],
                             instruction[19:12],
                             instruction[20],
                             instruction[30:21],
                             1'b0};
            default:
                immediate = 32'b0;

        endcase
    end
endmodule
