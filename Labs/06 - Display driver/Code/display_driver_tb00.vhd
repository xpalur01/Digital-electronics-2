--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY driver_7seg_tb00 IS
END driver_7seg_tb00;
 
ARCHITECTURE behavior OF driver_7seg_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT driver_7seg
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         data0_i : IN  std_logic_vector(3 downto 0);
         data1_i : IN  std_logic_vector(3 downto 0);
         data2_i : IN  std_logic_vector(3 downto 0);
         data3_i : IN  std_logic_vector(3 downto 0);
         dp_i : IN  std_logic_vector(3 downto 0);
         dp_o : OUT  std_logic;
         seg_o : OUT  std_logic_vector(6 downto 0);
         dig_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal data0_i : std_logic_vector(3 downto 0) := (others => '0');
   signal data1_i : std_logic_vector(3 downto 0) := (others => '0');
   signal data2_i : std_logic_vector(3 downto 0) := (others => '0');
   signal data3_i : std_logic_vector(3 downto 0) := (others => '0');
   signal dp_i : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal dp_o : std_logic;
   signal seg_o : std_logic_vector(6 downto 0);
   signal dig_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 2 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: driver_7seg PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          data0_i => data0_i,
          data1_i => data1_i,
          data2_i => data2_i,
          data3_i => data3_i,
          dp_i => dp_i,
          dp_o => dp_o,
          seg_o => seg_o,
          dig_o => dig_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
 --    wait for 100 ns;	
			for i in 0 to 10 loop
			 dp_i <= "1011"; data3_i <= "0000"; data2_i <= "0011"; data1_i <= "0001"; data0_i <= "0100"; srst_n_i <= '1';  
			end loop; 
			
			wait for clk_i_period*10; 

      -- insert stimulus here 

		


      wait;
   end process;

END;
