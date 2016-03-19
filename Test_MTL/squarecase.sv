module squarecase(
	input logic clk,
	input logic reset,
	input logic [10:0] Xpos, 
	input logic [9:0] Ypos,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);
	
	parameter X_LIM = 1055; // 1056 - 1 
	parameter Y_LIM = 524; // 525 - 1
	parameter Out_length = 10'd100;
	parameter In_length = 10'd80;
//	parameter Out_x_offset = 11'd100;
////	parameter In_x_offset = Out_x_offset + (Out_length - In_length)/2;
//	parameter In_x_offset = 11'd110;
//	parameter Out_y_offset = 10'd100;
////	parameter In_y_offset = Out_y_offset + (Out_length - In_length)/2;
//	parameter In_y_offset = 10'd110;
	
	logic [20:0] L1_Out_XY0, L1_Out_XY1, L1_Out_XY2, L1_Out_XY3;
	logic [20:0] L1_In_XY0, L1_In_XY1, L1_In_XY2, L1_In_XY3;
	
	logic [10:0] L1_Out_x_offset, L1_In_x_offset;
	logic [9:0] L1_Out_y_offset, L1_In_y_offset;
	
//	assign In_x_offset = Out_x_offset + 11'd10;
//	assign In_y_offset = Out_y_offset + 10'd10;	
	
//	logic [20:0] Out_XY0 = {Out_x_offset , Out_y_offset};
//	logic [20:0] Out_XY1 = {Out_x_offset + Out_length , Out_y_offset};
//	logic [20:0] Out_XY2 = {Out_x_offset + Out_length , Out_y_offset + Out_length};
//	logic [20:0] Out_XY3 = {Out_x_offset , Out_y_offset + Out_length};
//	
//	logic [20:0] In_XY0 = {In_x_offset , In_y_offset};
//	logic [20:0] In_XY1 = {In_x_offset + In_length , In_y_offset};
//	logic [20:0] In_XY2 = {In_x_offset + In_length , In_y_offset + In_length};
//	logic [20:0] In_XY3 = {In_x_offset , In_y_offset + In_length};
	
	always_ff @(posedge clk) begin
	
	L1_In_x_offset <= L1_Out_x_offset + 11'd10;
	L1_In_y_offset <= L1_Out_y_offset + 10'd10;	

	L1_Out_XY0 <= {L1_Out_x_offset , L1_Out_y_offset};
	L1_Out_XY3 <= {L1_Out_x_offset , L1_Out_y_offset + Out_length};
	L1_Out_XY1 <= {L1_Out_x_offset + L1_Out_length , L1_Out_y_offset};
	L1_Out_XY2 <= {L1_Out_x_offset + L1_Out_length , L1_Out_y_offset + Out_length};
	
	L1_In_XY0 <= {L1_In_x_offset , L1_In_y_offset};
	L1_In_XY3 <= {L1_In_x_offset , L1_In_y_offset + In_length};
	L1_In_XY1 <= {L1_In_x_offset + In_length , L1_In_y_offset};
	L1_In_XY2 <= {L1_In_x_offset + In_length , L1_In_y_offset + In_length};	
	
	case ({Xpos,Ypos})
	{11'd99,10'd99} : {L1_Out_x_offset,L1_Out_y_offset} <= {11'd99 + 11'd1, 10'd100};
//	{11'd200,10'd99} : {Out_x_offset,Out_y_offset} <= {11'd200 + 11'd1, 10'd99 + 10'd1};
	{11'd99,10'd209} : {L1_Out_x_offset,L1_Out_y_offset} <= {11'd99 + 11'd1, 10'd210 + 10'd1};
//	default : {Out_x_offset,Out_y_offset} <= {11'd99 + 11'd1, 10'd100};
	endcase
	end
	
	typedef enum logic {IDLE, RUN} state_t;
	state_t state;
	
	logic Out_square;
	logic In_square;
	
	
	always_ff @(posedge clk) begin

		Out_square <= {(Xpos >= L1_Out_XY0[20:10] && Xpos <= L1_Out_XY1[20:10]) 
							& (Ypos >= L1_Out_XY0[9:0] && Ypos <= L1_Out_XY3[9:0])};
		In_square <= {(Xpos >= L1_In_XY0[20:10] && Xpos <= L1_In_XY1[20:10]) 
							& (Ypos >= L1_In_XY0[9:0] && Ypos <= L1_In_XY3[9:0])};
							
		
		if(In_square) begin
			red <= 8'd222;
			green <= 8'd222;
			blue <= 8'd0;
		end
		else if(Out_square) begin
			red 	<= 8'd0;
			green <= 8'd0;
			blue 	<= 8'd255;
		end
		else begin
		red 	<= 8'd0;
		green <= 8'd0;
		blue 	<= 8'd0;
		end
		

	end
	
	
endmodule
