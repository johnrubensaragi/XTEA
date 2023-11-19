library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SerialSender is
    generic(data_length, address_length : natural);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        serial_clock :  in bit;
        sender_enable : in std_logic;
        sender_start : in std_logic;
        sender_trigger : out std_logic;
        sender_done : out std_logic;
        sender_data_in : in std_logic_vector((data_length-1) downto 0);
        sender_data_out : out std_logic_vector(7 downto 0)
    );
end entity SerialSender;

architecture behavioral of SerialSender is
    signal data_counter : std_logic_vector(2 downto 0) := (others => '0');
    type states is (idle, sending);
    signal c_state, n_state : states := idle;
begin
    next_state : process(clock)
    begin
        if (nreset = '0') then
            c_state <= idle;
        elsif rising_edge(clock) then
            if (sender_enable = '1') then
                c_state <= n_state;
            end if;
        end if;
    end process next_state;

    sender_fsm : process(serial_clock)
    begin
        if rising_edge(serial_clock) then
            case c_state is
                when idle =>
                    if (sender_start = '1') then
                        n_state <= sending;
                    end if;
                    sender_done <= '0';
                when sending =>
                    sender_trigger <= '0';
                    data_counter <= data_counter + 1;
                    case data_counter is
                        when "000" => sender_data_out <= sender_data_in(63 downto 56);
                        when "001" => sender_data_out <= sender_data_in(55 downto 48);
                        when "010" => sender_data_out <= sender_data_in(47 downto 40);
                        when "011" => sender_data_out <= sender_data_in(39 downto 32);
                        when "100" => sender_data_out <= sender_data_in(31 downto 24);
                        when "101" => sender_data_out <= sender_data_in(23 downto 16);
                        when "110" => sender_data_out <= sender_data_in(15 downto 8);
                        when "111" =>
                            sender_data_out <= sender_data_in(7 downto 0);
                            sender_done <= '1';
                            n_state <= idle;
                        when others =>
                    end case;
                when others => n_state <= idle;
            end case;
        end if;
    end process sender_fsm;

end behavioral;