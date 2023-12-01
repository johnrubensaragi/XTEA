library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity RegisterBank64Bit is
    generic(reg_size : natural := 8; selector_length : natural := 3);
    port(
        clock : in std_logic;
        enable : in std_logic;
        clear : in std_logic;
        selector : in std_logic_vector((selector_length-1) downto 0);
        data_in : in std_logic_vector((reg_size-1) downto 0);
        data_out : out std_logic_vector(63 downto 0)
    );
end RegisterBank64Bit;

architecture behavioral of RegisterBank64Bit is
    constant data_length : natural := 64;
    constant reg_length : natural := 2**selector_length;

    component Reg is
    generic(data_length : natural);
    port(
        clock : in std_logic;
        enable : in std_logic;
        clear : in std_logic;
        data_in : in std_logic_vector((reg_size-1) downto 0);
        data_out : out std_logic_vector((reg_size-1) downto 0)
    );
    end component Reg;

    type array_dataout is array (0 to (reg_length-1)) of std_logic_vector((reg_size-1) downto 0);
    signal master_dataout : array_dataout;
    signal master_enable : std_logic_vector((reg_length-1) downto 0);
begin
    combine_dataout : process(master_dataout)
    begin
        for i in 0 to (reg_length-1) loop
            data_out(63-(reg_size)*i downto 64-(reg_size)*(i+1)) <= master_dataout(i);
        end loop;
    end process combine_dataout;

    enabler : process(enable, selector)
    begin
        for i in 0 to (reg_length-1) loop
            if (selector = i and enable = '1') then
                master_enable(i) <= '1';
            else
                master_enable(i) <= '0';
            end if;
        end loop;
    end process enabler;

    GEN_REG : for I in 0 to (reg_length-1) generate
        REGX : Reg generic map (reg_size)
        port map(clock, master_enable(I), clear, data_in, master_dataout(I));
    end generate;
end architecture;