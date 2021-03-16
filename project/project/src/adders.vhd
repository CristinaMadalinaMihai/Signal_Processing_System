library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder is
	generic	(n : integer := 8);
	port ( nr1, nr2 : in std_logic_vector (n-1 downto 0);
	sum : out std_logic_vector (n downto 0));
end adder;

architecture adders of adder is
begin
	sum <= ('0' & nr1) + ('0' & nr2);
end adders;



