----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:20:00 12/03/2019 
-- Design Name: 
-- Module Name:    FIFOCCD - Behavioral 
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

entity FIFOCCD is
Generic(
g_width: natural := 8;
g_depth: natural := 32
);
    Port ( i_DATA_VECTOR_WE : in  STD_LOGIC_VECTOR (g_width-1 downto 0);
           i_DATA_WRITE : in  STD_LOGIC;
           i_DATA_READ : in  STD_LOGIC;
           o_DATA_VECTOR_RD : out  STD_LOGIC_VECTOR (g_width-1 downto 0);
           o_EMPTY : out  STD_LOGIC;
           o_FULL : out  STD_LOGIC);
end FIFOCCD;

architecture Behavioral of FIFOCCD is

type t_DATA is array (0 to g_depth) of STD_LOGIC_VECTOR (g_width-1 downto 0);
signal r_DATA: t_DATA := (others => (others => '0'));
signal r_READ_DATA_ITER: integer range 0 to g_depth-1 := 0;
signal r_WRITE_DATA_ITER: integer range 0 to g_depth-1 := 0;
signal r_DATA_COUNT : integer range -1 to 33 := 0;
begin

writeReadProcess : process(i_DATA_WRITE, i_DATA_READ) is
 begin
	if(rising_edge(i_DATA_WRITE)) then
		if(i_DATA_WRITE = '1') then
			if(r_WRITE_DATA_ITER < 32) then
				r_DATA_COUNT <= r_DATA_COUNT + 1;
				r_DATA (r_WRITE_DATA_ITER) <= i_DATA_VECTOR_WE;
				r_WRITE_DATA_ITER <= r_WRITE_DATA_ITER + 1;
			else
				r_DATA_COUNT <= r_DATA_COUNT + 1;
				r_DATA (r_WRITE_DATA_ITER) <= i_DATA_VECTOR_WE;
				r_WRITE_DATA_ITER <= 0;
			end if;
		end if;
	end if;
	if(rising_edge(i_DATA_READ)) then
		if(i_DATA_READ = '1') then
			if(r_WRITE_DATA_ITER < 32) then
				r_DATA_COUNT <= r_DATA_COUNT - 1;
				r_READ_DATA_ITER <= r_READ_DATA_ITER + 1;
			else
				r_DATA_COUNT <= r_DATA_COUNT - 1;
				r_WRITE_DATA_ITER <= 0;
			end if;
		end if;
	end if;
end process;

o_DATA_VECTOR_RD <= r_DATA (r_READ_DATA_ITER);
o_FULL <= '1' when r_DATA_COUNT = g_depth else '0';
o_EMPTY <= '1' when r_DATA_COUNT = 0 else '0';

assertProcess: process(i_DATA_WRITE, i_DATA_READ) is
begin
	if(rising_edge(i_DATA_WRITE)) then
		if(r_DATA_COUNT >= g_depth and i_DATA_WRITE = '1') then
			report "ASSERT FAILURE - MODULE_REGISTER_FIFO: FIFO IS FULL AND BEING WRITTEN " severity failure;
		end if;
	end if;
	if(rising_edge(i_DATA_READ)) then
		if(r_DATA_COUNT <= 0 and i_DATA_READ = '1') then
			report "ASSERT FAILURE - MODULE_REGISTER_FIFO: FIFO IS EMPLTY AND BEING READ" severity failure;
		end if;
	end if;
end process;

end Behavioral;

