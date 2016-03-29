/*
 *	ELEC2531: TP VERILOG 2
 *	FB, 2013.
 */

`timescale 1ns/1ps




module lineCUBE_testbench();
	
	/*
	 *	Define some signals.
	 *	In general, every INPUT to the Device Under Test should be a 'register', every
	 *	OUTPUT a wire. But hey, don't believe me if you don't want to, try anything you wish.
	 */
		
	reg 		clk;
	reg 		reset;
	reg [10:0]	x_offset;
	reg [9:0]	y_offset;
	reg [9:0]	y_final;
	reg [10:0]	x_final;
	wire [10:0] Xline;
	wire [9:0] Yline;
	wire [11:0] delta_x, delta_y;
	wire [11:0] error, error2;
	wire droit, bas;
	
	reg start_line;//, start_line;
	

	
	// Instantiate the DUT.
LineCUBE dut(
	.clk(clk),
	.reset(reset),
	.start(start_line),
	.x0(x_offset), .x1(x_final),
	.y0(y_offset), .y1(y_final),
	.x(Xline), 
	.y(Yline),
	.x_count(),
	.done(),
	.plot(),
	.*
);

	
	// synthesis translate_off
	/*
	 *	And set the signals!
	 *	Since we are in lovely simulator land, we can use all sorts of
	 *	non-synthesisable constructs! :)
	 */
	always	#10 clk = ~clk;
	
	initial begin
		clk		= 1'b0;
		reset	= 1'b1;
		start_line = 0;
		x_offset = 0;
		y_offset = 0;
		y_final = 0;
		x_final = 0 ;

		#50;
		reset	= 1'b0;
		start_line = 1'b1;
//		x_offset = 10'd15;
//		y_offset = 10'd0;
//		x_final = 11'd10;
//		y_final = 10'd9;
		x_offset = 10'd50;
		y_offset = 10'd0;
		x_final = 11'd90;
		y_final = 10'd39 ;
	//	#400;
	end
	// synthesis translate_on
endmodule


