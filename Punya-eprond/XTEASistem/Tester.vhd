library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Tester is
end Tester;

architecture sim of Tester is
    constant frequency : natural := 50000000;
    constant period : time := 1000 ms / frequency;
    constant string_input : string := "percobaa";
    constant string_key : string := "passwordku123456";
    constant count_max : natural := 64;

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';
    signal var_a : std_logic_vector(7 downto 0);
    signal var_b : std_logic_vector(7 downto 0);
    signal var_c : std_logic_vector(7 downto 0);

    signal creset : std_logic := '0';
    signal count : natural;
    

    function to_slv(str : string) return std_logic_vector is
        alias str_norm : string(str'length downto 1) is str;
        variable res_v : std_logic_vector(8 * str'length - 1 downto 0);
      begin
        for idx in str_norm'range loop
          res_v(8 * idx - 1 downto 8 * idx - 8) := 
            std_logic_vector(to_unsigned(character'pos(str_norm(idx)), 8));
        end loop;
        return res_v;
    end function;

begin    
    clock <= not clock after period/2;

    clockcounter_inst: entity work.ClockCounter
    generic map (
      count_max => count_max
    )
    port map (
      clock  => clock,
      creset => creset,
      count  => count
    );

    process
    begin
        creset <= not creset;
        wait until count = 10;
        creset <= not creset;
        wait until count = 5;
        creset <= not creset;
    end process;
end sim;