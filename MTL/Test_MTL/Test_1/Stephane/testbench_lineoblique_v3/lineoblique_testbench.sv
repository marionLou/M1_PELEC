/*
 *	ELEC2531: TP VERILOG 2
 *	FB, 2013.
 */

`timescale 1ns/1ps




module lineoblique_testbench();
	
	/*
	 *	Define some signals.
	 *	In general, every INPUT to the Device Under Test should be a 'register', every
	 *	OUTPUT a wire. But hey, don't believe me if you don't want to, try anything you wish.
	 */
	reg 		clk;
	reg 		reset;
	reg	[10:0] x_offset, x_final;
	reg	[9:0]	y_offset, y_final;
	
	wire [10:0]	Xcount, Xline;
	wire [9:0]	Ycount, Yline;
	wire [10:0] x_step, x_step_next;
	wire [9:0] y_step, y_step_next;
	wire [11:0] error, error2;
	wire		x_period, y_period, start_mark; 
	wire		done_mark, curseur;
	wire [11:0]	delta_x, delta_y;
	wire		droit, bas;
	
	// Instantiate the DUT.
	lineoblique dut (
		.clk			(clk),
		.reset			(reset),
		.red				(),
		.green			(),
		.blue				(),	
		.x_period		(x_period),
		.y_period		(y_period),
		.done_mark	(done_mark),
		.start_mark	(start_mark),
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
		#50;
		reset	= 1'b0;
		#20;
		reset	= 1'b0;
		x_offset = 10'd0;
		y_offset = 10'd0;
		x_final = 11'd99;
		y_final = 10'd39 ;
//		x_offset = 10'd3;
//		y_offset = 10'd0;
//		x_final = 11'd12;
//		y_final = 10'd4;	
		end
	// synthesis translate_on
endmodule


