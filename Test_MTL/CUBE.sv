module CUBE(
	input logic clk,
	input logic reset,
	input logic top_cube,
	input logic [10:0] Xpos, 
	input logic [9:0] Ypos,
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

	parameter xline01 = 10'd100;
	parameter xdiag = 10'd30;
	parameter ydiag = 9'd50;
	parameter x_offset = 10'd100;
	parameter y_offset = 9'd100;
	
	parameter offset = 10'd2;
 
	logic [18:0] XY0 = {x_offset , y_offset};
	logic [18:0] XY1 = {x_offset + xline01 , y_offset};
	logic [18:0] XY2 = {x_offset + xline01 + xdiag , y_offset + ydiag};
	logic [18:0] XY3 = {x_offset + xline01 , y_offset + ydiag + ydiag};
	logic [18:0] XY4 = {x_offset , y_offset + ydiag + ydiag};
	logic [18:0] XY5 = { x_offset - xdiag , y_offset + ydiag};
	logic [18:0] XY6 = { x_offset + xdiag , y_offset + ydiag};
	logic [18:0] XYcenter = {x_offset , y_offset + ydiag};

	
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

	logic count50, count45;
	logic count06, count64;
	logic count12, count23;
	
	logic start50, start45;
	logic start06, start64;
	logic start12, start23;
	
	logic left_face;
	logic right_face;
	logic [1:0] top_face;
	
	logic [10:0] count;
	
	
always_ff @(posedge clk)
begin
//
//	left_face <= {(Xpos > (XY0[18:9] + X_line_06) & Xpos < (XY1[18:9] + X_line_12)) 
//									&&(Ypos > XY0[8:0] & Ypos < XY6[8:0])}; 
//									
//	right_face <= {(Xpos > (XY6[18:9] - X_line_64) & Xpos < (XY2[18:9] - X_line_23)) 
//									&&(Ypos > XY6[8:0] & Ypos < XY4[8:0])};
//									
//	top_face[0] <= ((Xpos > (XY0[18:9] - X_line_50) & Xpos < (XY0[18:9] + X_line_06)) 
//					&& (Ypos > XY0[8:0] & Ypos < XY6[8:0]));
//					
//	top_face[1] <= {(Xpos > (XYcenter[18:9] - X_line_45) & Xpos < (XYcenter[18:9] + X_line_64)) 
//					&&(Ypos > XY6[8:0] & Ypos < XY4[8:0])};
//	
if(reset) begin
		start50 <= 0;
		start06 <= 0;
		start12 <= 0;
		start45 <= 0;
		start64 <= 0;
		start23 <= 0;
	end 
		else begin
		
	if(Xpos >= count50 + offset && Xpos <= count50 - offset) start50 <= 1;
	else start50 <= 0;
	if(Xpos >= count06 + offset && Xpos <= count06 - offset) start06 <= 1;
	else start06 <= 0;
	if(Xpos >= count12 + offset && Xpos <= count12 - offset) start12 <= 1;
	else start12 <= 0;
	if(Xpos >= count45 + offset && Xpos <= count45 - offset) start45 <= 1;
	else start45 <= 0;
	if(Xpos >= count64 + offset && Xpos <= count64 - offset) start64 <= 1;
	else start64 <= 0;
	if(Xpos >= count23 + offset && Xpos <= count23 - offset) start23 <= 1;
	else start23 <= 0;
	
	left_face <= {(Xpos >= X_line_06 && Xpos <= X_line_12) 
					&&(Ypos >= XY0[8:0] && Ypos < XY6[8:0])}; 
									
	right_face <= {(Xpos >= X_line_64 && Xpos <= X_line_23) 
					&&(Ypos >= XY6[8:0] && Ypos <= XY4[8:0])};
									
	top_face[0] <= {(Xpos >= X_line_50 && Xpos < X_line_06)  
					&& (Ypos > XY0[8:0] && Ypos < XY6[8:0])};
					
	top_face[1] <= {(Xpos >= X_line_45 && Xpos < X_line_64)  
					&&(Ypos > XY6[8:0] && Ypos < XY4[8:0])};
	
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
	else if (top_face[0] || top_face[1]) 
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
end

LineCUBE line01(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY0[18:9]), .x1(XY1[18:9]),
	.y0(XY0[8:0]), .y1(XY1[8:0]),
	.x(X_line_01), 
	.y(Y_line_01),
	.x_count(),
	.done(),
	.plot()
);

LineCUBE line12(
	.clk(clk),
	.reset(reset),
	.start(start12),
	.x0(XY1[18:9]), .x1(XY2[18:9]),
	.y0(XY1[8:0]), .y1(XY2[8:0]),
	.x(X_line_12), 
	.y(Y_line_12),
	.x_count(count12),
	.done(),
	.plot()
);

LineCUBE line23(
	.clk(clk),
	.reset(reset),
	.start(start23),
	.x0(XY2[18:9]), .x1(XY3[18:9]),
	.y0(XY2[8:0]), .y1(XY3[8:0]),
	.x(X_line_23), 
	.y(Y_line_23),
	.x_count(count23),
	.done(),
	.plot()
);

LineCUBE line34(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY3[18:9]), .x1(XY4[18:9]),
	.y0(XY3[8:0]), .y1(XY4[8:0]),
	.x(X_line_34), 
	.y(Y_line_34),
	.x_count(),
	.done(),
	.plot()
);

LineCUBE line45(
	.clk(clk),
	.reset(reset),
	.start(start45),
	.x0(XY4[18:9]), .x1(XY5[18:9]),
	.y0(XY4[8:0]), .y1(XY5[8:0]),
	.x(X_line_45), 
	.y(Y_line_45),
	.x_count(count45),
	.done(),
	.plot()
);

LineCUBE line50(
	.clk(clk),
	.reset(reset),
	.start(start50),
	.x0(XY5[18:9]), .x1(XY0[18:9]),
	.y0(XY5[8:0]), .y1(XY0[8:0]),
	.x(X_line_50), 
	.y(Y_line_50),
	.x_count(count50),
	.done(),
	.plot()
);

LineCUBE line06(
	.clk(clk),
	.reset(reset),
	.start(start06),
	.x0(XY0[18:9]), .x1(XY6[18:9]),
	.y0(XY0[8:0]), .y1(XY6[8:0]),
	.x(X_line_06), 
	.y(Y_line_06),
	.x_count(count06),
	.done(),
	.plot()
);

LineCUBE line64(
	.clk(clk),
	.reset(reset),
	.start(start64),
	.x0(XY6[18:9]), .x1(XY4[18:9]),
	.y0(XY6[8:0]), .y1(XY4[8:0]),
	.x(X_line_64), 
	.y(Y_line_64),
	.x_count(),
	.done(),
	.plot()
);

LineCUBE line62(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY6[18:9]), .x1(XY2[18:9]),
	.y0(XY6[8:0]), .y1(XY2[8:0]),
	.x(X_line_62), 
	.y(Y_line_62),
	.x_count(),
	.done(),
	.plot()
);
endmodule