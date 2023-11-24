library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SerialSender is
    generic(data_length, address_length : natural);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        sender_clock :  in std_logic;
        sender_enable : in std_logic;
        sender_start : in std_logic;
        sender_trigger : out std_logic := '1';
        sender_done : out std_logic;
        sender_data_in : in std_logic_vector((data_length-1) downto 0);
        sender_data_out : out std_logic_vector(7 downto 0)
    );
end entity SerialSender;

architecture behavioral of SerialSender is
    component PulseGenerator is
        generic(pulse_width, pulse_max : natural);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            pulse_enable : in std_logic;
            pulse_reset : in std_logic;
            pulse_out : out std_logic
        );
    end component PulseGenerator;
    signal data_counter : std_logic_vector(2 downto 0) := (others => '0');
    signal pulse_enable, pulse_reset, pulse_out : std_logic := '0';
    type states is (idle, sending);
    signal c_state, n_state : states := idle;
begin
    pulsegenerator_inst: PulseGenerator
    generic map (
      pulse_width => 10,
      pulse_max   => 16
    )
    port map (
      clock        => clock,
      nreset       => nreset,
      pulse_enable => pulse_enable,
      pulse_reset  => pulse_reset,
      pulse_out    => pulse_out
    );
    
    sender_trigger <= not pulse_out;

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

    sender_fsm : process(sender_clock)
        constant data_null : std_logic_vector(7 downto 0) := x"00";
        variable data_8bit : std_logic_vector(7 downto 0);
        variable int_counter : natural;
    begin
        int_counter := conv_integer(data_counter);
        data_8bit := sender_data_in((64-8*int_counter-1) downto 64-8*(int_counter+1));

        if (nreset = '0') then
            sender_done <= '0';
            sender_data_out <= (others => '0');
        elsif sender_clock'event and sender_clock = '1' then
            case c_state is
            when idle =>
                if (sender_start = '1') then
                    n_state <= sending;
                end if;
                data_counter <= (others => '0');
                sender_done <= '0';
            when sending =>
                if (data_8bit /= data_null) then
                    pulse_enable <= '1';
                    pulse_reset <= not pulse_reset;
                    data_counter <= data_counter + 1;
                    sender_data_out <= data_8bit;
                    if (int_counter = 7) then
                        sender_done <= '1'; n_state <= idle;
                    end if;
                else
                    sender_done <= '1';
                    n_state <= idle;
                end if;
            when others => n_state <= idle;
            end case;
        end if;
    end process sender_fsm;

end behavioral;