--componenta unitate de control-decide mai multe lucruri
--reg_dest: trebuie sa foloseasca rd ca registru de destinatie
--jump: trebuie sa sara la o adresa
--branch:trebuie sa faca o ramificare de la adresa curenta
--mem_read: trebuie sa citeasca din memoria de date
--mem_to_reg: trebuie sa scrie valoarea din memoria de date intr-un registru
--mem_write: trebuie sa scrie in memoria de date
--alu_src: trebuie sa foloseasca immediate(val. imediata) ca al doilea parametru al alu
--reg_write: trebuie sa scrie intr-un registru
--alu_op: comanda de utilizat in controlul alu  
library IEEE;									  
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity control is
	port (
		opcode: in std_logic_vector(5 downto 0);
		reg_dest,jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: out std_logic;
		alu_op: out std_logic_vector(1 downto 0)
	);
end control;
architecture beh of control is
	begin
	--consecintele sintaxei vhdl
	--				           R-types				        addi				           beq                            bne                            jump                           lw                               sw
	reg_dest <= 	'1' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '0' when opcode="100011"  else '0' when opcode="101011"  else '0';
	jump <=			'0' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '1' when opcode="000010"  else '0' when opcode="100011"  else '0' when opcode="101011"  else '0';
	branch <=		'0' when opcode="000000"  else '0' when opcode="001000"  else '1' when opcode="000100"  else '1' when opcode="000101"  else '0' when opcode="000010"  else '0' when opcode="100011"  else '0' when opcode="101011"  else '0';
	mem_read <=		'0' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '1' when opcode="100011"  else '0' when opcode="101011"  else '0';
	mem_to_reg <= 	'0' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '1' when opcode="100011"  else '0' when opcode="101011"  else '0';
	mem_write <= 	'0' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '0' when opcode="100011"  else '1' when opcode="101011"  else '0';
	alu_src <= 		'0' when opcode="000000"  else '1' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '1' when opcode="100011"  else '1' when opcode="101011"  else '0';
	reg_write <= 	'1' when opcode="000000"  else '1' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '1' when opcode="100011"  else '0' when opcode="101011"  else '0';
	alu_op <= 		"10" when opcode="000000" else "00" when opcode="001000" else "01" when opcode="000100" else "11" when opcode="000101" else "00" when opcode="000010" else "00" when opcode="100011"  else "00" when opcode="101011"  else "00";
		end beh;