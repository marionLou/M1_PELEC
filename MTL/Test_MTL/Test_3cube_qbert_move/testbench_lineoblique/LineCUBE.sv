`timescale 1ns/1ps

module LineCUBE(
	input logic clk,
	input logic reset,
	input logic [10:0] x0,x1,x_cnt,
	input logic [9:0] y0,y1,y_cnt,
	output logic done,
	output logic start,
	output logic [10:0] x_line,
	output logic [9:0] y_line
	);
		
//		logic signed [11:0] dx, dy, err, e2;
		logic [10:0] x_n, x_plus;
		logic [9:0] y_n, y_plus;
		
//		logic right, down;
		
		
		typedef enum logic {IDLE, RUN} state_t;
		state_t state;
		always_ff @(posedge clk) begin
		done <= 0;
		start <= (x_cnt == 0) && (y_cnt == y0);
		if (reset) state <= IDLE;
		else case (state)
			IDLE:
			begin
			x_n <= x0;
			y_n <= y0;
				if (start) begin
//					dx = x1 - x0;  //  Blocking!
//					right = dx >= 0;
//					if (~right) dx = -dx;
//					dy = y1 - y0;
//					down = dy >= 0;
//					if (down) dy = -dy;
//					err = dx + dy;
					x_line <= x_n;
					y_line <= y_n;
					state <= RUN;
				end
			end
			RUN:
//			if (x_cnt == x1 && y_cnt == y1 + 1) begin
			if (x_n == x1 && y_n == y1) begin
				x_line <= x_n;
			   y_line <= y_n;
				done <= 1;
				state <= IDLE;
			end else begin
//			  if (x_cnt == 0 && y_cnt == y_plus) begin
			  if (x_cnt == 0 && y_n != y1) begin
			  x_n <= x_plus;
			  y_n <= y_plus;
			  x_line <= x_n;
			  y_line <= y_n;
			  end
//			  else if (x_cnt == x_n && y_cnt == y_plus) begin
			  else if (x_cnt == x_n && y_n == y_plus) begin
			  x_n <= x_plus;
			  y_n <= y_plus;
			  x_line <= x_n;
			  y_line <= y_n;
			  end
			  else if (y_n == y1 && x_n != x1) begin
			  x_n <= x_plus;

			  x_line <= x_n;
			  y_line <= y_n;
			  end
			  else if (x_n == x1 && y_n != y1) begin
			  y_n <= y_plus;
			  
			  x_line <= x_n;
			  y_line <= y_n;
			  end
			  else begin
			  x_line <= x_n;
			  y_line <= y_n;
			  end
			end
			default:
				state <= IDLE;
			endcase
			end
XYplus SD(
	.clk(clk),
	.start(start),
//	.err(err),
//	.e2(e2),
//	.right(right),
//	.down(down),
//	.dx(dx),
//	.dy(dy),
	.x_n(x_n),.x0(x0),.x1(x1),
	.y_n(y_n),.y0(x0),.y1(y1),
	.x_plus(x_plus),
	.y_plus(y_plus)
);
//		always_ff @(posedge clk) begin
//		done <= 0;
//		if (reset) state <= IDLE;
//		else case (state)
//			IDLE:
//			if (start) begin
//				dx = x1 - x0;  //  Blocking!
//				right = dx >= 0;
//				if (~right) dx = -dx;
//				dy = y1 - y0;
//				down = dy >= 0;
//				if (down) dy = -dy;
//				err = dx + dy;
//				x <= x0;
//				y <= y0;
//				state <= RUN;
//			end
//			RUN:
//			if (x == x1 && y == y1) begin
//				done <= 1;
//				state <= IDLE;
//			end else begin
//				plot <= 1;
//				count <= count + 1;
//				e2 = err << 1;
//				if (e2 > dy) begin
//					err += dy;
//					if (right) x <= x + 11'd1;
//					else x <= x - 11'd1;
//				end
//				if  (e2 < dx) begin
//					err += dx;
//					if (down) y <= y + 10'd1;
//					else y <= y - 10'd1;
//				end
//			end
//			default:
//				state <= IDLE;
//			endcase
//			end

endmodule

module XYplus(
	clk,
	start,
//	err,
//	e2,
//	err,
//	right,
//	down,
//	dx,
//	dy,
	x0,x1,
	y0,y1,
	x_n,
	y_n,
	x_plus,
	y_plus
);
input logic clk;
input logic start;
input logic [10:0] x_n,x0,x1;
input logic [9:0] y_n,y0,y1;
output logic [10:0] x_plus;
output logic [9:0] y_plus;

logic signed [11:0] dx, dy, err, e2;

logic right, down;

always_ff @(posedge clk) 
begin
				if (start) begin
					dx = x1 - x0;  //  Blocking!
					right = dx >= 0;
					if (~right) dx = -dx;
					dy = y1 - y0;
					down = dy >= 0;
					if (down) dy = -dy;
					err = dx + dy;
				end
			else begin	
				e2 = err << 1;
				if (e2 > dy) begin
					err += dy;
					if (right) x_plus <= x_n + 11'd1;
					else x_plus <= x_n - 11'd1;
				end
				if  (e2 < dx) begin
					err += dx;
					if (down) y_plus <= y_n + 10'd1;
					else y_plus <= y_n - 10'd1;
				end
			end
end

endmodule
