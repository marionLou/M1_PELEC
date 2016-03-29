	component qbert_only is
		port (
			button_external_connection_export           : in  std_logic                     := 'X';             -- export
			clk_clk                                     : in  std_logic                     := 'X';             -- clk
			leds_external_connection_export             : out std_logic_vector(7 downto 0);                     -- export
			qbert_move_0_qbert_controller_spi           : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- spi
			qbert_move_0_qbert_controller_clk           : in  std_logic                     := 'X';             -- clk
			qbert_move_0_qbert_controller_reset_n       : in  std_logic                     := 'X';             -- reset_n
			qbert_move_0_qbert_controller_loading       : in  std_logic                     := 'X';             -- loading
			qbert_move_0_qbert_controller_newframe      : out std_logic;                                        -- newframe
			qbert_move_0_qbert_controller_endframe      : out std_logic;                                        -- endframe
			qbert_move_0_qbert_controller_read_data     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- read_data
			qbert_move_0_qbert_controller_read_sdram_en : out std_logic;                                        -- read_sdram_en
			qbert_move_0_qbert_controller_hd            : out std_logic;                                        -- hd
			qbert_move_0_qbert_controller_lcd_r         : out std_logic_vector(7 downto 0);                     -- lcd_r
			qbert_move_0_qbert_controller_lcd_b         : out std_logic_vector(7 downto 0);                     -- lcd_b
			qbert_move_0_qbert_controller_vd            : out std_logic;                                        -- vd
			qbert_move_0_qbert_controller_lcd_g         : out std_logic_vector(7 downto 0);                     -- lcd_g
			reset_reset_n                               : in  std_logic                     := 'X';             -- reset_n
			switch_external_connection_export           : in  std_logic_vector(3 downto 0)  := (others => 'X')  -- export
		);
	end component qbert_only;

	u0 : component qbert_only
		port map (
			button_external_connection_export           => CONNECTED_TO_button_external_connection_export,           --    button_external_connection.export
			clk_clk                                     => CONNECTED_TO_clk_clk,                                     --                           clk.clk
			leds_external_connection_export             => CONNECTED_TO_leds_external_connection_export,             --      leds_external_connection.export
			qbert_move_0_qbert_controller_spi           => CONNECTED_TO_qbert_move_0_qbert_controller_spi,           -- qbert_move_0_qbert_controller.spi
			qbert_move_0_qbert_controller_clk           => CONNECTED_TO_qbert_move_0_qbert_controller_clk,           --                              .clk
			qbert_move_0_qbert_controller_reset_n       => CONNECTED_TO_qbert_move_0_qbert_controller_reset_n,       --                              .reset_n
			qbert_move_0_qbert_controller_loading       => CONNECTED_TO_qbert_move_0_qbert_controller_loading,       --                              .loading
			qbert_move_0_qbert_controller_newframe      => CONNECTED_TO_qbert_move_0_qbert_controller_newframe,      --                              .newframe
			qbert_move_0_qbert_controller_endframe      => CONNECTED_TO_qbert_move_0_qbert_controller_endframe,      --                              .endframe
			qbert_move_0_qbert_controller_read_data     => CONNECTED_TO_qbert_move_0_qbert_controller_read_data,     --                              .read_data
			qbert_move_0_qbert_controller_read_sdram_en => CONNECTED_TO_qbert_move_0_qbert_controller_read_sdram_en, --                              .read_sdram_en
			qbert_move_0_qbert_controller_hd            => CONNECTED_TO_qbert_move_0_qbert_controller_hd,            --                              .hd
			qbert_move_0_qbert_controller_lcd_r         => CONNECTED_TO_qbert_move_0_qbert_controller_lcd_r,         --                              .lcd_r
			qbert_move_0_qbert_controller_lcd_b         => CONNECTED_TO_qbert_move_0_qbert_controller_lcd_b,         --                              .lcd_b
			qbert_move_0_qbert_controller_vd            => CONNECTED_TO_qbert_move_0_qbert_controller_vd,            --                              .vd
			qbert_move_0_qbert_controller_lcd_g         => CONNECTED_TO_qbert_move_0_qbert_controller_lcd_g,         --                              .lcd_g
			reset_reset_n                               => CONNECTED_TO_reset_reset_n,                               --                         reset.reset_n
			switch_external_connection_export           => CONNECTED_TO_switch_external_connection_export            --    switch_external_connection.export
		);

