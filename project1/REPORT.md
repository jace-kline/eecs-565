# Mini-Project 1 Report
### Jace Kline - 2881618

## Part 1 - Implementing Vigenere Cipher
The following code is my implementation of the Vigenere Cipher along with some utility functions. These are used in both my interactive program and the cracker program.
```c++
/* Vigenere.h */

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
std::string removeSpaces(std::string s);

#endif

/* Vigenere.cpp */

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

std::string removeSpaces(std::string s) {
    int i = 0;
    while(i < s.length()) {
        if(s.at(i) == ' ') s.erase(i,1);
        else i++;
    }
    return s;
}

```


## Part 2 - Implementing interactive encryption/decryption program
The following is a small program that utilizes the Vigenere cipher functions to either encrypt or decrypt a user input string where the user additionally supplies a key. All spaces are removed from both the key and the input, and all letters are coerced to their lowercase form.

```c++
/* vigenereIO/main.cpp */

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
```

## Part 3 - Vigenere Cracker
The problem is as follows: Given a ciphertext string (with vigenere encryption), a key length, and a first word length, can we efficiently crack the key to uncover the plaintext message? There are essentially two different ways to go about doing this...
1. Iterate over all of the keys in the key space and use each to perform a decryption on the given ciphertext. When a decryption of the ciphertext with the given key yields a string where the substring of (first word length) letters exists in the dictionary, then mark this as a possible key and continue. At the end, observe all of the decrypted messages from the plausible keys to determine the correct key and plaintext. This is the standard "brute-force" approach and the worst-case number of keys to iterate are 26^(key_length).
2. Since we know the length of the first word, we can work backwards to find the key by iterating only over the possible words of that given length in the dictionary. By algebraic manipulation of the Vigenere encryption function, we can derive each key character one at a time by using the Vigenere decryption function with the plaintext character as the key and the ciphertext character as the text. That is, key_character = (cipher_character - plaintext_character) mod 26. We truncate the plaintext strings and ciphertext strings to be of size key length, then we can express possible_key = decrypt(plaintext_truncated, ciphertext_truncated). For each of these possible keys, we can iterate some i over the region of indeces from key_length to first_word_length - 1 and check whether a character-wise decryption corresponds to a repeating key (i.e: decryptChar(plaintext[i], ciphertext[i]) =?= possible_key[i % key_length]). If this holds for all iterations, then we can make note of that key and the entire plaintext string that it decrypts from the original ciphertext. We repeat this process for all possible plaintexts that are of size first_word_length. This approach drastically reduces the computation time of cracking the Vigenere cipher by greatly reducing the number of items to iterate over. This is the approach that I used in the following code. It will simply do all reading of input data and writing possible key cracks without storing the entire dictionary in memory.
