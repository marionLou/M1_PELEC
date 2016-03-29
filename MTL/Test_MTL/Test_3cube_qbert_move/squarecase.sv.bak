module squarecase(
	input logic clk,
	input logic reset,
	input logic top_cube,
	input logic [10:0] Xpos, 
	input logic [9:0] Ypos,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);

	parameter Out_length = 10'd100;
	parameter In_length = 10'd80;
	parameter Out_x_offset = 11'd100;
	parameter In_x_offset = Out_x_offset + (Out_length - In_length)/2;
	parameter Out_y_offset = 10'd100;
	parameter In_y_offset = Out_y_offset + (Out_length - In_length)/2;
	
	logic [20:0] Out_XY0 = {Out_x_offset , Out_y_offset};
	logic [20:0] Out_XY1 = {Out_x_offset + Out_length , Out_y_offset};
	logic [20:0] Out_XY2 = {Out_x_offset + Out_length , Out_y_offset + Out_length};
	logic [20:0] Out_XY3 = {Out_x_offset , Out_y_offset + Out_length};
	
	logic [20:0] In_XY0 = {In_x_offset , In_y_offset};
	logic [20:0] In_XY1 = {In_x_offset + In_length , In_y_offset};
	logic [20:0] In_XY2 = {In_x_offset + In_length , In_y_offset + In_length};
	logic [20:0] In_XY3 = {In_x_offset , In_y_offset + In_length};
	
	logic Out_square;
	logic In_square;
	
	always_ff @(posedge clk) begin
		Out_square <= (Xpos >= {Out_XY0[20:10] && Xpos <= Out_XY1[20:10]) 
							& (Ypos >= Out_XY0[9:0] && Ypos <= Out_XY3[9:0])};
		In_square <= {(Xpos >= In_XY0[20:10] && Xpos <= In_XY1[20:10]) 
							& (Ypos >= In_XY0[9:0] && Ypos <= In_XY3[9:0])};
		if(Out_square) begin
			red 	<= 8'd86;
			green <= 8'd169;
			blue 	<= 8'd152;	
			if (In_square) begin
				red <= 8'd49;
				green <= 8'd70;
				blue <= 8'd70;
			end
		end
		else begin
		red <= 8'd0;
		green <= 8'd0;
		blue <= 8'd0;
		end
	end
	
	
endmodule