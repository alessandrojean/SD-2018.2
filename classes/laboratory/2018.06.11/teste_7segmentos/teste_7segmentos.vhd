library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity teste_7segmentos is
Port ( B0,B1,B2,B3 : in STD_LOGIC;
A,B,C,D,E,F,G : out STD_LOGIC);
end teste_7segmentos;
 
architecture Behavioral of teste_7segmentos is
 
begin
 
A <= NOT(B0 OR B2 OR (B1 AND B3) OR (NOT B1 AND NOT B3));
B <= NOT((NOT B1) OR (NOT B2 AND NOT B3) OR (B2 AND B3));
C <= NOT(B1 OR NOT B2 OR B3);
D <= NOT((NOT B1 AND NOT B3) OR (B2 AND NOT B3) OR (B1 AND NOT B2 AND B3) OR (NOT B1 AND B2) OR B0);
E <= NOT((NOT B1 AND NOT B3) OR (B2 AND NOT B3));
F <= NOT(B0 OR (NOT B2 AND NOT B3) OR (B1 AND NOT B2) OR (B1 AND NOT B3));
G <= NOT(B0 OR (B1 AND NOT B2) OR ( NOT B1 AND B2) OR (B2 AND NOT B3));
 
end Behavioral;