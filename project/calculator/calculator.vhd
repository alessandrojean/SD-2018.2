library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.keyboard_keys.all;
use work.calculator_package.all;

-- Entidade principal da calculadora.
entity calculator is
  port (PS2_DAT, PS2_CLK: inout std_logic;
        CLOCK_50: in std_logic;
        CLOCK_24: in std_logic_vector(1 downto 0);
        LEDR: out std_logic_vector(9 downto 0);
        HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0));
end entity;

architecture behavior of calculator is
  -- Sinais para o teclado.
  signal key_on: std_logic_vector(2 downto 0);
  signal key0: std_logic_vector(15 downto 0);
  -- Sinais para o funcionamento.
  signal actual_state: state := OPT_M1;
  -- Sinais para a calculadora.
  signal number_to_show: std_logic_vector(7 downto 0) := (others => '0');
  signal reading_number: std_logic_vector(7 downto 0) := (others => '0');
  signal number_a, number_b: std_logic_vector(7 downto 0) := (others => '0');
  signal result_number: std_logic_vector(7 downto 0) := (others => '0');
  signal invert_number: std_logic;
  signal operation: std_logic_vector(1 downto 0);
  signal calc: std_logic := '0';
  signal ovf_tmp: std_logic;
  -- Sinais para os displays.
  signal bcd_uni, bcd_ten, bcd_hun: std_logic_vector(3 downto 0);
  signal st3, st2, st1, st0: std_logic_vector(6 downto 0);
  signal tmp_st3: std_logic;
  -- Sinais para o PWM.
  signal pwm_v, clock_pwm: std_logic;
  signal pwm_sig: std_logic_vector(6 downto 0);
  signal duty_value: std_logic_vector(7 downto 0) := "11111111";
  signal pwm_inc, pwm_dec: std_logic;
begin
  -- Módulo responsável pela leitura das teclas
  -- de um teclado com interface PS2.
  ps2: entity work.kbdex_ctrl(rtl)
  generic map (24000) port map (
    PS2_DAT, PS2_CLK, CLOCK_24(0), '1', '1', "010",
    key_on, key_code(15 downto 0) => key0
  );  
  -- Divisor de clock para o controle do duty do PWM.
  clock_dvd_pwm: entity work.clock_divider(behavior)
  port map ('0', CLOCK_50, clock_pwm);
  -- Processo que reage ao clock dividido do PWM.
  process (clock_pwm)
  begin
    if rising_edge(clock_pwm) then
      -- Se a tecla de incrementar está apertada.
      if pwm_inc = '1' then
        -- Limita o valor máximo, fazendo com
        -- que a variável não estoure.
        if duty_value = "11111111" then
          duty_value <= "11111111";
        else
          duty_value <= duty_value + 1;
        end if;
      -- Se a tecla de decrementar está apertada.
      elsif pwm_dec = '1' then
        -- Limita o valor mínimo, fazendo com
        -- que a variável não estoure.
        if duty_value = "00000000" then
          duty_value <= "00000000";
        else
          duty_value <= duty_value - 1;
        end if;
      end if;
    end if;
  end process;
  -- Será ativo quando a tecla for o F2.
  pwm_inc <= '1' when key0 = KEY_PWM_INC else '0';
  -- Será ativo quando a tecla for o F1.
  pwm_dec <= '1' when key0 = KEY_PWM_DEC else '0';
  -- Entidade do PWM.
  pwm: entity work.pwm_module(behavior)
  port map (duty_value, CLOCK_50, '0', '1', pwm_v);
  -- Cria um vetor com preenchido com valor de pwm_v.
  pwm_sig <= (others => pwm_v);  
  -- Entidade do conversor de binário para BCD.
  bcd_converter: entity work.binary_to_bcd(behavior)
  port map ('0', '1', number_to_show, bcd_uni, bcd_ten, bcd_hun);
  -- Entidades dos displays de sete segmentos.
  -- O primeiro display apenas mostrará o sinal de
  -- menos se o número for negativo.
  tmp_st3 <= not number_to_show(7) when actual_state = OP else
             not invert_number;
  st3 <= (6 => tmp_st3, others => '1');
  -- Display das centenas.
  segm2: entity work.decoder_bcd_7seg(data_flow)
  port map (bcd_hun, st2);
  -- Display das dezenas.
  segm1: entity work.decoder_bcd_7seg(data_flow)
  port map (bcd_ten, st1);
  -- Display das unidades.
  segm0: entity work.decoder_bcd_7seg(data_flow)
  port map (bcd_uni, st0);
  -- Efetua um or com a saída do PWM.
  HEX3 <= st3 or pwm_sig;
  HEX2 <= st2 or pwm_sig;
  HEX1 <= st1 or pwm_sig;
  HEX0 <= st0 or pwm_sig;
  -- Escolhe qual número será exibido nos displays,
  -- baseando-se no estado atual.
  number_to_show <= reading_number when (actual_state = NUM_A or actual_state = NUM_B) else
                    result_number when actual_state = OP else
                    (others => '0') when key0 = KEY_RST;   
  -- Entidade do núcleo da calculadora.
  calculator_ker: entity work.calculator_kernel(behavior)
  port map ('1', number_a, number_b, operation, result_number, ovf_tmp);
  -- Indicador de overflow.
  LEDR(9) <= ovf_tmp when actual_state = OP else '0';
  -- Indicadores dos estados.
  LEDR(0) <= '1' when actual_state = OPT_M1 else '0';
  LEDR(1) <= '1' when actual_state = NUM_A else '0';
  LEDR(2) <= '1' when actual_state = OPT_M2 else '0';
  LEDR(3) <= '1' when actual_state = NUM_B else '0';
  LEDR(4) <= '1' when actual_state = OP else '0';
  -- Processo que reage a tecla pressionada do teclado.
  process (key_on(0))
    variable tmp_value: std_logic_vector(7 downto 0);
  begin
    if rising_edge(key_on(0)) then
      -- A tecla reset é assíncrona, se for pressionada,
      -- reseta todas as principais variáveis e volta
      -- para o primeiro estado.
      if key0 = KEY_RST then
        reading_number <= (others => '0');
        actual_state <= OPT_M1;
        invert_number <= '0';
        number_a <= (others => '0');
        number_b <= (others => '0');
        calc <= '0';
      -- Se a tecla pressionada não for nula.
      elsif key0 /= "0000000000000000" then
        case actual_state is
          -- Estado responsável por ler o primeiro
          -- sinal opcional.
          when OPT_M1 =>
            -- Se o sinal opcional foi pressionado,
            -- ativa a opção de inverter o número.
            if key0 = KEY_SUB then
              invert_number <= '1';
              actual_state <= NUM_A;
              calc <= '0';
            -- Se não, têm que ler o primeiro número.
            else
              tmp_value := key_to_number(key0);
              if tmp_value /= "10000000" then
                reading_number <= tmp_value;
                actual_state <= NUM_A;
              end if;
              invert_number <= '0';
              calc <= '0';
            end if;
          -- Estado responsável por ler o primeiro número.
          when NUM_A =>
            -- Se a tecla + foi pressionada, a leitura acaba.
            if key0 = KEY_SUM then
              operation <= OPT_SUM;
              actual_state <= OPT_M2;
              -- Zera o número que estava sendo lido.
              reading_number <= (others => '0');
              -- Se precisa inverter o número, inverte-o.
              if invert_number = '1' then
                number_a <= (not reading_number) + 1;
              else
                number_a <= reading_number;
              end if;
              invert_number <= '0';
              calc <= '0';
            -- Se a tecla - foi pressionada, a leitura acaba.
            elsif key0 = KEY_SUB then
              operation <= OPT_SUB;
              actual_state <= OPT_M2;
              -- Se precisa inverter o número, inverte-o.
              if invert_number = '1' then
                number_a <= (not reading_number) + 1;
              else
                number_a <= reading_number;
              end if;
              -- Zera o número que estava sendo lido.
              reading_number <= (others => '0');
              invert_number <= '0';
              calc <= '0';
            -- Se a tecla * foi pressionada, a leitura acaba.
            elsif key0 = KEY_MTP then
              operation <= OPT_MTP;
              actual_state <= OPT_M2;
              -- Se precisa inverter o número, inverte-o.
              if invert_number = '1' then
                number_a <= (not reading_number) + 1;
              else
                number_a <= reading_number;
              end if;
              -- Zera o número que estava sendo lido.
              reading_number <= (others => '0');
              invert_number <= '0';
              calc <= '0';
            -- Senão, continua lendo se for uma tecla numérica.
            else
              tmp_value := key_to_number(key0);
              if tmp_value /= "10000000" then
                -- Multiplica o valor atual por 10 e soma o novo.
                tmp_value := (reading_number(4 downto 0) & "000") 
                  + (reading_number(6 downto 0) & '0') + tmp_value;
                reading_number <= tmp_value;
              end if;
              calc <= '0';
            end if;
          -- Estado responsável por ler o segundo
          -- sinal opcional.
          when OPT_M2 =>
            -- Se o sinal opcional foi pressionado,
            -- ativa a opção de inverter o número.
            if key0 = KEY_SUB then
              invert_number <= '1';
              actual_state <= NUM_B;
              calc <= '0';           
            -- Se não, têm que ler o primeiro número.   
            else
              tmp_value := key_to_number(key0);
              if tmp_value /= "10000000" then
                reading_number <= key_to_number(key0);
                actual_state <= NUM_B;
                invert_number <= '0';
              end if;
              calc <= '0';              
            end if;
          -- Estado responsável por ler o segundo número.
          when NUM_B =>
            -- Se a tecla Enter foi pressionada, a leitura acaba.
            if key0 = KEY_ENT then
              actual_state <= OP;
              -- Se precisa inverter o número, inverte-o.
              if invert_number = '1' then
                number_b <= (not reading_number) + 1;
              else
                number_b <= reading_number;
              end if;
              -- Zera o número que estava sendo lido.
              reading_number <= (others => '0');
              invert_number <= '0';
              calc <= '1';
            -- Senão, continua lendo se for uma tecla numérica.
            else
              tmp_value := key_to_number(key0);
              if tmp_value /= "10000000" then
                -- Multiplica o valor atual por 10 e soma o novo.
                tmp_value := (reading_number(4 downto 0) & "000")
                  + (reading_number(6 downto 0) & '0') + tmp_value;
                reading_number <= tmp_value;
              end if;
            end if;
          -- Estado responsável por mostrar o resultado e
          -- esperar a entrada de um próximo operador caso
          -- o usuário queira utilizar o valor do resultado.
          when OP =>
            -- Se a tecla + é a pressionada.
            if key0 = KEY_SUM then
              number_a <= result_number;
              operation <= OPT_SUM;
              reading_number <= (others => '0');
              actual_state <= OPT_M2;
              invert_number <= '0';
            -- Se a tecla - é a pressionada.
            elsif key0 = KEY_SUB then
              number_a <= result_number;
              operation <= OPT_SUB;
              reading_number <= (others => '0');
              actual_state <= OPT_M2;
              invert_number <= '0';
            -- Se a tecla * é a pressionada.
            elsif key0 = KEY_MTP then
              number_a <= result_number;
              operation <= OPT_MTP;
              reading_number <= (others => '0');
              invert_number <= '0';              
              actual_state <= OPT_M2;
            end if;
        end case;
      end if;
    end if;
  end process;
end behavior;