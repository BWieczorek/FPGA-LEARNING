`timescale 1ns / 1ps


module full_bridge_controller
    #(
    parameter dead_time = 5000
    )
    (
    input wire i_clk,
    input wire [10:0] i_signed_val,
    input wire i_reset,
    output wire o_TrPL,
    output wire o_TrNL,
    output wire o_TrPR,
    output wire o_TrNR
    );
    reg [9:0] r_PWM_TrPL = 0;
    reg [10:0] r_signed_val_delayd = 0;
    reg [31:0] r_dead_time_counter = 0;
    reg r_TrNL = 0;
    reg [9:0] r_PWM_TrPR = 0;
    reg r_TrNR = 0;
    reg last_sign = 1;  // 1 - positive, 0 - negativ 
    reg [2:0] r_state = 0; //000 - idle(reset state), 001 - zero crossing (dead time), 110 - positiv, 100 - negativ
  pwm TrPL_pwm(
    r_PWM_TrPL,
    i_clk,
    o_TrPL,
    i_reset);
  pwm TrPR_pwm(
    r_PWM_TrPR,
    i_clk,
    o_TrPR,
    i_reset);
    always @(i_clk) begin
        if(!i_reset) begin
            r_signed_val_delayd <= i_signed_val;
            case(r_state) 
                3'b000: begin
                    r_PWM_TrPL <= 0;
                    r_TrNL <= 1'b0;
                    r_PWM_TrPR <= 0;
                    r_TrNR <= 1'b0;   
                end
                3'b001: begin
                    r_PWM_TrPL <= 0;
                    r_TrNL <= 1'b0;
                    r_PWM_TrPR <= 0;
                    r_TrNR <= 1'b0;   
                end
                3'b100: begin
                    r_PWM_TrPL <= 0;
                    r_TrNL <= 1'b1;
                    r_PWM_TrPR <= ~r_signed_val_delayd[9:0]; //neg coused by negative integer encoding
                    r_TrNR <= 1'b0;   
                end
                3'b110: begin
                    r_PWM_TrPL <= r_signed_val_delayd[9:0];
                    r_TrNL <= 1'b0;
                    r_PWM_TrPR <= 0;
                    r_TrNR <= 1'b1;   
                end
                default: begin
                    r_PWM_TrPL <= 0;
                    r_TrNL <= 0;
                    r_PWM_TrPR <= 0;
                    r_TrNR <= 0;
                    r_state <= 0;
                end
            endcase
            case(r_state) 
                3'b000: begin
                    r_state <= i_signed_val[10] ? 3'b100 : 3'b110;
                    r_dead_time_counter <= 0;
                    last_sign <= i_signed_val[10];
                end
                3'b001: begin
                    if(r_dead_time_counter >= dead_time) begin
                        if(i_signed_val[10] == 0) begin
                            r_state <= 3'b110;
                        end else begin
                            r_state <= 3'b100;
                        end
                       r_dead_time_counter <= 0;
                       last_sign <= i_signed_val[10];
                    end
                   r_dead_time_counter <= r_dead_time_counter + 1;
                end
                3'b100: begin
                    if(i_signed_val[10] != last_sign) begin
                        r_state <= 3'b001;
                    end
                end
                3'b110: begin
                    if(i_signed_val[10] != last_sign) begin
                        r_state <= 3'b001;
                    end
                end
                default: begin
                    r_state <= 0;
                end
            endcase
        end else begin
            r_PWM_TrPL <= 0;
            r_TrNL <= 0;
            r_PWM_TrPR <= 0;
            r_TrNR <= 0;
            r_state <= 0;
        end
    end
    assign o_TrNL = r_TrNL;
    assign o_TrNR = r_TrNR;
endmodule
