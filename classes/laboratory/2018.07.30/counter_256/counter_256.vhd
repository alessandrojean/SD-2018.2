library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_256 is
  port (CIN, RST: in std_logic;
        NUM: out std_logic_vector(7 downto 0));
end counter_256;

architecture behavior of counter_256 is
  constant MAXV: std_logic_vector(7 downto 0) := "11111111";
  signal COUNT: std_logic_vector(7 downto 0);
begin
  process (CIN, RST)
  begin
    if (RST = '0') then
	   COUNT <= (others => '0');
	 elsif rising_edge(CIN) then
	   if COUNT = MAXV then
		  COUNT <= (others => '0');
		else 
		  COUNT <= COUNT + 1;
		end if;
    end if;
	 NUM <= COUNT;
  end process;
end behavior;