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
    constant count_length : natural := 3;

    component ClockCounter
        generic(count_length : natural);
        port(
            clock : in std_logic;
            creset : in std_logic;
            count : out std_logic_vector((count_length-1) downto 0)
        );
    end component ClockCounter;

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';
    signal creset : std_logic  := '0';
    signal count : std_logic_vector((count_length-1) downto 0);

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
    clock_counter : ClockCounter generic map(count_length) port map(clock, creset, count);

    clock <= not clock after period/2;

    process
    begin
        wait until count = "100";
            creset <= not creset;
        wait until count = "001";
            creset <= not creset;
        wait;
    end process;
end sim;