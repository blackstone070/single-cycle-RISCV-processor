`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 16.07.2026
// Design Name:
// Module Name: ALU_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Testbench for ALU
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module ALU_tb();

    // Inputs
    reg [31:0] operand1;
    reg [31:0] operand2;
    reg [3:0] control_sig;

    // Outputs
    wire [31:0] result;
    wire zero_flag;

    // Instantiate the ALU
    ALU uut (
        .operand1(operand1),
        .operand2(operand2),
        .control_sig(control_sig),
        .result(result),
        .zero_flag(zero_flag)
    );

    // Monitor
    initial begin
        $monitor("Time=%0t | Ctrl=%04b | Op1=%11d (%h) | Op2=%11d (%h) | Result=%11d (%h) | Zero=%b",
                  $time,
                  control_sig,
                  operand1, operand1,
                  operand2, operand2,
                  result, result,
                  zero_flag);
    end

    // Test all ALU operations
    initial begin

        //=========================================================
        // ADD
        //=========================================================
        control_sig = 4'b0000;
        operand1 = 32'd20;
        operand2 = 32'd10;
        #10;

        //=========================================================
        // SUB
        //=========================================================
        control_sig = 4'b0001;
        operand1 = 32'd20;
        operand2 = 32'd10;
        #10;

        //=========================================================
        // AND
        //=========================================================
        control_sig = 4'b0010;
        operand1 = 32'hF0F0F0F0;
        operand2 = 32'h0FF00FF0;
        #10;

        //=========================================================
        // OR
        //=========================================================
        control_sig = 4'b0011;
        operand1 = 32'hF0F0F0F0;
        operand2 = 32'h0FF00FF0;
        #10;

        //=========================================================
        // XOR
        //=========================================================
        control_sig = 4'b0100;
        operand1 = 32'hAAAA5555;
        operand2 = 32'hFFFF0000;
        #10;

        //=========================================================
        // SLL
        //=========================================================
        control_sig = 4'b0101;
        operand1 = 32'd5;
        operand2 = 32'd2;
        #10;

        //=========================================================
        // SRL
        //=========================================================
        control_sig = 4'b0110;
        operand1 = 32'd40;
        operand2 = 32'd3;
        #10;

        //=========================================================
        // SRA
        //=========================================================
        control_sig = 4'b0111;
        operand1 = -32'sd40;
        operand2 = 32'd2;
        #10;

        //=========================================================
        // SLT (Signed)
        //=========================================================
        control_sig = 4'b1000;
        operand1 = -32'sd5;
        operand2 = 32'd10;
        #10;

        //=========================================================
        // SLTU (Unsigned)
        //=========================================================
        control_sig = 4'b1001;
        operand1 = 32'd5;
        operand2 = 32'd10;
        #10;

        //=========================================================
        // Zero Flag Test
        //=========================================================
        control_sig = 4'b0001;
        operand1 = 32'd100;
        operand2 = 32'd100;
        #10;

        $finish;

    end

endmodule