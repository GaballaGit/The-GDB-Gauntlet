# /bin/bash

rm *.o
rm *.out

echo "Assemble the source file assembly.asm"
nasm -f elf64 -g -o assembly.o assembly.asm

echo "Compile the source file main.c"
gcc -c -m64 -Wall -g -fno-pie -no-pie -o -std=c2x -o main.o -c main.c

echo "Link the object modules to create an executable file"
gcc -m64 -Wall -g -fno-pie -no-pie -z noexecstack -std=c2x -o assembly.out main.o assembly.o -lm -Wl,--no-as-needed

echo "Have fun!"

echo

echo "Remember to breakpoint in assembly to access the values!!!"

chmod +x assembly.out
gdb ./assembly.out

echo

echo "This bash script will now terminate."