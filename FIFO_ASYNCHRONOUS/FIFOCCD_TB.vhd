--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:26:31 12/03/2019
-- Design Name:   
-- Module Name:   /home/bwieczorek/projektyFPGA/fifoCCD/FIFOCCD_TB.vhd
-- Project Name:  fifoCCD
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FIFOCCD
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY FIFOCCD_TB IS
END FIFOCCD_TB;
 
ARCHITECTURE behavior OF FIFOCCD_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFOCCD
    PORT(
         i_DATA_VECTOR_WE : IN  std_logic_vector(7 downto 0);
         i_DATA_WRITE : IN  std_logic;
         i_DATA_READ : IN  std_logic;
         o_DATA_VECTOR_RD : OUT  std_logic_vector(7 downto 0);
         o_EMPTY : OUT  std_logic;
         o_FULL : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_DATA_VECTOR_WE : std_logic_vector(7 downto 0) := (others => '0');
   signal i_DATA_WRITE : std_logic := '0';
   signal i_DATA_READ : std_logic := '0';

 	--Outputs
   signal o_DATA_VECTOR_RD : std_logic_vector(7 downto 0);
   signal o_EMPTY : std_logic;
   signal o_FULL : std_logic;
	signal clk : STD_LOGIC;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFOCCD PORT MAP (
          i_DATA_VECTOR_WE => i_DATA_VECTOR_WE,
          i_DATA_WRITE => i_DATA_WRITE,
          i_DATA_READ => i_DATA_READ,
          o_DATA_VECTOR_RD => o_DATA_VECTOR_RD,
          o_EMPTY => o_EMPTY,
          o_FULL => o_FULL
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 25 ns;	
		i_DATA_VECTOR_WE <= "11111111";
		i_DATA_WRITE <= '1';
		wait for clk_period*1;
		i_DATA_WRITE <= '0';
		i_DATA_VECTOR_WE <= "10101010";
		wait for clk_period*15;
		i_DATA_WRITE <= '1';
		wait for clk_period*1;
      i_DATA_WRITE <= '0';
		wait for clk_period*1;
		i_DATA_READ <= '1';
		wait for clk_period*1;
		i_DATA_READ <= '0';
		wait for clk_period*15;
		i_DATA_VECTOR_WE <= "11111111";
		i_DATA_WRITE <= '1';
		wait for clk_period*1;
		i_DATA_WRITE <= '0';
		wait for clk_period*15;
		i_DATA_READ <= '1';
		wait for clk_period*1;
		i_DATA_READ <= '0';
		wait for clk_period*15;
		i_DATA_READ <= '1';
		wait for clk_period*1;
		i_DATA_READ <= '0';
		wait for clk_period*15;
		i_DATA_READ <= '1';
		wait for clk_period*1;
		i_DATA_READ <= '0';
		
      wait;
   end process;

END;
