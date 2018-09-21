library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entidade de um divisor de clock genérico.
entity clock_divider is
  generic (max: integer := 3125000);
  port (enb, clkin: in std_logic;
        clkout: buffer std_logic);
end clock_divider;

architecture behavior of clock_divider is
  -- Será o contador.
  signal X: integer range 0 to max;
begin
  process (enb, clkin)
  begin
    -- Enable assíncrono.
    if enb = '1' then
      clkout <= '0';
      X <= 0;
    elsif rising_edge(clkin) then
      -- Se X chegou ao valor máximo.
      if X = max then
        -- Reinicie o contador.
        X <= 0;
        -- Inverta o valor de clkout.
        clkout <= not clkout;
      else
        X <= X + 1;
      end if;
    end if;
  end process;
end behavior;