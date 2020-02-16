#include "Vigenere.h"

int charToInt(char c) {
    if(c >= 65 && c <= 90) return (int)(c - 65);
    else return((int)(c - 97));
}

char intToChar(int i) {
    return((char)(i + 97));
}

char encryptChar(char key, char plain) {
    return(intToChar((charToInt(plain) + charToInt(key)) % 26));
}

char decryptChar(char key, char cipher) {
    int i = (charToInt(cipher) - charToInt(key)) % 26;
    if(i < 0) i += 26; // Because C++ % operator can return negative numbers
    return(intToChar(i));
}

std::string encrypt(std::string key, std::string plain) {
    int key_len = key.length();
    for(int i = 0; i < plain.length(); i++) {
        plain.at(i) = encryptChar(key.at(i % key_len), plain.at(i));
    }
    return(plain);
}

std::string decrypt(std::string key, std::string cipher) {
    int key_len = key.length();
    for(int i = 0; i < cipher.length(); i++) {
        cipher.at(i) = decryptChar(key.at(i % key_len), cipher.at(i));
    }
    return(cipher);
}

std::string toLower(std::string s) {
    for(int i = 0; i < s.length(); i++) {
        s.at(i) = tolower(s.at(i));
    }
    return s;
}