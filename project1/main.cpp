#include <fstream>
#include <iostream>
#include "Store.h"
#include "Generator.h"

void readDict(Store& store, std::string filename);
void run(Store& store, std::string cipher_text, const int key_len, const int first_word_len);

int main(int argc, char** argv) {
    // We are assuming that we receive 3 input arguments
    // ./prog <cipher_text> <key_len> <first_word_len>
    std::string cipher_text = argv[1];
    short key_len = argv[2][0] - '0';
    short first_word_len = argv[3][0] - '0';

    Store store;
    readDict(store, "dict.txt");
    run(store, cipher_text, key_len, first_word_len);
    return 0;
}

void readDict(Store& store, std::string filename) {
    std::string s;
    std::ifstream fs;
    fs.open(filename);
    while(fs >> s) {
        store.insert(s);
    }
    fs.close();
}

void run(Store& store, std::string cipher_text, const int key_len, const int first_word_len) {
    std::ofstream os;
    os.open("out.txt");
    Generator g = Generator(key_len);
    std::string p, fw;

    while(true) {
        p = decrypt(g.getStr(), cipher_text);
        std::cout << g.getStr() << '\n';
        fw = p.substr(0,first_word_len - 1);
        if(store.contains(fw)) os << p << '\n';
        if(g.iterate()) break;
    }

    os.close();
}