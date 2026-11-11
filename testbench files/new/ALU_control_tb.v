`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2026 00:31:32
// Design Name: 
// Module Name: ALU_control_tb
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


module ALU_control_tb();

    reg [31:0] current_pc;
    wire [31:0] instruction;
//    reg [1:0] ALUOp;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [3:0] control_sig;
    wire RegWrite, MemRead, MemWrite, Branch, Jump, ALUSrc, MemtoReg;
    wire [1:0] ALUOp;
    
    
    Instruction_mem uut1 (.current_pc(current_pc),
                          .instruction(instruction));
        
    instruction_decoder uut2(.instruction(instruction),
                             .funct3(funct3),
                             .funct7(funct7),
                             .opcode(opcode));
    
     Main_control_unit uut3 (.instruction(instruction),
                            .ALUOp(ALUOp),
                            .RegWrite(RegWrite),
                            .MemRead(MemRead),
                            .MemWrite(MemWrite),
                            .Branch(Branch),
                            .Jump(Jump),
                            .ALUSrc(ALUSrc),
                            .MemtoReg(MemtoReg));  
                             
    ALU_control_unit uut4(.ALUOp(ALUOp),
                          .opcode(opcode),
                          .funct3(funct3),
                          .funct7(funct7),
                          .control_sig(control_sig));
    
    initial begin
        $monitor("Time=%0t | PC=%2d | Instr=%h | Opcode=%07b | ALUOp=%02b | funct3=%03b | funct7=%07b | ALU_Control=%04b",
              $time,
              current_pc,
              instruction,
              opcode,
              ALUOp,
              funct3,
              funct7,
              control_sig);
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
