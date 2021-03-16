library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;

entity square_wave is
	port ( clock : in bit;
	clock_out : out bit;
	O : out std_logic_vector (7 downto 0));
end square_wave;

architecture square_wave of square_wave is 

signal s : std_logic_vector (7 downto 0) := "11011000"; --216, 108, 54, 27, 141, 198, 99, 177
signal divider : std_logic_vector (2 downto 0) := "000";
signal clk_signal : std_logic;

begin
	process (clock) 
	begin
		if (clock'event and clock = '1') then
			divider <= divider + '1';
		end if;
		clk_signal <= divider(2);
		end process;
		
		process (clk_signal)
	begin
		if (clk_signal'event and clk_signal = '1') then
			s(6 downto 0) <= s(7 downto 1);
			s(7) <= s(0);
			O <= s;
		end if;
	end process;
		clock_out <= to_bit (clk_signal);
		
	end square_wave;