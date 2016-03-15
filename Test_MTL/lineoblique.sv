module lineoblique(
	input logic clk,
	input logic reset,
//	input logic [11:0] Xlimit,
//	input logic [11:0] Ylimit,
	input logic [10:0] Xpos, 
	input logic [9:0] Ypos,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
);
	parameter Htotal = 1056 - 1;
	parameter Vtotal = 525 - 1;
	
	parameter x_offset = 0;
	parameter y_offset = 0;
//	parameter x_final = 1056 -1 ;
	parameter x_final = 300 + y_final ;
	parameter y_final = 300;
	
	logic [10:0] Xline;
	logic [9:0] Yline;
	logic done_line, start_line;
	
//	logic [11:0] count;
	logic position;
	
	always_ff @(posedge clk)
begin
 position <=  (Xpos >= Xline);
 // position <= (Xpos >= Ypos + (Xline - x_offset));
//			position <= (Xpos >= x_offset + Ypos);
//			if (done_line) start_line <= 0;
			if (position) begin
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

LineCUBE line(
	.clk(clk),
	.reset(reset),
	.start(1),
	.x0(x_offset), .x1(x_final),
	.y0(y_offset), .y1(y_final),
	.x(Xline), 
	.y(Yline),
	.x_count(),
	.done(done_line),
	.plot()
);
endmodule
