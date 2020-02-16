prog: Vigenere.o main.o
	g++ -std=c++11 -g -Wall Vigenere.o main.o -o prog

main.o: main.cpp Vigenere.h
	g++ -std=c++11 -g -Wall -c  main.cpp

Vigenere.o: Vigenere.h Vigenere.cpp
	g++ -std=c++11 -g -Wall -c  Vigenere.cpp

clean:
	rm prog *.o