library ieee;
use ieee.std_logic_1164.all;

entity prg2 is
	port (clock : in bit;
	O : out std_logic_vector (7 downto 0));
end prg2;

architecture prg2 of prg2 is

signal s : std_logic_vector (7 downto 0) := "00101101";

begin
	process (clock)
	begin
		if (clock'event and clock = '1') then
			s(7 downto 1) <= s(6 downto 0);
			s(0) <=((s(5) xor s(7)) xor s(4)) xor s(3);	
		end if;
		
	end process;
	O <= s;
	end prg2;