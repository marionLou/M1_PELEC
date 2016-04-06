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
	
	parameter x_offset = 0;
	parameter y_offset = 200;
//	parameter y_final = 525 - 1;
	parameter y_final = 300;
	parameter x_final = 1056 -1 ;
	
	reg 		clk;
	reg 		reset;
	logic [10:0] Xline;
	logic [9:0] Yline;
	logic done_line;//, start_line;
	

	
	// Instantiate the DUT.
LineCUBE dut(
	.clk(clk),
	.reset(reset),
	.start(1),
	.x0(x_offset), .x1(x_final),
	.y0(y_offset), .y1(y_final),
	.x(Xline), 
	.y(Yline),
	.x_count(),
	.done(done_line),
	.plot()
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
		#2000;
	end
	// synthesis translate_on
endmodule

