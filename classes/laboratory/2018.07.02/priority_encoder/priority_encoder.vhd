library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder is
  port (P: in std_logic_vector(2 downto 0);
        C: out std_logic_vector(1 downto 0));
end priority_encoder;

architecture behavioral of priority_encoder is
begin
  C <= "11" when P(2) = '1' else
       "10" when P(1) = '1' else
		 "01" when P(0) = '1' else
		 "00";
		 
  -- Usando with-select:
  -- with P select
  --   C <= "11" when "100" to "111",
  --     "10" when "011" | "010",
  --     "01" when "001",
  --     "00" when others;
end behavioral;