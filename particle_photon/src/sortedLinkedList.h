#ifndef UNTITLED_SORTEDLINKEDLIST_H
#define UNTITLED_SORTEDLINKEDLIST_H

using namespace std;

class Node
{
public:
    Node *next;
    int degree;
    long time;
};


class sortedLinkedList
{
private:
    int length;
    Node *head;
public:

    sortedLinkedList();

    ~sortedLinkedList();

    void add(long time, int degree);

    bool deleteFront();

    void deleteAll();

    int getFront();

    int getLength();
};

#endif //UNTITLED_SORTEDLINKEDLIST_H
