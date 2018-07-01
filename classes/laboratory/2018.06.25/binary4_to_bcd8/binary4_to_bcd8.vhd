library ieee;
use ieee.std_logic_1164.all;

entity binary4_to_bcd8 is
  port (BIN: in std_logic_vector(3 downto 0);
        BCD0, BCD1: out std_logic_vector(3 downto 0));
end binary4_to_bcd8;

architecture data_flow of binary4_to_bcd8 is
begin
  BCD0(0) <= BIN(0);
  BCD0(1) <= (BIN(3) and BIN(2) and not BIN(1))
    or (not BIN(3) and BIN(1));
  BCD0(2) <= (not BIN(3) and BIN(2))
    or (BIN(2) and BIN(1));
  BCD0(3) <= BIN(3) and not BIN(2) and not BIN(1);
  
  BCD1(0) <= (BIN(3) and BIN(2))
    or (BIN(3) and BIN(1));
  BCD1(3 downto 1) <= "000";
end data_flow;