library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

entity display is
	port ( clock : in std_logic;
	anod : out std_logic_vector (3 downto 0);
	catod : out std_logic_vector (6 downto 0) );
end display;

architecture disp of display is

signal sig : std_logic_vector (3 downto 0);
signal clk : std_logic;

component f_div is
	port ( clock : in std_logic;
	clk : out std_logic );
end component ;

begin
	labal : f_div port map (clock, clk);
	
	process (clk, sig)
	begin
		if (clk'event and clk = '1') then
			sig(3) <= sig(0);
			sig(0) <= sig(1);
			sig(1) <= sig(2);
			sig(2) <= sig(3);
		end if;
		
		anod <= sig;
	end process;
	
	process (sig)
	begin
		case sig is 
			when "1110" => catod <= "0000001";	
			when "1101" => catod <= "0001000";
			when "1011" => catod <= "1110010";  
			when "0111" => catod <= "1001111";
			when others => catod <= "1111110";
		end case;							  
	end process;
end disp;
			