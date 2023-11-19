library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity TB_Serial is
end TB_Serial;
        
architecture sim of TB_Serial is
    constant frequency : natural := 50000000;
    constant period : time := 1000 ms / frequency;
    constant data_length : natural := 64;
    constant address_length : natural := 10;
    constant text_input : string := " -m 0 -d " & '"' & "itb! KAKI LU TUH BAU BANGETTTT!!! BIKIN GAK FOKUS KULIAH BAHKAN UJIAN!!! seenggaknya ganti kaos kaki tiap hari sama rajin cuci sepatu lah, masa space tiga bangku dari lu aja masih kecium bjir????????" & '"' & " -k password";

    signal clock, reader_trigger : std_logic := '0';
    signal nreset : std_logic := '1';
    signal reader_enable : std_logic := '0';
    signal reader_start, reader_finish, reader_done : std_logic := '0';
    signal error_out : std_logic_vector(1 downto 0) := (others => '0');
    signal reader_data_in : std_logic_vector(7 downto 0) := (others => '0');
    signal reader_address_out : std_logic_vector((address_length - 1 ) downto 0);
    signal reader_data_out : std_logic_vector((data_length - 1) downto 0);

    signal serial_running, serial_done : std_logic;
    signal store_address : std_logic_vector((address_length - 1 ) downto 0);
    signal store_data : std_logic_vector((data_length - 1) downto 0);
    signal send_data : std_logic_vector((data_length - 1) downto 0);
    signal send_start : std_logic;

    signal rs232_rx, rs232_tx : std_logic := '0';

    signal text_vector : std_logic_vector((8 * text_input'length - 1) downto 0);

    function to_slv(str : string) return std_logic_vector is
        alias str_norm : string(str'length downto 1) is str;
        variable res_v : std_logic_vector(8 * str'length - 1 downto 0);
      begin
        for idx in str_norm'range loop
          res_v(8 * idx - 1 downto 8 * idx - 8) := 
            std_logic_vector(to_unsigned(character'pos(str_norm(idx)), 8));
        end loop;
        return res_v;
      end function;

begin
    serialblock_inst: entity work.SerialBlock
    generic map (
    data_length    => data_length,
    address_length => address_length
    )
    port map (
        clock          => clock,
        nreset         => nreset,
        serial_running => serial_running,
        serial_done    => serial_done,
        error_out      => error_out,
        send_data      => send_data,
        send_start     => send_start,
        store_address  => store_address,
        store_data     => store_data,
        rs232_rx       => rs232_rx,
        rs232_tx       => rs232_tx
    );
    clock <= not clock after period / 2;

    serial_test : process
    begin
        nreset <= '0';
        text_vector <= to_slv(text_input);
        wait for period;
        nreset <= '1';
        
        -- reader_start <= '1';
        -- reader_enable <= '1';

        -- for num in text_input'range loop
        --     reader_data_in <= text_vector((text_vector'length-(8*(num-1))-1) downto text_vector'length-(8*num));
        --     reader_trigger <= not reader_trigger;
        --     wait for period;
        --     reader_trigger <= not reader_trigger;
        --     wait for 69.4 us;
        -- end loop;

        -- wait for period;
        -- reader_finish <= '1';
        -- reader_start <= '0';
        
        send_data <= to_slv("aku kuat");
        send_start <= '1';
        wait for period;
        send_start <= '0';

        wait;
    end process serial_test;
end sim;