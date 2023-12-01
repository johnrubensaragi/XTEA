library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Controller is
  port (
    -- main clock and reset
    clock : in std_logic;
    nreset : in std_logic;
    enable : in std_logic;
    leds : out std_logic_vector(3 downto 0);

    -- serial block port
    reader_running, sender_running : in std_logic;
    read_done, send_done : in std_logic;
    store_datatype : in std_logic_vector(1 downto 0);
    error_type : in std_logic_vector(1 downto 0);

    -- address countup port
    store_checkout : in std_logic;
    force_enable : out std_logic;
    force_address : out std_logic_vector(1 downto 0);
    address_atmax : in std_logic;
    maxadd_enable : out std_logic;

    -- memory block port
    enable_write : out std_logic;

    -- xtea block port
    xtea_done : in std_logic;

    -- mux and demux selectors
    selector_datawrite : out std_logic;
    selector_dataread, selector_datasend : out std_logic;
    selector_dataxtea, selector_datatext : out std_logic_vector(1 downto 0);
    selector_dataidentifier : out std_logic;

    -- pulse generator port
    sender_pulse_enable, sender_pulse_trigger : out std_logic;
    xtea_pulse_enable, xtea_pulse_trigger : out std_logic;
    countup_pulse_trigger : out std_logic;

    -- clock counter port
    ccounter_enable, ccounter_reset : out std_logic;
    ccounter_out : in natural range 0 to 15;

    -- text roms port
    rom_index_counter : out natural range 0 to 7

  );
end Controller;

architecture behavioral of Controller is
    
    -- internal triggers
    signal i_ccounter_reset, i_countup_trigger : std_logic := '0';
    signal i_xpulse_trigger, i_spulse_trigger : std_logic := '0';

    -- buffers
    signal store_datatype_buffer : std_logic_vector(1 downto 0);
    signal send_done_buffer, xtea_done_buffer : std_logic;
    signal store_checkout_buffer1, store_checkout_buffer2 : std_logic;
    signal store_checkout_buffer3, store_checkout_buffer4 : std_logic;

    -- for texts sending
    signal max_textrom_index : natural range 0 to 7;
    signal send_counter : natural range 0 to 7;

    type states is (idle, reading_serial, sending_message, setup_xtea1, setup_xtea2, setup_xtea3, starting_xtea,
                    processing_xtea, storing_xtea, reading_results, sending_results);
    signal controller_cstate, controller_nstate : states;
 
    function to_slv(str : string) return std_logic_vector is
        alias str_norm : string(str'length downto 1) is str;
        variable res_v : std_logic_vector(8 * str'length - 1 downto 0);
    begin
        for idx in str_norm'range loop
          res_v(8 * idx - 1 downto 8 * idx - 8) := 
            std_logic_vector(conv_unsigned(character'pos(str_norm(idx)), 8));
        end loop;
        return res_v;
    end function;

begin
    countup_pulse_trigger <= i_countup_trigger;
    ccounter_reset <= i_ccounter_reset;
    xtea_pulse_trigger <= i_xpulse_trigger;
    sender_pulse_trigger <= i_spulse_trigger;

    rom_index_counter <= send_counter;

    change_state: process(clock)
    begin
        if (nreset = '0') then
            controller_cstate <= idle;
        elsif rising_edge(clock) then
            controller_cstate <= controller_nstate;
        end if;
    end process change_state;

    fsm_controller : process(clock)
        constant results_text : string := "System results from processing XTEA:   " & LF;
        constant error_text1 : string := "Error type 1: System cannot recognize input format     " & LF;
        constant error_text2 : string := "Error type 2: Storage system exceeded  " & LF;
        constant error_text3 : string := "Error type 3: System is still busy     " & LF;
    begin
        if rising_edge(clock) and (enable = '1') then

        if (controller_cstate = idle) then leds <= "1110";
        elsif (controller_cstate = reading_serial) then leds <= "1101";
        elsif (controller_cstate = processing_xtea) then leds <= "1011";
        elsif (controller_cstate = sending_results) then leds <= "0111";
        else leds <= "1111";
        end if;

        case controller_cstate is
        when idle =>

            -- initialization
            sender_pulse_enable <= '0';
            xtea_pulse_enable <= '0';
            i_ccounter_reset <= '0';
            i_countup_trigger <= '0';
            i_xpulse_trigger <= '0';
            i_spulse_trigger <= '0';
            enable_write <= '0';
            send_counter <= 0;

            -- dont start if error
            if (error_type /= "01" and error_type /= "10") then
                if (reader_running = '1') then
                    controller_nstate <= reading_serial;
                else
                    controller_nstate <= controller_cstate;
                end if;
            end if;

        when reading_serial =>
            selector_datawrite <= '0'; -- select serial output as memory write
            maxadd_enable <= '1';
            force_address <= store_datatype;

            -- buffers for timing synchronization
            store_datatype_buffer <= store_datatype;
            store_checkout_buffer1 <= store_checkout;
            store_checkout_buffer2 <= store_checkout_buffer1;
            store_checkout_buffer3 <= store_checkout_buffer2;
            store_checkout_buffer4 <= store_checkout_buffer3;

            if (store_checkout_buffer4 = '1') then enable_write <= '1';
            else enable_write <= '0';
            end if;

            if (store_checkout = '1') then
                if (store_datatype_buffer /= store_datatype) then
                    force_enable <= '1';
                else
                    force_enable <= '0';
                end if;
            end if;

            -- only count up trigger if data type doesnt change
            if (store_checkout_buffer2 = '0' and store_checkout_buffer1 = '1' and store_datatype_buffer = store_datatype) then
                i_countup_trigger <= not i_countup_trigger;
            end if;

            -- start send error if error
            if (error_type = "01" or error_type = "10") then
                controller_nstate <= sending_message;
                enable_write <= '0';

            -- wait until reading is done
            elsif (read_done = '1') then
                maxadd_enable <= '0';
                controller_nstate <= setup_xtea1;
            else
                controller_nstate <= controller_cstate;
            end if;

        when sending_message => -- send messages based on error types
            selector_dataidentifier <= '0'; -- dont send newline character
            selector_dataread <= '1'; -- connect memory read to sender
            selector_datasend <= '1'; -- send data from text roms

            sender_pulse_enable <= '1';
            send_done_buffer <= send_done;
            
            -- if not error = send results message
            if (error_type = "00") then
                selector_datatext <= "00"; -- send text results
                max_textrom_index <= results_text'length/8;
            
            -- if error = send error messages
            elsif (error_type = "01") then 
                selector_datatext <= "01"; -- send error message for wrong format
                max_textrom_index <= error_text1'length/8;
            elsif (error_type = "10") then
                selector_datatext <= "10"; -- send error message for max storage exceeded
                max_textrom_index <= error_text2'length/8;
            elsif (error_type = "11") then
                selector_datatext <= "11"; -- send error message for system still busy
                max_textrom_index <= error_text3'length/8;
            end if;

            if (send_counter = 0) then -- jump start the sending
                i_spulse_trigger <= not i_spulse_trigger;
                send_counter <= send_counter + 1;
            end if;

            if (send_done_buffer = '0' and send_done = '1') then
                if (send_counter < max_textrom_index) then
                    i_spulse_trigger <= not i_spulse_trigger;
                    send_counter <= send_counter + 1;
                else
                    if (error_type = "00") then controller_nstate <= reading_results;
                    else controller_nstate <= idle;
                    end if;
                end if;
            end if;

        when setup_xtea1 => -- setup xtea mode
            selector_dataread <= '0'; -- select memory read to xtea inputs
            selector_dataxtea <= "00"; -- select memory read to xtea leftkey input
            force_address <= "00"; -- force address to 00 to start setting up xtea
            force_enable <= '1';
            ccounter_enable <= '1';

            -- wait for 5 clock cycles before next state
            if (ccounter_out >= 5) then
                i_countup_trigger <= not i_countup_trigger; -- count up address
                i_ccounter_reset <= not i_ccounter_reset;
                force_enable <= '0';
                ccounter_enable <= '0';
                controller_nstate <= setup_xtea2;
            end if;

        when setup_xtea2 => -- setup xtea key
            selector_dataread <= '0'; -- select memory read to xtea inputs
            selector_dataxtea <= "01"; -- select memory read to xtea rightkey input
            force_enable <= '0';
            ccounter_enable <= '1';

            -- wait for 5 clock cycles before next state
            if (ccounter_out >= 5) then
                i_countup_trigger <= not i_countup_trigger; -- count up address
                i_ccounter_reset <= not i_ccounter_reset;
                ccounter_enable <= '0';
                controller_nstate <= setup_xtea3;
            end if;

        when setup_xtea3 => -- setup xtea key
            selector_dataread <= '0'; -- select memory read to xtea inputs
            selector_dataxtea <= "10"; -- select memory read to xtea mode input
            force_enable <= '0';
            ccounter_enable <= '1';

            -- wait for 5 clock cycles before next state
            if (ccounter_out >= 5) then
                i_countup_trigger <= not i_countup_trigger; -- count up address
                i_ccounter_reset <= not i_ccounter_reset;
                ccounter_enable <= '0';
                controller_nstate <= starting_xtea;
            end if;

        when starting_xtea => -- read xtea input
            if (address_atmax /= '1') then
                selector_dataread <= '0'; -- select memory read to xtea inputs
                selector_dataxtea <= "11"; -- select memory read to xtea data input
                force_enable <= '0';
                ccounter_enable <= '1';

                -- trigger the pulse to start the xtea
                if (ccounter_out = 5) then
                    xtea_pulse_enable <= '1';
                    i_xpulse_trigger <= not i_xpulse_trigger;
                end if;

                -- wait for 5 clock cycles before next state
                if (ccounter_out >= 5) then
                    i_ccounter_reset <= not i_ccounter_reset;
                    ccounter_enable <= '0';
                    controller_nstate <= processing_xtea;
                end if;
            else
                force_enable <= '1';
                force_address <= "11"; -- force address to 11 to start reading results
                i_ccounter_reset <= not i_ccounter_reset;
                ccounter_enable <= '0';
                controller_nstate <= sending_message;
            end if;

        when processing_xtea => -- process encrypt/decrypt
            xtea_done_buffer <= xtea_done;
            if (xtea_done_buffer = '0' and xtea_done = '1') then
                controller_nstate <= storing_xtea;
            end if;

        when storing_xtea => -- store xtea output
            selector_dataread <= '1'; -- make sure to not connect memory read with xtea input
            selector_datawrite <= '1'; -- select xtea output as memory write
            ccounter_enable <= '1';
            enable_write <= '1';

            -- count up the address
            if (ccounter_out = 5) then
                i_countup_trigger <= not i_countup_trigger;
            end if;

            -- wait for 5 clock cycles before next state
            if (ccounter_out >= 5) then
                i_countup_trigger <= not i_countup_trigger;
                i_ccounter_reset <= not i_ccounter_reset;
                ccounter_enable <= '0';
                enable_write <= '0';
                controller_nstate <= starting_xtea;
            end if;

        when reading_results => -- read each results
            if (address_atmax /= '1') then
                selector_dataidentifier <= '0'; -- dont send newline character yet
                selector_dataread <= '1'; -- select memory read to sender
                selector_datasend <= '0'; -- select sender input as from memory
                force_enable <= '0';
                ccounter_enable <= '1';

                -- trigger the pulse to start the sending
                if (ccounter_out = 5) then
                    sender_pulse_enable <= '1';
                    i_spulse_trigger <= not i_spulse_trigger;
                end if;

                -- wait for 5 clock cycles before next state
                if (ccounter_out >= 5) then
                    i_ccounter_reset <= not i_ccounter_reset;
                    ccounter_enable <= '0';
                    controller_nstate <= sending_results;
                end if;
            else
                selector_dataidentifier <= '1'; -- send newline character
                if (ccounter_out = 5) then
                    sender_pulse_enable <= '1';
                    i_spulse_trigger <= not i_spulse_trigger;
                end if;

                -- wait for 15 clock cycles before next state
                if (ccounter_out >= 15) then
                    i_ccounter_reset <= not i_ccounter_reset;
                    ccounter_enable <= '0';
                    controller_nstate <= idle;
                end if;
            end if;

        when sending_results => -- send each results through serial
            send_done_buffer <= send_done;
            if (send_done_buffer = '0' and send_done = '1') then
                i_countup_trigger <= not i_countup_trigger;
                controller_nstate <= reading_results;
            end if;

        when others =>

        end case;
        end if;

    end process fsm_controller;

end behavioral;
