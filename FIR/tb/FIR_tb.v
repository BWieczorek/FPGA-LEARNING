`timescale 1ns / 1ps



module FIR_tb();

    reg i_clk = 0;
    reg signed [15:0] i_serial_in = 0;
    reg i_data_wr = 0;
    wire signed [2*16-1:0] o_data_out;
    wire o_data_rdy;
    wire signed[6:0] o_sin;
    reg i_reset;
FIR UUT(i_clk, i_serial_in, i_data_wr, o_data_out, o_data_rdy, i_reset);
Sin_gen sin(i_clk, o_sin);
    localparam filter_time = 10*10;
    initial begin
        i_reset = 1;
        #filter_time
        forever begin
        i_reset = 0;
        i_data_wr = 1;
        #10
        i_data_wr = 0;
        #(filter_time-10);
        end
    
    
    
    end
    always begin
    #5 i_clk <= ~i_clk;
        i_serial_in [15:9] <= o_sin;
    end
endmodule

module Sin_gen(
    input i_clk,
    output [6:0] o_sin
);
reg [31:0]	phase = 0;
reg [31:0] frequency_step = 2**23;
reg	[6:0]	sin_wave [0:255];
reg [6:0] r_sin;
initial begin
 $display("Read table");
 $readmemh("sin_table.hex", sin_wave);
 $display(sin_wave[5]);
 $monitor(phase);
 end
// The initial value is usually irrelevant
always @(posedge i_clk) begin
	// Allow for an D/A running at a lower speed from your FPGA
		phase <= phase + frequency_step;
end
always @(posedge i_clk) begin
	   r_sin <= sin_wave[phase[31:24]];
end
assign o_sin = r_sin;
endmodule