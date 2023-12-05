library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

entity TB_DummyTopLevel is
end entity;

architecture sim of TB_DummyTopLevel is
  constant clock_frequency : natural := 50e6;   -- 50 MHz
  constant clock_period    : time    := 1 sec / clock_frequency;
  constant baud_rate       : natural := 115200; -- 115200 bps
  constant baud_period     : time    := 1 sec / baud_rate;

  constant data_length    : natural := 64;
  constant address_length : natural := 10;
  constant string1_input  : string  := "-m 0 -k passwordku -d halo tesset olah hihi";
  constant string2_input  : string  := "-m 0 -k passwordku -d halo tes";
  constant string3_input  : string  := "-m 0 -k passwordku -d ini beda lagi loh";
  constant string4_input  : string  := "-m 0 -k passwordku -d nyoba doang";
  constant string5_input  : string  := "-m 0 -k passwordku -d hehe";
  constant string6_input  : string  := "-m 1 -k passwordku -d 60D48B909CC1ED0FE239D2A1FC635D6598347998226D92167C6782F0382D520D484D21AAB04C432E1A234163780522BD765BB9B489379F3C";

  signal enable    : std_logic                    := '1';
  signal clock     : std_logic                    := '0';
  signal nreset    : std_logic                    := '1';
  signal error_out : std_logic_vector(1 downto 0) := (others => '0');

  signal rs232_rx, rs232_tx : std_logic := '1';

  signal uart_vector1 : std_logic_vector((string1_input'length * 10 - 1) downto 0);
  signal uart_vector2 : std_logic_vector((string2_input'length * 10 - 1) downto 0);
  signal uart_vector3 : std_logic_vector((string3_input'length * 10 - 1) downto 0);
  signal uart_vector4 : std_logic_vector((string4_input'length * 10 - 1) downto 0);
  signal uart_vector5 : std_logic_vector((string5_input'length * 10 - 1) downto 0);
  signal uart_vector6 : std_logic_vector((string6_input'length * 10 - 1) downto 0);

  signal uart_tx   : std_logic := '1';
  signal bps_clock : std_logic;

  signal counter : natural := 0;

  signal keys         : std_logic_vector(3 downto 0) := "1111";
  signal switch, leds : std_logic_vector(3 downto 0);

  component ClockDiv is
    generic (div_frequency, clock_frequency : natural);
    port (
      clock_in  : in  std_logic;
      clock_out : out std_logic
    );
  end component;

  function to_rs232(str : string) return std_logic_vector is
    alias str_norm : string(str'length downto 1) is str;
    variable res_v : std_logic_vector(10 * str'length - 1 downto 0);
  begin
    for idx in str_norm'range loop
      res_v(10 * idx - 1 downto 10 * idx - 10) := '0' & std_logic_vector(to_unsigned(character'pos(str_norm(idx)), 8)) & '1';
    end loop;
    return res_v;
  end function;

begin

  dummytoplevel_inst: entity work.top
    port map (
      enable   => enable,
      clk      => clock,
      nreset   => nreset,
      rs232_rx => rs232_rx,
      rs232_tx => rs232_tx,
      keys     => keys,
      switch   => switch,
      leds     => leds
    );

  clockdiv_inst: ClockDiv
    generic map (
      div_frequency   => 2 * baud_rate,
      clock_frequency => clock_frequency
    )
    port map (
      clock_in  => clock,
      clock_out => bps_clock
    );

  clock <= not clock after clock_period / 2;

  rs232_rx     <= uart_tx;
  uart_vector1 <= to_rs232(string1_input);
  uart_vector2 <= to_rs232(string2_input);
  uart_vector3 <= to_rs232(string3_input);
  uart_vector4 <= to_rs232(string4_input);
  uart_vector5 <= to_rs232(string5_input);
  uart_vector6 <= to_rs232(string6_input);

  serial_test: process

    procedure send_tx(uart_vector : std_logic_vector) is
      variable bit10_v : std_logic_vector(9 downto 0);
    begin
      for char in uart_vector'length / 10 downto 1 loop
        bit10_v := uart_vector(10 * char - 1 downto 10 * char - 10);
        for num in 9 downto 0 loop
          if (num /= 9 and num /= 0) then
            uart_tx <= bit10_v(9 - num);
          else
            uart_tx <= bit10_v(num);
          end if;
          counter <= counter + 1;
          wait until rising_edge(bps_clock);
        end loop;
      end loop;
    end procedure;

  begin
    wait for 5 * clock_period;
    nreset <= '0';
    keys(0) <= '0';
    wait for 2 * clock_period;
    nreset <= '1';
    keys(0) <= '1';
    wait for 0.5 sec / baud_rate;

    send_tx(uart_vector1);
    wait for 15 * string1_input'length * baud_period;

    nreset <= '0';
    wait for 2 * clock_period;
    nreset <= '1';
    wait for 1 sec / baud_rate;

    send_tx(uart_vector2);
    wait for 32 * string2_input'length * baud_period;
    wait for 0.5 sec / baud_rate;

    send_tx(uart_vector3);
    wait for 32 * string3_input'length * baud_period;
    wait for 0.5 sec / baud_rate;

    send_tx(uart_vector4);
    wait for 32 * string4_input'length * baud_period;
    wait for 0.5 sec / baud_rate;

    send_tx(uart_vector5);
    wait for 32 * string5_input'length * baud_period;
    wait for 0.5 sec / baud_rate;

    send_tx(uart_vector6);
    wait for 32 * string6_input'length * baud_period;
    wait for 0.5 sec / baud_rate;

    wait;
  end process;
end architecture;
