`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2026 09:55:05
// Design Name: 
// Module Name: RISC_V_single_cycle
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


module RISC_V_single_cycle(
    input clk ,
    input reset 
//    input [31:0] next_pc,
//    output [31:0] current_pc,
//    output [31:0] instruction,
//    output RegWrite, MemRea,d, MemWrite, Branch, Jump, ALUSrc, MemtoReg,
//    output [1:0] ALUOp,
//    output [2:0] funct3,
//    output [6:0] funct7,
//    output [6:0] opcode,
//    output [31:0] immediate, 
//    output [31:0]read_reg1_data,
//    output [31:0]read_reg2_data,
//    output [31:0]ALU_result,
//    output zero_flag
   
    );
    
    // write reg_file module inputs as wire and assign as instruction[a:b] format.
    // write ALU operand as wires
    //
    
    wire [31:0] next_pc;
    wire [31:0] current_pc;
    wire [31:0] pc_plus_4;
    wire [31:0] instruction;
    wire RegWrite, MemRead, MemWrite, Branch, Jump, ALUSrc, MemtoReg;
    wire [1:0] ALUOp;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [6:0] opcode;
    wire [31:0] immediate; 
    wire [3:0] control_sig;
    wire [31:0]ALU_result;
    wire zero_flag;
    wire less_signed;
    wire less_unsigned;
    
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    
    wire [31:0]alu_operand1;
    wire [31:0]alu_operand2;
    wire[31:0]intermediate_result;
    wire[31:0]jump_result;
    wire[31:0]write_back_data;
    wire[31:0]mem_data;
    
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];
    
    //logic for barnch taken or not....
    
    reg branch_taken;

    always @(*) begin
        branch_taken = 1'b0;

        if (Branch) begin
            case (funct3)
                3'b000: branch_taken = zero_flag;         // BEQ
                3'b001: branch_taken = ~zero_flag;        // BNE
                3'b100: branch_taken = less_signed;       // BLT
                3'b101: branch_taken = ~less_signed;      // BGE
                3'b110: branch_taken = less_unsigned;     // BLTU
                3'b111: branch_taken = ~less_unsigned;    // BGEU
            endcase
        end
    end
    //program counter initialization .....
    
    program_counter PC(.reset(reset),
                    .clk(clk),
                    .next_pc(next_pc),
                    .current_pc(current_pc));
                    
    PC_updater PU(.current_pc(current_pc),
                  .next_pc(pc_plus_4));               
    
    //instruction management...
    
    Instruction_mem im(.current_pc(current_pc),
                       .instruction(instruction));
               
    instruction_decoder id(.instruction(instruction),
                           .funct7(funct7),
                           .funct3(funct3),
                           .opcode(opcode));
                           
                           
     // immediate generatio....
     
     immediate_gen IG(.instruction(instruction),
                      .opcode(opcode),
                      .immediate(immediate));
                      
                           
    //sendig to control units .....
    
    Main_control_unit MCU(.instruction(instruction),
                      .RegWrite(RegWrite),
                      .MemRead(MemRead),
                      .MemWrite(MemWrite),
                      .Branch(Branch),
                      .Jump(Jump),
                      .ALUSrc(ALUSrc),
                      .MemtoReg(MemtoReg),
                      .ALUOp(ALUOp));
                      
     ALU_control_unit ACU(.ALUOp(ALUOp),
                          .opcode(opcode),
                          .funct3(funct3),
                          .funct7(funct7),
                          .control_sig(control_sig));     
                            
                            
    //fetching regester values for operand 1 and operand 2 ....
   
    reg_file RF(.clk(clk),
                .read_reg1_addr(rs1),
                .read_reg2_addr(rs2),
                .write_reg_addr(rd),
                .write_data(write_back_data), 
                .write_enable(RegWrite),
                .read_reg1_data(rs1_data),
                .read_reg2_data(rs2_data));
                            
    //using MUX to decide opernd 2 and operand 1 ....
    
    Mux m1(.I0(rs2_data),
           .I1(immediate),
           .sel(ALUSrc),
           .out(alu_operand2));
           
    Mux m2(.I0(rs1_data), // for AUIPC case
           .I1(current_pc),
           .sel(opcode == 7'b0010111),
           .out(alu_operand1));
           
           
   // sendig to ALU for calculation....
   
   ALU a1(.operand1(alu_operand1),
          .operand2(alu_operand2),
          .control_sig(control_sig),
          .result(ALU_result),
          .zero_flag(zero_flag),
          .less_signed(less_signed),
          .less_unsigned(less_unsigned));
                  
    //assigning lw and sw logic path....
    
   data_mem cache(.clk(clk),
                  .address(ALU_result),
                  .mem_write(MemWrite),
                  .mem_read(MemRead),
                  .write_data(rs2_data),
                  .read_data(mem_data));
        
    
    // logic for writing back the result to the ALU ....
   
    Mux intermediate_result_write(.sel(MemtoReg),
                     .I0(ALU_result),
                     .I1(mem_data),
                     .out(intermediate_result));
    Mux jump_result_write(.sel(Jump),  // added for jump case as we need to store return PC in rd to fetvvh the next instruction 
                           .I0(intermediate_result),
                           .I1(pc_plus_4),
                           .out(jump_result));
                           
    Mux LUI_result_write(.sel(opcode == 7'b0110111), //added for LUI case where we need to write immediate in palce of rd.
                           .I0(jump_result),
                           .I1(immediate),
                           .out(write_back_data));                       
    
    //using MUX to implement next_pc logic for each case ....
    wire [31:0]branch_target;
    wire [31:0]jalr_target;
    wire [31:0]jal_target;
    wire [31:0]branch_mux_out;
    wire [31:0]jump_mux_out;
    wire [31:0]jumpr_mux_out;
    
    assign branch_target = current_pc + immediate; 
    assign jal_target = current_pc + immediate;     
    assign jalr_target = {ALU_result[31:1],1'b0};
    
    Mux branch_mux( // for branch logic 
    .I0(pc_plus_4),
    .I1(branch_target),
    .sel(branch_taken),
    .out(branch_mux_out));
    
    Mux JAL_MUX( // jal logic 
    .I0(branch_mux_out),
    .I1(jal_target),
    .sel(Jump & (opcode==7'b1101111)),
    .out(jump_mux_out));
    
    Mux JALR_MUX( // jal logic 
    .I0(jump_mux_out),
    .I1(jalr_target),
    .sel(Jump & (opcode==7'b1100111)),
    .out(jumpr_mux_out));
    
    assign next_pc = jumpr_mux_out;
    
endmodule
