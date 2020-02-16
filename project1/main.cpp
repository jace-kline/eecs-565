#include <fstream>
#include <iostream>
#include "Vigenere.h"

void tryWord(std::ofstream& o, std::string& p, std::string& c, unsigned int key_len, unsigned int first_word_len);
void run(std::string cipher_text, unsigned int key_len, unsigned int first_word_len);

int main(int argc, char** argv) {
    // We are assuming that we receive 3 input arguments
    // ./prog <cipher_text> <key_len> <first_word_len>
    std::string cipher_text = argv[1];
    unsigned int key_len = std::stoi(argv[2]);
    unsigned int first_word_len = std::stoi(argv[3]);

    cipher_text = toLower(cipher_text);
    std::cout << "Cipher Text Input: " << cipher_text << '\n';
    std::cout << "Key length: " << key_len << '\n';
    std::cout << "First word length: " << first_word_len << '\n';
    run(cipher_text, key_len, first_word_len);
    return 0;
}

void tryWord(std::ofstream& o, std::string& p, std::string& c, unsigned int key_len, unsigned int first_word_len) {
    std::string p1 = p.substr(0,first_word_len);
    std::string p2 = p.substr(0,key_len);
    std::string c1 = c.substr(0,first_word_len);
    std::string c2 = c.substr(0,key_len);
    std::string k = decrypt(p2, c2);
    for(unsigned int i = key_len; i < first_word_len; i++) {
        if(decryptChar(p1.at(i), c1.at(i)) != k.at(i % key_len)) return;
    }
    o << "Key: " << k << "\nDecrypted Text: " << decrypt(k, c) << "\n\n";
}

void run(std::string cipher_text, unsigned int key_len, unsigned int first_word_len) {
    std::string s;
    std::ofstream os;
    os.open("out.txt");
    std::ifstream fs;
    fs.open("dict.txt");
    std::string s2;
    while(fs >> s) {
        if(s.length() == first_word_len) {
            s2 = toLower(s);
            tryWord(os, s2, cipher_text, key_len, first_word_len);
        }
    }
    fs.close();
    os.close();
 }