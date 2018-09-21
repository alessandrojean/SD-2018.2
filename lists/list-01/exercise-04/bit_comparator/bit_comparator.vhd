library ieee;
use ieee.std_logic_1164.all;

entity bit_comparator is
  port (a, b: in std_logic;
        gti, eqi, lti: in std_logic;
		  gto, eqo, lto: out std_logic);
end entity;

architecture data_flow of bit_comparator is
begin
  gto <= (not a and not b and gti) or (a and not b) or (a and b and gti);
  eqo <= (not a and not b and eqi) or (a and b and eqi);
  lto <= (not a and not b and lti) or (not a and not b) or (a and b and lti);
end data_flow;