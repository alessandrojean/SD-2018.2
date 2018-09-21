library ieee;
use ieee.std_logic_1164.all;

entity universal_shift_register is
  port (serial_in, load: in std_logic;
        parallel_in: in std_logic_vector(3 downto 0);
		  mode: in std_logic_vector(1 downto 0);
		  parallel_out: buffer std_logic_vector(3 downto 0));
end entity;

architecture behavior of universal_shift_register is
begin
  process(load)
  begin
    if rising_edge(load) then
	   case mode is
		  when "00" =>
		    parallel_out <= parallel_out;
		  when "01" =>
		    parallel_out <= parallel_out(2 downto 0) & serial_in;
		  when "10" =>
		    parallel_out <= serial_in & parallel_out(3 downto 1);
		  when "11" =>
		    parallel_out <= parallel_in;
		end case;
	 end if;
  end process;
end behavior;