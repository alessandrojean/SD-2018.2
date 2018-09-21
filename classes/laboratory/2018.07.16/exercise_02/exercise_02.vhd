library ieee;
use ieee.std_logic_1164.all;

entity exercise_02 is
  port (CKIN, RES: in std_logic;
        SEG1O, SEG0O: out std_logic_vector(6 downto 0));
end exercise_02;

architecture behavior of exercise_02 is
  component clock_divider
    port (ENB, CLKIN: in std_logic;
	       CLKOUT: buffer std_logic);
  end component;
  
  component counter_16
    port (CIN, RST: in std_logic;
	       NUM: out std_logic_vector(3 downto 0));
  end component;
  
  component binary4_to_bcd8
    port (BIN: in std_logic_vector(3 downto 0);
	       BCD0, BCD1: out std_logic_vector(3 downto 0));
  end component;
  
  component decoder_bcd_7seg
    port (BCD: in std_logic_vector(3 downto 0);
	       S: out std_logic_vector(6 downto 0));
  end component;
  
  signal CD: std_logic;
  signal SC, B0, B1: std_logic_vector(3 downto 0);
begin
  Divider: clock_divider
  port map ('0', CKIN, CD);
  
  Counter: counter_16
  port map (CD, RES, SC);
  
  BinaryBCD: binary4_to_bcd8
  port map (SC, B0, B1);
  
  Seg1: decoder_bcd_7seg
  port map (B1, SEG1O);
  
  Seg0: decoder_bcd_7seg
  port map (B0, SEG0O);
end behavior;