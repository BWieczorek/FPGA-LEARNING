----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:22:32 11/30/2019 
-- Design Name: 
-- Module Name:    UART_ECHO - Behavioral 
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

entity UART_ECHO is
    Port ( i_CLK : in STD_LOGIC;
			  i_RX_LINE : in  STD_LOGIC;
           o_TX_LINE : out  STD_LOGIC);
end UART_ECHO;

architecture Behavioral of UART_ECHO is

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
	 COMPONENT Uart_RECEIVER		
	 port(
			i_CLK 				: in std_logic;
			i_Serial_Data 		: in std_logic;
			o_Data_Done			: out std_logic;
			o_Parallel_Data	: out std_logic_vector (7 downto 0));
			
	 end COMPONENT;
	 signal r_RX_LINE : STD_LOGIC;
	 signal r_TX_LINE : STD_LOGIC := '1';
	 signal r_DATA_VECTOR : STD_LOGIC_VECTOR(7 downto 0);
	 signal r_RX_DONE : STD_LOGIC;
	 signal r_TX_DONE : STD_LOGIC;
	 signal r_TX_INPROGRESS : STD_LOGIC;

begin
	   transmiter: UartTransmitter PORT MAP (
          i_CLK => i_CLK,
          i_DataVector => r_DATA_VECTOR,
          i_DATA_TX_FLAG => r_RX_DONE,
          o_DATA_TX_LINE => r_TX_LINE,
          o_DATA_TX_DONE => r_TX_DONE,
          o_DATA_TX_INPROGRESS => r_TX_INPROGRESS
        );
		  	   reciver: Uart_RECEIVER PORT MAP (
          i_CLK => i_CLK,	
			 i_Serial_Data => r_RX_LINE,		
			 o_Data_Done => r_RX_DONE,
			 o_Parallel_Data => r_DATA_VECTOR
        );
		  r_RX_LINE <= i_RX_LINE;
		  o_TX_LINE <= not r_TX_LINE;
		  


end Behavioral;

