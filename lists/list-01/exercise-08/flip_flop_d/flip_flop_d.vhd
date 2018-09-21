library ieee;
use ieee.std_logic_1164.all;

entity flip_flop_d is
  port (d, preset, reset, clk: in std_logic;
        q: out std_logic);
end entity;

architecture behavior of flip_flop_d is
begin
  process(reset, clk)
  begin
    if reset = '1' then
	   q <= '0';
    elsif falling_edge(clk) then
	   if (preset = '1') then
		  q <= '1';
		else
		  q <= d;
		end if;
	 end if;
  end process;
end behavior;