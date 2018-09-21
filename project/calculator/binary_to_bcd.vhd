library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entidade conversor de binário para BCD.
-- Utiliza o algoritmo Double dabble.
entity binary_to_bcd is
  port (en, sig: in std_logic;
        binary: in std_logic_vector(7 downto 0);
        bcd_uni: out std_logic_vector(3 downto 0);
        bcd_ten: out std_logic_vector(3 downto 0);
        bcd_hun: out std_logic_vector(3 downto 0));
end binary_to_bcd;

architecture behavior of binary_to_bcd is
begin
  process (en, binary)
    -- Representa a tabela.
    variable v: std_logic_vector(19 downto 0);
  begin
    -- Zera as saídas caso não estiver ativo.
    if en = '1' then
      bcd_uni <= (others => '0');
      bcd_ten <= (others => '0');
      bcd_hun <= (others => '0');
    else
      -- Inicialize tudo com zero.
      v := (others => '0');
      -- Se o valor é com sinal e é negativo,
      -- inverta-o para pegar o valor positivo.
      if sig = '1' and binary(7) = '1' then
        v(7 downto 0) := (not binary) + 1;
      else
        v(7 downto 0) := binary;
      end if;
      -- Repita o procedimento n vezes.
      for i in 0 to 7 loop
        -- Se alguma das colunas for maior que 4,
        -- some 3 a esta coluna.
        if v(19 downto 16) > "0100" then
          v(19 downto 16) := v(19 downto 16) + "0011";
        end if;
        if v(15 downto 12) > "0100" then
          v(15 downto 12) := v(15 downto 12) + "0011";
        end if;
        if v(11 downto 8) > "0100" then
          v(11 downto 8) := v(11 downto 8) + "0011";
        end if;
        -- Efetue um shift para a esquerda.
        v := v(18 downto 0) & '0';
      end loop;
      -- Saída das centenas.
      bcd_hun <= v(19 downto 16);
      -- Saída das dezenas.
      bcd_ten <= v(15 downto 12);
      -- Saída das unidades.
      bcd_uni <= v(11 downto 8);
    end if;
  end process;
end behavior;