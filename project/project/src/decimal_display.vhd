library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity display is
	port ( clock : in bit;
	data : in std_logic_vector (7 downto 0);
	average : in std_logic_vector ( 7 downto 0);
	anod: out std_logic_vector(7 downto 0);
	catod : out std_logic_vector (6 downto 0)
	 );
end display;

architecture  display of display is

component clk_display is
	port (clock_in : in bit;
	clock_out : out bit );
end component ;

signal clk : bit;
signal anod_signal : std_logic_vector (5 downto 0) := "011111";

signal d : integer range 0 to 255;
signal a : integer range 0 to 255;

type tip is array (2 downto 0) of integer range 0 to 9;
signal digit_data : tip;
signal digit_average : tip;


begin
	d <= to_integer(unsigned(data));
	digit_data(0) <= d mod 10;
	digit_data(1) <= (d/10) mod 10;
	digit_data(2) <= d/100;	
	
	a <= to_integer(unsigned(average));
	digit_average(0) <= a mod 10;
	digit_average(1) <= (a/10) mod 10;
	digit_average(2) <= a/100;
	
	L_div: clk_display port map (clock, clk);

	process (clk, anod_signal)
	begin
		if (clk'event and clk = '1') then
			anod_signal (4 downto 0) <= anod_signal (5 downto 1);
			anod_signal(5) <= anod_signal(0);
		end if;
	end process; 

	process (anod_signal, data, average)
	begin
		case anod_signal is	
			
		when "011111" =>
		case digit_data(2) is 
			when 0 => catod <= "0000001"; 
			when 1 => catod <= "1001111"; 
			when 2 => catod <= "0010010"; 
			when 3 => catod <= "0000110"; 
			when 4 => catod <= "1001100"; 
			when 5 => catod <= "0100100"; 
			when 6 => catod <= "0100000";   
			when 7 => catod <= "0001111"; 
			when 8 => catod <= "0000000"; 
			when 9 => catod <= "0000100"; 
			when others => catod <= "0111000"; -- F
		end case;
		
		when "101111" =>	
		case digit_data(1) is 
			when 0 => catod <= "0000001"; 
			when 1 => catod <= "1001111"; 
			when 2 => catod <= "0010010"; 
			when 3 => catod <= "0000110"; 
			when 4 => catod <= "1001100"; 
			when 5 => catod <= "0100100"; 
			when 6 => catod <= "0100000";   
			when 7 => catod <= "0001111"; 
			when 8 => catod <= "0000000"; 
			when 9 => catod <= "0000100"; 
			when others => catod <= "0111000"; -- F
		end case;
		
		when "110111" =>
		case digit_data(0) is 
			when 0 => catod <= "0000001"; 
			when 1 => catod <= "1001111"; 
			when 2 => catod <= "0010010"; 
			when 3 => catod <= "0000110"; 
			when 4 => catod <= "1001100"; 
			when 5 => catod <= "0100100"; 
			when 6 => catod <= "0100000";   
			when 7 => catod <= "0001111"; 
			when 8 => catod <= "0000000"; 
			when 9 => catod <= "0000100"; 
			when others => catod <= "0111000"; -- F
		end case;
		
		when "111011" =>
		case digit_average(2) is 
			when 0 => catod <= "0000001"; 
			when 1 => catod <= "1001111"; 
			when 2 => catod <= "0010010"; 
			when 3 => catod <= "0000110"; 
			when 4 => catod <= "1001100"; 
			when 5 => catod <= "0100100"; 
			when 6 => catod <= "0100000";   
			when 7 => catod <= "0001111"; 
			when 8 => catod <= "0000000"; 
			when 9 => catod <= "0000100"; 
			when others => catod <= "0111000"; -- F
		end case;
		
		when "111101" =>	
		case digit_average(1) is 
			when 0 => catod <= "0000001"; 
			when 1 => catod <= "1001111"; 
			when 2 => catod <= "0010010"; 
			when 3 => catod <= "0000110"; 
			when 4 => catod <= "1001100"; 
			when 5 => catod <= "0100100"; 
			when 6 => catod <= "0100000";   
			when 7 => catod <= "0001111"; 
			when 8 => catod <= "0000000"; 
			when 9 => catod <= "0000100"; 
			when others => catod <= "0111000"; -- F
		end case;
		
		when "111110" =>
			
		case digit_average(0) is 
			when 0 => catod <= "0000001"; 
			when 1 => catod <= "1001111"; 
			when 2 => catod <= "0010010"; 
			when 3 => catod <= "0000110"; 
			when 4 => catod <= "1001100"; 
			when 5 => catod <= "0100100"; 
			when 6 => catod <= "0100000";   
			when 7 => catod <= "0001111"; 
			when 8 => catod <= "0000000"; 
			when 9 => catod <= "0000100"; 
			when others => catod <= "0111000"; -- F
		end case;
		
		when others => catod <= "1111111";
		end case;
				
	end process; 
	
	anod (2 downto 0) <= anod_signal(2 downto 0);
	anod (6 downto 4) <= anod_signal (5 downto 3);
	anod(3) <= '1';
	anod(7) <= '1'; 
end display;