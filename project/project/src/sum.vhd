library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity sum is
	port ( data : in std_logic_vector (7 downto 0);
	clock : in bit;
	reset : in std_logic;
	Sum2 : out std_logic_vector(8 downto 0);
	Sum4 : out std_logic_vector(9 downto 0);
	Sum8  : out std_logic_vector(10 downto 0); 
	Sum16 : out std_logic_vector(11 downto 0) );
end sum;

architecture sum of sum is

component adder is
	generic	(n : integer := 8);
	port ( nr1, nr2 : in std_logic_vector (n-1 downto 0);
	sum : out std_logic_vector (n downto 0));
end component ;

type tip_8 is array (15 downto 0) of std_logic_vector (7 downto 0);
signal s : tip_8;

type tip_9 is array (7 downto 0) of std_logic_vector (8 downto 0);
signal t : tip_9; 

type tip_10 is array (3 downto 0) of std_logic_vector (9 downto 0);
signal p : tip_10;

type tip_11 is array (1 downto 0) of std_logic_vector (10 downto 0);
signal r : tip_11;

begin
	process (clock, reset)
	begin
		if (reset = '1') then
			s <= (others => "00000000");
		elsif (clock'event and clock = '1') then 
		s(15 downto 1) <= s(14 downto 0);
		s(0) <= data;
		end if;
	end process;	
	
	L : for i in 0 to 7 generate
		ADD_8_i : adder generic	map (8)
		port map (s(2 * i), s(2 * i + 1), t(i));
	end generate L;
	
	Sum2 <= t(0);
	
	M : for i in 0 to 3 generate
		ADD_9_i : adder generic	map (9)
		port map (t(2 * i), t(2 * i + 1), p(i));
	end generate M;	
	
	Sum4 <= p(0);
	
	N : for i in 0 to 1 generate
		ADD_10_i : adder generic map (10)
		port map (p(2 * i), p(2 * i + 1), r(i));
	end generate N;
	
	Sum8 <= r(0);
	
	C : adder generic map (11)
	port map (r(0), r(1), Sum16);
	
	end sum;