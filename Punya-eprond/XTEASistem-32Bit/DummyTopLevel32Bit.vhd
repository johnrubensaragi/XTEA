library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DummyTopLevel32Bit is
	port(
		clock : in std_logic;
		nreset : in std_logic;
		data_select : in std_logic
	);
end DummyTopLevel32Bit;

architecture behavioral of DummyTopLevel32Bit is
	constant address_length : natural := 10;
	constant data_length : natural := 64;

	component MemoryBlock is
    port(
        clock : in std_logic;
        enable_write : in std_logic;
        memory_address : in std_logic_vector((address_length - 1) downto 0);
        memory_write : in std_logic_vector((data_length - 1) downto 0);
        memory_read : out std_logic_vector((data_length - 1) downto 0)
    );
	end component MemoryBlock;

	component MUX2Data is
	generic (data_length : natural);
	port(
		selector : in std_logic;
		data_in1 : in std_logic_vector((data_length-1) downto 0);
		data_in2 : in std_logic_vector((data_length-1) downto 0);
		data_out : out std_logic_vector((data_length-1) downto 0)
	);
	end component MUX2Data;

	signal enable_write : std_logic := '0';
	signal memory_write, memory_read : std_logic_vector((data_length-1) downto 0);
	signal data_in1, data_in2 : std_logic_vector((data_length-1) downto 0);
	signal memory_address : std_logic_vector((address_length-1) downto 0);

begin
	
	memoryblock_inst: MemoryBlock
	port map (
		clock          => clock,
		enable_write   => enable_write,
		memory_address => memory_address,
		memory_write   => memory_write,
		memory_read    => memory_read
	);

	mux_inst1: MUX2Data generic map(data_length)
	port map (
		selector => data_select,
		data_in1 => data_in1,
		data_in2 => data_in2,
		data_out => memory_write
	);

	memory_address <= x"BA" & "10";
	enable_write <= '1';
	data_in1 <= x"BAB12FA9ABF1A01B";
	data_in2 <= x"ABF1A01BBAB12FA9";

end behavioral;