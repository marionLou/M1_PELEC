`timescale 1ns/1ps
module LineCUBE(
	input logic clk,
	input logic reset,
	input logic start,
	input logic [10:0] x0,x1,
	input logic [9:0] y0,y1,
	output logic done,
	output logic plot,
	output logic [10:0] x_count,
	output logic [10:0] x,
	output logic [9:0] y
	);
		
		logic signed [11:0] dx, dy, err, e2;
		logic right, down;
		
		logic [10:0] count;
		
		typedef enum logic {IDLE, RUN} state_t;
		state_t state;

		always_ff @(posedge clk) begin
		done <= 0;
		plot <= 0;
		count <= 0;
		if (reset) state <= IDLE;
		else case (state)
			IDLE:
			if (start) begin
				dx = x1 - x0;  //  Blocking!
				right = dx >= 0;
				if (~right) dx = -dx;
				dy = y1 - y0;
				down = dy >= 0;
				if (down) dy = -dy;
				err = dx + dy;
				x <= x0;
				y <= y0;
				plot <= 1;
				count <= count + 1;
				state <= RUN;
			end
			RUN:
			if (x == x1 && y == y1) begin
				done <= 1;
				count <= 0;
				state <= IDLE;
			end else begin
				plot <= 1;
				count <= count + 1;
				e2 = err << 1;
				if (e2 > dy) begin
					err += dy;
					if (right) x <= x + 11'd1;
					else x <= x - 11'd1;
				end
				if  (e2 < dx) begin
					err += dx;
					if (down) y <= y + 10'd1;
					else y <= y - 10'd1;
				end
			end
			
			default:
				state <= IDLE;
			endcase
			end
assign x_count = count + x0;

endmodule