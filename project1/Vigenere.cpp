#include "Vigenere.h"

int charToInt(char c) {
    return(c - (c >= 'A' && c <='Z' ? 'A' : 'a'));
}

char intToChar(int i) {
    return(i + 'a');
}

char encryptChar(char key, char plain) {
    return(intToChar((charToInt(plain) + charToInt(key)) % 26));
}

char decryptChar(char key, char cipher) {
    return(intToChar((charToInt(cipher) - charToInt(key)) % 26));
}

std::string encrypt(std::string key, std::string plain) {
    unsigned short cursor_key = 0;
    unsigned short cursor_plain = 0;
    std::string cipher = "";
    while(cursor_plain < plain.length()) {
        cipher.push_back(encryptChar(key.at(cursor_key), plain.at(cursor_plain)));
        cursor_key = (cursor_key + 1) % key.length();
        cursor_plain++;
    }
    return cipher;
}

std::string decrypt(std::string key, std::string cipher) {
    unsigned short cursor_key = 0;
    unsigned short cursor_cipher = 0;
    std::string plain = "";
    while(cursor_cipher < cipher.length()) {
        plain.push_back(decryptChar(key.at(cursor_key), cipher.at(cursor_cipher)));
        cursor_key = (cursor_key + 1) % key.length();
        cursor_cipher++;
    }
    return plain;
}