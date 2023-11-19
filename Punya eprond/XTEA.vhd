library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity XTEA is
    port(
        clock, nreset : in std_logic;
        xtea_key : in std_logic_vector(127 downto 0);
        xtea_input : in std_logic_vector(63 downto 0);
        xtea_mode : in std_logic;
        xtea_start : in std_logic;
        xtea_output : out std_logic_vector(63 downto 0);
        xtea_done : out std_logic
    );
end XTEA;

architecture behavioral of XTEA is
    constant delta : std_logic_vector(31 downto 0) := x"9E3779B9";

    type subkeys is array (0 to 3) of std_logic_vector(31 downto 0);
    signal subkey : subkeys;
    signal subinput0, subinput1 : std_logic_vector(31 downto 0);
    signal sum : std_logic_vector(31 downto 0);
    signal counter : std_logic_vector(4 downto 0);

    type xtea_states is (idle, start, change_v0, change_sum, change_v1);
    signal xtea_cstate, xtea_nstate : xtea_states := idle;

    function vector_shift(mode: std_logic; vector : std_logic_vector; num : integer) return std_logic_vector is
        constant conc_vector : std_logic_vector((num-1) downto 0) := (others => '0');
    begin
        if (mode = '0') then -- shift left
            return vector((vector'length-1) downto (num-1)) & conc_vector;
        elsif (mode = '1') then -- shift right
            return conc_vector & vector((vector'length-1-num) downto 0);
        end if;
    end function;

    function xor_twov(vector1, vector2 : std_logic_vector; length : integer) return std_logic_vector is
        variable res_v : std_logic_vector((length - 1) downto 0) := (others => '0');
    begin
        for idx in length-1 downto 0 loop
            res_v(idx) := vector1(idx) xor vector2(idx);
        end loop;
        return res_v;
    end function;

begin

    process(clock, nreset)
    begin
        if rising_edge(clock) then
            if (nreset = '0') then
                xtea_cstate <= idle;
            else
                xtea_cstate <= xtea_nstate;
            end if;
        end if;
    end process;

    process(xtea_start, xtea_cstate)
    begin
        case(xtea_cstate) is
            when idle =>
                subkey(0) <= xtea_key(127 downto 96);
                subkey(1) <= xtea_key(95 downto 64);
                subkey(2) <= xtea_key(63 downto 32);
                subkey(3) <= xtea_key(31 downto 0);
                subinput0 <= xtea_input(63 downto 32);
                subinput1 <= xtea_input(31 downto 0);
                counter <= "00000";
                xtea_done <= '0';                    
                
                if (xtea_mode = '0') then
                    sum <= (others => '0');
                elsif (xtea_mode = '1') then
                    sum <= vector_shift('0', delta, 5);
                end if;

                if (xtea_start = '1') then
                    xtea_nstate <= start;
                else
                    xtea_nstate <= xtea_cstate;
                end if;

            when start =>
                if (counter = "11111") then  -- Finish if reached 32 rounds
                    xtea_output <= std_logic_vector(subinput0) & std_logic_vector(subinput1);
                    xtea_done <= '1';
                    xtea_nstate <= idle;
                else -- 
                    if (xtea_mode = '0') then
                        xtea_nstate <= change_v0;
                    elsif (xtea_mode = '1') then
                        xtea_nstate <= change_v1;
                    end if;
                end if;

            when change_v0 =>
                if (xtea_mode = '0') then
                    subinput0 <= subinput0 + xor_twov(xor_twov(vector_shift('0', subinput1, 4), vector_shift('1', subinput1, 5), 32) + subinput1, (sum + subkey(conv_integer(sum(1 downto 0) and "11"))), 32);
                    xtea_nstate <= change_sum;
                elsif (xtea_mode = '1') then
                    subinput0 <= subinput0 - xor_twov(xor_twov(vector_shift('0', subinput1, 4), vector_shift('1', subinput1, 5), 32) + subinput1, (sum + subkey(conv_integer(sum(1 downto 0) and "11"))), 32);
                    counter <= counter + 1;
                    xtea_nstate <= start;
                end if;

            when change_sum =>
                if (xtea_mode = '0') then
                    sum <= sum + delta;
                    xtea_nstate <= change_v1;
                elsif (xtea_mode = '1') then
                    sum <= sum - delta;
                    xtea_nstate <= change_v0;
                end if;

            when change_v1 =>
                if (xtea_mode = '0') then
                    subinput1 <= subinput1 + xor_twov(xor_twov(vector_shift('0', subinput0, 4), vector_shift('1', subinput0, 5), 32) + subinput0, (sum + subkey(conv_integer(vector_shift('1', sum, 11)(1 downto 0) and "11"))), 32);
                    xtea_nstate <= start;
                    counter <= counter + 1;
                elsif (xtea_mode = '1') then
                    subinput1 <= subinput1 - xor_twov(xor_twov(vector_shift('0', subinput0, 4), vector_shift('1', subinput0, 5), 32) + subinput0, (sum + subkey(conv_integer(vector_shift('1', sum, 11)(1 downto 0) and "11"))), 32);
                    xtea_nstate <= change_sum;
                end if;

            when others =>
                xtea_nstate <= idle;
        end case;
    end process;

end behavioral;

