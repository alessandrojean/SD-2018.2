library ieee;
use ieee.std_logic_1164.all;

-- Núcleo da calculadora, similar a uma ALU.
entity calculator_kernel is
  port (enb: in std_logic;
        a, b: in std_logic_vector(7 downto 0);
        opr: in std_logic_vector(1 downto 0);
        res: out std_logic_vector(7 downto 0);
        overflow: out std_logic);
end calculator_kernel;

architecture behavior of calculator_kernel is
  -- Resultado da multiplicação.
  signal res_mtp: std_logic_vector(15 downto 0);
  -- Overflow da multiplicação.
  signal ovf_mtp: std_logic;
  -- Resultado da soma.
  signal res_sm: std_logic_vector(7 downto 0);
  -- Overflow da soma.
  signal ovf_sm: std_logic;
  -- Carry out da soma.
  signal cout_sm: std_logic;
  -- Bit que será o controle no XOR para inverter B.
  signal b_vl: std_logic_vector(7 downto 0);
  -- Indica que é uma multiplicação.
  signal is_mtp: std_logic;
  -- Indica que é uma soma.
  signal is_sm: std_logic;
  -- Indica que é uma subtração.
  signal is_sb: std_logic;
begin
  is_mtp <= '1' when opr = "10" else '0';
  is_sm <= '1' when opr = "00" else '0';
  is_sb <= '1' when opr = "01" else '0';
  -- Entidade do multiplicador.
  multiplier: entity work.multiplier_nbits(data_flow)
  generic map (8) port map ('1', a, b, res_mtp, ovf_mtp);
  -- Inverte o b caso seja uma subtração.
  b_vl <= (others => is_sb);  
  -- Entidade do somador.
  adder: entity work.adder_nbits(data_flow)
  generic map (8) port map ('1', a, b xor b_vl, is_sb, res_sm, cout_sm, ovf_sm);
  -- Escolhe qual dos overflows será a saída.
  overflow <= '0' when enb = '0' else
              ovf_mtp when is_mtp = '1' else
              ovf_sm;
  -- Escolhe qual dos resultados será a saída.
  res <= (others => '0') when enb = '0' else
         res_mtp(7 downto 0) when is_mtp = '1' else
         res_sm;
end behavior;