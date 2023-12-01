library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SerialReader is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        reader_enable : in std_logic;
        reader_trigger : in std_logic;
        reader_start : in std_logic;
        reader_done : out std_logic := '0';
        reader_finish : in std_logic;
        error_out : out std_logic_vector(1 downto 0) := "00";
        reader_data_in : in std_logic_vector(7 downto 0);
        reader_data_out : out std_logic_vector(63 downto 0) := (others => '0');
        reader_data_type : out std_logic_vector(1 downto 0);
        reader_data_checkout : out std_logic
    );
end SerialReader;

architecture behavioral of SerialReader is
    component ascii2hex is
    port(
        ascii   : in std_logic_vector(7 downto 0);
        hex     : out std_logic_vector(3 downto 0)
    );
    end component ascii2hex;

    type states is (idle, start, read_kw, read_whitespace, read_mode, read_key, read_data);
    signal c_state, n_state : states;

    signal temp_data : std_logic_vector(63 downto 0) := (others => '0'); 
    signal temp_type : std_logic_vector(1 downto 0) := "00";
    signal temp_checkout : std_logic := '0';
    signal checkout_buffer : std_logic_vector(3 downto 0);
    
    signal converted_data_in : std_logic_vector(3 downto 0);

    signal done_mode, done_key, done_data : std_logic := '0';
    signal done_checkout : std_logic := '0';
    signal mode_selector : std_logic := '0';
    signal counter : std_logic_vector(3 downto 0) := "0000";

begin

    asciitohex : ascii2hex port map(reader_data_in, converted_data_in);

    reader_data_type <= temp_type;
    reader_data_out <= temp_data;

    checkout_pulse : process(clock)
    begin
        if rising_edge(clock) then
            checkout_buffer <= checkout_buffer(2 downto 0) & temp_checkout;
            if (checkout_buffer = "0000") then reader_data_checkout <= '0';
            elsif (checkout_buffer = "0001") then reader_data_checkout <= '1';
            elsif (checkout_buffer = "1111") then reader_data_checkout <= '0';
            end if;
        end if;
    end process checkout_pulse;

    next_state : process(clock)
    begin
        if (nreset = '0') then
            c_state <= idle;

        elsif rising_edge(clock) then
            if (reader_enable = '1') then
                c_state <= n_state;
            end if;
        end if;
    end process next_state;

    reader_fsm : process(reader_trigger, nreset)
        constant empty_data : std_logic_vector(63 downto 0) := (others => '0');
        variable int_counter : natural;
    begin
        int_counter := conv_integer(counter);
        if (reader_enable = '1') then

        -- only check state when triggered
        if rising_edge(reader_trigger) then

            -- finish if read a newline character
            if (reader_finish = '1') then -- ASCII newline (LF)
                
                -- trigger checkout if not empty
                if (done_checkout = '0') then temp_checkout <= '1';
                end if;

                -- check if all inputs are done
                if (done_mode = '1' or done_key = '1' or done_data = '1') then  
                    reader_done <= '1';
                else -- error if not all is done
                    error_out <= "01";
                end if;

                n_state <= idle;
            else

            case c_state is
            when idle =>
                temp_checkout <= '0';
                error_out <= "00";
                done_mode <= '0'; done_key <= '0'; done_data <='0';
                done_checkout <= '0';
                reader_done <= '0';

                n_state <= read_kw;

            when start => -- wait for "-"
                if (reader_data_in = "00101101") then -- ASCII "-"
                    n_state <= read_kw;
                elsif (reader_data_in = "00100000") then -- ASCII " "
                    n_state <= c_state;       
                else -- Send error if wrong format
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_kw => -- read type keyword
                if (reader_data_in = "01101011") then -- ASCII "k"
                    if (done_mode = '1' and done_key = '0' and done_data = '0') then -- to make sure the input is in order
                        temp_type <= "00";
                        n_state <= read_whitespace;
                    end if;
                elsif (reader_data_in = "01101101") then -- ASCII "m"
                    if (done_mode = '0' and done_key = '0' and done_data = '0') then -- to make sure the input is in order
                        temp_type <= "10";
                        n_state <= read_whitespace;
                    end if;
                elsif (reader_data_in = "01100100") then -- ASCII "d"
                    if (done_mode = '1' and done_key = '1' and done_data = '0') then -- to make sure the input is in order
                        temp_type <= "11";
                        n_state <= read_whitespace;
                    end if;
                else -- Send error if wrong format
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_whitespace => -- read whitespace (" ")
                counter <= "0000";
                if (reader_data_in = "00100000") then -- ASCII " "
                    if (temp_type = "00") then
                        n_state <= read_key;
                    elsif (temp_type = "10") then
                        n_state <= read_mode;
                    else
                        n_state <= read_data;
                    end if;
                else -- Send error if wrong format
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_mode => -- read input mode
                temp_checkout <= '1';
                done_mode <= '1';
                if (reader_data_in = "00110000") then -- ASCII "0" or "1"
                    temp_data <= empty_data(55 downto 0) & reader_data_in;
                    mode_selector <= '0';
                    n_state <= start;
                elsif (reader_data_in = "00110001") then -- ASCII "0" or "1"
                    temp_data <= empty_data(55 downto 0) & reader_data_in;
                    mode_selector <= '1';
                    n_state <= start;
                else -- Send error if wrong format
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_key => -- read input key
                counter <= counter + 1;
                if (int_counter = 0) then
                    if (reader_data_in = "00101101") then -- ASCII "-"
                        done_key <= '1';
                        n_state <= read_kw;
                    elsif (reader_data_in = "00100000") then -- ASCII " "
                        error_out <= "01";
                        n_state <= idle;
                    else
                        temp_data <= reader_data_in & empty_data(55 downto 0);
                        done_checkout <= '0';
                        temp_checkout <= '0';
                        temp_type <= "00";
                        done_key <= '1';
                    end if;
                else
                    if (reader_data_in = "00100000") then -- ASCII " "
                        if (done_checkout = '0') then temp_checkout <= '1';
                        end if;
                        done_checkout <= '1';
                        n_state <= start;
                    else
                        -- change each 8 bit data based on counter
                        if (int_counter <= 7) then
                            if (int_counter = 0) then
                                temp_data <= reader_data_in & empty_data(55 downto 0);
                                done_checkout <= '0';
                                temp_checkout <= '0';
                                temp_type <= "00";
                                done_key <= '1';
                            else
                                temp_data((64-8*int_counter-1) downto 64-8*(int_counter+1)) <= reader_data_in;
                                if (int_counter = 7) then
                                    done_checkout <= '1';
                                    temp_checkout <= '1';
                                end if;
                            end if;
                        else
                            if (int_counter = 8) then
                                temp_data <= reader_data_in & empty_data(55 downto 0);
                                done_checkout <= '0';
                                temp_checkout <= '0';
                                temp_type <= "01";
                            else
                                temp_data((64-8*(int_counter-8)-1) downto 64-8*((int_counter-8)+1)) <= reader_data_in;
                                if (int_counter = 15) then
                                    done_checkout <= '1';
                                    temp_checkout <= '1';
                                    n_state <= start;
                                end if;
                            end if;
                        end if;
                    end if;
                end if;

            when read_data => -- read input data
                counter <= counter + 1;
                temp_type <= "11";
                done_data <= '1';
                temp_checkout <= '0';

                if (mode_selector = '0') then -- encrypt mode

                    -- change each 8 bit data based on counter
                    if (int_counter = 0) then
                        done_checkout <= '0';
                        temp_data <= reader_data_in & empty_data(55 downto 0);
                    else
                        temp_data((64-8*int_counter-1) downto 64-8*(int_counter+1)) <= reader_data_in;
                        if (int_counter = 7) then
                            done_checkout <= '1';
                            temp_checkout <= '1';
                            counter <= "0000";
                        end if;
                    end if;

                else -- decrypt mode

                    -- change each 4 bit data based on counter
                    if (int_counter = 0) then
                        done_checkout <= '0';
                        temp_data <= converted_data_in & empty_data(59 downto 0);
                    else
                        temp_data((64-4*int_counter-1) downto 64-4*(int_counter+1)) <= converted_data_in;
                        if (int_counter = 15) then
                            done_checkout <= '1';
                            temp_checkout <= '1';
                            counter <= "0000";
                        end if;
                    end if;

                end if;

            when others => n_state <= idle;
            end case;
        end if;
        end if;
        end if;
    end process reader_fsm;
end behavioral;