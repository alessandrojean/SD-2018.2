library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entidade de um multiplicador genérico,
-- com n bits em m e r. A saída será
-- o dobro de bits, 2n.
entity multiplier_nbits is
  generic (n: integer := 8);
  port (enb: in std_logic;
        m, r: in std_logic_vector(n - 1 downto 0);
        prd: buffer std_logic_vector(2 * n - 1 downto 0);
        overflow: out std_logic);  
end multiplier_nbits;

-- Multiplicador que utiliza o Algoritmo de Booth.
-- Algoritmo adaptado de:
-- https://en.wikipedia.org/wiki/Booth%27s_multiplication_algorithm
architecture data_flow of multiplier_nbits is
begin
  process (enb, m, r)
    -- A representa o valor de m.
    variable A: std_logic_vector(2 * n + 1 downto 0);
    -- S representa o valor de -m.
    variable S: std_logic_vector(2 * n + 1 downto 0);
    -- P é o acumulador.
    variable P: std_logic_vector(2 * n + 1 downto 0);
  begin
    -- O resultado só será calculado se o módulo estiver ativado.
    if enb = '0' then
      prd <= (others => '0');
      overflow <= '0';
    else
      -- Preencha os primeiros n bits com o valor de m,
      -- e preencha os n + 1 bits remanescentes com zeros.
      A := (others => '0');
      A(2 * n + 1 downto n + 1) := m(n - 1) & m;
      -- Preencha os primeiros n bits com o valor de -m,
      -- e preencha os n + 1 bits remanescentes com zeros.
      S := (others => '0');
      S(2 * n downto n + 1) := ((not m) + 1);
      S(2 * n + 1) := S(2 * n);
      -- Preencha os primeiros n bits com zeros,
      -- seguido do valor de r e preencha o bit menos
      -- significativo com zero.
      P := (others => '0');
      P(n downto 1) := r;
      -- Repita n vezes.
      for i in 0 to n - 1 loop
        -- Se os dois bits menos significativos de P
        -- forem 01, use o valor de P + A.
        if P(1 downto 0) = "01" then
          P := P + A;
        -- Se os dois bits menos significativos de P
        -- forem 10, use o valor de P + S.
        elsif P(1 downto 0) = "10" then
          P := P + S;
        end if;
        -- Faça um shift aritimético de um bit para a direita,
        -- atribuindo este valor a P.
        P(2 * n downto 0) := P(2 * n + 1 downto 1);      
      end loop;
      -- Ignorando o bit menos significativo de P,
      -- P terá o produto m x r.
      prd <= P(2 * n downto 1);
      -- O overflow é detectado de uma forma similar ao
      -- da soma em complemento de dois, ou seja,
      -- verificando se os sinais estão corretos na saída.
      if (m(n - 1) = '1' and r(n - 1) = '1' and P(n) = '1') then
        overflow <= '1';
      elsif (m(n - 1) = '0' and r(n - 1) = '0' and P(n) = '1') then
        overflow <= '1';
      elsif (m(n - 1) = '0' and r(n - 1) = '1' and P(n) = '0') then
        overflow <= '1';
      elsif (m(n - 1) = '1' and r(n - 1) = '0' and P(n) = '0') then
        overflow <= '1';
      else 
        overflow <= '0';
      end if;
    end if;
  end process;
end data_flow;