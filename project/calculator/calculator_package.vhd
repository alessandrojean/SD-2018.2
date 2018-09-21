library ieee;
use ieee.std_logic_1164.all;

package calculator_package is
  -- Constantes para as operações.
  constant OPT_SUM: std_logic_vector(1 downto 0) := "00";
  constant OPT_SUB: std_logic_vector(1 downto 0) := "01";
  constant OPT_MTP: std_logic_vector(1 downto 0) := "10";
  -- Tipo para a máquina de estados.
  type state is (OPT_M1, NUM_A, OPT_M2, NUM_B, OP);
end calculator_package;