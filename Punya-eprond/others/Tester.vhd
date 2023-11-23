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
    
    signal counter : natural range 0 to 63 := 0;
    signal ccounter_reset : std_logic := '0';

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
    clockcounter_inst: entity work.ClockCounter
    generic map (
      count_max => 64
    )
    port map (
      clock  => clock,
      nreset => nreset,
      enable => '1',
      creset => ccounter_reset,
      count  => counter
    );

    clock <= not clock after clock_period/2;

    process
    begin
      nreset <= '0';
      wait for 2*clock_period;
      nreset <= '1';
      wait for 10*clock_period;

      ccounter_reset <= not ccounter_reset;
      wait for 15*clock_period;
      ccounter_reset <= not ccounter_reset;
      wait for 10*clock_period;

      wait;
    end process;

end sim;