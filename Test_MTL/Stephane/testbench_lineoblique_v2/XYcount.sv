`timescale 1ns/1ps

module XYcount(
	// Host Side
	input logic iCLK, 				// Input LCD control clock
	input logic iRST_n, 				// Input system reset

	output logic [10:0] x_cnt, 
	output logic [9:0] y_cnt,
	output logic  x_period,
	output logic  y_period
);
	
//	parameter H_LINE = 1056; 
//	parameter V_LINE = 525;
//	parameter H_LINE = 20; 
//	parameter V_LINE = 10;
	parameter H_LINE = 100; 
	parameter V_LINE = 40;
//	parameter H_LINE = 16; 
//	parameter V_LINE = 5;
	
	logic mhd;
	logic mvd;

always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n)
	begin
		x_cnt <= 11'd0;	
		mhd  <= 1'd0;  
	end	
	else if (x_cnt == (H_LINE-1))
	begin
		x_cnt <= 11'd0;
		mhd  <= 1'd0;
	end	   
	else
	begin
		x_cnt <= x_cnt + 11'd1;
		mhd  <= 1'd1;
	end	
end

always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n)
		y_cnt <= 10'd0;
	else if (x_cnt == (H_LINE-1))
	begin
		if (y_cnt == (V_LINE-1))
			y_cnt <= 10'd0;
		else
			y_cnt <= y_cnt + 10'd1;	
	end
end

always@(posedge iCLK  or negedge iRST_n) begin
	if (!iRST_n)
		mvd  <= 1'b1;
	else if (y_cnt == 10'd0)
		mvd  <= 1'b0;
	else
		mvd  <= 1'b1;
end	

assign x_period = mhd;
assign y_period = mvd;

endmodule
