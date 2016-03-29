/*
	couleur orange R = 216
						G = 95
						B = 2
*/
module qbert_orange_bas_gauche(

//------INPUT--------------------//	
	input logic clk,
	input logic reset,
	input logic qbert_jump,
	input logic [10:0] x_cnt, x0,// x1,  
	input logic [9:0] y_cnt, y0,// y1,
	input logic [10:0] XDIAG_DEMI,
	input logic [9:0] YDIAG_DEMI,

//------OUTPUT-------------------//
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue,
	output logic [5:0] le_qbert

	);


logic [10:0] XC; // x-top face center
logic [9:0] YC; // y-top face center

logic pied_gauche;
logic pied_droit;
logic jambe_gauche;
logic jambe_droite;
logic tete;
logic museau;

logic [5:0] is_qbert_orange;

always_ff @(posedge clk) begin

	{XC,YC} <= {x0 , y0 + YDIAG_DEMI};
	
	pied_gauche <= { (y_cnt >= YC + YDIAG_DEMI/10'd6  && y_cnt <= YC + YDIAG_DEMI/10'd2)	
						&& (x_cnt >= XC + XDIAG_DEMI/11'd2 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
						
	pied_droit <= { (y_cnt >= YC - YDIAG_DEMI/10'd6 && y_cnt < YC + YDIAG_DEMI/10'd6)
						&& (x_cnt >= XC + XDIAG_DEMI/11'd2 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
	
	jambe_droite <= {	(y_cnt >= YC - YDIAG_DEMI/10'd6 && y_cnt <= YC - YDIAG_DEMI/10'd12)
							&& (x_cnt >= XC + XDIAG_DEMI/11'd3 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
							
	jambe_gauche <= {	(y_cnt >= YC + YDIAG_DEMI/10'd12 && y_cnt <= YC + YDIAG_DEMI/10'd6)
							&& (x_cnt >= XC + XDIAG_DEMI/11'd3 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
	
	tete <= {(y_cnt >= YC - YDIAG_DEMI/10'd4 && y_cnt <= YC + YDIAG_DEMI/10'd4) 
			&& (x_cnt <= XC + XDIAG_DEMI/11'd3 && x_cnt >= XC - XDIAG_DEMI/11'd2)};
			
	museau <= {(y_cnt >= YC + YDIAG_DEMI/10'd4 && y_cnt <= YC + 11'd2*YDIAG_DEMI/10'd3) 
			&& (x_cnt <= XC + XDIAG_DEMI/11'd3 && x_cnt >= XC - XDIAG_DEMI/11'd4)};


	
	is_qbert_orange <= {pied_gauche, jambe_gauche, pied_droit, jambe_droite, tete, museau};
	
			if (is_qbert_orange !=0) begin
			red <= 8'd216;
			green <= 8'd95;
			blue <= 8'd2;
			end
			else begin
			red <= 8'd0;
			green <= 8'd0;
			blue <= 8'd0;
			end
	

end
	
assign le_qbert = is_qbert_orange;

endmodule
