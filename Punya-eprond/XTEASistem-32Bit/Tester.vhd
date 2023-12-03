library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Tester is
end Tester;

architecture sim of Tester is
    constant clock_frequency : natural := 50e6;
    constant clock_period : time := 1 sec / clock_frequency;
    constant baud_rate : natural := 115200;
    constant string_input : string := "Ini merupakan sebuah percobaan untuk mencobakan bagaimana sebenernya sebuah percobaan bekerja";

    component ClockDiv is
      generic(div_frequency, clock_frequency : natural);
      port(
        clock_in: in std_logic;
        clock_out: out std_logic
      );
    end component ClockDiv;

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';

    signal var_a : std_logic_vector(7 downto 0);
    signal var_b : std_logic_vector(7 downto 0);
    signal var_c : std_logic_vector(7 downto 0);
    
    signal pulse_reset, pulse_out : std_logic := '0';

    function to_rs232(str : string) return std_logic_vector is
        alias str_norm : string(str'length downto 1) is str;
        variable res_v : std_logic_vector(10 * str'length - 1 downto 0);
      begin
        for idx in str_norm'range loop
          res_v(10 * idx - 1 downto 10 * idx - 10) := 
            '0' & std_logic_vector(to_unsigned(character'pos(str_norm(idx)), 8)) & '1';
        end loop;
        return res_v;
    end function;

begin
    clock <= not clock after clock_period/2;

    pulsegenerator_inst: entity work.PulseGenerator
    generic map (
      pulse_width  => 5,
      pulse_max    => 32,
      pulse_offset => 20
    )
    port map (
      clock        => clock,
      nreset       => nreset,
      pulse_enable => '1',
      pulse_reset  => pulse_reset,
      pulse_out    => pulse_out
    );

    process
    begin
      nreset <= '0';
      wait for 2*clock_period;
      nreset <= '1';
      wait for 10*clock_period;

      pulse_reset <= not pulse_reset;
      wait for 32*clock_period;
      pulse_reset <= not pulse_reset;
      wait for 32*clock_period;
      pulse_reset <= not pulse_reset;
      wait for 32*clock_period;
      pulse_reset <= not pulse_reset;
      wait for 32*clock_period;

    end process;

end sim;