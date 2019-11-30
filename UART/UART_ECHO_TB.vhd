--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:55:35 11/30/2019
-- Design Name:   
-- Module Name:   /home/bwieczorek/git/UART/UART_ECHO_TB.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UART_ECHO
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
 
ENTITY UART_ECHO_TB IS
END UART_ECHO_TB;
 
ARCHITECTURE behavior OF UART_ECHO_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART_ECHO
    PORT(
         i_CLK : IN  std_logic;
         i_RX_LINE : IN  std_logic;
         o_TX_LINE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_CLK : std_logic := '0';
   signal i_RX_LINE : std_logic := '1';

 	--Outputs
   signal o_TX_LINE : std_logic;

   -- Clock period definitions
   constant i_CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART_ECHO PORT MAP (
          i_CLK => i_CLK,
          i_RX_LINE => i_RX_LINE,
          o_TX_LINE => o_TX_LINE
        );

   -- Clock process definitions
   i_CLK_process :process
   begin
		i_CLK <= '0';
		wait for i_CLK_period/2;
		i_CLK <= '1';
		wait for i_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		i_RX_LINE <= '0';
      wait for i_CLK_period*868;
		i_RX_LINE <= '1';
      wait for i_CLK_period*868;
		i_RX_LINE <= '0';
      wait for i_CLK_period*868;
		i_RX_LINE <= '1';
      wait for i_CLK_period*868;
		i_RX_LINE <= '0';
      wait for i_CLK_period*868;
		i_RX_LINE <= '1';
      wait for i_CLK_period*868;
		i_RX_LINE <= '0';
      wait for i_CLK_period*868;
		i_RX_LINE <= '1';
      wait for i_CLK_period*868;
		i_RX_LINE <= '0';
      wait for i_CLK_period*868;
		i_RX_LINE <= '1';


      wait;
   end process;

END;
