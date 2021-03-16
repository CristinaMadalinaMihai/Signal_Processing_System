library ieee;
use ieee.std_logic_1164.all;

entity clk_div is
	port ( clock : in bit;
	clk : out bit );
end clk_div;

architecture div of clk_div is

begin
	process (clock)
	variable count : integer := 0; 
	variable clk_signal : bit := '0';
	begin
		if (clock'event and clock = '1') then
			if (count = 49999999) then
				clk_signal := not (clk_signal);
				count := 0;
			else 
				count := count + 1;
			end if;
		end if;	
				clk <= clk_signal;
	end process;

	end div;