#ifndef GENERATOR_H
#define GENERATOR_H

#include "Vigenere.h"

class Generator {
    private:
        int key_len;
        std::string s;
        int* counters;
        bool* flags;

    protected:
        void incrementCounter(int i);
    public:
        Generator(const int len);
        ~Generator();
        bool iterate(); // Returns true if complete with all permutations
        std::string getStr(); // Returns the member string in current state
};

#endif