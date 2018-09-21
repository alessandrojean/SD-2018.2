library ieee;
use ieee.std_logic_1164.all;

entity recognizer_1101 is
  port (CLK, ENT, RST: in std_logic;
        SDA: out std_logic);
end entity;

architecture behavior of recognizer_1101 is
  type state_type is (A, B, C, D, E);
  signal Y: state_type;
begin
  process (RST, CLK)
  begin
    if RST = '0' then
	   Y <= A;
	 elsif rising_edge(CLK) then
	   case Y is
		  when A =>
		    if ENT = '0' then Y <= A;
			 else Y <= B;
			 end if;
		  when B =>
		    if ENT = '0' then Y <= A;
			 else Y <= C;
			 end if;
		  when C =>
		    if ENT = '0' then Y <= D;
			 else Y <= C;
			 end if;
		  when D =>
		    if ENT = '0' then Y <= A;
			 else Y <= E;
			 end if;
		  when E =>
		    if ENT = '0' then Y <= A;
			 else Y <= C;
			 end if;
		end case;
	 end if;
  end process;
  SDA <= '1' when Y = E else '0';
end behavior;