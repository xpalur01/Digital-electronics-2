library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity traffic is
	port ( 
			clk_i       : in std_logic; 
			srst_n_i    : in std_logic; -- RESET
			
			lights_o      : out std_logic_vector(5 downto 0)
			
			);

end entity traffic;

architecture traffic of traffic is

    type state_type is (s1c_s2z, s1c_s2o, s1c_s2c, s1z_s2c, s1o_s2c, s1c_s2c2);
	 signal state: state_type;
	 
    --signal count: std_logic_vector(3 downto 0);
    --constant SEC5: std_logic_vector(3 downto 0) := "1111";
    --constant SEC1: std_logic_vector(3 downto 0) := "0011";
    signal s_count : unsigned(3 downto 0);
    constant SEC5: unsigned(3 downto 0) := "1111";
    constant SEC1: unsigned(3 downto 0) := "0011";

begin

--------------------------------------

--------------------------------------
	process (clk_i, srst_n_i)
begin

	if srst_n_i = '1' then
			state <= s1c_s2z;
			s_count <= X"0";

        --elsif clk'event and clk = '1' then
        elsif rising_edge(clk_i) then
        
		case state is
			when s1c_s2z =>
					if s_count < SEC5 then
							state <= s1c_s2z;
							s_count <= s_count +1;
					else
							state <= s1c_s2o;
							s_count <= "0000";
					end if;			
					
							when s1c_s2o =>
									if s_count < SEC1 then
											state <= s1c_s2o;
											s_count <= s_count +1;
									else 
											state <= s1c_s2c;
											s_count <= "0000";
									end if;
									
											when s1c_s2c =>
													if s_count < SEC1 then
															state <= s1c_s2c;
															s_count <= s_count +1;
													else 
															state <= s1z_s2c;
															s_count <= "0000";
													end if;	

															when s1z_s2c =>
																	if s_count < SEC5 then
																			state <= s1z_s2c;
																			s_count <= s_count +1;
																	else 
																			state <= s1o_s2c;
																			s_count <= "0000";
																	end if;	
																	
																			when s1o_s2c =>
																					if s_count < SEC1 then
																							state <= s1o_s2c;
																							s_count <= s_count +1;
																					else 
																							state <= s1c_s2c2;
																							s_count <= "0000";
																					end if;	
																					
																						when s1c_s2c2 =>
																									if s_count < SEC1 then
																											state <= s1c_s2c2;
																											s_count <= s_count +1;
																									else 
																											state <= s1c_s2z;
																											s_count <= "0000";
																									end if;
																							
						when others =>
										state <= s1c_s2z;
										
		end case;
	end if;
	
end process;
---------------------------------

---------------------------------
C2: process (state)
begin
		case state is
		
				when s1c_s2z => lights_o <= "100001";		--s0		bits: semafor1: red , orange , green semafor2: red, orange, green
				when s1c_s2o => lights_o <= "100010";		--s1		s1z_s2o == semafor 1 green, semafor 2 orange
				when s1c_s2c => lights_o <= "100100";		--s2
				when s1z_s2c => lights_o <= "001100";		--s3
				when s1o_s2c => lights_o <= "010100";		--s4
				when s1c_s2c2 => lights_o <= "100100";	--s5
				when others => lights_o <= "100001";		
				
		end case;
	end process;

							
end traffic;