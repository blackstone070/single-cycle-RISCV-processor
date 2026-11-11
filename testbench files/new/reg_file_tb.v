`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 13:49:36
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb;

    // Inputs
    reg clk;
    reg [4:0] read_reg1_addr;
    reg [4:0] read_reg2_addr;
    reg [4:0] write_reg_addr;
    reg [31:0] write_data;
    reg write_enable;

    // Outputs
    wire [31:0] read_reg1_data;
    wire [31:0] read_reg2_data;

    // Instantiate Register File
    reg_file uut (
        .clk(clk),
        .read_reg1_addr(read_reg1_addr),
        .read_reg2_addr(read_reg2_addr),
        .write_reg_addr(write_reg_addr),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_reg1_data(read_reg1_data),
        .read_reg2_data(read_reg2_data)
    );

    // Clock Generation (20 ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Monitor all important signals
    initial begin
        $monitor("Time=%0t | WE=%b | WAddr=%d | WData=%d | R1Addr=%d | R1Data=%d | R2Addr=%d | R2Data=%d",
                  $time,
                  write_enable,
                  write_reg_addr,
                  write_data,
                  read_reg1_addr,
                  read_reg1_data,
                  read_reg2_addr,
                  read_reg2_data);
    end

    // Test sequence
    initial begin

        // Initialize all inputs
        write_enable   = 0;
        write_reg_addr = 5'd0;
        write_data     = 32'd0;
        read_reg1_addr = 5'd0;
        read_reg2_addr = 5'd0;

        //----------------------------------------------------
        // Write 25 into x3
        //----------------------------------------------------
        #5;
        write_enable   = 1;
        write_reg_addr = 5'd3;
        write_data     = 32'd25;

        // Wait for clock edge (10 ns)
        #20;

        //----------------------------------------------------
        // Write 90 into x5
        //----------------------------------------------------
        write_reg_addr = 5'd5;
        write_data     = 32'd90;

        // Wait for next clock edge (30 ns)
        #20;

        //----------------------------------------------------
        // Disable writing
        //----------------------------------------------------
        write_enable = 0;

        //----------------------------------------------------
        // Read x3 and x5
        //----------------------------------------------------
        read_reg1_addr = 5'd3;
        read_reg2_addr = 5'd5;

        #20;

        //----------------------------------------------------
        // Try writing to x0
        //----------------------------------------------------
        write_enable   = 1;
        write_reg_addr = 5'd0;
        write_data     = 32'd999;

        #20;

        //----------------------------------------------------
        // Read x0
        //----------------------------------------------------
        write_enable   = 0;
        read_reg1_addr = 5'd0;

        #20;

        //----------------------------------------------------
        // Try writing with write_enable = 0
        //----------------------------------------------------
        write_reg_addr = 5'd8;
        write_data     = 32'd1234;
        write_enable   = 0;

        #20;

        //----------------------------------------------------
        // Read x8 (should remain 0)
        //----------------------------------------------------
        read_reg1_addr = 5'd8;

        #20;

        $finish;

    end

endmodule
