library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DummyTopLevel is
	port(
		clock : in std_logic;
		nreset : in std_logic;
		data_select : in std_logic
	);
end DummyTopLevel;

architecture behavioral of DummyTopLevel is
	constant address_length : natural := 8;
	constant data_length : natural := 32;
	
	component SRAM is
	generic (data_length, address_length : integer);
    port(
        clock : in std_logic;
        enable_read, enable_write : in std_logic;
        memory_address : in std_logic_vector((address_length-1) downto 0);
        memory_write : in std_logic_vector((data_length-1) downto 0);
        memory_read : out std_logic_vector((data_length-1) downto 0)
    );
	end component SRAM;
	
	component MUX is
	generic (data_length : natural);
	port(
		selector : in std_logic;
		data_in1 : in std_logic_vector((data_length-1) downto 0);
		data_in2 : in std_logic_vector((data_length-1) downto 0);
		data_out : out std_logic_vector((data_length-1) downto 0)
	);
	end component MUX;

	signal enable_write, enable_read : std_logic := '0';
	signal memory_write, memory_read : std_logic_vector((data_length-1) downto 0);
	signal data_in1, data_in2 : std_logic_vector((data_length-1) downto 0);
	signal memory_address : std_logic_vector((address_length-1) downto 0);
	
begin
	
	memory_block1 : SRAM
	generic map(
		data_length    => data_length,
		address_length => address_length
	) 
	port map(
		clock          => clock,
		enable_write   => enable_write,
		enable_read    => enable_read,
		memory_address => memory_address,
		memory_write   => memory_write,
		memory_read    => memory_read
	);
	
	mux_inst1: MUX
	generic map (
		data_length => data_length
	)
	port map (
		selector => data_select,
		data_in1 => data_in1,
		data_in2 => data_in2,
		data_out => memory_write
	);

	memory_address <= x"BA";
	enable_write <= '1';
	data_in1 <= x"BAB12FA9";
	data_in2 <= x"ABF1A01B";

end behavioral;