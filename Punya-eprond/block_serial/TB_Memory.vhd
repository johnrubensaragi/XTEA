library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity TB_Memory is
end entity;

architecture behavioral of TB_Memory is
    constant clock_frequency : natural := 50e6;
    constant clock_period : time := 1 sec/clock_frequency;
    constant data_length : natural := 64;
    constant address_length : natural := 10;

    signal store_data, read_data : std_logic_vector((data_length-1) downto 0);
    signal store_address : std_logic_vector((address_length-1) downto 0);
    signal enable_write : std_logic;
    
    signal clock, nreset : std_logic := '0';
begin

    memoryblock_inst: entity work.MemoryBlock
    port map (
      clock          => clock,
      enable_write   => enable_write,
      memory_address => store_address,
      memory_write   => store_data,
      memory_read    => read_data
    );

    clock <= not clock after clock_period/2;
    
    process
    begin
        wait for 5*clock_period;
        nreset <= not nreset;

        enable_write <= '1';
        store_address <= (others => '1');
        store_data <= x"AB2C95Ac41A951cF";
        wait for 5*clock_period;

        store_address <= (others => '0');
        wait for clock_period;

        for idx in 0 to 2**address_length loop 
            store_address <= conv_std_logic_vector(idx, 10);
            store_data <= store_data + 1;
            if (idx mod 2 = 1) then
                enable_write <= '0';
            else
                enable_write <= '1';
            end if;
            wait for 5*clock_period;
        end loop;

        wait;
    end process;
end architecture;
