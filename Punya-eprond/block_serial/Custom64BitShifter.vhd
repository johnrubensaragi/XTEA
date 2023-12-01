library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Custom64BitShifter is
    generic(data_size : natural := 8);
    port(
        clock : in std_logic;
        trigger_shift : in std_logic;
        max_shift : in std_logic;
        data_in : in std_logic_vector((data_size-1) downto 0);
        data_out : out std_logic_vector(63 downto 0)
    );
end Custom64BitShifter;

architecture behavioral of Custom64BitShifter is
    signal temp_data_out : std_logic_vector(63 downto 0) := (others => '0');
    signal trigger_buffer : std_logic_vector(1 downto 0);
    signal shift_counter : natural range 0 to 64/data_size := 1;
begin
    data_out <= temp_data_out;

    shifter : process(clock)
        constant shift_length : natural := 64/data_size;
        variable shift_remaining : natural;
    begin
        shift_remaining := shift_length - shift_counter; 

        if (max_shift = '1') then
            if (shift_counter < shift_length) then
            temp_data_out <= temp_data_out(data_size*shift_counter-1 downto 0) & conv_std_logic_vector(0, data_size*shift_remaining);
            shift_counter <= shift_length;
            end if;
        elsif rising_edge(clock) then
            trigger_buffer <= trigger_buffer(0) & trigger_shift;
            if (trigger_buffer = "01") then
                temp_data_out <= temp_data_out(63-data_size downto 0) & conv_std_logic_vector(0, data_size);
                if (shift_counter < shift_length) then
                    shift_counter <= shift_counter + 1;
                else
                    shift_counter <= 1;
                end if;
            elsif (trigger_buffer = "11") then
                temp_data_out((data_size-1) downto 0) <= data_in;
            end if;
        end if;
    end process shifter;
end behavioral;