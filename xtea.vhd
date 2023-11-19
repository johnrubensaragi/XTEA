library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xtea is
	port
	(
		d_in_ready	: in	std_logic;
		d_in 		: in	std_logic_vector(63 downto 0);
		key  		: in	std_logic_vector(127 downto 0);
		clk			: in 	std_logic;
		mode		: in	std_logic;						--0 jika enc, 1 jika dec
		d_out		: out	std_logic_vector(63 downto 0);
		d_out_ready	: out	std_logic
	);
end xtea;



architecture arc of xtea is --u artinya unsigned
	constant zero32		: std_logic_vector(31 downto 0) := x"00000000";
	signal num_rounds 	: unsigned(7 downto 0) := to_unsigned(32, 8);
	signal delta	  	: std_logic_vector(31 downto 0) := x"9E3779B9";
	signal v1			: std_logic_vector(31 downto 0);
	signal v0			: std_logic_vector(31 downto 0);
	signal sum 			: std_logic_vector(31 downto 0);
	signal i			: unsigned(7 downto 0) := to_unsigned(32, 8);

	function sl4(signal input: in std_logic_vector) return std_logic_vector is
	begin
		return input(27 downto 0) & "0000";
	end function sl4;

	function sl5(signal input: in std_logic_vector) return std_logic_vector is
		begin
			return input(26 downto 0) & "00000";
	end function sl5;

	function sr5(signal input: in std_logic_vector) return std_logic_vector is
	begin
		return "00000" & input(31 downto 5);
	end function sr5;

	function add(a, b: std_logic_vector) return std_logic_vector is
		begin
			return std_logic_vector(unsigned(a) + unsigned(b));
	end function add;

	function sub(a, b: std_logic_vector) return std_logic_vector is
		begin
			return std_logic_vector(unsigned(a) - unsigned(b));
	end function sub;

	function ksn3(key, sum: in std_logic_vector) return std_logic_vector is
		begin
			if(sum(1 downto 0) = "00") then return key(31 downto 0);
			elsif(sum(1 downto 0) = "01") then return key(63 downto 32);
			elsif(sum(1 downto 0) = "10") then return key(95 downto 64);
			else return key(127 downto 96);
			end if;
	end function ksn3;

	function ksn311(key, sum: in std_logic_vector) return std_logic_vector is
		begin
			if(sum(12 downto 11) = "00") then return key(31 downto 0);
			elsif(sum(12 downto 11) = "01") then return key(63 downto 32);
			elsif(sum(12 downto 11) = "10") then return key(95 downto 64);
			else return key(127 downto 96);
			end if;
	end function ksn311;

	type state is (init, s0, s1);
	signal s: state := init;

begin
	process(clk)
	begin
		if(clk'event) and (clk = '1') then
			if(s = init) then
				if(d_in_ready = '1') then
					s <= s0;
					d_out_ready <= '0';
					i <= num_rounds;
					v1 <= d_in(63 downto 32);
					v0 <= d_in(31 downto 0);
					if(mode = '0') then sum <= zero32;
					else
						sum <= sl5(delta);
					end if;
				else
					s <= init;
				end if;

			elsif(s = s0) then
				s <= s1;
				i <= i - to_unsigned(1, 8);
				if(mode = '0') then
					v0  <= add(v0, add(sl4(v1) xor sr5(v1), v1) xor add(sum, ksn3(key, sum)));
					sum <= add(sum, delta);
				else
					v1  <= sub(v1, add(sl4(v0) xor sr5(v0), v0) xor add(sum, ksn311(key, sum)));
					sum <= sub(sum, delta);
				end if;

			elsif(s = s1) then
				if(mode = '0') then
					v1 <= add(v1, add(sl4(v0) xor sr5(v0), v0) xor (add(sum, ksn311(key, sum))));
				else
					v0 <= sub(v0, add(sl4(v1) xor sr5(v1), v1) xor (add(sum, ksn3(key, sum))));
				end if;

				if(i = 0) then
					d_out_ready <= '1';
					if(mode = '0') then
						d_out <= add(v1, add(sl4(v0) xor sr5(v0), v0) xor (add(sum, ksn311(key, sum)))) & v0;
					else
						d_out <= v1 & sub(v0, add(sl4(v1) xor sr5(v1), v1) xor (add(sum, ksn311(key, sum))));
					end if;
					s <= init;
				else
					s <= s0;
				end if;
			end if;
		end if;
	end process;
end arc;