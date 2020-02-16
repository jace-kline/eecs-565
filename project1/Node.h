#ifndef NODE_H
#define NODE_H

#include "Vigenere.h"

class Node {
    private:
        Node* children[26]; // array of length 26 to Node pointers
    public:
        Node();
        ~Node();
        void insert(std::string& s);
        bool contains(std::string& s) const;
};

#endif