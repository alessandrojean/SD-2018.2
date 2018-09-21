library ieee;
use ieee.std_logic_1164.all;

entity difference_detector is
  port (x, clk: in std_logic;
        z: out std_logic);
end entity;

architecture behavior of difference_detector is
  signal ant: std_logic;
begin
  process(clk)
  begin
    if rising_edge(clk) then
	   if x = ant then
		  z <= '0';
		else
		  z <= '1';
		end if;
		ant <= x;
	 end if;
  end process;
end behavior;