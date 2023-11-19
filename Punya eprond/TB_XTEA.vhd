library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity TB_Xtea is
end TB_Xtea;

architecture sim of TB_Xtea is
    constant frequency : natural := 50000000;
    constant period : time := 1000 ms / frequency;
    constant string_input : string := "percobaa";
    constant string_key : string := "passwordku123456";

    component XTEA is
        port(
            clock, nreset : in std_logic;
            xtea_key : in std_logic_vector(127 downto 0);
            xtea_input : in std_logic_vector(63 downto 0);
            xtea_mode : in std_logic;
            xtea_start : in std_logic;
            xtea_output : out std_logic_vector(63 downto 0);
            xtea_done : out std_logic
        );    
    end component XTEA;

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';

    signal xtea_start : std_logic;
    signal xtea_done : std_logic;
    signal xtea_mode : std_logic;
    signal xtea_input : std_logic_vector(63 downto 0) := (others => '0');
    signal xtea_key : std_logic_vector(127 downto 0) := (others => '0');
    signal xtea_output : std_logic_vector(63 downto 0) := (others => '0');

    signal rout : std_logic_vector(63 downto 0);

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
    xtea_blok : XTEA port map(clock, nreset, xtea_key, xtea_input, xtea_mode, xtea_start, xtea_output, xtea_done);
    
    clock <= not clock after period/2;

    process
    begin
        wait until rising_edge(clock);
        xtea_mode <= '0';
        xtea_input <= to_slv(string_input);
        xtea_key <= to_slv(string_key);
        xtea_start <= '1';
        wait until rising_edge(xtea_done);
        rout <= xtea_output;
        xtea_start <= '0';
        wait until rising_edge(clock);
        xtea_input <= xtea_output;
        xtea_mode <= '1';
        xtea_start <= '1';
        wait until rising_edge(xtea_done);
        rout <= xtea_output;
        wait;
    end process;
end sim;