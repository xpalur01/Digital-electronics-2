library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_lights_top is
	port(
			clk_i 	: in std_logic;
			btn 	: in std_logic_vector(3 downto 3);
			srst_n_i    : in std_logic; -- RESET
			
			led    : out std_logic_vector(7 downto 2)
			
		  );
		  
end traffic_lights_top;

architecture traffic_lights_top of traffic_lights_top is

	component clock_enable is 
		port( 
				clk_i							: in std_logic;
				srst_n_i 					: in std_logic;
				
				clock_enable_o 			: out std_logic	
			  );
			  
	end component;
	
	component traffic is
		port(
				clk_i       : in std_logic; 
				srst_n_i    : in std_logic; -- RESET
			
				lights      : out std_logic_vector(5 downto 0)		
			  );
			  
	end component;
	
signal srst_n_i, clock_enable_o: std_logic;
begin
	srst_n_i <= btn(3);
	
	U1: clock_enable
			port map( 
						clk_i 		=> clk_i,
						srst_n_i => srst_n_i,
						clock_enable_o 		=> clock_enable_o					
						);
	U2: traffic
			port map(
						clk_i		 => clock_enable_o,
						srst_n_i  => srst_n_i,
						lights	 => led					
						);
						
end traffic_lights_top;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--entity top is
--end top;
--
--architecture Behavioral of top is
--
--begin
--
--
--end Behavioral;

