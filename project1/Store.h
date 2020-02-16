#ifndef STORE_H
#define STORE_H

#include "Node.h"

class Store {
    private:
        Node* arr[26];
    public:
        Store();
        ~Store();
        void insert(std::string& s);
        bool contains(std::string& s);
};

#endif