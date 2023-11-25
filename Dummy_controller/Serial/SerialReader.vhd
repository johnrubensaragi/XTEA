library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;

entity SerialReader is
  generic (data_length, address_length : natural);
  port (
    clock                : in  std_logic;
    nreset               : in  std_logic;
    reader_enable        : in  std_logic;
    reader_trigger       : in  std_logic;
    reader_start         : in  std_logic;
    reader_done          : out std_logic                                    := '0';
    error_out            : out std_logic_vector(1 downto 0)                 := "00";
    reader_data_in       : in  std_logic_vector(7 downto 0);
    reader_data_out      : out std_logic_vector((data_length - 1) downto 0) := (others => '0');
    reader_data_type     : out std_logic_vector(1 downto 0);
    reader_data_checkout : out std_logic
  );
end entity;

architecture behavioral of SerialReader is
  type states is (idle, start, read_kw, read_whitemode, read_whitekey, read_whitedata, read_mode, read_key, read_startdata, read_data);
  signal c_state, n_state : states;

  signal temp_data                      : std_logic_vector((data_length - 1) downto 0) := (others => '0');
  signal temp_type                      : std_logic_vector(1 downto 0)                 := "00";
  signal temp_checkout                  : std_logic                                    := '0';
  signal done_mode, done_key, done_data : std_logic                                    := '0';
  signal counter                        : std_logic_vector(3 downto 0)                 := "0000";

begin

  reader_data_checkout <= temp_checkout;
  reader_data_type     <= temp_type;
  reader_data_out      <= temp_data;

  next_state: process (clock)
  begin
    if (nreset = '0') then
      c_state <= idle;

    elsif rising_edge(clock) then
      if (reader_enable = '1') then
        c_state <= n_state;
      end if;
    end if;
  end process;

  reader_fsm: process (reader_trigger, nreset)
    constant default_key : std_logic_vector(127 downto 0)               := x"6c7bd673045e9d5c29ac6c25db7a3191";
    constant empty_data  : std_logic_vector((data_length - 1) downto 0) := x"0000000000000000";
    variable int_counter : natural;
  begin
    int_counter := conv_integer(counter);
    if (nreset = '0') then
      reader_done <= '0';
      temp_checkout <= '0';
      temp_data <= (others => '0');
      error_out <= "00";
      done_mode <= '0';
      done_key <= '0';
      done_data <= '0';

    elsif (reader_enable = '1') then

      -- only check state when triggered
      if rising_edge(reader_trigger) then

        -- finish if read a newline character
        if (reader_data_in = "00001010") then -- ASCII newline (LF)

          -- trigger checkout if not empty
          if (temp_data /= empty_data) then
            temp_checkout <= not temp_checkout;
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
              -- only start if it is started
              if (reader_start = '1') then
                n_state <= read_kw;
              end if;

              reader_done <= '0';

            when start => -- wait for "-"
              if (reader_data_in = "00101101") then -- ASCII "-"
                n_state <= read_kw;
              elsif (reader_data_in = "00100000") then -- ASCII " "
                n_state <= c_state;
              else
                error_out <= "01";
                n_state <= idle;
              end if;

            when read_kw => -- read type keyword
              if (reader_data_in = "01101101" and done_mode /= '1') then -- ASCII "m"
                n_state <= read_whitemode;
              elsif (reader_data_in = "01101011" and done_key /= '1') then -- ASCII "k"
                n_state <= read_whitekey;
              elsif (reader_data_in = "01100100" and done_data /= '1') then -- ASCII "d"
                n_state <= read_whitedata;
              else -- Send error if wrong format
                error_out <= "01";
                n_state <= idle;
              end if;

            when read_whitemode => -- read whitespace
              if (reader_data_in = "00100000") then -- ASCII " "
                counter <= "0000";
                n_state <= read_mode;
              else -- Send error if wrong format
                error_out <= "01";
                n_state <= idle;
              end if;

            when read_whitekey => -- read whitespace
              if (reader_data_in = "00100000") then -- ASCII " "
                counter <= "0000";
                n_state <= read_key;
              else -- Send error if wrong format
                error_out <= "01";
                n_state <= idle;
              end if;

            when read_whitedata => -- read whitespace
              if (reader_data_in = "00100000") then -- ASCII " "
                n_state <= read_startdata;
              else -- Send error if wrong format
                error_out <= "01";
                n_state <= idle;
              end if;

            when read_mode => -- read input mode
              if (reader_data_in = "00110000" or reader_data_in = "00110001") then -- ASCII "0" or "1"
                temp_data <= empty_data((data_length - 1) downto 8) & reader_data_in;
                temp_checkout <= not temp_checkout;
                temp_type <= "10";
                done_mode <= '1';
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
                  temp_data <= reader_data_in & default_key(119 downto 64);
                  temp_type <= "00";
                  done_key <= '1';
                end if;
              else
                if (reader_data_in = "00100000") then -- ASCII " "
                  temp_checkout <= not temp_checkout;
                  n_state <= start;
                else
                  -- change each 8 bit data based on counter
                  if (int_counter <= 7) then
                    if (int_counter = 0) then
                      temp_data <= reader_data_in & default_key(119 downto 64);
                    else
                      temp_data((64 - 8 * int_counter - 1) downto 64 - 8 *(int_counter + 1)) <= reader_data_in;
                      if (int_counter = 7) then
                        temp_checkout <= not temp_checkout;
                      end if;
                    end if;
                  else
                    if (int_counter = 8) then
                      temp_data <= reader_data_in & default_key(55 downto 0);
                      temp_type <= "01";
                    else
                      temp_data((64 - 8 *(int_counter - 8) - 1) downto 64 - 8 *((int_counter - 8) + 1)) <= reader_data_in;
                      if (int_counter = 15) then
                        temp_checkout <= not temp_checkout;
                        n_state <= start;
                      end if;
                    end if;
                  end if;
                end if;
              end if;

            when read_startdata => -- read start data keyword (")
              if (reader_data_in = "00100010") then -- ASCII (")
                counter <= "0000";
                n_state <= read_data;
              else
                error_out <= "01";
                n_state <= idle;
              end if;

            when read_data => -- read input data
              counter <= counter + 1;
              if (reader_data_in = "00100010") then -- ASCII (")
                temp_checkout <= not temp_checkout;
                temp_type <= "11";
                done_data <= '1';
                n_state <= start;
              else
                -- change each 8 bit data based on counter
                if (int_counter = 0) then
                  temp_data <= reader_data_in & empty_data(55 downto 0);
                  temp_type <= "11";
                else
                  temp_data((64 - 8 * int_counter - 1) downto 64 - 8 *(int_counter + 1)) <= reader_data_in;
                  if (int_counter = 7) then
                    temp_checkout <= not temp_checkout;
                    counter <= "0000";
                  end if;
                end if;
              end if;

            when others => n_state <= idle;
          end case;
        end if;
      end if;
    end if;
  end process;
end architecture;
