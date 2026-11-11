`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2026 10:52:33
// Design Name: 
// Module Name: ALU_control_unit
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


module ALU_control_unit(
    input [1:0] ALUOp,
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] control_sig
);
    /* table of ALU_CONTROL SIGNAL-->
    ALU_Control	Operation
    0000	       ADD
    0001	       SUB
    0010	       AND
    0011	       OR
    0100	       XOR
    0101	       SLL
    0110	       SRL
    0111	       SRA
    1000	       SLT
    1001	       SLTU
    
    */
    // for ALUop = 10 -> we have to decode the func3 and func7 for instruction decode. for other cases no need to find funct .
    always @(*) begin
    control_sig = 4'b0000;      // Default = ADD
    case(ALUOp) 
        2'b00:// Load/Store
            control_sig = 4'b0000;
        2'b01:// Branch
            control_sig = 4'b0001;   
        2'b10:// R or I type ALU Instructions
        begin
            // R-Type Instructions
            if(opcode == 7'b0110011)
            begin
                case(funct3)
                    3'b000:
                    begin
                        if(funct7 == 7'b0000000)
                            control_sig = 4'b0000;      // ADD
                        else if(funct7 == 7'b0100000)
                            control_sig = 4'b0001;      // SUB
                    end
                    3'b111: control_sig = 4'b0010;      // AND
                    3'b110: control_sig = 4'b0011;      // OR
                    3'b100: control_sig = 4'b0100;      // XOR
                    3'b001: control_sig = 4'b0101;      // SLL
                    3'b101:
                    begin
                        if(funct7 == 7'b0000000)
                            control_sig = 4'b0110;      // SRL
                        else if(funct7 == 7'b0100000)
                            control_sig = 4'b0111;      // SRA
                    end
                    3'b010: control_sig = 4'b1000;      // SLT
                    3'b011: control_sig = 4'b1001;      // SLTU
                endcase
            end
            // I-Type Instructions
            else if(opcode == 7'b0010011)
            begin
                case(funct3)
                    3'b000: control_sig = 4'b0000;      // ADDI
                    3'b111: control_sig = 4'b0010;      // ANDI
                    3'b110: control_sig = 4'b0011;      // ORI
                    3'b100: control_sig = 4'b0100;      // XORI
                    3'b010: control_sig = 4'b1000;      // SLTI
                    3'b011: control_sig = 4'b1001;      // SLTIU
                    3'b001: control_sig = 4'b0101;      // SLLI
                    3'b101:
                    begin
                        if(funct7 == 7'b0000000)
                            control_sig = 4'b0110;      // SRLI
                        else if(funct7 == 7'b0100000)
                            control_sig = 4'b0111;      // SRAI
                    end
                endcase
            end
        end
        default:
            control_sig = 4'b0000;
    endcase
end
endmodule   
