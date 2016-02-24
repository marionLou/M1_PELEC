	DE0_LT24_SOPC u0 (
		.clk_clk                          (<connected-to-clk_clk>),                          //                       clk.clk
		.reset_reset_n                    (<connected-to-reset_reset_n>),                    //                     reset.reset_n
		.sdram_wire_addr                  (<connected-to-sdram_wire_addr>),                  //                sdram_wire.addr
		.sdram_wire_ba                    (<connected-to-sdram_wire_ba>),                    //                          .ba
		.sdram_wire_cas_n                 (<connected-to-sdram_wire_cas_n>),                 //                          .cas_n
		.sdram_wire_cke                   (<connected-to-sdram_wire_cke>),                   //                          .cke
		.sdram_wire_cs_n                  (<connected-to-sdram_wire_cs_n>),                  //                          .cs_n
		.sdram_wire_dq                    (<connected-to-sdram_wire_dq>),                    //                          .dq
		.sdram_wire_dqm                   (<connected-to-sdram_wire_dqm>),                   //                          .dqm
		.sdram_wire_ras_n                 (<connected-to-sdram_wire_ras_n>),                 //                          .ras_n
		.sdram_wire_we_n                  (<connected-to-sdram_wire_we_n>),                  //                          .we_n
		.from_key_export                  (<connected-to-from_key_export>),                  //                  from_key.export
		.lt24_conduit_cs                  (<connected-to-lt24_conduit_cs>),                  //              lt24_conduit.cs
		.lt24_conduit_rs                  (<connected-to-lt24_conduit_rs>),                  //                          .rs
		.lt24_conduit_rd                  (<connected-to-lt24_conduit_rd>),                  //                          .rd
		.lt24_conduit_wr                  (<connected-to-lt24_conduit_wr>),                  //                          .wr
		.lt24_conduit_data                (<connected-to-lt24_conduit_data>),                //                          .data
		.lt24_lcd_rstn_export             (<connected-to-lt24_lcd_rstn_export>),             //             lt24_lcd_rstn.export
		.lt24_touch_spi_MISO              (<connected-to-lt24_touch_spi_MISO>),              //            lt24_touch_spi.MISO
		.lt24_touch_spi_MOSI              (<connected-to-lt24_touch_spi_MOSI>),              //                          .MOSI
		.lt24_touch_spi_SCLK              (<connected-to-lt24_touch_spi_SCLK>),              //                          .SCLK
		.lt24_touch_spi_SS_n              (<connected-to-lt24_touch_spi_SS_n>),              //                          .SS_n
		.lt24_touch_penirq_n_export       (<connected-to-lt24_touch_penirq_n_export>),       //       lt24_touch_penirq_n.export
		.lt24_touch_busy_export           (<connected-to-lt24_touch_busy_export>),           //           lt24_touch_busy.export
		.alt_pll_c4_conduit_export        (<connected-to-alt_pll_c4_conduit_export>),        //        alt_pll_c4_conduit.export
		.alt_pll_c3_conduit_export        (<connected-to-alt_pll_c3_conduit_export>),        //        alt_pll_c3_conduit.export
		.alt_pll_areset_conduit_export    (<connected-to-alt_pll_areset_conduit_export>),    //    alt_pll_areset_conduit.export
		.alt_pll_locked_conduit_export    (<connected-to-alt_pll_locked_conduit_export>),    //    alt_pll_locked_conduit.export
		.alt_pll_phasedone_conduit_export (<connected-to-alt_pll_phasedone_conduit_export>), // alt_pll_phasedone_conduit.export
		.alt_pll_c1_clk                   (<connected-to-alt_pll_c1_clk>),                   //                alt_pll_c1.clk
		.to_led_export                    (<connected-to-to_led_export>)                     //                    to_led.export
	);

