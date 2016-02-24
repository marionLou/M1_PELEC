
module DE0_LT24_SOPC (
	clk_clk,
	reset_reset_n,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	from_key_export,
	lt24_conduit_cs,
	lt24_conduit_rs,
	lt24_conduit_rd,
	lt24_conduit_wr,
	lt24_conduit_data,
	lt24_lcd_rstn_export,
	lt24_touch_spi_MISO,
	lt24_touch_spi_MOSI,
	lt24_touch_spi_SCLK,
	lt24_touch_spi_SS_n,
	lt24_touch_penirq_n_export,
	lt24_touch_busy_export,
	alt_pll_c4_conduit_export,
	alt_pll_c3_conduit_export,
	alt_pll_areset_conduit_export,
	alt_pll_locked_conduit_export,
	alt_pll_phasedone_conduit_export,
	alt_pll_c1_clk,
	to_led_export);	

	input		clk_clk;
	input		reset_reset_n;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input		from_key_export;
	output		lt24_conduit_cs;
	output		lt24_conduit_rs;
	output		lt24_conduit_rd;
	output		lt24_conduit_wr;
	output	[15:0]	lt24_conduit_data;
	output		lt24_lcd_rstn_export;
	input		lt24_touch_spi_MISO;
	output		lt24_touch_spi_MOSI;
	output		lt24_touch_spi_SCLK;
	output		lt24_touch_spi_SS_n;
	input		lt24_touch_penirq_n_export;
	input		lt24_touch_busy_export;
	output		alt_pll_c4_conduit_export;
	output		alt_pll_c3_conduit_export;
	input		alt_pll_areset_conduit_export;
	output		alt_pll_locked_conduit_export;
	output		alt_pll_phasedone_conduit_export;
	output		alt_pll_c1_clk;
	output	[7:0]	to_led_export;
endmodule
