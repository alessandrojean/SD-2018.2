library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity exercise_03 is
  port (SOMASUB, CLEAR, ENTER: in std_logic;
        B: in std_logic_vector(3 downto 0);
		  NUM: buffer std_logic_vector(3 downto 0);
		  CARRYOUT: out std_logic);
end exercise_03;

architecture behavior of exercise_03 is
begin
  process (CLEAR, ENTER)
    variable TMP: std_logic_vector(4 downto 0);
	 variable CTR: std_logic_vector(3 downto 0);
  begin
    CTR := (others => SOMASUB);
    if (CLEAR = '0') then
		TMP := (others => '0');
	 elsif rising_edge(ENTER) then
	   --TMP := '0' & (B(3) xor SOMASUB) & (B(2) xor SOMASUB)
      --  & (B(1) xor SOMASUB) & (B(0) xor SOMASUB);
		TMP := '0' & (B xor CTR);
		if SOMASUB = '1' then
	     TMP := NUM + TMP + 1;
		else
		  TMP := NUM + TMP;
		end if;
	 end if;
	 NUM <= TMP(3 downto 0);
	 CARRYOUT <= TMP(4);
  end process;
end behavior;