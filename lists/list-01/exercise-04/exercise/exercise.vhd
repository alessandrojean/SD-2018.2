library ieee;
use ieee.std_logic_1164.all;

entity exercise is
  port (ain, bin: in std_logic_vector(3 downto 0);
        gt, eq, lt: out std_logic);
end entity;

architecture data_flow of exercise is
  component bit_comparator is
    port (a, b: in std_logic;
          gti, eqi, lti: in std_logic;
		    gto, eqo, lto: out std_logic);
  end component;
  
  signal gtt: std_logic_vector(2 downto 0);
  signal eqt: std_logic_vector(2 downto 0);
  signal ltt: std_logic_vector(2 downto 0);
begin
  Comparador0: bit_comparator
  port map(ain(0), bin(0), '0', '1', '0', gtt(0), eqt(0), ltt(0));
  
  Comparador1: bit_comparator
  port map(ain(1), bin(1), gtt(0), eqt(0), ltt(0), gtt(1), eqt(1), ltt(1));
  
  Comparador2: bit_comparator
  port map(ain(2), bin(2), gtt(1), eqt(1), ltt(1), gtt(2), eqt(2), ltt(2));
  
  Comparador3: bit_comparator
  port map(ain(3), bin(3), gtt(2), eqt(2), ltt(2), gt, eq, lt);
end data_flow;