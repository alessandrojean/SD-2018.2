library ieee;
use ieee.std_logic_1164.all;

entity universal_8bit_shift_register is
  port (clk, clk_en, sh_ld, clr, ser: in std_logic;
        parallel_in: in std_logic_vector(7 downto 0);
		  qh: out std_logic);
end entity;

architecture behavior of universal_8bit_shift_register is
  signal q: std_logic_vector(7 downto 0);
begin
  process(clr, clk, clk_en)
  begin
    if clr = '0' then
	   qh <= '0';
		q <= (others => '0');
	 elsif clk_en = '0' and rising_edge(clk) then
	   if sh_ld = '0' then
		  q <= parallel_in;
		else
		  qh <= q(0);
		  q <= ser & q(7 downto 1);
		end if;
	 end if;
  end process;
end behavior;