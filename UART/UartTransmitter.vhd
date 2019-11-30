----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:13 11/30/2019 
-- Design Name: 
-- Module Name:    UartTransmiter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UartTransmitter is
	 Generic (
	 g_CLK_PRE_BIT : INTEGER := 868
	 );
    Port ( i_CLK : in STD_LOGIC;
			  i_DataVector : in  STD_LOGIC_VECTOR (7 downto 0);
           i_DATA_TX_FLAG : in  STD_LOGIC;
           o_DATA_TX_LINE : out  STD_LOGIC;
           o_DATA_TX_DONE : out  STD_LOGIC;
           o_DATA_TX_INPROGRESS : out  STD_LOGIC);
end UartTransmitter;


architecture Behavioral of UartTransmitter is

signal r_DataByte : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal r_DATA_BIT_INDEX : INTEGER range 0 to 7 := 0;
type t_UART_STATE is (s_WAITING_FOR_INPUT, s_START_BIT, s_TRANSMISION_IN_PROGRESS, s_STOP_BIT);
signal r_UART_STATE: t_UART_STATE := s_WAITING_FOR_INPUT;
signal r_TX_LINE : STD_LOGIC := '1';
signal r_CLK_COUNTER: INTEGER := 0;
signal r_TRANSMISION_IN_PROGRESS_FLAG : STD_LOGIC := '0';
signal r_DATA_TX_DONE : STD_LOGIC := '1';

begin
MAIN_PROCESS: Process(i_CLK)
	begin
		if(rising_edge(i_CLK)) then
		
		case r_UART_STATE is
			--WAITING FOR INPUT STATE
				when s_WAITING_FOR_INPUT =>
					if(i_DATA_TX_FLAG = '1') then
						r_DataByte <= i_DataVector;
						r_UART_STATE <= s_START_BIT;
						r_DATA_TX_DONE <= '0';
						r_CLK_COUNTER <= 0;
					else 
						r_TRANSMISION_IN_PROGRESS_FLAG <= '0';
						r_TX_LINE <= '1';
						r_CLK_COUNTER <= 0;
						r_UART_STATE <= s_WAITING_FOR_INPUT;
					end if;
				
			--Start BIT STATE
					when s_START_BIT =>
					r_CLK_COUNTER <= r_CLK_COUNTER + 1;
					if(r_CLK_COUNTER < g_CLK_PRE_BIT) then
						r_TX_LINE <= '0';
						r_TRANSMISION_IN_PROGRESS_FLAG <= '1';
						r_UART_STATE <= s_START_BIT;
					else
						r_CLK_COUNTER <= 0;
						r_UART_STATE <= s_TRANSMISION_IN_PROGRESS;
					end if;
					
			--TRANSMIOSN IN PROGRESS
				when s_TRANSMISION_IN_PROGRESS =>
					r_CLK_COUNTER <= r_CLK_COUNTER + 1;
					if(r_DATA_BIT_INDEX < 8) then
						if(r_CLK_COUNTER < g_CLK_PRE_BIT) then
							r_TX_LINE <= r_DataByte(r_DATA_BIT_INDEX);
						else
							r_CLK_COUNTER <= 0;
							r_UART_STATE <= s_TRANSMISION_IN_PROGRESS;
							r_Data_BIT_INDEX <= r_DATA_BIT_INDEX + 1;
						end if;
					else
						r_UART_STATE <= s_STOP_BIT;
						r_CLK_COUNTER <= 0;
						r_DATA_BIT_INDEX <= 0;
					end if;
			--STOP BIT UART
				when s_STOP_BIT =>
					r_CLK_COUNTER <= r_CLK_COUNTER + 1;
					if(r_CLK_COUNTER < g_CLK_PRE_BIT) then
						r_TX_LINE <= '1';
					else
						r_UART_STATE <= s_WAITING_FOR_INPUT;
						r_CLK_COUNTER <= 0;
						r_DATA_TX_DONE <= '1';
					end if;
		end case;
			end if;
	o_DATA_TX_LINE <= r_TX_LINE;
	o_DATA_TX_DONE <= r_DATA_TX_DONE;
	o_DATA_TX_INPROGRESS <= r_TRANSMISION_IN_PROGRESS_FLAG;
			
	end process;


end Behavioral;

