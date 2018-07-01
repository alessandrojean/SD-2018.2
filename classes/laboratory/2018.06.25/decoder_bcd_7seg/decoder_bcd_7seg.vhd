library ieee;
use ieee.std_logic_1164.all;

entity decoder_bcd_7seg is
  port (BCD: in std_logic_vector(3 downto 0);
        S: out std_logic_vector(6 downto 0));
end decoder_bcd_7seg;

architecture data_flow of decoder_bcd_7seg is
begin
  S(0) <= not(BCD(0) or BCD(2) or (BCD(1) and BCD(2)) or (not BCD(1) and not BCD(3)));
  S(1) <= not(not BCD(1) or (not BCD(2) and not BCD(3)) or (BCD(2) and BCD(3)));
  S(2) <= not(BCD(1) or not BCD(2) or BCD(3));
  S(3) <= not((not BCD(1) and not BCD(3)) or (BCD(2) and not BCD(3)) or (BCD(1) and not BCD(2) and BCD(3)) or (not BCD(1) and BCD(2)) or BCD(0));
  S(4) <= not((not BCD(1) and not BCD(3)) or (BCD(2) and not BCD(3)));
  S(5) <= not(BCD(0) or (not BCD(2) and not BCD(3)) or (BCD(1) and not BCD(2)) or (BCD(1) and not BCD(3)));
  S(6) <= not(BCD(0) or (BCD(1) and not BCD(2)) or (not BCD(1) and BCD(2)) or (BCD(2) and not BCD(3)));
end data_flow;