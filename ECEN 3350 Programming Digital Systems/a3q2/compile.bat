SETLOCAL

set installdir="c:\altera\13.1\nios2eds\bin\gnu\H-i686-mingw32\bin"
set scriptfile="C:/altera/13.1/University_Program/Monitor_Program/build/nios_cpp_build.ld"
set incdir="C:/altera/13.1/quartus/../nios2eds/components/altera_nios2/sdk/inc"
set incdir2="C:/altera/13.1/quartus/../nios2eds/components/altera_nios2/HAL/inc"
set projdir="C:/Users/lianne/Desktop/a3q2"



%installdir%\nios2-elf-as --gstabs -I %incdir% -I %projdir% %projdir%/sumthree.s -o %projdir%/sumthree.o 

%installdir%\nios2-elf-gcc -g -ffunction-sections -fverbose-asm -fno-inline -mhw-mul -mno-hw-div -I%incdir2% -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED -D_JTAG_UART_BASE=268439552 -Wl,--defsym -Wl,nasys_stack_top=0x800000 -Wl,--defsym -Wl,nasys_program_mem=0x0 -Wl,--defsym -Wl,nasys_data_mem=0x0 -Wl,--section-start -Wl,.exceptions=0x20 -Wl,--section-start -Wl,.reset=0x0 -Wl,--script=%scriptfile% -o %projdir%/main.elf %projdir%/main.c %projdir%/sumthree.o  

%installdir%\nios2-elf-objcopy -O srec %projdir%/main.elf %projdir%/main.srec 

%installdir%\nios2-elf-objdump.exe -D -x -S %projdir%/main.elf  > main.objdump

pause

ENDLOCAL

