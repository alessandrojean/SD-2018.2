library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder is
  port (AF, BF: in std_logic_vector(3 downto 0);
        SF: out std_logic_vector(3 downto 0);
		  COUTF: out std_logic);
end four_bit_adder;

architecture data_flow of four_bit_adder is
signal C1, C2, C3: std_logic;

component full_adder
  port (A, B, CIN: in std_logic;
        S, COUT: out std_logic);
end component;
begin
  Chip1: full_adder
  port map (AF(0), BF(0), '0', SF(0), C1);
  
  Chip2: full_adder
  port map (AF(1), BF(1), C1, SF(1), C2);
  
  Chip3: full_adder
  port map (AF(2), BF(2), C2, SF(2), C3);
  
  Chip4: full_adder
  port map (AF(3), BF(3), C3, SF(3), COUTF);
end data_flow;