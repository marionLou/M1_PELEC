	component qbert_test2 is
		port (
			button_external_connection_export   : in std_logic                    := 'X';             -- export
			clk_clk                             : in std_logic                    := 'X';             -- clk
			reset_reset_n                       : in std_logic                    := 'X';             -- reset_n
			switches_external_connection_export : in std_logic_vector(3 downto 0) := (others => 'X')  -- export
		);
	end component qbert_test2;

	u0 : component qbert_test2
		port map (
			button_external_connection_export   => CONNECTED_TO_button_external_connection_export,   --   button_external_connection.export
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                          clk.clk
			reset_reset_n                       => CONNECTED_TO_reset_reset_n,                       --                        reset.reset_n
			switches_external_connection_export => CONNECTED_TO_switches_external_connection_export  -- switches_external_connection.export
		);

