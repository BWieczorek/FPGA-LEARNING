`timescale 1ns / 1ps



module full_bridge_controller_tb();
    reg i_clk = 0;
    reg [10:0] i_signed_val = 0;
    reg i_reset = 0;
    wire o_TrPL;
    wire o_TrNL;
    wire o_TrPR;
    wire o_TrNR;
    parameter timeconst = 500000;
    full_bridge_controller UUT(i_clk, i_signed_val, i_reset, o_TrPL, o_TrNL, o_TrPR, o_TrNR);
    initial begin
        #100
        forever begin
        i_reset = 0;
        i_signed_val = 1000;
        #timeconst;
        i_signed_val = -500;
        #timeconst;
        i_reset = 1;
        #timeconst;
        end
    end
    
    always begin
    #5 
    i_clk = ~i_clk;
    end
endmodule
