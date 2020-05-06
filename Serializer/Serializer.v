`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:12:22 01/15/2020 
// Design Name: 
// Module Name:    Serializer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Serializer(
    input [11:0] i_data_parallel,
    input i_data_RX, //Write order
    input i_clk, 
    input i_data_TX, //Send via serial order
    output o_data_serial, 
    output o_data_sent,
    output o_SCLK //serial divided cloak
    );
	 parameter SERIAL_CLOCK_DIVIDER = 10;
	 reg SCLK = 1'b0;
	 reg [7:0] r_serial_clk_counter = 0;
	 reg r_data_sent = 1'b1;
	 reg SCLK_meta, SCLK_sync, SCLK_prev;
	 reg [3:0] bit_counter = 3'b0;
	 reg r_data_serial = 0;
	 reg [11:0] r_data;
	 
	 assign o_data_serial = r_data_serial;
	 assign o_SCLK = SCLK_sync;
	 assign o_data_sent = r_data_sent;
	 
	always @(posedge i_clk)
	begin: main_proccess
	
		if(i_data_TX == 1'b1 && r_data_sent == 1'b1) begin
				r_data_sent <= 1'b0;
		end
		
		if(i_data_RX == 1'b1) begin
			r_data <= i_data_parallel;
			r_data_sent <= 1'b1;
			bit_counter <= 4'b0;
		end
		
		SCLK_prev <= SCLK_sync;
		if(SCLK_sync == 1'b1 && SCLK_prev == 1'b0) begin
			if(r_data_sent == 1'b0 && bit_counter <= 4'd11) begin
				r_data <= r_data << 1;
				r_data_serial <= r_data[11];
				bit_counter <= bit_counter + 1;
			end else begin
				r_data_serial <= 1'b0;
				bit_counter <= 4'b0;
				r_data_sent <= 1'b1;
			end
		end
	end
		
	 
	 always @(posedge i_clk)
	 begin: o_SCLK_DIVIDER
		if(r_serial_clk_counter >= SERIAL_CLOCK_DIVIDER/2) begin
			r_serial_clk_counter <= 0;
			SCLK <= ~SCLK;
		end else begin
			r_serial_clk_counter <= r_serial_clk_counter + 1;
		end
		SCLK_meta <= SCLK;
		SCLK_sync <= SCLK_meta;
	 end
	 

endmodule
