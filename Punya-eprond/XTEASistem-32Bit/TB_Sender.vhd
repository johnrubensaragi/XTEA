library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity TB_Sender is
end TB_Sender;
        
architecture sim of TB_Sender is
    constant frequency : natural := 50e6; -- 50 MHz
    constant period : time := 1 sec / frequency;
    constant data_length : natural := 64;
    constant address_length : natural := 10;
    constant text1_input : string := "Halo ini adalah hasil enkripsi  ";
    constant text2_input : string := "Ini merupakan text yang berbeda daripada sebelumnya    " & LF;
    constant text3_input : string := "Apalagi ini yang merupakan text paling berbeda. ";

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';
    signal error_out : std_logic_vector(1 downto 0) := (others => '0');

    signal serial_running, send_done, read_done : std_logic;
    signal store_data : std_logic_vector((data_length - 1) downto 0);
    signal store_datatype : std_logic_vector(1 downto 0);
    signal store_checkout : std_logic;
    signal send_data : std_logic_vector((data_length - 1) downto 0);
    signal send_start : std_logic;

    constant ROM_length : natural := 10;
    type simple_ROM is array(0 to (ROM_length-1)) of std_logic_vector((data_length-1) downto 0);
    signal memory_text1, memory_text2, memory_text3 : simple_ROM;

    signal rs232_rx, rs232_tx : std_logic := '1';

    -- signal text1_vector : std_logic_vector((8 * text1_input'length - 1) downto 0);
    -- signal text2_vector : std_logic_vector((8 * text2_input'length - 1) downto 0);
    -- signal text3_vector : std_logic_vector((8 * text3_input'length - 1) downto 0);

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

    serialblock_inst: entity work.SerialBlock
    generic map (
        data_length    => data_length,
        address_length => address_length
    )
    port map (
        clock          => clock,
        nreset         => nreset,
        serial_running => serial_running,
        read_done      => read_done,
        send_done      => send_done,
        send_start     => send_start,
        error_out      => error_out,
        send_data      => send_data,
        store_data     => store_data,
        store_datatype => store_datatype,
        store_checkout => store_checkout,
        rs232_rx       => rs232_rx,
        rs232_tx       => rs232_tx
    );

    clock <= not clock after period / 2;
    -- text1_vector <= to_slv(text1_input);
    -- text2_vector <= to_slv(text2_input);
    -- text3_vector <= to_slv(text3_input);

    fill_rom : process(clock)
        constant text1_vector : std_logic_vector((8 * text1_input'length - 1) downto 0) := to_slv(text1_input);
        constant text2_vector : std_logic_vector((8 * text2_input'length - 1) downto 0) := to_slv(text2_input);
        constant text3_vector : std_logic_vector((8 * text3_input'length - 1) downto 0) := to_slv(text3_input);
    begin
        for idx in 0 to (ROM_length-1) loop
            if (idx < text1_vector'length/64) then 
                memory_text1(idx) <= text1_vector(text1_vector'length-1-64*(idx) downto text1_vector'length-(64*(idx+1)));
            end if;
            if (idx < text2_vector'length/64) then 
                memory_text2(idx) <= text2_vector(text2_vector'length-1-64*(idx) downto text2_vector'length-(64*(idx+1)));
            end if;
            if (idx < text3_vector'length/64) then 
                memory_text3(idx) <= text3_vector(text3_vector'length-1-64*(idx) downto text3_vector'length-(64*(idx+1)));
            end if;
        end loop;
    end process;

    -- sender_test : process
    --     constant newline_vector : std_logic_vector(63 downto 0) := "00001010" & conv_std_logic_vector(0, 56);
    -- begin
    --     nreset <= '0';
    --     wait for period;
    --     nreset <= '1';

    --     for num in text1_input'range loop
    --         if (num mod 8 = 0) then
    --             send_data <= text1_vector((text1_vector'length-(64*((num/8)-1))-1) downto text1_vector'length-(64*(num/8)));
    --             send_start <= '1';
    --             wait for period;
    --             send_start <= '0';
    --             wait until rising_edge(send_done);
    --         end if;
    --     end loop;
    --     send_data <= newline_vector;
    --     send_start <= '1';
    --     wait for period;
    --     send_start <= '0';
    --     wait;
    -- end process sender_test;
end sim;