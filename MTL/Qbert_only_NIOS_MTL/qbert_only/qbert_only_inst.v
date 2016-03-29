	qbert_only u0 (
		.button_external_connection_export           (<connected-to-button_external_connection_export>),           //    button_external_connection.export
		.clk_clk                                     (<connected-to-clk_clk>),                                     //                           clk.clk
		.leds_external_connection_export             (<connected-to-leds_external_connection_export>),             //      leds_external_connection.export
		.qbert_move_0_qbert_controller_spi           (<connected-to-qbert_move_0_qbert_controller_spi>),           // qbert_move_0_qbert_controller.spi
		.qbert_move_0_qbert_controller_clk           (<connected-to-qbert_move_0_qbert_controller_clk>),           //                              .clk
		.qbert_move_0_qbert_controller_reset_n       (<connected-to-qbert_move_0_qbert_controller_reset_n>),       //                              .reset_n
		.qbert_move_0_qbert_controller_loading       (<connected-to-qbert_move_0_qbert_controller_loading>),       //                              .loading
		.qbert_move_0_qbert_controller_newframe      (<connected-to-qbert_move_0_qbert_controller_newframe>),      //                              .newframe
		.qbert_move_0_qbert_controller_endframe      (<connected-to-qbert_move_0_qbert_controller_endframe>),      //                              .endframe
		.qbert_move_0_qbert_controller_read_data     (<connected-to-qbert_move_0_qbert_controller_read_data>),     //                              .read_data
		.qbert_move_0_qbert_controller_read_sdram_en (<connected-to-qbert_move_0_qbert_controller_read_sdram_en>), //                              .read_sdram_en
		.qbert_move_0_qbert_controller_hd            (<connected-to-qbert_move_0_qbert_controller_hd>),            //                              .hd
		.qbert_move_0_qbert_controller_lcd_r         (<connected-to-qbert_move_0_qbert_controller_lcd_r>),         //                              .lcd_r
		.qbert_move_0_qbert_controller_lcd_b         (<connected-to-qbert_move_0_qbert_controller_lcd_b>),         //                              .lcd_b
		.qbert_move_0_qbert_controller_vd            (<connected-to-qbert_move_0_qbert_controller_vd>),            //                              .vd
		.qbert_move_0_qbert_controller_lcd_g         (<connected-to-qbert_move_0_qbert_controller_lcd_g>),         //                              .lcd_g
		.reset_reset_n                               (<connected-to-reset_reset_n>),                               //                         reset.reset_n
		.switch_external_connection_export           (<connected-to-switch_external_connection_export>)            //    switch_external_connection.export
	);

