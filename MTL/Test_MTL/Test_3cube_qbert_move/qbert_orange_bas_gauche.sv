/*
	couleur orange R = 216
						G = 95
						B = 2
DATE : 23/03/16 
MODIFICATION : Adding a loop for moving qbert
*/
module qbert_orange_bas_gauche(
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt, x0, x1,  
	input logic [9:0] y_cnt, y0, y1,
//	output logic [7:0] red,
//	output logic [7:0] green,
//	output logic [7:0] blue,
//	input logic qbert_jump,
	output logic [10:0] qbert_x,  
	output logic [9:0] qbert_y,
	output logic [5:0] le_qbert

	);

parameter xlength = 11'd55;
parameter xdiag = 11'd60;
parameter ydiag = 10'd100;
//parameter move_speed = 26;

logic [10:0] XC; // x-top face center
logic [9:0] YC; // y-top face center

//logic flag_XY = 0;

logic pied_gauche;
logic pied_droit;
logic jambe_gauche;
logic jambe_droite;
logic tete;
logic museau;

logic [5:0] is_qbert_orange;

logic [31:0] move_count = 32'b0;
//logic signed [10:0] move_dx = (x1 - x0);
//logic signed [10:0] move_dy = (y1 - y0);
//
//logic signed [10:0] move_xy = {(move_dx>0 )? 1'd1 : -1'd1 , 
//								(move_dy>0)? 1'd1 : -1'd1};
//logic qbert_jump_state;

typedef enum logic {IDLE, RUN} state_t;
state_t move_state;


always_ff @(posedge clk) begin

//---- move Qbert in four directions--//
 move_count <= move_count + 32'd1;
//
////flag_XY <= 1;
//
//
	case(move_state)
		IDLE : if( move_count[16] == 1'b1 ) begin 
					if (YC <= y1 + ydiag) begin
						{XC,YC} <= {XC , YC + 10'd1}; 
					end
					else if (XC < x1) {XC,YC} <= {XC + 11'd1, YC} ; 
					else {XC,YC} <= {x0 , y0 + ydiag};
					
					move_state <= RUN; 
				end 
		RUN : if(move_count[16] == 1'b0) move_state <= IDLE;
		default : begin 
					move_state <= IDLE;
					{XC,YC} <= {x0 , y0 + ydiag};
					end
	endcase
	
	
	
/* ---- EXPLANATION -------------------------------------------
	I think that the signal which is given to the pic by MIWI is	
   just an impulse. Therefore, when "qbert_jump" which a signal from NIOS
	is ON, then we enter the condition. Immediatelly "qbert_jump" is null.
	But qbert_jump_state is ON and we can re-enter the loop for incre-
	menting the QBERT Position. When the Qbert Position is equal to
	(X,Y)final then we go out from the loop because "qbert_jump_state"
	is null.
*/
//	if (qbert_jump || qbert_jump_state) begin
//		qbert_jump_state <= 1;
//		if (move_count[26] == 0) begin
//			if (move_dx>0) begin
//				if (y0 != y1) begin
//				{XC,YC} <= {XC , YC + move_xy[0]};
//				end 
//				else if (x0 != x1) begin
//				{XC,YC} <= {XC + move_xy[1] , YC};
//				end
//			end
//			else begin
//				if (x0 != x1) begin
//				{XC,YC} <= {XC + move_xy[1] , YC};
//				end
//				else if (y0 != y1) begin
//				{XC,YC} <= {XC , YC + move_xy[0]};
//				end  
//			end		
//		end
//		else if (XC == x1 & YC == y1) qbert_jump_state <= 0; 
//	end
//	else {XC,YC} <= {x0 , y0 + ydiag}; 
	
//---------- Qbert zones ---------------//
	
	pied_gauche <= { (y_cnt >= YC + ydiag/10'd6  && y_cnt <= YC + ydiag/10'd2)	
						&& (x_cnt >= XC + xdiag/11'd2 && x_cnt <= XC + 11'd2*xdiag/11'd3)};
						
	pied_droit <= { (y_cnt >= YC - ydiag/10'd6 && y_cnt < YC + ydiag/10'd6)
						&& (x_cnt >= XC + xdiag/11'd2 && x_cnt <= XC + 11'd2*xdiag/11'd3)};
	
	jambe_droite <= {	(y_cnt >= YC - ydiag/10'd6 && y_cnt <= YC - ydiag/10'd12)
							&& (x_cnt >= XC + xdiag/11'd3 && x_cnt <= XC + 11'd2*xdiag/11'd3)};
							
	jambe_gauche <= {	(y_cnt >= YC + ydiag/10'd12 && y_cnt <= YC + ydiag/10'd6)
							&& (x_cnt >= XC + xdiag/11'd3 && x_cnt <= XC + 11'd2*xdiag/11'd3)};
	
	tete <= {(y_cnt >= YC - ydiag/10'd4 && y_cnt <= YC + ydiag/10'd4) 
			&& (x_cnt <= XC + xdiag/11'd3 && x_cnt >= XC - xdiag/11'd2)};
			
	museau <= {(y_cnt >= YC + ydiag/10'd4 && y_cnt <= YC + 11'd2*ydiag/10'd3) 
			&& (x_cnt <= XC + xdiag/11'd3 && x_cnt >= XC - xdiag/11'd4)};


	
	is_qbert_orange <= {pied_gauche, jambe_gauche, pied_droit, jambe_droite, tete, museau};
	
//		if (is_qbert_orange !=0) begin
//			red <= 8'd216;
//			green <= 8'd95;
//			blue <= 8'd2;
//		end
//		else begin
//			red 	<= 8'd0;
//			green <= 8'd0;
//			blue 	<= 8'd0;
//		end

end
	
assign {qbert_x, qbert_y} = {XC, YC};
assign le_qbert = is_qbert_orange;

endmodule
