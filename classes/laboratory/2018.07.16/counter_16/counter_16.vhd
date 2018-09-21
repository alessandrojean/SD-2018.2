library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_16 is
  port (CIN, RST: in std_logic;
        NUM: out std_logic_vector(3 downto 0));
end counter_16;

architecture behavior of counter_16 is
  constant MAXV: std_logic_vector(3 downto 0) := "1111";
  signal COUNT: std_logic_vector(3 downto 0);
begin
  process (CIN, RST)
  begin
    if (RST = '0') then
	   COUNT <= "0000";
	 elsif rising_edge(CIN) then
	   if COUNT = MAXV then
		  COUNT <= "0000";
		else 
		  COUNT <= COUNT + 1;
		end if;
    end if;
	 NUM <= COUNT;
  end process;
end behavior;