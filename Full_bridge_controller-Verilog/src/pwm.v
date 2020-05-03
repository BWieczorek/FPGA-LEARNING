`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: B. Wieczorek
// 
// Create Date: 05/02/2020 07:43:21 PM
// Design Name: -
// Module Name: pwm
// Project Name: -
// Target Devices: -
// Tool Versions: -
// Description: 10bit pwm generator with reset as force low signal
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm(
    input [9:0] i_duty_cycle,
    input i_clk,
    output o_pwm_signal,
    input i_reset
    );
    reg [9:0] counter = 0;
    reg r_pwm_output = 0;
    always @(posedge i_clk) begin
        if(!i_reset) begin
            if(counter < i_duty_cycle) begin
                r_pwm_output <= 1'b1;
            end else begin
                r_pwm_output <= 1'b0;
            end
            if(counter >= 1022) begin
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end else begin
            counter <= 0;
            r_pwm_output <= 1'b0;
        end
    end
    assign o_pwm_signal = r_pwm_output; 
endmodule
