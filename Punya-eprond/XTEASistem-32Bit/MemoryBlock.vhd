library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MemoryBlock is
    generic (data_length, address_length : integer);
    port(
        clock : in std_logic;
        enable_write : in std_logic;
        memory_address : in std_logic_vector((address_length - 1) downto 0);
        memory_write : in std_logic_vector((data_length - 1) downto 0);
        memory_read : out std_logic_vector((data_length - 1) downto 0)
    );
end entity;

architecture behavioral of MemoryBlock is
    component MUX2Data  is
    generic (data_length : natural);
    port (
        selector : in std_logic;
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX2Data;

    component MUX4Data is
    generic (data_length : natural);
    port (
        selector : in std_logic_vector(1 downto 0);
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_in3 : in std_logic_vector((data_length-1) downto 0);
        data_in4 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX4Data;

    component SRAM is 
    generic (data_length, address_length : integer);
    port(
        clock : in std_logic;
        enable_write : in std_logic;
        memory_address : in std_logic_vector((address_length - 1) downto 0);
        memory_write : in std_logic_vector((data_length - 1) downto 0);
        memory_read : out std_logic_vector((data_length - 1) downto 0)
    );
    end component SRAM;

    signal sram00_read, sram10_read, sram20_read, sram30_read : std_logic_vector(31 downto 0);
    signal sram01_read, sram11_read, sram21_read, sram31_read : std_logic_vector(31 downto 0);
    signal lmemory_write, rmemory_write : std_logic_vector(31 downto 0);
    signal sram_address : std_logic_vector(7 downto 0);
    signal row_selector : std_logic_vector(1 downto 0);
    signal row_enable : std_logic_vector(3 downto 0);

    signal enable_row0, enable_row1, enable_row2, enable_row3 : std_logic;

begin

    sram_address <= memory_address(7 downto 0);
    row_selector <= memory_address(9 downto 8);
    enable_row0 <= row_enable(0);
    enable_row1 <= row_enable(1);
    enable_row2 <= row_enable(2);
    enable_row3 <= row_enable(3);

    lmemory_write <= memory_write(63 downto 32);
    rmemory_write <= memory_write(31 downto 0);

    row_enable_mux : MUX4Data generic map(4) port map(row_selector, "0001", "0010", "0100", "1000", row_enable);
    lmemory_read_mux : MUX4Data generic map(32) port map(row_selector, sram00_read, sram10_read, sram20_read, sram30_read, memory_read(63 downto 32));
    rmemory_read_mux : MUX4Data generic map(32) port map(row_selector, sram01_read, sram11_read, sram21_read, sram31_read, memory_read(31 downto 0));

    sram00_inst: SRAM generic map (32, 8)
    port map (clock, enable_row0, sram_address, lmemory_write, sram00_read);

    sram01_inst: SRAM generic map (32, 8)
    port map (clock, enable_row0, sram_address, rmemory_write, sram01_read);

    sram10_inst: SRAM generic map (32, 8)
    port map (clock, enable_row1, sram_address, lmemory_write, sram10_read);

    sram11_inst: SRAM generic map (32, 8)
    port map (clock, enable_row1, sram_address, rmemory_write, sram11_read);

    sram20_inst: SRAM generic map (32, 8)
    port map (clock, enable_row2, sram_address, lmemory_write, sram20_read);

    sram21_inst: SRAM generic map (32, 8)
    port map (clock, enable_row2, sram_address, rmemory_write, sram21_read);

    sram30_inst: SRAM generic map (32, 8)
    port map (clock, enable_row3, sram_address, lmemory_write, sram30_read);

    sram31_inst: SRAM generic map (32, 8)
    port map (clock, enable_row3, sram_address, rmemory_write, sram31_read);


end architecture;