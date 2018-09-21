library ieee;
use ieee.std_logic_1164.all;

entity register_4bits is
  port (da, db: in std_logic_vector(3 downto 0);
        sel, ck: in std_logic;
		  q: out std_logic_vector(3 downto 0));
end entity;

architecture behavior of register_4bits is
begin
  process (ck)
  begin
    if falling_edge(ck) then
	   if sel = '0' then
		  q <= da;
		else
		  q <= db;
		end if;
	 end if;
  end process;
end behavior;