`timescale 1ns / 1ps


module FIR
#(
parameter data_in = 16,
parameter no_tap = 10  //i_data_wr = i_clk/no_tap
)
(
    input i_clk,
    input signed [data_in-1:0] i_serial_in ,
    input i_data_wr,
    output signed [2*data_in-1:0] o_data_out ,
    output o_data_rdy,
    input i_reset
    );
    
    reg signed [2*data_in:0] acc = 0;
    reg [$clog2(no_tap):0] counter = 0;
    reg r_data_wr_en = 0;
    reg signed [data_in-1:0] impulse_response [no_tap-1:0];
    reg signed [data_in-1:0] data_reg [no_tap-1:0];
    reg r_data_rdy = 0;
    reg signed [2*data_in-1:0] r_data_out = 0;
    integer i;
    initial begin
        for (i = 0; i <= no_tap; i=i+1) begin
             data_reg[i] = 0;
        end   
      impulse_response[0] = 'h0a;
      impulse_response[1] = 'h00;
      impulse_response[2] = 'h00;
      impulse_response[3] = 'hfd;
      impulse_response[4] = 'h0c;
      impulse_response[5] = 'hfc;
      impulse_response[6] = 'h0c;
      impulse_response[7] = 'h01;
      impulse_response[8] = 'h00;
      impulse_response[9] = 'hfd;
       
    end
    
    always @(posedge i_clk) begin
        if(i_reset) begin
            acc <= 0;
            counter <= 0;
        end else begin
        if(r_data_wr_en) begin
            counter <= 0;
            r_data_rdy <= 1;
            r_data_out <= acc;
            acc <= 0;
            data_reg[0] <= i_serial_in;
            for(i = 1; i <= no_tap; i=i+1) begin
                data_reg[i] <= data_reg[i-1];
            end
        end else begin
            r_data_rdy <= 0;
            counter <= counter + 1;
            acc <= acc + impulse_response[counter]*data_reg[counter];
        end
        end
    end
    
    
        always @(posedge i_clk)
         begin
            if(r_data_wr_en == 0 & i_data_wr ==1) begin
                r_data_wr_en <= 1;
            end else if(r_data_wr_en == 1 & i_data_wr ==0) begin
                r_data_wr_en <= 0;
            end else begin
                r_data_wr_en <= 0;
            end
    end
    assign o_data_rdy = r_data_rdy;
    assign o_data_out = r_data_out;
endmodule
