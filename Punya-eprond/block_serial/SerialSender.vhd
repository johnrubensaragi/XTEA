library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SerialSender is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        sender_enable : in std_logic;
        sender_start : in std_logic;
        sender_convert : in std_logic;
        sender_trigger : in std_logic;
        sender_transmit : out std_logic;
        sender_done : out std_logic;
        sender_data_in : in std_logic_vector(63 downto 0);
        sender_data_out : out std_logic_vector(7 downto 0)
    );
end entity SerialSender;

architecture behavioral of SerialSender is
    component MUX2Data is
    generic (data_length : natural);
    port (
        selector : in std_logic;
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX2Data;

    component MUX8Data is
    generic (data_length : natural);
    port (
        selector : in std_logic_vector(2 downto 0);
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_in3 : in std_logic_vector((data_length-1) downto 0);
        data_in4 : in std_logic_vector((data_length-1) downto 0);
        data_in5 : in std_logic_vector((data_length-1) downto 0);
        data_in6 : in std_logic_vector((data_length-1) downto 0);
        data_in7 : in std_logic_vector((data_length-1) downto 0);
        data_in8 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX8Data;

    component MUX16Data is
    generic (data_length : natural);
    port (
        selector : in std_logic_vector(3 downto 0);
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_in3 : in std_logic_vector((data_length-1) downto 0);
        data_in4 : in std_logic_vector((data_length-1) downto 0);
        data_in5 : in std_logic_vector((data_length-1) downto 0);
        data_in6 : in std_logic_vector((data_length-1) downto 0);
        data_in7 : in std_logic_vector((data_length-1) downto 0);
        data_in8 : in std_logic_vector((data_length-1) downto 0);
        data_in9 : in std_logic_vector((data_length-1) downto 0);
        data_in10 : in std_logic_vector((data_length-1) downto 0);
        data_in11 : in std_logic_vector((data_length-1) downto 0);
        data_in12 : in std_logic_vector((data_length-1) downto 0);
        data_in13 : in std_logic_vector((data_length-1) downto 0);
        data_in14 : in std_logic_vector((data_length-1) downto 0);
        data_in15 : in std_logic_vector((data_length-1) downto 0);
        data_in16 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX16Data;    

    component hex2ascii is
    port(
        hex     : in std_logic_vector(3 downto 0);
        ascii   : out std_logic_vector(7 downto 0)
    );
    end component hex2ascii;

    type states is (idle, sending);
    signal c_state, n_state : states := idle;

    signal convdata_selector : std_logic_vector(4 downto 0) := (others => '1');
    signal rawdata_selector : std_logic_vector(3 downto 0) := (others => '1');
    signal converted_data : std_logic_vector(127 downto 0);

    signal temp_done : std_logic;
    signal rawdata_out, convdata_out : std_logic_vector(7 downto 0);
begin

    GEN_CONVERTER : for I in 0 to 15 generate
        hextoascii : hex2ascii port map(sender_data_in(63-4*(I) downto 64-4*(I+1)), converted_data(127-8*(I) downto 128-8*(I+1)));
    end generate;

    mux_convdata : MUX16Data generic map(8) port map(convdata_selector(3 downto 0), converted_data(127-8*(0) downto 128-8*(1)), converted_data(127-8*(1) downto 128-8*(2)),
        converted_data(127-8*(2) downto 128-8*(3)), converted_data(127-8*(3) downto 128-8*(4)), converted_data(127-8*(4) downto 128-8*(5)), 
        converted_data(127-8*(5) downto 128-8*(6)), converted_data(127-8*(6) downto 128-8*(7)), converted_data(127-8*(7) downto 128-8*(8)),
        converted_data(127-8*(8) downto 128-8*(9)), converted_data(127-8*(9) downto 128-8*(10)), converted_data(127-8*(10) downto 128-8*(11)),
        converted_data(127-8*(11) downto 128-8*(12)), converted_data(127-8*(12) downto 128-8*(13)), converted_data(127-8*(13) downto 128-8*(14)),
        converted_data(127-8*(14) downto 128-8*(15)), converted_data(127-8*(15) downto 128-8*(16)), convdata_out);

    mux_rawdata : MUX8Data generic map(8) port map(rawdata_selector(2 downto 0), sender_data_in(63-8*(0) downto 64-8*(1)), sender_data_in(63-8*(1) downto 64-8*(2)),
        sender_data_in(63-8*(2) downto 64-8*(3)), sender_data_in(63-8*(3) downto 64-8*(4)), sender_data_in(63-8*(4) downto 64-8*(5)), 
        sender_data_in(63-8*(5) downto 64-8*(6)), sender_data_in(63-8*(6) downto 64-8*(7)), sender_data_in(63-8*(7) downto 64-8*(8)), rawdata_out);

    mux_dataout : MUX2Data generic map(8) port map(sender_convert, rawdata_out, convdata_out, sender_data_out);

    sender_done <= temp_done;

    change_state : process(clock)
    begin
        if (nreset = '0') then
            c_state <= idle;
        elsif rising_edge(clock) then
            if (sender_enable = '1') then
                c_state <= n_state;
            end if;
        end if;
    end process change_state;

    up_counter : process(sender_trigger)
    begin
        if rising_edge(sender_trigger) then
            if (sender_convert = '0') then
                rawdata_selector <= rawdata_selector + 1;
                convdata_selector <= (others => '1');
            else
                convdata_selector <= convdata_selector + 1;
                rawdata_selector <= (others => '1');
            end if;

            if (rawdata_selector = "1000" and sender_convert = '0') then
                rawdata_selector <= (others => '0');
            elsif (convdata_selector = "10000" and sender_convert = '1') then
                convdata_selector <= (others => '0');
            end if;
        end if;
    end process up_counter;

    sender_fsm : process(clock)
    begin
        if rising_edge(clock) then
            case c_state is
            when idle =>
                temp_done <= '0';
                if (sender_start = '1') then
                    sender_transmit <= '1';
                    n_state <= sending;
                end if;
            when sending =>
                if (sender_trigger = '1') then
                    if (rawdata_selector = "1000" and sender_convert = '0') or
                        (convdata_selector = "10000" and sender_convert = '1') then
                        temp_done <= '1';
                    else
                        temp_done <= '0';
                    end if;
                end if;
                if (temp_done = '1') then
                    sender_transmit <= '0';
                    n_state <= idle;
                else
                    n_state <= c_state;
                end if;
            when others => n_state <= idle;
            end case;
        end if;
    end process sender_fsm;

end behavioral;