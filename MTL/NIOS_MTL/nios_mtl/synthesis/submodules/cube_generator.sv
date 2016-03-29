module cube_generator(
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt, x_offset, XDIAG_DEMI, XLENGTH,
	input logic [9:0] y_cnt, y_offset, YDIAG_DEMI,
	input logic [10:0] qbert_x,  
	input logic [9:0] qbert_y,
	output logic qbert_top_face,
	output logic left_face,
	output logic right_face,
//	output logic [3:0] top_face
	output logic top_face
	);
	/*
 A beautiful cube with 
the position of each point 
				y	<------O
		 5				    |
	  %%%%%				 |
	0%%%°%%%4			 v
	 -%%%%%-			   
	|-- 6 --|			 X
	|---|---|
	1\--|--3
	  \-2-/
	
	*/  
	
	// lenght for the cube's left face




 
	logic [20:0] XY0;
	logic [20:0] XY1;
	logic [20:0] XY2;
	logic [20:0] XY3;
	logic [20:0] XY4;
	logic [20:0] XY5;
	logic [20:0] XY6;

	

	logic [10:0] X_line_12;
	logic [9:0] Y_line_12;
	logic [10:0] X_line_23;
	logic [9:0] Y_line_23;
	logic [10:0] X_line_45;
	logic [9:0] Y_line_45;
	logic [10:0] X_line_50;
	logic [9:0] Y_line_50;
	logic [10:0] X_line_06;
	logic [9:0] Y_line_06;
	logic [10:0] X_line_64;
	logic [9:0] Y_line_64;


	
	logic left_reg;
	logic right_reg;
	logic [3:0] top_reg;
	logic qbert_zone;
	logic qbert_top_face_reg;
	
	
	
	
always_ff @(posedge clk)
begin
	
   XY0 <= {x_offset , y_offset};
   XY1 <= {x_offset + XLENGTH , y_offset};
	XY2 <= {x_offset + XLENGTH + XDIAG_DEMI , y_offset + YDIAG_DEMI};
	XY3 <= {x_offset + XLENGTH , y_offset + YDIAG_DEMI + YDIAG_DEMI};
	XY4 <= {x_offset , y_offset + YDIAG_DEMI + YDIAG_DEMI};
	XY5 <= { x_offset - XDIAG_DEMI , y_offset + YDIAG_DEMI};
	XY6 <= { x_offset + XDIAG_DEMI , y_offset + YDIAG_DEMI};
//	XYcenter <= {x_offset , y_offset + YDIAG_DEMI};
	
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
					
	qbert_zone <= {(qbert_x < XY0[20:10] + XDIAG_DEMI && qbert_x > XY0[20:10] - XDIAG_DEMI) 
				&& (qbert_y < XY0[9:0] + YDIAG_DEMI + YDIAG_DEMI && qbert_y > XY0[9:0] )};
		
end

logic [31:0] count;

typedef enum logic {IDLE, RUN} state_t;
state_t state;

always_ff @(posedge clk) begin

//-----------------Qbert------------------------------//

count <= count + 32'b1;
	case(state)
		IDLE : begin
					begin
						if ( qbert_zone) state <= RUN;
						else qbert_top_face_reg <= 1'b0; 
					end
				end
		RUN : begin
					 // qbert_top_face_reg <= 1'b1;
					 // state <= IDLE;
					if (count[16] == 1'b1)
					qbert_top_face_reg <= 1'b1 ;
					else state <= IDLE;
				end
		default : begin
						state <= IDLE;
						qbert_top_face_reg <= 1'b0;
					end
	endcase

end

//assign passage_qbert = passage_qbert_reg;
assign top_face = top_reg[3]|top_reg[2]|top_reg[1]|top_reg[0];
assign left_face = left_reg;
assign right_face = right_reg;
assign qbert_top_face = qbert_top_face_reg;


Draw_Line line12(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY1[20:10]), .x1(XY2[20:10]),
	.y0(XY1[9:0]), .y1(XY2[9:0]),
	.x_line(X_line_12), 
	.y_line(Y_line_12),
	.done(),
	.*
);

Draw_Line line23(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY2[20:10]), .x1(XY3[20:10]),
	.y0(XY2[9:0]), .y1(XY3[9:0]),
	.x_line(X_line_23), 
	.y_line(Y_line_23),
	.done(),
	.*
);


Draw_Line line45(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY5[20:10]), .x1(XY4[20:10]),
	.y0(XY5[9:0]), .y1(XY4[9:0]),
	.x_line(X_line_45), 
	.y_line(Y_line_45),
	.done(),
	.*
);

Draw_Line line50(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY0[20:10]), .x1(XY5[20:10]),
	.y0(XY0[9:0]), .y1(XY5[9:0]),
	.x_line(X_line_50), 
	.y_line(Y_line_50),
	.done(),
	.*
);

Draw_Line line06(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY0[20:10]), .x1(XY6[20:10]),
	.y0(XY0[9:0]), .y1(XY6[9:0]),
	.x_line(X_line_06), 
	.y_line(Y_line_06),
	.done(),
	.*
);

Draw_Line line64(
	.clk(clk),
	.reset(reset),
	.start(),
	.x0(XY6[20:10]), .x1(XY4[20:10]),
	.y0(XY6[9:0]), .y1(XY4[9:0]),
	.x_line(X_line_64), 
	.y_line(Y_line_64),
	.done(),
	.*
);


endmodule