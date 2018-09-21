library ieee;
use ieee.std_logic_1164.all;

entity sequence_recognizer is
  port (x, reset, clk: in std_logic;
        z: out std_logic);
end entity;

architecture behavior of sequence_recognizer is
  type state_type is (A, B, C, D, E, F, G, H, I);
  signal state, next_state: state_type;
begin
  state_register: process(reset, clk)
  begin
    if reset = '0' then
	   state <= A;
	 elsif rising_edge(clk) then
	   state <= next_state;
	 end if;
  end process;
  
  next_state_func: process(x, state)
  begin
    case state is
	   when A =>
		  if x = '0' then next_state <= B;
		  else next_state <= A;
		  end if;
		when B =>
		  if x = '1' then next_state <= C;
		  else next_state <= A;
		  end if;
		when C =>
		  if x = '1' then next_state <= D;
		  else next_state <= A;
		  end if;
		when D =>
		  if x = '1' then next_state <= E;
		  else next_state <= A;
		  end if;
		when E =>
		  if x = '0' then next_state <= F;
	     else next_state <= A;
		  end if;
		when F =>
		  if x = '0' then next_state <= G;
		  else next_state <= C;
		  end if;
		when G =>
		  if x = '1' then next_state <= H;
		  else next_state <= A;
		  end if;
		when H =>
		  if x = '0' then next_state <= I;
		  else next_state <= D;
		  end if;
		when I =>
		  if x = '1' then next_state <= C;
		  else next_state <= A;
		  end if;
		end case;
  end process;
  
  output_func: process(x, state)
  begin
    case state is
	   when A => z <= '0';
		when B => z <= '0';
		when C => z <= '0';
		when D => z <= '0';
		when E => z <= '0';
		when F => z <= '0';
		when G => z <= '0';
		when H => z <= '0';
		when I =>
		  if x = '1' then
		    z <= '1';
		  else
		    z <= '0';
		  end if;
	 end case;
  end process;
end behavior;