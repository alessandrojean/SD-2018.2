library ieee;
use ieee.std_logic_1164.all;

entity mux_41 is
  port (values: in std_logic_vector(3 downto 0);
        selector: in std_logic_vector(1 downto 0);
		  output: out std_logic);
end entity;

architecture data_flow of mux_41 is
begin
  output <= values(0) when selector = "00" else
            values(1) when selector = "01" else
				values(2) when selector = "10" else
				values(3) when selector = "11";
end data_flow;