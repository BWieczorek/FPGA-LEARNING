--------------------------------------------------------------------------------
-- Company: None
-- Engineer: BWieczorek
--
-- Create Date:   14:58:53 11/30/2019
-- Design Name:   UART_TRASMITTER
-- Module Name:   /home/bwieczorek/git/UART/UART_TRANSMITER_TB.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UartTransmiter
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
 
ENTITY UART_TRANSMITTER_TB IS
END UART_TRANSMITTER_TB;
 
ARCHITECTURE behavior OF UART_TRANSMITTER_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UartTransmitter
    PORT(
         i_CLK : IN  std_logic;
         i_DataVector : IN  std_logic_vector(7 downto 0);
         i_DATA_TX_FLAG : IN  std_logic;
         o_DATA_TX_LINE : OUT  std_logic;
         o_DATA_TX_DONE : OUT  std_logic;
         o_DATA_TX_INPROGRESS : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_CLK : std_logic := '0';
   signal i_DataVector : std_logic_vector(7 downto 0) := (others => '0');
   signal i_DATA_TX_FLAG : std_logic := '0';

 	--Outputs
   signal o_DATA_TX_LINE : std_logic;
   signal o_DATA_TX_DONE : std_logic;
   signal o_DATA_TX_INPROGRESS : std_logic;
	signal r_CLOCk_2 : STD_LOGIC := '0';
	signal r_CLOCK_TIMER : integer:=0;

   -- Clock period definitions
   constant i_CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UartTransmitter PORT MAP (
          i_CLK => i_CLK,
          i_DataVector => i_DataVector,
          i_DATA_TX_FLAG => i_DATA_TX_FLAG,
          o_DATA_TX_LINE => o_DATA_TX_LINE,
          o_DATA_TX_DONE => o_DATA_TX_DONE,
          o_DATA_TX_INPROGRESS => o_DATA_TX_INPROGRESS
        );

   -- Clock process definitions
   i_CLK_process :process
   begin
		i_CLK <= '0';
		wait for i_CLK_period/2;
		i_CLK <= '1';
		wait for i_CLK_period/2;
   end process;
	   i_CLK_2 :process (i_CLK)
   begin
		if(rising_edge(i_CLK)) then
		r_CLOCK_TIMER <= r_CLOCK_TIMER + 1;
			if(r_CLOCK_TIMER >= 868) then
				r_CLOCK_TIMER <= 0;
				r_CLOCk_2 <= not r_CLOCk_2;
			end if;
		end if;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	

      wait for i_CLK_period*10;
		i_DataVector <= "01010101";
		i_DATA_TX_FLAG <= '1';
		wait for i_CLK_period*1;
		i_DATA_TX_FLAG <= '0';
		i_DataVector <= "00000000";

      wait;
   end process;

END;
