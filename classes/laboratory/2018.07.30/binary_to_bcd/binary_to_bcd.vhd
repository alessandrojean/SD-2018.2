library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity binary_to_bcd is
  port (en: in std_logic;
        binary: in std_logic_vector(12 downto 0);
		  bcd_uni: out std_logic_vector(3 downto 0);
		  bcd_ten: out std_logic_vector(3 downto 0);
		  bcd_hun: out std_logic_vector(3 downto 0);
		  bcd_tho: out std_logic_vector(3 downto 0));
end binary_to_bcd;

architecture behavior of binary_to_bcd is
begin
  process(en, binary)
    variable v: std_logic_vector(28 downto 0);
  begin
    if en = '1' then
	   bcd_uni <= (others => '0');
		bcd_ten <= (others => '0');
		bcd_hun <= (others => '0');
		bcd_tho <= (others => '0');
	 else
	   v := (others => '0');
	   v(12 downto 0) := binary;
	   for i in 0 to 12 loop
		  if v(28 downto 25) > "0100" then
		    v(28 downto 25) := v(28 downto 25) + "0011";
		  end if;
		  if v(24 downto 21) > "0100" then
		    v(24 downto 21) := v(24 downto 21) + "0011";
		  end if;
		  if v(20 downto 17) > "0100" then
		    v(20 downto 17) := v(20 downto 17) + "0011";
		  end if;
		  if v(16 downto 13) > "0100" then
		    v(16 downto 13) := v(16 downto 13) + "0011";
		  end if;
		  v := v(27 downto 0) & '0';
      end loop;
	   bcd_tho <= v(28 downto 25);
	   bcd_hun <= v(24 downto 21);
	   bcd_ten <= v(20 downto 17);
		bcd_uni <= v(16 downto 13);
    end if;
  end process;
end behavior;