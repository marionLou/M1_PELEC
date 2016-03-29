module cube_generator(
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt, x_offset, 
	input logic [9:0] y_cnt, y_offset,
	output left_face,
	output right_face,
	output [3:0] top_face
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


	parameter xlength = 11'd120;
	parameter xdiag = 11'd50;
	parameter ydiag = 10'd90;
//	parameter x_offset = 11'd400;
//	parameter y_offset = 10'd200;

 
	logic [20:0] XY0;
	logic [20:0] XY1;
	logic [20:0] XY2;
	logic [20:0] XY3;
	logic [20:0] XY4;
	logic [20:0] XY5;
	logic [20:0] XY6;
	logic [20:0] XYcenter;

	
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

	
	logic start50, start45;
	logic start06, start64;
	logic start12, start23;
	
	logic left_reg;
	logic right_reg;
	logic [3:0] top_reg;
	
	logic [10:0] count;
	
	
always_ff @(posedge clk)
begin
	
   XY0 <= {x_offset , y_offset};
   XY1 <= {x_offset + xlength , y_offset};
	XY2 <= {x_offset + xlength + xdiag , y_offset + ydiag};
	XY3 <= {x_offset + xlength , y_offset + ydiag + ydiag};
	XY4 <= {x_offset , y_offset + ydiag + ydiag};
	XY5 <= { x_offset - xdiag , y_offset + ydiag};
	XY6 <= { x_offset + xdiag , y_offset + ydiag};
	XYcenter <= {x_offset , y_offset + ydiag};
	
  left_reg <= {(x_cnt >= X_line_64 && x_cnt <= X_line_23) 
					&&(y_cnt >= XY6[9:0] && y_cnt <= XY4[9:0])};
	
  right_reg <= {(x_cnt >= X_line_06 && x_cnt <= X_line_12) 
					&&(y_cnt >= XY0[9:0] && y_cnt < XY6[9:0])}; 
									
  top_reg[0] <= {(x_cnt >= XY0[20:10] && x_cnt < X_line_06)  
					&& (y_cnt > XY0[9:0] && y_cnt <= XY6[9:0])};
		
  top_reg[1] <= {(x_cnt >= X_line_50 && x_cnt < XY0[20:10])  
					&& (y_cnt > XY0[9:0] && y_cnt <= XY6[9:0])};
					
  top_reg[2] <= {(x_cnt >= XY0[20:10] && x_cnt < X_line_64)  
					&&(y_cnt > XY6[9:0] && y_cnt < XY4[9:0])};
	
  top_reg[3] <= {(x_cnt >= X_line_45 && x_cnt < XY0[20:10])  
					&&(y_cnt > XY6[9:0] && y_cnt < XY4[9:0])};
		
end

assign top_face = top_reg;
assign left_face = left_reg;
assign right_face = right_reg;

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