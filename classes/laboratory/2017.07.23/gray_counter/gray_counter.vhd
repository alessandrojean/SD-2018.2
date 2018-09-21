library ieee;
use ieee.std_logic_1164.all;

entity gray_counter is
  port (CLK, SOBE, RST: in std_logic;
        SDA: buffer std_logic_vector(1 downto 0));
end entity;

architecture behavior of gray_counter is
  constant A: std_logic_vector(1 downto 0) := "00";
  constant B: std_logic_vector(1 downto 0) := "01";
  constant C: std_logic_vector(1 downto 0) := "11";
  constant D: std_logic_vector(1 downto 0) := "10";
begin
  process (CLK, RST)
  begin
    if RST = '0' then
	   if SOBE = '1' then
		  SDA <= A;
		else
		  SDA <= D;
		end if;
	 elsif rising_edge(CLK) then
	   case SDA is
		  when A =>
		    if SOBE = '1' then SDA <= B;
			 else SDA <= D;
			 end if;
		  when B =>
		    if SOBE = '1' then SDA <= C;
			 else SDA <= A;
			 end if;
		  when C =>
		    if SOBE = '1' then SDA <= D;
			 else SDA <= B;
			 end if;
		  when D =>
		    if SOBE = '1' then SDA <= A;
			 else SDA <= C;
			 end if;
		end case;
	 end if;
  end process;
end behavior;