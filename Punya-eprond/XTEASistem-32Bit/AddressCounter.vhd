library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity AddressCounter is
    generic(address_length : natural := 10);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        countup_trigger : in std_logic;
        force_enable : in std_logic;
        force_address : in std_logic_vector(1 downto 0);        
        address_out : out std_logic_vector((address_length-1) downto 0)
    );
end AddressCounter;

architecture behavioral of AddressCounter is
    signal temp_address : std_logic_vector((address_length-1) downto 0);
    signal trigger_buffer : std_logic;
begin

    address_out <= temp_address;

    process (clock, nreset, force_enable)
    begin
        if (nreset = '0') then
            temp_address <= (others => '0');
        elsif (force_enable = '1') then
            temp_address <= conv_std_logic_vector(0, (address_length-2)) & force_address;
        elsif rising_edge(clock) then
            trigger_buffer <= countup_trigger;
            if (trigger_buffer = '0' and countup_trigger = '1') then
                temp_address <= temp_address + 1;
            end if;
        end if;
    end process;
end behavioral;
