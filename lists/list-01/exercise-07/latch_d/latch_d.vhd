library ieee;
use ieee.std_logic_1164.all;

entity latch_d is
  port (d: in std_logic_vector(3 downto 0);
        en: in std_logic;
		  q: buffer std_logic_vector(3 downto 0));
end entity;

architecture data_flow of latch_d is
begin
  with en select
    q <= d when '1',
	      q when '0';
end data_flow;