`timescale 1ns/1ps

module LineCUBE(
	input logic clk,
	input logic reset,
	input logic start,
	input logic [10:0] x0,x1,x_cnt,
	input logic [9:0] y0,y1,y_cnt,
	output logic done,
	output logic [10:0] xline,
	output logic [9:0] yline
	);
		
		logic signed [11:0] dx, dy, err, e2;
		logic [10:0] x_n, x_plus;
		logic [9:0] y_n, y_plus;
		
		logic right, down;
		
		
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
					dx = x1 - x0;  //  Blocking!
					right = dx >= 0;
					if (~right) dx = -dx;
					dy = y1 - y0;
					down = dy >= 0;
					if (down) dy = -dy;
					err = dx + dy;
					xline <= x_n;
					xline <= y_n;
					state <= RUN;
				end
			end
			RUN:
			if (x_cnt == x1 && y_cnt == y1 + 1) begin
				done <= 1;
				state <= IDLE;
			end else begin
			  if (x_cnt == 0) begin
			  x_line <= x_n;
			  y_line <= x_n;
			  x_n <= x_plus;
			  y_n <= y_plus;
			  end
			  else if (y_cnt == y_plus && x_cnt == x_n) begin
			  x_n <= x_plus;
			  y_n <= y_plus;
			  x_line <= x_plus;
			  y_line <= y_plus;
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
module XYplus(
	.err(err),
	.e2(e2),
	.dx(dx),
	.dy(dy),
	.x_n(x_n),
	.y_n(y_n),
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
	err,
	e2,
	dx,
	dy,
	x_n,
	y_n,
	x_plus,
	y_plus
);

input [11:0] err;
input [11:0] e2;
input [11:0] dx;
input [11:0] dy;
input [10:0] x_n;
input [9:0] y_n;
output [10:0] x_plus;
output [9:0] y_plus;

always_ff @(posedge clk) 
begin
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

endmodule
