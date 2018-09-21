library ieee;
use ieee.std_logic_1164.all;

-- Entidade de um somador completo,
-- que aceita o carry de entrada.
entity full_adder is
  port (a, b, cin: in std_logic;
        s, cout: out std_logic);
end full_adder;

architecture data_flow of full_adder is
begin
  -- A soma pode ser feita com um xor.
  s <= a xor b xor cin;
  -- O carry deve ser '1' se pelo menos duas
  -- das três entradas forem '1'.
  cout <= (b and cin) or (a and cin) or (a and b);
end data_flow;