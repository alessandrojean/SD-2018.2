library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity four_bit_adder_vector is
  port (A, B: in std_logic_vector(3 downto 0);
        CIN: in std_logic;
		  S: out std_logic_vector(3 downto 0);
		  COUT: out std_logic);
end four_bit_adder_vector;

architecture behavioral of four_bit_adder_vector is
  signal AUX: std_logic_vector(4 downto 0);
begin
  AUX <= ('0' & A) + ('0' & B) + ("0000" & CIN);
  S <= AUX(3 downto 0);
  COUT <= AUX(4);
end behavioral;