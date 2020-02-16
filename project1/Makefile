prog: main.o Store.o Node.o Generator.o Vigenere.o
	g++ -std=c++11 -g -Wall Store.o Node.o Generator.o Vigenere.o main.o -o prog

main.o: main.cpp Store.h Generator.h
	g++ -std=c++11 -g -Wall -c  main.cpp

Store.o: Store.h Store.cpp Node.h
	g++ -std=c++11 -g -Wall -c  Store.cpp

Node.o: Node.h Node.cpp
	g++ -std=c++11 -g -Wall -c  Node.cpp

Generator.o: Generator.h Generator.cpp Vigenere.h
	g++ -std=c++11 -g -Wall -c  Generator.cpp

Vigenere.o: Vigenere.h Vigenere.cpp
	g++ -std=c++11 -g -Wall -c  Vigenere.cpp

clean:
	rm prog *.o