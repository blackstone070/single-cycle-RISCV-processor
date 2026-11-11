`timescale 1ns / 1ps

module RISC_V_single_cycle_tb();

    reg clk;
    reg reset;
    integer i;

    //=========================================================
    // DUT
    //=========================================================
    RISC_V_single_cycle uut (
        .clk(clk),
        .reset(reset)
    );

    //=========================================================
    // Clock Generation (20ns Period)
    //=========================================================
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    //=========================================================
    // Reset
    //=========================================================
    initial begin
        reset = 1'b1;
        #20;
        reset = 1'b0;
    end

    //=========================================================
    // Waveform
    //=========================================================
    initial begin
        $dumpfile("processor.vcd");
        $dumpvars(0,RISC_V_single_cycle_tb);
    end

    //=========================================================
    // Processor Monitor
    //=========================================================
    always @(posedge clk) begin

        $display("\n==================================================");
        $display("Time = %0t",$time);

        $display("PC      = %h",uut.current_pc);
        $display("Next PC = %h",uut.next_pc);

        $display("Instruction = %h",uut.instruction);
        $display("Opcode      = %b",uut.opcode);

        $display("rs1=%0d  rs2=%0d  rd=%0d",
                 uut.rs1,
                 uut.rs2,
                 uut.rd);

        $display("ReadData1 = %h",uut.rs1_data);
        $display("ReadData2 = %h",uut.rs2_data);

        $display("Immediate = %h",uut.immediate);

        $display("ALU Operand1 = %h",uut.alu_operand1);
        $display("ALU Operand2 = %h",uut.alu_operand2);

        $display("ALU Result = %h",uut.ALU_result);

        $display("Memory Data = %h",uut.mem_data);

        $display("Write Back = %h",uut.write_back_data);

        $display("------------------------------------------");

        $display("RegWrite=%b MemRead=%b MemWrite=%b",
                    uut.RegWrite,
                    uut.MemRead,
                    uut.MemWrite);

        $display("Branch=%b Jump=%b",
                    uut.Branch,
                    uut.Jump);

        $display("ALUSrc=%b MemtoReg=%b",
                    uut.ALUSrc,
                    uut.MemtoReg);

        $display("Zero=%b LessS=%b LessU=%b",
                    uut.zero_flag,
                    uut.less_signed,
                    uut.less_unsigned);

        $display("BranchTaken=%b",uut.branch_taken);

        $display("==================================================");

    end

    //=========================================================
    // Run Simulation
    //=========================================================
    initial begin

        // Increase if your program is longer
        #800;

        //------------------------------------------------------
        // Register File Contents
        //------------------------------------------------------
        $display("\n\n========== REGISTER FILE ==========");

        for(i=0;i<32;i=i+1)
        begin
            $display("x%0d = %h",
                     i,
                     uut.RF.register[i]);
        end

        //------------------------------------------------------
        // Data Memory Contents
        //------------------------------------------------------
        $display("\n========== DATA MEMORY ==========");

        for(i=0;i<16;i=i+1)
        begin
            $display("MEM[%0d] = %h",
                     i,
                     uut.cache.data_mem[i]);
        end

        $display("\n==================================");
        $display("SIMULATION FINISHED");
        $display("==================================");

        $finish;

    end

endmodule