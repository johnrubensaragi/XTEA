library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Reg is
    generic(data_length : natural);
    port(
        clock : in std_logic;
        enable : in std_logic;
        data_in : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
end Reg;

architecture behavioral of Reg is
    signal temp_data : std_logic_vector((data_length-1) downto 0);
begin
    data_out <= temp_data;

    process(clock)
    begin
        if rising_edge(clock) then
            if (enable = '1') then
                temp_data <= data_in;
            else
                temp_data <= temp_data;
            end if;
        end if;
    end process;

end behavioral;