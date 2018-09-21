library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clock_divider is
  port (ENB, CLKIN: in std_logic;
        CLKOUT: buffer std_logic);
end clock_divider;

architecture behavior of clock_divider is
  signal X: std_logic_vector(25 downto 0);
begin
  process (ENB, CLKIN)
  begin
    if ENB = '1' then
	   CLKOUT <= '0';
		X <= "00000000000000000000000000";
	 elsif rising_edge(CLKIN) then
	   if X = "10111110101111000010000000" then
		  X <= "00000000000000000000000000";
		  CLKOUT <= not CLKOUT;
		else
		  X <= X + 1;
		end if;
    end if;
  end process;
end behavior;