library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_12 is
  port (ld, rst, crs, ck: in std_logic;
        d: in std_logic_vector(3 downto 0);
		  q: buffer std_logic_vector(3 downto 0));
end entity;

architecture behavior of counter_12 is
begin
  process (rst, ck)
  begin
    if rst = '1' then
	   if crs = '1' then
		  q <= "1011";
		else
        q <= (others => '0');
		end if;
    elsif rising_edge(ck) then
      if ld = '1' then
		  q <= d;
		elsif q = "1011" and crs = '0' then
		  q <= (others => '0');
		elsif q = "0000" and crs = '1' then
		  q <= "1011";
		elsif crs = '1' then
		  q <= q - 1;
		else
		  q <= q + 1;
		end if;
    end if;	 
  end process;
end behavior;