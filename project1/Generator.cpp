#include "Generator.h"

Generator::Generator(const int len) {
    key_len = len;
    counters = new int[len];
    flags = new bool[len];
    s = "";
    for(int i = key_len - 1; i >= 0; i--) {
        counters[i] = 0;
        flags[i] = false;
        s.push_back(i);
    }
}

Generator::~Generator() {
    if(counters != nullptr) delete[] counters;
    if(flags != nullptr) delete[] flags;
}

void Generator::incrementCounter(int i) {
    counters[i] = (counters[i] + 1) % 26;
    if(counters[i] == 0) flags[i] = true;
}

bool Generator::iterate() {
    s = "";
    for(int i = key_len; i >= 0; i--) {
        flags[i] = false;
        if(i == key_len - 1) incrementCounter(i);
        else if(flags[i+1]) incrementCounter(i);
        s.push_back(intToChar(i));
    }
    return(flags[0]);
}

std::string Generator::getStr() {
    return(s);
}

