library ieee;
use ieee.std_logic_1164.all;

entity binary4_to_bcd8 is
  port (number: in std_logic_vector(3 downto 0);
        bcd1, bcd0: out std_logic_vector(3 downto 0));
end entity;

architecture behavior of binary4_to_bcd8 is
  signal complete_number: std_logic_vector(7 downto 0);
begin
  process (number)
  begin
    case number is
	   when "0000" => complete_number <= "00000000";
		when "0001" => complete_number <= "00000001";
		when "0010" => complete_number <= "00000010";
		when "0011" => complete_number <= "00000011";
		when "0100" => complete_number <= "00000100";
		when "0101" => complete_number <= "00000101";
		when "0110" => complete_number <= "00000110";
		when "0111" => complete_number <= "00000111";
		when "1000" => complete_number <= "00001000";
		when "1001" => complete_number <= "00001001";
		when "1010" => complete_number <= "00010000";
		when "1011" => complete_number <= "00010001";
		when "1100" => complete_number <= "00010010";
		when "1101" => complete_number <= "00010011";
		when others => complete_number <= "00010100";
	 end case;
	 bcd1 <= complete_number(7 downto 4);
	 bcd0 <= complete_number(3 downto 0);
  end process;
end behavior;