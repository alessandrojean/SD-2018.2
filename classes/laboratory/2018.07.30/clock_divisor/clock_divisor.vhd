library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clock_divisor is
  port (ENB, CLKIN: in std_logic;
        CLKOUT: buffer std_logic);
end clock_divisor;

architecture behavior of clock_divisor is
  signal X: std_logic_vector(21 downto 0);
begin
  process (ENB, CLKIN)
  begin
    if ENB = '1' then
	   CLKOUT <= '0';
		X <= (others => '0');
	 elsif rising_edge(CLKIN) then
	   if X = "1001100010010110100000" then
		  X <= (others => '0');
		  CLKOUT <= not CLKOUT;
		else
		  X <= X + 1;
		end if;
    end if;
  end process;
end behavior;