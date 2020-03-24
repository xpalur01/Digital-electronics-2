library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity traffic is
	port ( 
			clk_i       : in std_logic; 
			srst_n_i    : in std_logic; -- RESET
			
			lights      : out std_logic_vector(5 downto 0)
			
			);

end entity traffic;

architecture traffic of traffic is

    type state_type is (s0, s1, s2, s3, s4, s5);
	 signal state: state_type;
	 
    --signal count: std_logic_vector(3 downto 0);
    --constant SEC5: std_logic_vector(3 downto 0) := "1111";
    --constant SEC1: std_logic_vector(3 downto 0) := "0011";
    signal count : unsigned(3 downto 0);
    constant SEC5: unsigned(3 downto 0) := "1111";
    constant SEC1: unsigned(3 downto 0) := "0011";

begin

--------------------------------------

--------------------------------------
	process (clk_i, srst_n_i)
begin

	if srst_n_i = '1' then
			state <= s0;
			count <= X"0";

        --elsif clk'event and clk = '1' then
        elsif rising_edge(clk_i) then
        
		case state is
			when s0 =>
					if count < SEC5 then
							state <= s0;
							count <= count +1;
					else
							state <= s1;
							count <= "0000";
					end if;			
					
							when s1 =>
									if count < SEC1 then
											state <= s1;
											count <= count +1;
									else 
											state <= s2;
											count <= "0000";
									end if;
									
											when s2 =>
													if count < SEC1 then
															state <= s2;
															count <= count +1;
													else 
															state <= s3;
															count <= "0000";
													end if;	

															when s3 =>
																	if count < SEC5 then
																			state <= s3;
																			count <= count +1;
																	else 
																			state <= s4;
																			count <= "0000";
																	end if;	
																	
																			when s4 =>
																					if count < SEC1 then
																							state <= s4;
																							count <= count +1;
																					else 
																							state <= s5;
																							count <= "0000";
																					end if;	
																					
																						when s5 =>
																									if count < SEC1 then
																											state <= s5;
																											count <= count +1;
																									else 
																											state <= s0;
																											count <= "0000";
																									end if;
																							
						when others =>
										state <= s0;
										
		end case;
	end if;
	
end process;
---------------------------------

---------------------------------
C2: process (state)
begin
		case state is
		
				when s0 => lights <= "100001";
				when s1 => lights <= "100010";
				when s2 => lights <= "100100";
				when s3 => lights <= "001100";
				when s4 => lights <= "010100";
				when s5 => lights <= "100100";
				when others => lights <= "100001";
				
		end case;
	end process;

							
end traffic;