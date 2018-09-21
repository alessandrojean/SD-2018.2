library ieee;
use ieee.std_logic_1164.all;

entity gray_counter_clock is
  port (CLKC, RSTC, SOBEC: in std_logic;
        SDAC: out std_logic_vector(1 downto 0));
end entity;

architecture behavior of gray_counter_clock is
  component clock_divider is
    port (ENB, CLKIN: in std_logic;
          CLKOUT: buffer std_logic);
  end component;
  
  component gray_counter is
    port (CLK, SOBE, RST: in std_logic;
          SDA: buffer std_logic_vector(1 downto 0));
  end component;
  
  signal CKM: std_logic;
begin
  Divisor: clock_divider
  port map ('0', CLKC, CKM);
  
  Contador: gray_counter
  port map (CKM, SOBEC, RSTC, SDAC);
end behavior;