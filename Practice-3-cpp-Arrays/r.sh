#!/bin/bash

rm *.o
rm *.out

echo "Compile the source file main.cpp"
g++ -c -m64 -Wall -g -fno-pie -no-pie -std=c++2a -o main.o main.cpp

echo "Link the object modules to create an executable file"
g++ -m64 -Wall -g -fno-pie -no-pie -z noexecstack -std=c++2a -o main.out main.o -lm -Wl,--no-as-needed

echo "Have fun!"

echo

echo "Remember to breakpoint to access the values!!!"

chmod +x main.out
gdb ./main.out

echo

echo "This bash script will now terminate."
