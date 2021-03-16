library ieee;
use ieee.std_logic_1164.all;

entity avg is
	port (reset_generator : in std_logic;
	reset_filter : in std_logic;
	system_clock : in bit;
	control : in std_logic_vector (2 downto 0);
	lengthhh : in std_logic_vector (2 downto 0);
	anod: out std_logic_vector(7 downto 0);
	catod : out std_logic_vector (6 downto 0));
end avg;

architecture avg of avg is 

signal data_signal : std_logic_vector (7 downto 0);
signal data_clock : bit;
signal average_signal : std_logic_vector (7 downto 0);

component generator is
	port (system_clock : in bit;
	control : in std_logic_vector (2 downto 0);
	reset : in std_logic;
	data : out std_logic_vector (7 downto 0);
	data_clock : out bit);
end component generator;

component filter is
	port (data : in std_logic_vector (7 downto 0);
	data_clock : in bit;
	system_clock : in bit;
	lengthh : in std_logic_vector (2 downto 0);
	reset_filter : in std_logic;
	average : out std_logic_vector (7 downto 0) );
end component filter; 

component display is
	port ( clock : in bit;
	data : in std_logic_vector (7 downto 0);
	average : in std_logic_vector ( 7 downto 0);
	anod: out std_logic_vector(7 downto 0);
	catod : out std_logic_vector (6 downto 0)
	 );
end	component display;

begin 
	
	Label_Generator : generator port map (system_clock, control, reset_generator, data_signal, data_clock);
	Label_Filter : filter port map (data_signal, data_clock, system_clock, lengthhh, reset_filter, average_signal);
	Label_Display : display port map (system_clock, data_signal, average_signal, anod, catod);
end avg;