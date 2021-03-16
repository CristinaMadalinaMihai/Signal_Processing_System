library ieee;
use ieee.std_logic_1164.all;

entity stud1 is
	port (clk : in bit;
	O : out std_logic_vector (7 downto 0));
end stud1;

architecture stud of stud1 is 

type tip is array (5 downto 0) of std_logic_vector (7 downto 0);

signal s : tip := ("00001000", "00000110", "00000001", "00000000", "00000100", "00000101"); -- 8, 6, 1, 0, 4, 5   

begin
	process (clk)
	begin
		if (clk'event and clk = '1') then
			s(5 downto 1) <= s(4 downto 0);
			s(0) <= s(5);
			
		end if;
		O <= s(0);		
	end process; 

	end stud;