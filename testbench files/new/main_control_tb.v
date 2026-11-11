`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 21:52:38
// Design Name: 
// Module Name: main_control_tb
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


module main_control_tb();
//    reg [31:0] instruction;
    wire RegWrite, MemRead, MemWrite, Branch, Jump, ALUSrc, MemtoReg;
    wire [1:0] ALUOp;
    
    reg [31:0] current_pc;
    wire [31:0] instruction;
    
    Instruction_mem uut1 (
        .current_pc(current_pc),
        .instruction(instruction)
    );
    
    Main_control_unit uut2 (.instruction(instruction),
                            .ALUOp(ALUOp),
                            .RegWrite(RegWrite),
                            .MemRead(MemRead),
                            .MemWrite(MemWrite),
                            .Branch(Branch),
                            .Jump(Jump),
                            .ALUSrc(ALUSrc),
                            .MemtoReg(MemtoReg));   
//    initial begin
//        RegWrite =0;
//        MemRead = 0;
//        MemWrite = 0; 
//        Branch = 0; 
//        Jump = 0; 
//        ALUSrc = 0; 
//        MemtoReg = 0;
//        ALUOp = 2'b0;
//    end
       
    initial begin
        $monitor("Time = %0t ns | PC = %d | Instruction = %h | Opcode = %b | RegWrite = %b | MemRead = %b | MemWrite = %b | Branch = %b | Jump = %b | ALUSrc = %b | MemtoReg = %b | ALUOp = %b",
        
                  $time, current_pc, instruction,instruction[6:0], RegWrite, MemRead, MemWrite, Branch, Jump, ALUSrc, MemtoReg, ALUOp );
    end
    
    integer i;

    initial begin
        for(i = 0; i < 18; i = i + 1) begin
            current_pc = i * 4;
            #10;
        end

        $finish;
    end
endmodule
