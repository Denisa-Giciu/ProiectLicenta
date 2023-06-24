#compileaza toate fisierele vhdl
vcom *.vhd		

#incepe o simulare noua( foloseste eval deja in terminal, in caz contar o noua deschisa va fi deschisa)
eval vsim work.main

#adaugam obiectele in waveform
add wave -r /* 			

#forteaza clockul sa fie 10ns
force -freeze sim:/main/ck 1 0, 0 {5000 ps} -r 10ns