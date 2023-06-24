-- memorie de instructiuni
-- contine toate instructiunile de rulat
--  Memoria este pastrata în randuri de 32 de biti pentru a reprezenta registre pe 32 de biti

-- Aceasta componenta preia o adresa de 32 de biti si returneaza instructiunea de la acea adresa

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all; -- necesar pentru citirea unui fisier

entity instruction_memory is
	port (
		read_address: in STD_LOGIC_VECTOR (31 downto 0);
		instruction, last_instr_address: out STD_LOGIC_VECTOR (31 downto 0)
	);
end instruction_memory;


architecture behavioral of instruction_memory is	  

    -- memorie de instructiuni de 128 de bytes (32 de rânduri * 4 bytes/rand)
    type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_mem: mem_array := (
        "00000000000000000000000000000000", -- initializam memoria de date
        "00000000000000000000000000000000", -- memoria 1
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000", -- memoria 10 
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",  
        "00000000000000000000000000000000", -- memoria 20
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000", -- mem 30
        "00000000000000000000000000000000"
    );

    begin

    -- procesul de citire a instructiunilor in memorie
    process 
        file file_pointer : text;
        variable line_content : string(1 to 32);
        variable line_num : line;
        variable i: integer := 0;
        variable j : integer := 0;
        variable char : character:='0'; 
    
        begin
     
        file_open(file_pointer, "instructions.txt", READ_MODE);
        -- Citirea pana la atingerea sfarsitului fisierului 
        while not endfile(file_pointer) loop
            readline(file_pointer,line_num); -- citim o linie din fisier
            READ(line_num,line_content); -- transformam sirul intr-o linie
            -- convertim fiecare caracter din sir intr-un bit si il salvamn memorie
            for j in 1 to 32 loop        
                char := line_content(j);
                if(char = '0') then
                    data_mem(i)(32-j) <= '0';
                else
                    data_mem(i)(32-j) <= '1';
                end if; 
            end loop;
            i := i + 1;
        end loop;
        if i > 0 then
            last_instr_address <= std_logic_vector(to_unsigned((i-1)*4, last_instr_address'length));
        else
            last_instr_address <= "00000000000000000000000000000000";
        end if;

        file_close(file_pointer); -- inchidem fisierul
        wait;
    end process;

    --deoarece registrele sunt in multipli de 4 bytes, putem ignora ultimii 2 biti
    instruction <= data_mem(to_integer(unsigned(read_address(31 downto 2))));

end behavioral;