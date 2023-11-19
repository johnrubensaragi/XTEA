library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Testbench is
end Testbench;
        
architecture sim of Testbench is
    constant frequency : natural := 500000000;
    constant period : time := 1000 ms / frequency;
    constant data_length : natural := 64;
    constant address_length : natural := 10;
    constant text_input : string := "-m 0 -d " & '"' & "Praktikum kali ini melibatkan berbagai percobaan terkait beberapa rangkaian sekuensial, yaitu sistem lampu merah serta sistem kalkulator dua fungsi. Terdapat empat percobaan yang berhasil dilakukan pada praktikum ini, yaitu percobaan pertama terkait desain sistem lampu merah berdasarkan spesifikasi, percobaan kedua terkait pengujian modul VGA, percobaan ketiga terkait penggabungan sistem lampu merah dengan modul VGA, serta percobaan keempat terkait desain sistem kalkulator penghitung FPB dan modulo dari dua angka. Hasil dari ketiga percobaan pertama membuktikan bahwa sistem lampu merah dengan tiga mode dapat diimplementasikan melalui FSM dengan jumlah state sebanyak 6 state. Sistem ini kemudian dapat digabungkan dengan modul VGA agar proses lampu merah dapat ditampilkan pada monitor LCD. Selain itu, percobaan terakhir membuktikan bahwa kalkulator pendekatan sekuensial dapat digunakan untuk melakukan perhitungan faktor persekutuan terbesar (FPB) serta modulo dari dua bilangan. Hasil desain FSM untuk kedua fungsi ini memiliki jumlah state sebanyak 7 state untuk perhitungan FPB dan sebanyak 5 state untuk perhitungan modulo. Pengujian melalui berbagai variasi input juga menunjukkan bahwa sistem ini dapat memerlukan waktu yang berbeda-beda untuk mendapatkan hasil perhitungan. Kecepatan perhitungan untuk kedua fungsi ini didasarkan kepada jumlah pengurangan yang harus dilakukan sistem. Jika sistem melibatkan dua bilangan yang perbedaannya sangat besar, sistem akan memerlukan waktu yang lama karena perlu dilakukan pengurangan satu per satu. Sedangkan, jika perbedaan kedua bilangan hanya melibatkan satu pengurangan, hasil perhitungan sistem akan lebih cepat didapatkan. Alhasil, seluruh percobaan pada praktikum ini membuktikan bahwa rangkaian sekuensial dapat digunakan untuk memodelkan berbagai sistem yang sering ditemukan, seperti sistem lampu merah serta kalkulator sekuensial." & '"' & " -k passwordmantap";
    
    component TopLevelSistem is
        port(
            clock : in std_logic;
            nreset : inout std_logic;
            read_input : in std_logic_vector(7 downto 0);
            start_read, trigger : in std_logic
        );
    end component TopLevelSistem;

    signal clock, trigger : std_logic := '0';
    signal nreset : std_logic := '1';
    signal start_read : std_logic;
    signal read_input : std_logic_vector(7 downto 0) := (others => '0');
    
    signal text_vector : std_logic_vector((8 * text_input'length - 1) downto 0);

    signal check_address : std_logic_vector((address_length - 1) downto 0);
    signal check_data : std_logic_vector((data_length - 1) downto 0);

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
    dut : TopLevelSistem port map(clock, nreset, read_input, start_read, trigger);

    clock <= not clock after period / 2;

    testbench : process
    begin
        text_vector <= to_slv(text_input);
        start_read <= '1';
        trigger <= not trigger;
        wait for period/2;
        
        for num in text_input'range loop
            read_input <= text_vector((text_vector'length-(8*(num-1))-1) downto text_vector'length-(8*num));
            trigger <= not trigger;
            wait for period;
        end loop;

        start_read <= '0';
        wait;
    end process testbench;
end sim;