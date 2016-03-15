module Color_block(
	input logic clk,
	input logic [2:0] Block,
	input logic [10:0] Xpos,
	input logic [9:0] Ypos,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);
	logic position;
	logic [3:0] tvreal;
always_ff @(posedge clk)
begin
	position <= (Xpos>200 && Xpos<600)&&( Ypos>120 && Ypos<360);
	tvreal <= {(Xpos>0 && Xpos<199),(Xpos>200 && Xpos<399),
					(Xpos>400 && Xpos<599),(Xpos>600 && Xpos<799)};
	
//	 if(Block == 3'b1) begin
//					red 	<= 8'd255;
//					green 	<= 8'd0;
//					blue 	<= 8'd0;	
//				end 
//	else if(Block == 3'b10) begin
//					red 	<= 8'd0;
//					green 	<= 8'd255;
//					blue 	<= 8'd0;	
//				end				
//	else if(Block == 3'b11) begin
//					red 	<= 8'd0;
//					green 	<= 8'd0;
//					blue 	<= 8'd255;	
//				end
//	else begin
//						red 	<= 8'd0;
//						green 	<= 8'd0;
//						blue 	<= 8'd0; 
//						end
			
	case(Block)
		3'b001 : begin if(position) begin
					red 	<= 8'd255;
					green 	<= 8'd0;
					blue 	<= 8'd0;	
				end 
					else begin
						red 	<= 8'd0;
						green 	<= 8'd0;
						blue 	<= 8'd0; 
						end
				end
		3'b010 : begin if(position) begin
					red 	<= 8'd0;
					green 	<= 8'd255;
					blue 	<= 8'd0;	
				end 
					else begin
						red 	<= 8'd0;
						green 	<= 8'd0;
						blue 	<= 8'd0; 
						end
				end
		3'b011 : begin if(position) begin
					red 	<= 8'd0;
					green 	<= 8'd0;
					blue 	<= 8'd255;	
				end 
					else begin
						red 	<= 8'd0;
						green 	<= 8'd0;
						blue 	<= 8'd0; 
						end
				end
		3'b100 : begin if(position) begin
					red 	<= 8'd255;
					green 	<= 8'd255;
					blue 	<= 8'd255;	
				end 
					else begin
					red 	<= 8'd0;
					green 	<= 8'd0;
					blue 	<= 8'd0; 
					end
			end
		default : begin
						if(tvreal[0]) begin
						red <= 8'd139;
						green <= 8'd0;
						blue <= 8'd139;
						end
						else if (tvreal[1]) begin
						red <= 8'd0;
						green <= 8'd0;
						blue <= 8'd255;
						end
						else if (tvreal[2]) begin
						red <= 8'd0;
						green <= 8'd255;
						blue <= 8'd0;
						end
						else if (tvreal[3]) begin
						red <= 8'd255;
						green <= 8'd255;
						blue <= 8'd0;
						end
						else begin
						red <= 8'd0;
						green <= 8'd153;
						blue <= 8'd0;
						end
					end
	endcase	
end

endmodule