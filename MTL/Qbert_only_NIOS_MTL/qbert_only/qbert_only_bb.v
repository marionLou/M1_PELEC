
module qbert_only (
	button_external_connection_export,
	clk_clk,
	leds_external_connection_export,
	qbert_move_0_qbert_controller_spi,
	qbert_move_0_qbert_controller_clk,
	qbert_move_0_qbert_controller_reset_n,
	qbert_move_0_qbert_controller_loading,
	qbert_move_0_qbert_controller_newframe,
	qbert_move_0_qbert_controller_endframe,
	qbert_move_0_qbert_controller_read_data,
	qbert_move_0_qbert_controller_read_sdram_en,
	qbert_move_0_qbert_controller_hd,
	qbert_move_0_qbert_controller_lcd_r,
	qbert_move_0_qbert_controller_lcd_b,
	qbert_move_0_qbert_controller_vd,
	qbert_move_0_qbert_controller_lcd_g,
	reset_reset_n,
	switch_external_connection_export);	

	input		button_external_connection_export;
	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	input	[7:0]	qbert_move_0_qbert_controller_spi;
	input		qbert_move_0_qbert_controller_clk;
	input		qbert_move_0_qbert_controller_reset_n;
	input		qbert_move_0_qbert_controller_loading;
	output		qbert_move_0_qbert_controller_newframe;
	output		qbert_move_0_qbert_controller_endframe;
	input	[31:0]	qbert_move_0_qbert_controller_read_data;
	output		qbert_move_0_qbert_controller_read_sdram_en;
	output		qbert_move_0_qbert_controller_hd;
	output	[7:0]	qbert_move_0_qbert_controller_lcd_r;
	output	[7:0]	qbert_move_0_qbert_controller_lcd_b;
	output		qbert_move_0_qbert_controller_vd;
	output	[7:0]	qbert_move_0_qbert_controller_lcd_g;
	input		reset_reset_n;
	input	[3:0]	switch_external_connection_export;
endmodule
