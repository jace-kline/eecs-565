#include "Node.h"

Node::Node() : children() {}

Node::~Node() {
    for(int i = 0; i < 26; i++) {
        if(children[i] != nullptr) delete children[i];
    }
}

void Node::insert(std::string& s) {
    if(s.length() == 0) return;
    else {
        short i = s.at(0);
        s.erase(0,1);
        if(children[charToInt(i)] == nullptr) children[charToInt(i)] = new Node();
        children[charToInt(i)]->insert(s);
    } 
}

bool Node::contains(std::string& s) const {
    if(s.length() == 0) return true;
    else if(children[charToInt(s.at(0))] == nullptr) return false;
    else {
        short i = s.at(0);
        s.erase(0,1);
        return(children[charToInt(i)]->contains(s));
    }  
}