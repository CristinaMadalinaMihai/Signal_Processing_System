library ieee;
use ieee.std_logic_1164.all;

entity stud2 is
	port (clock : in bit;
	O : out std_logic_vector (7 downto 0));
end stud2;

architecture student2 of stud2 is  

type tip is array (5 downto 0) of std_logic_vector (7 downto 0);

signal s : tip := ("00001001", "00000111", "00000001", "00000100", "00000010", "00000011");	-- 9, 7, 1, 4, 2, 3

begin
	process (clock)
	begin
		if (clock'event and clock = '1') then	
			s(5 downto 1) <= s(4 downto 0);
			s(0) <= s(5);
			O <= s(0);
		end if; 
			
	end process;

	end student2;