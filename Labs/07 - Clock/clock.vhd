------------------------------------------------------------------------
--
-- Driver for seven-segment displays.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation

------------------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------------------
entity clock is
port (
    clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)

    seg_o    : out std_logic_vector(7-1 downto 0);
    dig_o    : out std_logic_vector(4-1 downto 0)
);
end entity clock;

------------------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------------------
architecture Behavioral of clock is
    signal s_en  : std_logic;
    signal s_hex : std_logic_vector(4-1 downto 0);
    signal s_cnt : std_logic_vector(4-1 downto 0) := "0000";
	signal s_data0 : std_logic_vector(4-1 downto 0);
	signal s_data1 : std_logic_vector(4-1 downto 0);
	signal s_data2 : std_logic_vector(4-1 downto 0);
	signal s_data4 : std_logic_vector(4-1 downto 0);
begin

    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity. Create s_en signal.
    --- WRITE YOUR CODE HERE
	 
		 
			CLOCK_ENABLE0 : entity work.clock_enable
			
					generic map (
									 g_NPERIOD => x"0028"      									 
														  
										)
					port map (
									clk_i => clk_i, 
									srst_n_i =>  srst_n_i, 
									clock_enable_o => s_en
				);
												 
    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    --- WRITE YOUR CODE HERE
	 
			HEX_TO_7SEG0 : entity work.hex_to_7seg
				
							port map (
											hex_i => s_hex,
											seg_o => seg_o	   									   												
				);


    --------------------------------------------------------------------
    -- p_select_cnt:
    -- Sequential process with synchronous reset and clock enable,
    -- which implements an internal 4-bit counter s_cnt
    -- selection bits.
    --------------------------------------------------------------------
    p_select_cnt : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
				
                -- WRITE YOUR CODE HERE
							s_cnt <= (others => '0');   -- Clear all bits              									
											
					 
					 
            elsif s_en = '1' then
				
                -- WRITE YOUR CODE HERE																					
							s_cnt <= s_cnt + "0001";															
												
            end if;
        end if;
    end process p_select_cnt;

    --------------------------------------------------------------------
    -- p_clock:
    --------------------------------------------------------------------
    p_clock : process (s_cnt, data0_i, data1_i, data2_i, data3_i)
    begin
		s_data0 <= s_cnt;
		--dig_o <= "1110";	
		--s_hex <= s_data0;			
        if s_cnt = "1001" then -- 9	
			s_data1<= s_data1 + "0001";
			srst_n_i <= '0';
			dig_o <= "1110";	
			s_hex <= s_data0;
			if s_data1 = "1001" then
				s_data2<= s_data2 + "0001";
				s_data1<= "0000";
				dig_o <= "1101";	
				s_hex <= s_data1;
				if s_data2 = "1001" then
					s_data3<= s_data3 + "0001";
					s_data2<= "0000";
					dig_o <= "1011";	
					s_hex <= s_data2;
					if s_data3 = "0110" then --6
						s_data3<= "0000";
						dig_o <= "0111";	
						s_hex <= s_data3;
						
					end if;
				end if;
			end if;
		end if;
		
		
    end process p_clock;

end architecture Behavioral;