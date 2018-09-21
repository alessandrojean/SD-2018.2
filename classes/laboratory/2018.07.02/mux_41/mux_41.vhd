library ieee;
use ieee.std_logic_1164.all;

entity mux_41 is
  port (S1F, S0F: in std_logic;
        WF: in std_logic_vector(3 downto 0);
		  FF: out std_logic);
end mux_41;

architecture behavioral of mux_41 is
  signal X1, X0: std_logic;
 
  component mux_21
    port (W0, W1, S: in std_logic;
	      F: out std_logic);
  end component;
begin
  Mux1: mux_21
    port map (WF(0), WF(1), S0F, X1);
  
  Mux2: mux_21
    port map (WF(2), WF(3), S0F, X0);
	 
  Mux3: mux_21
    port map (X1, X0, S1F, FF);
end behavioral;