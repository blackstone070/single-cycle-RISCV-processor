`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2026 01:08:26
// Design Name: 
// Module Name: data_mem_tb
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


`timescale 1ns / 1ps

module data_mem_tb();

    reg clk;
    reg [31:0] address;
    reg mem_write;
    reg mem_read;
    reg [31:0] write_data;

    wire [31:0] read_data;

    // Instantiate Data Memory
    data_mem uut (
        .clk(clk),
        .address(address),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | Address=%0d | MemWrite=%b | MemRead=%b | WriteData=%0d (%h) | ReadData=%0d (%h)",
                  $time,
                  address,
                  mem_write,
                  mem_read,
                  write_data, write_data,
                  read_data, read_data);
    end

    // Test Sequence
    initial begin

        // Initialize signals
        address    = 32'd0;
        mem_write  = 0;
        mem_read   = 0;
        write_data = 32'd0;

        //==========================================
        // Write 25 to Address 0
        //==========================================
        #5;
        address    = 32'd0;
        write_data = 32'd25;
        mem_write  = 1;
        #20;
        mem_write  = 0;

        //==========================================
        // Read Address 0
        //==========================================
        #10;
        mem_read = 1;
        #10;
        mem_read = 0;

        //==========================================
        // Write 100 to Address 8
        // (Address 8 -> Memory Index 2)
        //==========================================
        #10;
        address    = 32'd8;
        write_data = 32'd100;
        mem_write  = 1;
        #20;
        mem_write  = 0;

        //==========================================
        // Read Address 8
        //==========================================
        #10;
        mem_read = 1;
        #10;
        mem_read = 0;

        //==========================================
        // Read Address 4 (Never Written)
        // Should return 0
        //==========================================
        #10;
        address = 32'd4;
        mem_read = 1;
        #10;
        mem_read = 0;

        #20;
        $finish;

    end

endmodule
