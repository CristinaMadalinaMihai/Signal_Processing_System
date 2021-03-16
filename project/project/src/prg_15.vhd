library ieee;
use ieee.std_logic_1164.all;

entity prg1 is
	port (clock : in bit;
	O : out std_logic_vector (7 downto 0));
end prg1;

architecture prg1 of prg1 is

signal s : std_logic_vector (3 downto 0) := "1101";

begin
	process (clock)
	begin
		if (clock'event and clock = '1') then
			s(3 downto 1) <= s(2 downto 0);	 
			s(0) <= s(2) xor s(3);
		end if;
			
	end process;
	O <= "0000" & s;
	end prg1;