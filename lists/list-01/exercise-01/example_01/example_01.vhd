library ieee, lcdf_vhdl;
use ieee.std_logic_1164.all, lcdf_vhdl.func_prims.all;

entity example_01 is
  port (en, a0, a1: in std_logic;
        d0, d1, d2, d3: out std_logic);
end entity;

architecture data_flow of example_01 is
  component NOT1
    port (in1: in std_logic;
          out1: out std_logic);
  end component;
  
  component AND2
    port (in1, in2: in std_logic;
          out1: out std_logic);
  end component;
  
  signal A0_n, A1_n, N0, N1, N2, N3: std_logic;
begin
  g0: NOT1 port map (in1 => A0, out1 =>A0_n);
  g1: NOT1 port map (in1 => A1, out1 => A1_n);
  g2: AND2 port map (in1 => A0_n, in2 => A1_n, out1 => N0);
  g3: AND2 port map (in1 => A0, in2 => A1_n, out1 => N1);
  g4: AND2 port map (in1 => A0_n, in2 => A1, out1 => N2);
  g5: AND2 port map (in1 => A0, in2 => A1, out1 => N3);
  g6: AND2 port map (in1 => EN, in2 => N0, out1 => D0);
  g7: AND2 port map (in1 => EN, in2 => N1, out1 => D1);
  g8: AND2 port map (in1 => EN, in2 => N2, out1 => D2);
  g9: AND2 port map (in1 => EN, in2 => N3, out1 => D3);
end data_flow;