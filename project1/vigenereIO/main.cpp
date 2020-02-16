#include "../Vigenere.h"
#include <iostream>

int main() {
    std::string key, s;
    int i;

    while(true) {
        while(true) {
            std::cout << "Options...\n";
            std::cout << "1. Encrypt\n";
            std::cout << "2. Decrypt\n";
            std::cout << "3. Exit Program\n";
            std::cout << "> ";
            std::cin >> i;
            if(i == 3) exit(0);
            else if(i != 1 && i != 2) std::cout << "Please input either 1 or 2.\n";
            else break;
        }
        std::cout << "Input a key:\n> ";
        std::getline(std::cin >> std::ws, key);
        std::cout << "Input a string to " << (i == 1 ? "encrypt" : "decrypt") << ":\n> ";
        std::getline(std::cin >> std::ws, s);
        key = toLower(removeSpaces(key));
        s = toLower(removeSpaces(s));
        std::cout << (i == 1 ? "Encrypted" : "Decrypted") << " message: " << (i == 1 ? encrypt(key, s) : decrypt(key, s)) << "\n\n";
    }
    return 0;
}