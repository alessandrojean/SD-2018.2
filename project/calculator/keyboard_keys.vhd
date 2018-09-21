library ieee;
use ieee.std_logic_1164.all;

package keyboard_keys is
  -- Tecla F2.
  constant KEY_PWM_INC: std_logic_vector(15 downto 0) := "0000000000000110";
  -- Tecla F1.
  constant KEY_PWM_DEC: std_logic_vector(15 downto 0) := "0000000000000101";
  -- Tecla + do teclado numérico.
  constant KEY_SUM:     std_logic_vector(15 downto 0) := "0000000001111001";
  -- Tecla - do teclado numérico
  constant KEY_SUB:     std_logic_vector(15 downto 0) := "0000000001111011";
  -- Tecla * do teclado numérico.
  constant KEY_MTP:     std_logic_vector(15 downto 0) := "0000000001111100";
  -- Tecla Enter do teclado numérico.
  constant KEY_ENT:     std_logic_vector(15 downto 0) := "1110000001011010";
  -- Tecla Backspace.
  constant KEY_RST:     std_logic_vector(15 downto 0) := "0000000001100110";
  -- Teclas numéricas.
  constant KEY_0:       std_logic_vector(15 downto 0) := "0000000001110000"; 
  constant KEY_1:       std_logic_vector(15 downto 0) := "0000000001101001"; 
  constant KEY_2:       std_logic_vector(15 downto 0) := "0000000001110010"; 
  constant KEY_3:       std_logic_vector(15 downto 0) := "0000000001111010"; 
  constant KEY_4:       std_logic_vector(15 downto 0) := "0000000001101011"; 
  constant KEY_5:       std_logic_vector(15 downto 0) := "0000000001110011"; 
  constant KEY_6:       std_logic_vector(15 downto 0) := "0000000001110100"; 
  constant KEY_7:       std_logic_vector(15 downto 0) := "0000000001101100"; 
  constant KEY_8:       std_logic_vector(15 downto 0) := "0000000001110101"; 
  constant KEY_9:       std_logic_vector(15 downto 0) := "0000000001111101";
  -- Converte a tecla pressionada, caso possível,
  -- para o número respectivo.
  function key_to_number (key: std_logic_vector) return std_logic_vector;
end keyboard_keys;

package body keyboard_keys is
  function key_to_number (key: std_logic_vector) return std_logic_vector is
    variable result: std_logic_vector(7 downto 0);
  begin
    case key is
      when KEY_0 => result := "00000000";
      when KEY_1 => result := "00000001";
      when KEY_2 => result := "00000010";
      when KEY_3 => result := "00000011";
      when KEY_4 => result := "00000100";
      when KEY_5 => result := "00000101";
      when KEY_6 => result := "00000110";
      when KEY_7 => result := "00000111";
      when KEY_8 => result := "00001000";
      when KEY_9 => result := "00001001";
      when others => result := "10000000";
    end case;
    return result;
  end key_to_number;
end keyboard_keys;