library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (A, B, CIN: in STD_LOGIC;
        S, COUT: out STD_LOGIC);
end full_adder;

architecture data_flow of full_adder is
begin
  S <= A xor B xor CIN;
  COUT <= (B and CIN) or (A and CIN) or (A and B);
end data_flow;