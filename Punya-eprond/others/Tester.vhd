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

    signal trigger_shift, max_shift : std_logic := '0';
    signal data_in : std_logic_vector(3 downto 0);
    signal data_out : std_logic_vector(63 downto 0);

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
    custom64bitshifter_inst: entity work.Custom64BitShifter
    generic map (
      data_size => 4
    )
    port map (
      clock         => clock,
      trigger_shift => trigger_shift,
      max_shift     => max_shift,
      data_in       => data_in,
      data_out      => data_out
    );
    clock <= not clock after clock_period/2;

    process
    begin
      nreset <= '0';
      wait for 2*clock_period;
      nreset <= '1';
      wait for 10*clock_period;

      data_in <= x"B";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"A";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"4";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"1";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      max_shift <= '1';
      wait for 5*clock_period;
      max_shift <= '0';

      data_in <= x"B";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"A";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"4";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"1";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      data_in <= x"B";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"A";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"4";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"1";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"B";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"A";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"4";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      data_in <= x"1";
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;
      trigger_shift <= not trigger_shift;
      wait for 20*clock_period;

      max_shift <= '1';

      wait;
    end process;

end sim;