`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 19:20:55
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] operand1,
    input [31:0] operand2,
    input [3:0]control_sig, //  tells whcich operation to perform
    output reg [31:0]result,
    output zero_flag,
    output less_signed,
    output less_unsigned
    );
    
    always@(*) begin
        result =0;
        case(control_sig)
            4'b0000: result = operand1 + operand2;
            4'b0001: result = operand1-operand2;
            4'b0010: result = operand1 & operand2;
            4'b0011: result = operand1 | operand2;
            4'b0100: result = operand1 ^ operand2;
            4'b0101: result = operand1 << operand2[4:0];
            4'b0110: result = operand1 >> operand2[4:0];
            4'b0111: result = $signed(operand1)>>> operand2[4:0];  // SRA
            4'b1000: result = ($signed(operand1)<$signed(operand2))? 32'b1:32'b0;
            4'b1001: result = (operand1<operand2)?32'b1:32'b0;
            default: result =32'b0;
        endcase
    end 
    assign zero_flag = (result==32'b0);
    assign less_signed   = ($signed(operand1) < $signed(operand2));
    assign less_unsigned = (operand1 < operand2);
endmodule
