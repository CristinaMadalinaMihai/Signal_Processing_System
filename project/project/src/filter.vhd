library	ieee;
use ieee.std_logic_1164.all;
use work.all;

entity filter is
	port (data : in std_logic_vector (7 downto 0);
	data_clock : in bit;
	system_clock : in bit;
	lengthh : in std_logic_vector (2 downto 0);
	reset_filter : in std_logic;
	average : out std_logic_vector (7 downto 0) );
end filter;

architecture filter of filter is

component sum is
	port ( data : in std_logic_vector (7 downto 0);
	clock : in bit;
	reset : in std_logic;
	Sum2 : out std_logic_vector(8 downto 0);
	Sum4 : out std_logic_vector(9 downto 0);
	Sum8  : out std_logic_vector(10 downto 0); 
	Sum16 : out std_logic_vector(11 downto 0) );
end component sum;

signal sum_2 : std_logic_vector (8 downto 0);
signal sum_4 : std_logic_vector (9 downto 0);
signal sum_8 : std_logic_vector (10 downto 0); 
signal sum_16 : std_logic_vector (11 downto 0);

signal avrg : std_logic_vector (7 downto 0);

begin
	Addition : sum port map (data, data_clock, reset_filter, sum_2, sum_4, sum_8, sum_16);
	
	process (data_clock, lengthh, reset_filter)
	begin
		if (reset_filter = '1') then
			avrg <= (others => '0');
		elsif (data_clock'event and data_clock = '1') then  
			 case lengthh is
				when "000" =>
				avrg <= avrg;
				when "100" =>
				avrg <= sum_2(8 downto 1);
				when "101" =>
				avrg <= sum_4(9 downto 2);
				when "110" =>
				avrg <= sum_8(10 downto 3);
				when "111" =>
				avrg <= sum_16(11 downto 4); 
				when others => avrg <= (others => '0');
				end case;
		end if;	
		average <= avrg;
	end process;

end filter;