library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pwm_module is
  port (duty: in std_logic_vector(7 downto 0);
        clk, enable, rst: in std_logic;
		  pwm_out: out std_logic);
end pwm_module;

architecture behavior of pwm_module is
  signal timer: std_logic_vector(7 downto 0) := "00000000";
begin
  process(clk, enable, rst)
  begin
    if enable = '1' then
	   timer <= (others => '0');
		pwm_out <= '0';
	 elsif rst = '0' then
	   timer <= (others => '0');
    elsif rising_edge(clk) then
	   timer <= timer + 1;
	   if timer <= duty then
	     pwm_out <= '0';
	   else
	     pwm_out <= '1';
		end if;
    end if;
  end process;
end behavior;