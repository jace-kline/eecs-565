#ifndef VIGENERE_H
#define VIGENERE_H

#include <string>

int charToInt(char c);
char intToChar(int i);
char encryptChar(char key, char plain);
char decryptChar(char key, char cipher);
std::string encrypt(std::string key, std::string plain);
std::string decrypt(std::string key, std::string cipher);
std::string toLower(std::string s);

#endif