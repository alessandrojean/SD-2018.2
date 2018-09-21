library ieee;
use ieee.std_logic_1164.all;

entity detect4 is
  port (w1, w2, clk, reset: in std_logic;
        z: out std_logic);
end entity;

architecture behavior of detect4 is
  type state_type is (A, B, C, D, E);
  signal y: state_type;
begin
  process(clk)
  begin
    if reset = '0' then
	   y <= A;
    elsif rising_edge(clk) then
	   case y is
		  when A =>
		    if (w1 xor w2) = '1' then y <= A;
			 else y <= B;
			 end if;
		  when B =>
		    if (w1 xor w2) = '1' then y <= A;
			 else y <= C;
			 end if;
		  when C =>
		    if (w1 xor w2) = '1' then y <= A;
			 else y <= D;
			 end if;
		  when D =>
		    if (w1 xor w2) = '1' then y <= A;
			 else y <= E;
			 end if;
		  when E =>
		    if (w1 xor w2) = '1' then y <= A;
			 else y <= E;
			 end if;
		end case;
	 end if;
  end process;
  z <= '1' when y = E else '0';
end behavior;