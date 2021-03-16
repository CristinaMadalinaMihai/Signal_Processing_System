library ieee;
use ieee.std_logic_1164.all;

entity clk_display is
	port (clock_in : in bit;
	clock_out : out bit );
end clk_display;

architecture clk_display of clk_display is

begin
	process (clock_in)
	variable count : integer := 0;
	variable clock_signal : bit := '0';
	begin
		if (clock_in'event and clock_in = '1')
			then 
			if (count = 25000)
				then clock_signal := not clock_signal;
				count := 0;
			else 
				count := count + 1;
			end if;
		end if;
	clock_out <= clock_signal;
		end process;
		
end clk_display;