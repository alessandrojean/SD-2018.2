library ieee;
use ieee.std_logic_1164.all;

entity class_project is
  port(clkt: in std_logic;
       cduty: in std_logic_vector(7 downto 0);
		 seg3, seg2, seg1, seg0: out std_logic_vector(6 downto 0));  
end entity;

architecture data_flow of class_project is
  component counter_8192 is
    port (CIN, RST: in std_logic;
          NUM: out std_logic_vector(12 downto 0));
  end component;
  
  component pwm_module is
    port (duty: in std_logic_vector(7 downto 0);
          clk, enable, rst: in std_logic;
		    pwm_out: out std_logic);
  end component;
  
  component binary_to_bcd is
    port (en: in std_logic;
          binary: in std_logic_vector(12 downto 0);
	       bcd_uni: out std_logic_vector(3 downto 0);
		    bcd_ten: out std_logic_vector(3 downto 0);
		    bcd_hun: out std_logic_vector(3 downto 0);
		    bcd_tho: out std_logic_vector(3 downto 0));
  end component;
  
  component decoder_bcd_7seg is
    port (BCD: in std_logic_vector(3 downto 0);
          S: out std_logic_vector(6 downto 0));
  end component;
  
  component clock_divisor is
    port (ENB, CLKIN: in std_logic;
          CLKOUT: buffer std_logic);
  end component;
  
  signal cmenor: std_logic;
  signal numero: std_logic_vector(12 downto 0);
  signal bcd3, bcd2, bcd1, bcd0: std_logic_vector(3 downto 0);
  signal st3, st2, st1, st0: std_logic_vector(6 downto 0);
  signal pwout: std_logic;
  signal pwvec: std_logic_vector(6 downto 0);
begin
  Clock: clock_divisor
  port map('0', clkt, cmenor);
  
  Contador: counter_8192
  port map(cmenor, '1', numero);
  
  ParaBCD: binary_to_bcd
  port map('0', numero, bcd0, bcd1, bcd2, bcd3);
  
  Seg3M: decoder_bcd_7seg
  port map(bcd3, st3);
  
  Seg2M: decoder_bcd_7seg
  port map(bcd2, st2);
  
  Seg1M: decoder_bcd_7seg
  port map(bcd1, st1);
  
  Seg0M: decoder_bcd_7seg
  port map(bcd0, st0);
  
  PWM: pwm_module
  port map(cduty, clkt, '0', '1', pwout);
  
  pwvec <= (others => pwout);  
  seg3 <= st3 or pwvec;
  seg2 <= st2 or pwvec;
  seg1 <= st1 or pwvec;
  seg0 <= st0 or pwvec;
end data_flow;