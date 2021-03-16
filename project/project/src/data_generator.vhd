library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.all;

entity generator is
	port (system_clock : in bit;
	control : in std_logic_vector (2 downto 0);
	reset : in std_logic;
	data : out std_logic_vector (7 downto 0);
	data_clock : out bit);
end generator;

architecture generator of generator is

component prg1 is
	port (clock : in bit;
	O : out std_logic_vector (7 downto 0));
end component prg1;

component prg2 is
	port (clock : in bit;
	O : out std_logic_vector (7 downto 0));
end component prg2;

component stud1 is
	port (clk : in bit;
	O : out std_logic_vector (7 downto 0));
end component stud1;

component stud2 is
	port (clock : in bit;
	O : out std_logic_vector (7 downto 0));
end component stud2;

component square_wave is
	port ( clock : in bit;
	clock_out : out bit;
	O : out std_logic_vector (7 downto 0));
end component square_wave;

component clk_div is
	port ( clock : in bit;
	clk : out bit );
end component clk_div;

type tip is array (4 downto 0) of std_logic_vector (7 downto 0);
signal s : tip;
signal data_signal : std_logic_vector (7 downto 0);
signal data_clock_signal : bit;
signal data_clock_signal_sqwave : bit;
signal clock : bit;

begin
	L0 : square_wave port map (data_clock_signal, data_clock_signal_sqwave, s(4));
	L1 : stud1 port map (data_clock_signal, s(0));
	L2 : stud2 port map (data_clock_signal, s(1));
	L3 : prg1 port map (data_clock_signal, s(2));
	L4 : prg2 port map (data_clock_signal, s(3)); 
	
	L5 : clk_div port map (system_clock, data_clock_signal);
	
	process (data_clock_signal, reset, control)
	begin
		if (reset = '1') then
			data_signal <= "00000000";
		elsif (data_clock_signal'event and data_clock_signal= '1') then
			case control is
				when "001" => data_signal <= s(4); 
				when "010" => data_signal <= s(0);
				when "011" => data_signal <= s(1);
				when "110" => data_signal <= s(2);
				when "111" => data_signal <= s(3);
				when others => data_signal <= "00000000";
			end case;
		end if;
		if (control = "001") then 
			clock <= data_clock_signal_sqwave;
		else
			clock <= data_clock_signal;
			end if;
		end process;
		data <= data_signal;
		data_clock <= clock;
		end generator;
	