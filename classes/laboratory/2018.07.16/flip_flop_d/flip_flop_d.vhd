library ieee;
use ieee.std_logic_1164.all;

entity flip_flop_d is
  port (D, CLK, CLR: in std_logic;
        Q: out std_logic);
end flip_flop_d;

architecture behavior of flip_flop_d is
begin
  process (CLK, CLR)
  begin
    if CLR = '0' then
	   Q <= '0';
	 elsif rising_edge(CLK) then
	   Q <= D;
	 end if;
  end process;
end behavior;