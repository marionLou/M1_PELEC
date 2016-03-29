module Qbert_Map(
	input logic clk,
	input logic reset,
	input logic top_cube,
	input logic [10:0] x_cnt, 
	input logic [9:0] y_cnt,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);
	
//	parameter RANK1_X_OFFSET = 11'd400;
//	parameter RANK1_Y_OFFSET = 10'd90;
	parameter RANK1_X_OFFSET = 11'd400;
	parameter RANK1_Y_OFFSET = 10'd300;
	
	logic R1_left_face;
	logic R1_right_face;
	logic [3:0] R1_top_face;
	
//	logic [10:0] R1_x_offset = RANK1_X_OFFSET;
//	logic [9:0] R1_y_offset = RANK1_Y_OFFSET;
	logic [10:0] R1_x_offset;
	logic [9:0] R1_y_offset;	
//assign {R1_x_offset,R1_y_offset} = {RANK1_X_OFFSET , RANK1_Y_OFFSET};
	always_ff @(posedge clk) begin
	{R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , RANK1_Y_OFFSET};
//	 
////	case ({x_cnt,y_cnt})
////	{RANK1_X_OFFSET - 1, RANK1_Y_OFFSET-1} : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , RANK1_Y_OFFSET};
////	{RANK1_X_OFFSET + 1, RANK1_Y_OFFSET + 10'd90 + 10'd90 } : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , RANK1_Y_OFFSET + 10'd90 + 10'd90 + 2};
////	default : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET, RANK1_Y_OFFSET};
////	endcase
//	
	end
	
	
	always_ff @(posedge clk) begin
						
		if(R1_left_face) begin
			red 	<= 8'd86;
			green <= 8'd169;
			blue 	<= 8'd152;
		end
		else if(R1_right_face) begin
			red <= 8'd49;
			green <= 8'd70;
			blue <= 8'd70;
		end
		else if(R1_top_face[0]||R1_top_face[1]||R1_top_face[2]||R1_top_face[3]) begin
			if (top_cube) begin
				red <= 8'd222;
				green <= 8'd222;
				blue <= 8'd0;
				end
			else begin
				red <= 8'd86;
				green <= 8'd70;
				blue <= 8'd239;
				end
		end
		else begin
		red 	<= 8'd0;
		green <= 8'd0;
		blue 	<= 8'd0;
		end
		

	end

//cube_generator rank1 #(.xlength(120), .xdiag(50), .ydiag(90))
cube_generator  #( 11'd120, 11'd50, 10'd90) rank1( 
	.x_offset(R1_x_offset),
	.y_offset(R1_y_offset),
	.left_face(R1_left_face),
	.right_face(R1_right_face),
	.top_face(R1_top_face),
	.*
	);

//cube_generator rank2(
//	.left_face(R2_left_face),
//	.right_face(R2_right_face),
//	.top_face(R2_top_face),
//	.*
//);
	
endmodule
