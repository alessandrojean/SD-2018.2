library ieee;
use ieee.std_logic_1164.all;

-- Soma dois números a e b com n bits 
-- em complemento de dois. O resultado é a saida s.
-- Caso haja overflow, overflow recebe '1'.
entity adder_nbits is
  generic (n: integer := 8);
  port (enb: in std_logic;
        a, b: in std_logic_vector(n - 1 downto 0);
        cin: in std_logic;
        s: out std_logic_vector(n - 1 downto 0);
		    cout, overflow: out std_logic);
end adder_nbits;

architecture data_flow of adder_nbits is
  -- Componente do somador completo.
  component full_adder is
    port (a, b, cin: in std_logic;
          s, cout: out std_logic);
  end component;
  
  -- Representará a propagação dos carries.
  signal carry: std_logic_vector(n downto 0) := (others => '0');
  -- Resultado da soma.
  signal sum: std_logic_vector(n - 1 downto 0);
  -- Representará o overflow.
  signal overflow_tmp: std_logic;
begin
  -- O primeiro carry deve ser o cin.
  carry(0) <= cin;
  -- Gera 8 instâncias de um somador completo,
  -- ligando sempre a saída de cout de um
  -- na cin do próximo, em cascata.
  generator: for i in 0 to n - 1 generate
    adder: full_adder
	  port map (a(i), b(i), carry(i), sum(i), carry(i + 1));
  end generate;
  -- Carry out só receberá a saída quando estiver ativo.
  cout <= '0' when enb = '0' else carry(n);
  -- O resultado só receberá a saída quando estiver ativo.
  s <= (others => '0') when enb = '0' else sum;
  -- Em complemento de dois, o overflow ocorre quando
  -- dois números tem o mesmo sinal (ambos positivos ou
  -- ambos negativos) e o resultado tem o sinal oposto.
  -- Fonte: http://bit.ly/2L8fayE
  overflow_tmp <= (a(n - 1) and b(n - 1) and not sum(n - 1)) 
    or (not a(n - 1) and not b(n - 1) and sum(n - 1));
  -- O overflow só receberá a saída quando estiver ativo.
  overflow <= '0' when enb = '0' else overflow_tmp;
end data_flow;