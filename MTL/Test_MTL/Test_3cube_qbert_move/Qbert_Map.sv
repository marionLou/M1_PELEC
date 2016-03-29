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
	
	parameter XLENGTH = 11'd22;
	parameter XDIAG_DEMI = 11'd15;
	parameter YDIAG_DEMI = 10'd25;
	parameter RANK1_X_OFFSET = 11'd600;
	parameter RANK1_Y_OFFSET = 10'd90;
	
	logic [10:0] RANK2_X_OFFSET = RANK1_X_OFFSET - XLENGTH - XDIAG_DEMI;
	logic [9:0] RANK2_Y_OFFSET = RANK1_Y_OFFSET + YDIAG_DEMI;
	
	logic [10:0] RANK3_X_OFFSET = RANK1_X_OFFSET - 11'd2*XLENGTH - 11'd2*XDIAG_DEMI;
	logic [9:0] RANK3_Y_OFFSET = RANK1_Y_OFFSET + 10'd2*YDIAG_DEMI;
	
	logic [10:0] RANK4_X_OFFSET = RANK1_X_OFFSET - 11'd3*XLENGTH - 11'd3*XDIAG_DEMI;
	logic [9:0] RANK4_Y_OFFSET = RANK1_Y_OFFSET + 10'd3*YDIAG_DEMI;
	
	logic [10:0] RANK5_X_OFFSET = RANK1_X_OFFSET - 11'd4*XLENGTH - 11'd4*XDIAG_DEMI;
	logic [9:0] RANK5_Y_OFFSET = RANK1_Y_OFFSET + 10'd4*YDIAG_DEMI;
	
	logic [10:0] RANK6_X_OFFSET = RANK1_X_OFFSET - 11'd5*XLENGTH - 11'd5*XDIAG_DEMI;
	logic [9:0] RANK6_Y_OFFSET = RANK1_Y_OFFSET + 10'd5*YDIAG_DEMI;
	
	logic [10:0] RANK7_X_OFFSET = RANK1_X_OFFSET - 11'd6*XLENGTH - 11'd6*XDIAG_DEMI;
	logic [9:0] RANK7_Y_OFFSET = RANK1_Y_OFFSET + 10'd6*YDIAG_DEMI;
	
	logic [10:0] R1_x_offset, R2_x_offset, R3_x_offset, R4_x_offset;
	logic [10:0] R5_x_offset, R6_x_offset, R7_x_offset;
	logic [9:0] R1_y_offset, R2_y_offset, R3_y_offset, R4_y_offset;
	logic [9:0] R5_y_offset, R6_y_offset, R7_y_offset;
	
// --- Rank 1 --------------------------------------------------//	
	logic R1_left_face;
	logic R1_right_face;
	logic [3:0] R1_top_face_n1, R1_top_face_n2, R1_top_face_n3, R1_top_face_n4;
	logic [3:0] R1_top_face_n5, R1_top_face_n6, R1_top_face_n7;
	
	logic [10:0] R1_x_offset_n1, R1_x_offset_n2, R1_x_offset_n3, R1_x_offset_n4;
	logic [10:0] R1_x_offset_n5, R1_x_offset_n6, R1_x_offset_n7;
	logic [9:0] R1_y_offset_n1, R1_y_offset_n2, R1_y_offset_n3, R1_y_offset_n4;
	logic [9:0] R1_y_offset_n5, R1_y_offset_n6, R1_y_offset_n7;

	assign {R1_x_offset_n1, R1_y_offset_n1} = {RANK1_X_OFFSET, RANK1_Y_OFFSET};
	assign {R1_x_offset_n2, R1_y_offset_n2} = {RANK1_X_OFFSET, RANK1_Y_OFFSET + 10'd2*(YDIAG_DEMI)+10'd1};
	assign {R1_x_offset_n3, R1_y_offset_n3} = {RANK1_X_OFFSET, RANK1_Y_OFFSET + 10'd4*(YDIAG_DEMI)+10'd1};
	assign {R1_x_offset_n4, R1_y_offset_n4} = {RANK1_X_OFFSET, RANK1_Y_OFFSET + 10'd6*(YDIAG_DEMI)+10'd1};	
	assign {R1_x_offset_n5, R1_y_offset_n5} = {RANK1_X_OFFSET, RANK1_Y_OFFSET + 10'd8*(YDIAG_DEMI)+10'd1};	
	assign {R1_x_offset_n6, R1_y_offset_n6} = {RANK1_X_OFFSET, RANK1_Y_OFFSET + 10'd10*(YDIAG_DEMI)+10'd1};	
	assign {R1_x_offset_n7, R1_y_offset_n7} = {RANK1_X_OFFSET, RANK1_Y_OFFSET + 10'd12*(YDIAG_DEMI)+10'd1};	

// --- Rank 2 --------------------------------------------------//

	logic R2_left_face;
	logic R2_right_face;
	logic [3:0] R2_top_face_n1, R2_top_face_n2, R2_top_face_n3, R2_top_face_n4;
	logic [3:0] R2_top_face_n5, R2_top_face_n6;
	
	logic [10:0] R2_x_offset_n1, R2_x_offset_n2, R2_x_offset_n3, R2_x_offset_n4;
	logic [10:0] R2_x_offset_n5, R2_x_offset_n6;
	logic [9:0] R2_y_offset_n1, R2_y_offset_n2, R2_y_offset_n3, R2_y_offset_n4;
	logic [9:0] R2_y_offset_n5, R2_y_offset_n6;

	assign {R2_x_offset_n1, R2_y_offset_n1} = {RANK2_X_OFFSET, RANK2_Y_OFFSET};
	assign {R2_x_offset_n2, R2_y_offset_n2} = {RANK2_X_OFFSET, RANK2_Y_OFFSET + 10'd2*(YDIAG_DEMI)+10'd1};
	assign {R2_x_offset_n3, R2_y_offset_n3} = {RANK2_X_OFFSET, RANK2_Y_OFFSET + 10'd4*(YDIAG_DEMI)+10'd1};
	assign {R2_x_offset_n4, R2_y_offset_n4} = {RANK2_X_OFFSET, RANK2_Y_OFFSET + 10'd6*(YDIAG_DEMI)+10'd1};	
	assign {R2_x_offset_n5, R2_y_offset_n5} = {RANK2_X_OFFSET, RANK2_Y_OFFSET + 10'd8*(YDIAG_DEMI)+10'd1};	
	assign {R2_x_offset_n6, R2_y_offset_n6} = {RANK2_X_OFFSET, RANK2_Y_OFFSET + 10'd10*(YDIAG_DEMI)+10'd1};	
		

// --- Rank 3 --------------------------------------------------//

	logic R3_left_face;
	logic R3_right_face;
	logic [3:0] R3_top_face_n1, R3_top_face_n2, R3_top_face_n3, R3_top_face_n4;
	logic [3:0] R3_top_face_n5;
	
	logic [10:0] R3_x_offset_n1, R3_x_offset_n2, R3_x_offset_n3, R3_x_offset_n4;
	logic [10:0] R3_x_offset_n5;
	logic [9:0] R3_y_offset_n1, R3_y_offset_n2, R3_y_offset_n3, R3_y_offset_n4;
	logic [9:0] R3_y_offset_n5;

	assign {R3_x_offset_n1, R3_y_offset_n1} = {RANK3_X_OFFSET, RANK3_Y_OFFSET};
	assign {R3_x_offset_n2, R3_y_offset_n2} = {RANK3_X_OFFSET, RANK3_Y_OFFSET + 10'd2*(YDIAG_DEMI)+10'd1};
	assign {R3_x_offset_n3, R3_y_offset_n3} = {RANK3_X_OFFSET, RANK3_Y_OFFSET + 10'd4*(YDIAG_DEMI)+10'd1};
	assign {R3_x_offset_n4, R3_y_offset_n4} = {RANK3_X_OFFSET, RANK3_Y_OFFSET + 10'd6*(YDIAG_DEMI)+10'd1};	
	assign {R3_x_offset_n5, R3_y_offset_n5} = {RANK3_X_OFFSET, RANK3_Y_OFFSET + 10'd8*(YDIAG_DEMI)+10'd1};	

// --- Rank 4 --------------------------------------------------//

	logic R4_left_face;
	logic R4_right_face;
	logic [3:0] R4_top_face_n1, R4_top_face_n2, R4_top_face_n3, R4_top_face_n4;
	
	logic [10:0] R4_x_offset_n1, R4_x_offset_n2, R4_x_offset_n3, R4_x_offset_n4;
	logic [9:0] R4_y_offset_n1, R4_y_offset_n2, R4_y_offset_n3, R4_y_offset_n4;

	assign {R4_x_offset_n1, R4_y_offset_n1} = {RANK4_X_OFFSET, RANK4_Y_OFFSET};
	assign {R4_x_offset_n2, R4_y_offset_n2} = {RANK4_X_OFFSET, RANK4_Y_OFFSET + 10'd2*(YDIAG_DEMI)+10'd1};
	assign {R4_x_offset_n3, R4_y_offset_n3} = {RANK4_X_OFFSET, RANK4_Y_OFFSET + 10'd4*(YDIAG_DEMI)+10'd1};
	assign {R4_x_offset_n4, R4_y_offset_n4} = {RANK4_X_OFFSET, RANK4_Y_OFFSET + 10'd6*(YDIAG_DEMI)+10'd1};					

// --- Rank 5 --------------------------------------------------//

	logic R5_left_face;
	logic R5_right_face;
	logic [3:0] R5_top_face_n1, R5_top_face_n2, R5_top_face_n3;
	
	logic [10:0] R5_x_offset_n1, R5_x_offset_n2, R5_x_offset_n3;
	logic [9:0] R5_y_offset_n1, R5_y_offset_n2, R5_y_offset_n3;

	assign {R5_x_offset_n1, R5_y_offset_n1} = {RANK5_X_OFFSET, RANK5_Y_OFFSET};
	assign {R5_x_offset_n2, R5_y_offset_n2} = {RANK5_X_OFFSET, RANK5_Y_OFFSET + 10'd2*(YDIAG_DEMI)+10'd1};
	assign {R5_x_offset_n3, R5_y_offset_n3} = {RANK5_X_OFFSET, RANK5_Y_OFFSET + 10'd4*(YDIAG_DEMI)+10'd1};

// --- Rank 6 --------------------------------------------------//

	logic R6_left_face;
	logic R6_right_face;
	logic [3:0] R6_top_face_n1, R6_top_face_n2;
	
	logic [10:0] R6_x_offset_n1, R6_x_offset_n2;
	logic [9:0] R6_y_offset_n1, R6_y_offset_n2;

	assign {R6_x_offset_n1, R6_y_offset_n1} = {RANK6_X_OFFSET, RANK6_Y_OFFSET};
	assign {R6_x_offset_n2, R6_y_offset_n2} = {RANK6_X_OFFSET, RANK6_Y_OFFSET + 10'd2*(YDIAG_DEMI)+10'd1};		

// --- Rank 7 --------------------------------------------------//

	logic R7_left_face;
	logic R7_right_face;
	logic [3:0] R7_top_face_n1;
	
	logic [10:0] R7_x_offset_n1;
	logic [9:0] R7_y_offset_n1;

	assign {R7_x_offset_n1, R7_y_offset_n1} = {RANK7_X_OFFSET, RANK7_Y_OFFSET};

// -- Structural coding ----------------------------------------//

logic [6:0] is_left_face, is_right_face;
logic is_top_face;
//logic [27:0] is_top_face_n1, is_top_face_n2, is_top_face_n3, is_top_face_n4;

	always_ff @(posedge clk) begin
	
	is_left_face <= {R1_left_face, R2_left_face, R3_left_face, R4_left_face, 
							R6_left_face, R5_left_face, R7_left_face};
	
	is_right_face <= {R1_right_face, R2_right_face, R3_right_face, R4_right_face, 
							R6_right_face, R5_right_face, R7_right_face};
							
	is_top_face <= {(R1_top_face_n1 != 4'b0 ) ||(R1_top_face_n2 != 4'b0 ) ||(R1_top_face_n3 != 4'b0 ) ||
							(R1_top_face_n4 != 4'b0 ) ||(R1_top_face_n5 != 4'b0 ) ||(R1_top_face_n6 != 4'b0 ) ||
							(R1_top_face_n7 != 4'b0 ) ||(R2_top_face_n1 != 4'b0 ) ||(R2_top_face_n2 != 4'b0 ) ||
							(R2_top_face_n3 != 4'b0 ) ||(R2_top_face_n4 != 4'b0 ) ||(R2_top_face_n5 != 4'b0 ) ||
							(R2_top_face_n6 != 4'b0 ) ||(R3_top_face_n1 != 4'b0 ) ||(R3_top_face_n2 != 4'b0 ) ||
							(R3_top_face_n3 != 4'b0 ) ||(R3_top_face_n4 != 4'b0 ) ||(R3_top_face_n5 != 4'b0 ) ||
							(R4_top_face_n1 != 4'b0 ) ||(R4_top_face_n2 != 4'b0 ) ||(R4_top_face_n3 != 4'b0 ) || (R4_top_face_n4 != 4'b0 ) ||
							(R5_top_face_n1 != 4'b0 ) ||(R5_top_face_n2 != 4'b0 ) ||(R5_top_face_n3 != 4'b0 ) ||
							(R6_top_face_n1 != 4'b0 ) ||(R6_top_face_n2 != 4'b0 ) ||(R7_top_face_n1 != 4'b0 ) };

//is_top_face_n1 <= {R1_top_face_n1 , R1_top_face_n2 , R1_top_face_n3, 
//					 R1_top_face_n4, R1_top_face_n5 , R1_top_face_n6 ,
//						R1_top_face_n7} ;
//is_top_face_n2 <=	{R2_top_face_n1 , R2_top_face_n2,
//					R2_top_face_n3 , R2_top_face_n4, R2_top_face_n5,
//					R2_top_face_n6, R3_top_face_n1 };
//is_top_face_n3	<=	{ R3_top_face_n2, 
//					R3_top_face_n3 , R3_top_face_n4 , R3_top_face_n5, 
//					R4_top_face_n1 , R4_top_face_n2 , R4_top_face_n3 } ;
//					
//is_top_face_n4	<=			{R4_top_face_n4,
//					R5_top_face_n1 , R5_top_face_n2 , R5_top_face_n3,
//					R6_top_face_n1 , R6_top_face_n2 , R7_top_face_n1 };
							
	case ({x_cnt,y_cnt})
	//-- Rank1------------------------//
	{RANK1_X_OFFSET - 11'd1, R1_y_offset_n1 - 10'd1} : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , R1_y_offset_n1};
	{RANK1_X_OFFSET - 11'd1, R1_y_offset_n2 - 10'd1} : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , R1_y_offset_n2};
	{RANK1_X_OFFSET - 11'd1, R1_y_offset_n3 - 10'd1} : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , R1_y_offset_n3};
	{RANK1_X_OFFSET - 11'd1, R1_y_offset_n4 - 10'd1} : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , R1_y_offset_n4};
	{RANK1_X_OFFSET - 11'd1, R1_y_offset_n5 - 10'd1} : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , R1_y_offset_n5};
	{RANK1_X_OFFSET - 11'd1, R1_y_offset_n6 - 10'd1} : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , R1_y_offset_n6};
	{RANK1_X_OFFSET - 11'd1, R1_y_offset_n7 - 10'd1} : {R1_x_offset,R1_y_offset} <= {RANK1_X_OFFSET , R1_y_offset_n7};
	
	//-- Rank2------------------------//
	{RANK2_X_OFFSET - 11'd1, R2_y_offset_n1 - 10'd1} : {R2_x_offset,R2_y_offset} <= {RANK2_X_OFFSET , R2_y_offset_n1};
	{RANK2_X_OFFSET - 11'd1, R2_y_offset_n2 - 10'd1} : {R2_x_offset,R2_y_offset} <= {RANK2_X_OFFSET , R2_y_offset_n2};
	{RANK2_X_OFFSET - 11'd1, R2_y_offset_n3 - 10'd1} : {R2_x_offset,R2_y_offset} <= {RANK2_X_OFFSET , R2_y_offset_n3};
	{RANK2_X_OFFSET - 11'd1, R2_y_offset_n4 - 10'd1} : {R2_x_offset,R2_y_offset} <= {RANK2_X_OFFSET , R2_y_offset_n4};
	{RANK2_X_OFFSET - 11'd1, R2_y_offset_n5 - 10'd1} : {R2_x_offset,R2_y_offset} <= {RANK2_X_OFFSET , R2_y_offset_n5};
	{RANK2_X_OFFSET - 11'd1, R2_y_offset_n6 - 10'd1} : {R2_x_offset,R2_y_offset} <= {RANK2_X_OFFSET , R2_y_offset_n6};
	
	//-- Rank3------------------------//
	{RANK3_X_OFFSET - 11'd1, R3_y_offset_n1 - 10'd1} : {R3_x_offset,R3_y_offset} <= {RANK3_X_OFFSET , R3_y_offset_n1};
	{RANK3_X_OFFSET - 11'd1, R3_y_offset_n2 - 10'd1} : {R3_x_offset,R3_y_offset} <= {RANK3_X_OFFSET , R3_y_offset_n2};
	{RANK3_X_OFFSET - 11'd1, R3_y_offset_n3 - 10'd1} : {R3_x_offset,R3_y_offset} <= {RANK3_X_OFFSET , R3_y_offset_n3};
	{RANK3_X_OFFSET - 11'd1, R3_y_offset_n4 - 10'd1} : {R3_x_offset,R3_y_offset} <= {RANK3_X_OFFSET , R3_y_offset_n4};
	{RANK3_X_OFFSET - 11'd1, R3_y_offset_n5 - 10'd1} : {R3_x_offset,R3_y_offset} <= {RANK3_X_OFFSET , R3_y_offset_n5};

	//-- Rank4------------------------//
	{RANK4_X_OFFSET - 11'd1, R4_y_offset_n1 - 10'd1} : {R4_x_offset,R4_y_offset} <= {RANK4_X_OFFSET , R4_y_offset_n1};
	{RANK4_X_OFFSET - 11'd1, R4_y_offset_n2 - 10'd1} : {R4_x_offset,R4_y_offset} <= {RANK4_X_OFFSET , R4_y_offset_n2};
	{RANK4_X_OFFSET - 11'd1, R4_y_offset_n3 - 10'd1} : {R4_x_offset,R4_y_offset} <= {RANK4_X_OFFSET , R4_y_offset_n3};
	{RANK4_X_OFFSET - 11'd1, R4_y_offset_n4 - 10'd1} : {R4_x_offset,R4_y_offset} <= {RANK4_X_OFFSET , R4_y_offset_n4};
	
	//-- Rank5------------------------//
	{RANK5_X_OFFSET - 11'd1, R5_y_offset_n1 - 10'd1} : {R5_x_offset,R5_y_offset} <= {RANK5_X_OFFSET , R5_y_offset_n1};
	{RANK5_X_OFFSET - 11'd1, R5_y_offset_n2 - 10'd1} : {R5_x_offset,R5_y_offset} <= {RANK5_X_OFFSET , R5_y_offset_n2};
	{RANK5_X_OFFSET - 11'd1, R5_y_offset_n3 - 10'd1} : {R5_x_offset,R5_y_offset} <= {RANK5_X_OFFSET , R5_y_offset_n3};
	
	//-- Rank6------------------------//
	{RANK6_X_OFFSET - 11'd1, R6_y_offset_n1 - 10'd1} : {R6_x_offset,R6_y_offset} <= {RANK6_X_OFFSET , R6_y_offset_n1};
	{RANK6_X_OFFSET - 11'd1, R6_y_offset_n2 - 10'd1} : {R6_x_offset,R6_y_offset} <= {RANK6_X_OFFSET , R6_y_offset_n2};
	
	//-- Rank7------------------------//
	{RANK7_X_OFFSET - 11'd1, R7_y_offset_n1 - 10'd1} : {R7_x_offset,R7_y_offset} <= {RANK7_X_OFFSET , R7_y_offset_n1};
	endcase
	
	end
	
	
	always_ff @(posedge clk) begin
						
		if(is_left_face != 7'b0) begin
			red 	<= 8'd86;
			green <= 8'd169;
			blue 	<= 8'd152;
		end
		else if(is_right_face != 7'b0) begin
			red <= 8'd49;
			green <= 8'd70;
			blue <= 8'd70;
		end 
		else if (is_top_face != 1'b0 ) begin
//		else if (is_top_face_n1 != 28'b0 && is_top_face_n2 != 28'b0 && is_top_face_n3 != 28'b0 && is_top_face_n4 != 28'b0) begin
		 //else if(R7_top_face_n1[0]||R7_top_face_n1[1]||R7_top_face_n1[2]||R7_top_face_n1[3]) begin
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
	
//----------------------------------------------
//******* TOP + CUBE GENERATOR *****************
//----------------------------------------------

cube_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank1(  
	.x_offset(R1_x_offset),
	.y_offset(R1_y_offset),
	.left_face(R1_left_face),
	.right_face(R1_right_face),
//	.top_face(R1_top_face_n1),
//	.qbert_top_face(R1_qbert_top_face_n1),
	.*
	);

top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank1_n1( 
	.x_offset(R1_x_offset_n1),
	.y_offset(R1_y_offset_n1),
	.top_face(R1_top_face_n1),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank1_n2( 
	.x_offset(R1_x_offset_n2),
	.y_offset(R1_y_offset_n2),
	.top_face(R1_top_face_n2),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank1_n3( 
	.x_offset(R1_x_offset_n3),
	.y_offset(R1_y_offset_n3),
	.top_face(R1_top_face_n3),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank1_n4( 
	.x_offset(R1_x_offset_n4),
	.y_offset(R1_y_offset_n4),
	.top_face(R1_top_face_n4),
	.*
	);

top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank1_n5( 
	.x_offset(R1_x_offset_n5),
	.y_offset(R1_y_offset_n5),
	.top_face(R1_top_face_n5),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank1_n6( 
	.x_offset(R1_x_offset_n6),
	.y_offset(R1_y_offset_n6),
	.top_face(R1_top_face_n6),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank1_n7( 
	.x_offset(R1_x_offset_n7),
	.y_offset(R1_y_offset_n7),
	.top_face(R1_top_face_n7),
	.*
	);
	
////--deuxième ligne

cube_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank2(  
	.x_offset(R2_x_offset),
	.y_offset(R2_y_offset),
	.left_face(R2_left_face),
	.right_face(R2_right_face),
//	.top_face(R1_top_face_n1),
//	.qbert_top_face(R1_qbert_top_face_n1),
	.*
	);

top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank2_n1( 
	.x_offset(R2_x_offset_n1),
	.y_offset(R2_y_offset_n1),
	.top_face(R2_top_face_n1),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank2_n2( 
	.x_offset(R2_x_offset_n2),
	.y_offset(R2_y_offset_n2),
	.top_face(R2_top_face_n2),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank2_n3( 
	.x_offset(R2_x_offset_n3),
	.y_offset(R2_y_offset_n3),
	.top_face(R2_top_face_n3),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank2_n4( 
	.x_offset(R2_x_offset_n4),
	.y_offset(R2_y_offset_n4),
	.top_face(R2_top_face_n4),
	.*
	);

top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank2_n5( 
	.x_offset(R2_x_offset_n5),
	.y_offset(R2_y_offset_n5),
	.top_face(R2_top_face_n5),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank2_n6( 
	.x_offset(R2_x_offset_n6),
	.y_offset(R2_y_offset_n6),
	.top_face(R2_top_face_n6),
	.*
	);

////--Troisième ligne -------------------------------------

cube_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank3(  
	.x_offset(R3_x_offset),
	.y_offset(R3_y_offset),
	.left_face(R3_left_face),
	.right_face(R3_right_face),
//	.top_face(R1_top_face_n1),
//	.qbert_top_face(R1_qbert_top_face_n1),
	.*
	);

top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank3_n1( 
	.x_offset(R3_x_offset_n1),
	.y_offset(R3_y_offset_n1),
	.top_face(R3_top_face_n1),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank3_n2( 
	.x_offset(R3_x_offset_n2),
	.y_offset(R3_y_offset_n2),
	.top_face(R3_top_face_n2),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank3_n3( 
	.x_offset(R3_x_offset_n3),
	.y_offset(R3_y_offset_n3),
	.top_face(R3_top_face_n3),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank3_n4( 
	.x_offset(R3_x_offset_n4),
	.y_offset(R3_y_offset_n4),
	.top_face(R3_top_face_n4),
	.*
	);

top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank3_n5( 
	.x_offset(R3_x_offset_n5),
	.y_offset(R3_y_offset_n5),
	.top_face(R3_top_face_n5),
	.*
	);
	
////--Quatrième ligne --------------//
//
cube_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank4(  
	.x_offset(R4_x_offset),
	.y_offset(R4_y_offset),
	.left_face(R4_left_face),
	.right_face(R4_right_face),
//	.top_face(R1_top_face_n1),
//	.qbert_top_face(R1_qbert_top_face_n1),
	.*
	);


top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank4_n1( 
	.x_offset(R4_x_offset_n1),
	.y_offset(R4_y_offset_n1),
	.top_face(R4_top_face_n1),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank4_n2( 
	.x_offset(R4_x_offset_n2),
	.y_offset(R4_y_offset_n2),
	.top_face(R4_top_face_n2),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank4_n3( 
	.x_offset(R4_x_offset_n3),
	.y_offset(R4_y_offset_n3),
	.top_face(R4_top_face_n3),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank4_n4( 
	.x_offset(R4_x_offset_n4),
	.y_offset(R4_y_offset_n4),
	.top_face(R4_top_face_n4),
	.*
	);
	
////--Cinquième ligne --------------//

cube_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank5(  
	.x_offset(R5_x_offset),
	.y_offset(R5_y_offset),
	.left_face(R5_left_face),
	.right_face(R5_right_face),
//	.top_face(R1_top_face_n1),
//	.qbert_top_face(R1_qbert_top_face_n1),
	.*
	);

	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank5_n1( 
	.x_offset(R5_x_offset_n1),
	.y_offset(R5_y_offset_n1),
	.top_face(R5_top_face_n1),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank5_n2( 
	.x_offset(R5_x_offset_n2),
	.y_offset(R5_y_offset_n2),
	.top_face(R5_top_face_n2),
	.*
	);
	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank5_n3( 
	.x_offset(R5_x_offset_n3),
	.y_offset(R5_y_offset_n3),
	.top_face(R5_top_face_n3),
	.*
	);

////--Sixième ligne --------------//	
//
cube_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank6(  
	.x_offset(R6_x_offset),
	.y_offset(R6_y_offset),
	.left_face(R6_left_face),
	.right_face(R6_right_face),
//	.top_face(R1_top_face_n1),
//	.qbert_top_face(R1_qbert_top_face_n1),
	.*
	);

	
top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank6_n1( 
	.x_offset(R6_x_offset_n1),
	.y_offset(R6_y_offset_n1),
	.top_face(R6_top_face_n1),
	.*
	);

top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank6_n2( 
	.x_offset(R6_x_offset_n2),
	.y_offset(R6_y_offset_n2),
	.top_face(R6_top_face_n2),
	.*
	);
	
////--Septième ligne --------------//	
//
cube_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank7(  
	.x_offset(R7_x_offset),
	.y_offset(R7_y_offset),
	.left_face(R7_left_face),
	.right_face(R7_right_face),
//	.top_face(R1_top_face_n1),
//	.qbert_top_face(R1_qbert_top_face_n1),
	.*
	);

top_generator  #( XLENGTH, XDIAG_DEMI, YDIAG_DEMI) rank7_n1( 
	.x_offset(R7_x_offset_n1),
	.y_offset(R7_y_offset_n1),
	.top_face(R7_top_face_n1),
	.*
	);

	
endmodule
