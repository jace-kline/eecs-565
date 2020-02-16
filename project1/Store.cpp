#include "Store.h"

Store::Store() : arr() {}

Store::~Store() {
    for(int i = 0; i < 26; i++) {
        if(arr[i] != nullptr) delete arr[i];
    }
}

void Store::insert(std::string& s) {
    int i = charToInt(s.at(0));
    if(arr[i] == nullptr) arr[i] = new Node();
    arr[i]->insert(s);
}

bool Store::contains(std::string& s) {
    int i = charToInt(s.at(0));
    return(arr[i]->contains(s)); // assume nonempty for speed
}