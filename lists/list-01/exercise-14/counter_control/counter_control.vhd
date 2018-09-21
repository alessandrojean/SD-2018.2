library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_control is
  port (w, clk: in std_logic;
        num: buffer std_logic_vector(2 downto 0));
end entity;

architecture behavior of counter_control is
begin
  process(clk)
  begin
    if rising_edge(clk) then
	   if w = '1' then
		  if num = "110" then
		    num <= "000";
		  elsif num = "111" then
		    num <= "001";
		  else
		    num <= num + "10";
		  end if;
		else
		  if num = "000" then
		    num <= "111";
		  else
		    num <= num - 1;
		  end if;
		end if;
	 end if;
  end process;
end behavior;