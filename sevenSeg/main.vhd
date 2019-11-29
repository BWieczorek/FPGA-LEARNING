----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:46:36 11/29/2019 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
    Port ( IO_P1 : out  STD_LOGIC_VECTOR (9 downto 3);
           IO_P2 : out  STD_LOGIC_VECTOR (4 downto 3);
           SW0 : in  STD_LOGIC;
           CLK : in  STD_LOGIC);
end main;

architecture Behavioral of main is
signal KHZ_COUNTER : integer range 0 to 50001 := 0;
signal KHZ_CLK : STD_LOGIC := '0';
signal OUTPUT_1 : STD_LOGIC_VECTOR (6 downto 0) := "1010101";
signal OUTPUT_2 : STD_LOGIC_VECTOR (6 downto 0) := "1010101";
signal ADDRESS : STD_LOGIC_VECTOR (1 downto 0) := "01";
signal RTC_COUNTER : integer range 0 to 50000001 := 0;
signal RTC_CLK : STD_LOGIC := '0';
signal DIGIT_1 : integer range 0 to 9 := 0;
signal DIGIT_2 : integer range 0 to 9 := 0;
function digit2SevenSeg(digit: integer range 0 to 9)
	return STD_LOGIC_VECTOR is
	variable result: STD_LOGIC_VECTOR (6 downto 0);
	begin
			case digit is
		when 0 => result := not "1111110";
		when 1 => result := not "0110000";
		when 2 => result := not "1101101";
		when 3 => result := not "1111001";
		when 4 => result := not "0110011";
		when 5 => result := not "1011011";
		when 6 => result := not "1011111";
		when 7 => result := not "1110000";
		when 8 => result := not "1111111";
		when 9 => result := not "1111011";
	end case;
	return result;
end function;
begin
khz_gen : process(CLK)
begin 
	if(Rising_edge(CLK)) then
		KHZ_COUNTER <= KHZ_COUNTER+1;
		if(KHZ_COUNTER >= 50000) then
		KHZ_CLK <= not KHZ_CLK;
		KHZ_COUNTER <= 0;
		end if;
	end if;
end process;
multiplexer : process(KHZ_CLK)
begin
	if(Rising_edge(KHZ_CLK)) then
		if(ADDRESS = "10") then
			ADDRESS <= "01";
			IO_P2 <= "01";
			IO_P1 <= OUTPUT_1;
		else
			ADDRESS <= "10";
			IO_P2 <= "10";
			IO_P1 <= OUTPUT_2;
		end if;
	end if;
end process;
RTC : process(CLK)
begin
	if(Rising_edge(CLK)) then
		RTC_COUNTER <= RTC_COUNTER+1;
		if(RTC_COUNTER >= 50000000) then -- add 2 times 0
		RTC_CLK <= not RTC_CLK;
		RTC_COUNTER <= 0;
		end if;
	end if;
end process;
DIGITALIZATION: process(RTC_CLK)
begin
	if(Rising_edge(RTC_CLK)) then
		if(Digit_1 >= 9) then
			Digit_1 <= 0;
			if(Digit_2 >= 9) then
				Digit_2 <= 0;
				else 
					Digit_2 <= Digit_2 + 1;
			end if;
			else 
			Digit_1 <= Digit_1 + 1;
		end if;
	end if;
end process;
		OUTPUT_1 <= digit2sevenseg(Digit_1);
		OUTPUT_2 <= digit2sevenseg(Digit_2);
end Behavioral;

