library ieee;
use ieee.std_logic_1164.all;

entity exercise is
  port (src, dst: in std_logic_vector(1 downto 0);
        ain: in std_logic_vector(3 downto 0);
		  aout: out std_logic_vector(3 downto 0));
end entity;

architecture data_flow of exercise is
  component mux_41 is
    port (values: in std_logic_vector(3 downto 0);
          selector: in std_logic_vector(1 downto 0);
		    output: out std_logic);
  end component;
  
  component demux_14 is
    port (input: in std_logic;
          selector: in std_logic_vector(1 downto 0);
		    outputs: out std_logic_vector(3 downto 0));
  end component;
  
  signal active_line: std_logic;
begin
  Multiplexer: mux_41
  port map(ain, src, active_line);
  
  Demultiplexer: demux_14
  port map(active_line, dst, aout);
end data_flow;