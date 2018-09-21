library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_10 is
  port (clk, reset: in std_logic;
        num: buffer std_logic_vector(3 downto 0));
end entity;

architecture behavior of counter_10 is
begin
  process(clk)
  begin
    if rising_edge(clk) then
	   if reset = '1' then
		  num <= (others => '0');
		elsif num = "1010" then
		  num <= (others => '0');
	   else
		  num <= num + 1;
		end if;
	 end if;
  end process;
end behavior;