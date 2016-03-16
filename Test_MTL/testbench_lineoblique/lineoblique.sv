`timescale 1ns/1ps

module lineoblique(
	input logic clk,
	input logic reset,
	input logic [10:0] x_offset, x_final, 
	input logic [9:0] y_offset, y_final,
	
	output logic done_mark, start_mark,
	output logic x_period, y_period, curseur,
	output logic [10:0] Xcount, Xline,
	output logic [9:0] Ycount, Yline,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
);
//	parameter Htotal = 1056 - 1;
//	parameter Vtotal = 525 - 1;
//	
//	parameter x_offset = 100;
//	parameter y_offset = 0;
//	parameter x_final = 100 + Vtotal - 1;
//	parameter y_final = Vtotal - 1;
	
	logic [10:0] Xpos, Xdraw;
	logic [9:0] Ypos, Ydraw;
	logic done_line, start_line;
	
	logic position;
	
	always_ff @(posedge clk)
begin
if (done_line) start_line <=0;
else if (Ypos == 0) start_line <= 1;
 position <=  (Xpos >= Xline) ;
 // position <= (Xpos >= Ypos + (Xline - x_offset));
//			position <= (Xpos >= x_offset + Ypos);


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


XYcount cnt(
.iCLK(clk),
.iRST_n(!reset),
.x_cnt(Xpos),
.y_cnt(Ypos),
.x_period(x_period),
.y_period(y_period)
);

LineCUBE line(
	.clk(Ypos),
	.reset(reset),
	.start(start_line),
	.x0(x_offset), .x1(x_final),
	.y0(y_offset), .y1(y_final),
	.x(Xdraw), 
	.y(Ydraw),
	.x_count(),
	.done(done_line),
	.plot()
);

assign Xcount = Xpos;
assign Ycount = Ypos;
assign Xline = Xdraw;
assign Yline = Ydraw;
assign curseur = position;
endmodule
