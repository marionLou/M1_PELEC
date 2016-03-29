/*
	couleur orange R = 216
						G = 95
						B = 2
*/
module qbert_orange_bas_gauche(
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt, x_offset,  
	input logic [9:0] y_cnt, y_offset,
//	output logic [7:0] red,
//	output logic [7:0] green,
//	output logic [7:0] blue,
	output logic [5:0] le_qbert

	);
parameter xlength = 11'd55;
parameter xdiag = 11'd60;
parameter ydiag = 10'd100;

logic [10:0] XC; // x-top face center
logic [9:0] YC; // y-top face center

logic pied_gauche;
logic pied_droit;
logic jambe_gauche;
logic jambe_droite;
logic tete;
//logic oeil_gauche;
//logic oeil_droit;
//logic bouche;
logic museau;

logic [5:0] is_qbert_orange;

always_ff @(posedge clk) begin

	{XC,YC} <= {x_offset , y_offset + ydiag};
	
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
	
//	if (is_qbert_orange !=0) begin
//			red <= 8'd216;
//			green <= 8'd95;
//			blue <= 8'd2;
//	end
//	else begin
//			red <= 8'd0;
//			green <= 8'd0;
//			blue <= 8'd0;
//	end
end
	
assign le_qbert = is_qbert_orange;

endmodule

//	{XC,YC} <= {x_offset + xdiag, y_offset + ydiag};
//	
//	pied_gauche <= { (y_cnt >= YC - ydiag/10'd2 && y_cnt <= YC - ydiag/10'd6)	
//						&& (x_cnt >= XC + 11'd2*xdiag/11'd3 && x_cnt <= XC + xdiag/11'd2)};
//						
//	pied_droit <= { (y_cnt >= YC - ydiag/10'd6 && y_cnt <= YC + ydiag/10'd6)
//						&& (x_cnt >= XC + 11'd2*xdiag/11'd3 && x_cnt <= XC + xdiag/11'd2)};
//	
//	jambe_gauche <= {	(y_cnt >= YC - ydiag/10'd6 && y_cnt <= YC - ydiag/10'd12)
//							&& (x_cnt >= XC + xdiag/11'd3 && x_cnt <= XC + 11'd2*xdiag/11'd3)};
//							
//	jambe_droite <= {	(y_cnt >= YC + ydiag/10'd12 && y_cnt <= YC + ydiag/10'd6)
//							&& (x_cnt >= XC + xdiag/11'd3 && x_cnt <= XC + 11'd2*xdiag/11'd3)};
//	
//	tete <= {(y_cnt >= YC - ydiag/10'd4 && y_cnt <= YC + ydiag/10'd4) 
//			&& (x_cnt <= XC + xdiag/11'd3 && x_cnt >= XC - xdiag/11'd4)};
//			
//	museau <= {(y_cnt <= YC - ydiag/10'd4 && y_cnt >= YC - 11'd3*ydiag/10'd2) 
//			&& (x_cnt <= XC + xdiag/11'd3 && x_cnt >= XC - xdiag/11'd6)};
