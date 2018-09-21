library ieee;
use ieee.std_logic_1164.all;

entity demux_14 is
  port (input: in std_logic;
        selector: in std_logic_vector(1 downto 0);
		  outputs: out std_logic_vector(3 downto 0));
end entity;

architecture data_flow of demux_14 is
begin
  outputs(0) <= input and not selector(1) and not selector(0);
  outputs(1) <= input and not selector(1) and selector(0);
  outputs(2) <= input and selector(1) and not selector(0);
  outputs(3) <= input and selector(1) and selector(0);
end data_flow;