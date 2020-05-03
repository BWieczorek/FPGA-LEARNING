`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module pwm_tb;

    reg clk = 0;
    reg [9:0] duty_cycle;
    reg reset = 0;
    wire pwm;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 100000;  

    pwm UUT(.i_clk(clk), .i_duty_cycle(duty_cycle), .i_reset(reset), .o_pwm_signal(pwm));
    
    always begin
        #5
        clk = ~clk;
    end
    
    initial // initial block executes only once
        begin
          duty_cycle = 500;
          #period
          duty_cycle = 15;
          #period
          reset = 1;
          #period
          duty_cycle = 1023;
          reset = 0;
        end
endmodule