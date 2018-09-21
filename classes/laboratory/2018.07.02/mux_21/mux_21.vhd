library ieee;
use ieee.std_logic_1164.all;

entity mux_21 is
  port (W0, W1, S: in std_logic;
        F: out std_logic);
end mux_21;

architecture behavioral of mux_21 is
begin
  with S select
    F <= W0 when '0',
	      W1 when '1';
end behavioral;