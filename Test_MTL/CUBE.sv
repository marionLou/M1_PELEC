module CUBE(
	input logic clk,
	input logic reset,
	input logic top_cube,
	input logic [10:0] x_cnt, 
	input logic [9:0] y_cnt,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);
	/*
 A beautiful cube with 
the position of each point 
		 5
	  %%%%%
	0%%%°%%%4
	 -%%%%%-
	|-- 6 --|
	|---|---|
	1\--|--3
	  \-2-/
	
	*/  
	
	// lenght for the cube's left face
//	parameter X0 = 10'd50;
//	parameter Y0 = 10'd50;
//	parameter X1 = 10'd150;
//	parameter Y1 = 10'd50;
//	parameter X2 = 10'd180;
//	parameter Y2 = 10'd100;
//	parameter X3 = 10'd150;
//	parameter Y3 = 10'd150;
//	parameter X4 = 10'd50;
//	parameter Y4 = 10'd150;
//	parameter X5 = 10'd20;
//	parameter Y5 = 10'd100;
//	parameter X6 = 10'd80;
//	parameter Y6 = 10'd100;

	parameter xline01 = 11'd120;
	parameter xdiag = 11'd50;
	parameter ydiag = 10'd90;
	parameter x_offset = 11'd400;
	parameter y_offset = 10'd200;
	
	parameter offset = 10'd2;
 
	logic [20:0] XY0 = {x_offset , y_offset};
	logic [20:0] XY1 = {x_offset + xline01 , y_offset};
	logic [20:0] XY2 = {x_offset + xline01 + xdiag , y_offset + ydiag};
	logic [20:0] XY3 = {x_offset + xline01 , y_offset + ydiag + ydiag};
	logic [20:0] XY4 = {x_offset , y_offset + ydiag + ydiag};
	logic [20:0] XY5 = { x_offset - xdiag , y_offset + ydiag};
	logic [20:0] XY6 = { x_offset + xdiag , y_offset + ydiag};
	logic [20:0] XYcenter = {x_offset , y_offset + ydiag};

	
	logic [10:0] X_line_01;
	logic [9:0] Y_line_01;
	logic [10:0] X_line_12;
	logic [9:0] Y_line_12;
	logic [10:0] X_line_23;
	logic [9:0] Y_line_23;
	logic [10:0] X_line_34;
	logic [9:0] Y_line_34;
	logic [10:0] X_line_45;
	logic [9:0] Y_line_45;
	logic [10:0] X_line_50;
	logic [9:0] Y_line_50;
	logic [10:0] X_line_06;
	logic [9:0] Y_line_06;
	logic [10:0] X_line_64;
	logic [9:0] Y_line_64;
	logic [10:0] X_line_62;
	logic [9:0] Y_line_62;

//	logic count50, count45;
//	logic count06, count64;
//	logic count12, count23;
	
	logic start50, start45;
	logic start06, start64;
	logic start12, start23;
	
	logic left_face;
	logic right_face;
	logic [3:0] top_face;
	
	logic [10:0] count;
	
	
always_ff @(posedge clk)
begin
//
//	left_face <= {(x_cnt > (XY0[18:9] + X_line_06) & x_cnt < (XY1[18:9] + X_line_12)) 
//									&&(y_cnt > XY0[8:0] & y_cnt < XY6[8:0])}; 
//									
//	right_face <= {(x_cnt > (XY6[18:9] - X_line_64) & x_cnt < (XY2[18:9] - X_line_23)) 
//									&&(y_cnt > XY6[8:0] & y_cnt < XY4[8:0])};
//									
//	top_face[0] <= ((x_cnt > (XY0[18:9] - X_line_50) & x_cnt < (XY0[18:9] + X_line_06)) 
//					&& (y_cnt > XY0[8:0] & y_cnt < XY6[8:0]));
//					
//	top_face[1] <= {(x_cnt > (XYcenter[18:9] - X_line_45) & x_cnt < (XYcenter[18:9] + X_line_64)) 
//					&&(y_cnt > XY6[8:0] & y_cnt < XY4[8:0])};
//	
	
	left_face <= {(x_cnt >= X_line_06 && x_cnt <= X_line_12) 
					&&(y_cnt >= XY0[9:0] && y_cnt < XY6[9:0])}; 
									
	right_face <= {(x_cnt >= X_line_64 && x_cnt <= X_line_23) 
					&&(y_cnt >= XY6[9:0] && y_cnt <= XY4[9:0])};
									
//	top_face[0] <= {(x_cnt >= X_line_50 && x_cnt < X_line_06)  
//					&& (y_cnt > XY0[8:0] && y_cnt < XY6[8:0])};
//					
//	top_face[1] <= {(x_cnt >= X_line_45 && x_cnt < X_line_64)  
//					&&(y_cnt > XY6[8:0] && y_cnt < XY4[8:0])};
	top_face[0] <= {(x_cnt >= XY0[20:10] && x_cnt < X_line_06)  
					&& (y_cnt > XY0[9:0] && y_cnt <= XY6[9:0])};
		
	top_face[1] <= {(x_cnt >= X_line_50 && x_cnt < XY0[20:10])  
					&& (y_cnt > XY0[9:0] && y_cnt <= XY6[9:0])};
					
	top_face[2] <= {(x_cnt >= XY0[20:10] && x_cnt < X_line_64)  
					&&(y_cnt > XY6[9:0] && y_cnt < XY4[9:0])};
	
	top_face[3] <= {(x_cnt >= X_line_45 && x_cnt < XY0[20:10])  
					&&(y_cnt > XY6[9:0] && y_cnt < XY4[9:0])};
	
	if(left_face) begin
			red 	<= 8'd86;
			green <= 8'd169;
			blue 	<= 8'd152;	
			end
	else if (right_face) begin
			red <= 8'd49;
			green <= 8'd70;
			blue <= 8'd70;
			end
	else if (top_face[0] || top_face[1] || top_face[2] || top_face[3]) 
			begin
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
			red <= 8'd0;
			green <= 8'd0;
			blue <= 8'd0;
		end
		
end

LineCUBE line01(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY0[20:10]), .x1(XY1[20:10]),
	.y0(XY0[9:0]), .y1(XY1[9:0]),
	.x_line(X_line_01), 
	.y_line(Y_line_01),
	.done(),
	.*
);

LineCUBE line12(
	.clk(clk),
	.reset(reset),
	.start(start12),
	.x0(XY1[20:10]), .x1(XY2[20:10]),
	.y0(XY1[9:0]), .y1(XY2[9:0]),
	.x_line(X_line_12), 
	.y_line(Y_line_12),
	.done(),
	.*
);

LineCUBE line23(
	.clk(clk),
	.reset(reset),
	.start(start23),
	.x0(XY2[20:10]), .x1(XY3[20:10]),
	.y0(XY2[9:0]), .y1(XY3[9:0]),
	.x_line(X_line_23), 
	.y_line(Y_line_23),
	.done(),
	.*
);

LineCUBE line34(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY3[20:10]), .x1(XY4[20:10]),
	.y0(XY3[9:0]), .y1(XY4[9:0]),
	.x_line(X_line_34), 
	.y_line(Y_line_34),
	.done(),
	.*
);

LineCUBE line45(
	.clk(clk),
	.reset(reset),
	.start(start45),
	.x0(XY5[20:10]), .x1(XY4[20:10]),
	.y0(XY5[9:0]), .y1(XY4[9:0]),
	.x_line(X_line_45), 
	.y_line(Y_line_45),
	.done(),
	.*
);

LineCUBE line50(
	.clk(clk),
	.reset(reset),
	.start(start50),
	.x0(XY0[20:10]), .x1(XY5[20:10]),
	.y0(XY0[9:0]), .y1(XY5[9:0]),
	.x_line(X_line_50), 
	.y_line(Y_line_50),
	.done(),
	.*
);

LineCUBE line06(
	.clk(clk),
	.reset(reset),
	.start(start06),
	.x0(XY0[20:10]), .x1(XY6[20:10]),
	.y0(XY0[9:0]), .y1(XY6[9:0]),
	.x_line(X_line_06), 
	.y_line(Y_line_06),
	.done(),
	.*
);

LineCUBE line64(
	.clk(clk),
	.reset(reset),
	.start(start64),
	.x0(XY6[20:10]), .x1(XY4[20:10]),
	.y0(XY6[9:0]), .y1(XY4[9:0]),
	.x_line(X_line_64), 
	.y_line(Y_line_64),
	.done(),
	.*
);

LineCUBE line62(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY6[20:10]), .x1(XY2[20:10]),
	.y0(XY6[9:0]), .y1(XY2[9:0]),
	.x_line(X_line_62), 
	.y_line(Y_line_62),
	.done(),
	.*
);
endmodule