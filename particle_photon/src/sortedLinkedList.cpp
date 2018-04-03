#include "sortedLinkedList.h"

sortedLinkedList::sortedLinkedList()
{
    this->length = 0;
    this->head = nullptr;
}

void sortedLinkedList::add(long time, int degree)
{
    Node *prev = nullptr;
    Node *p = this->head;

    auto *node = new Node();
    node->time = time;
    node->degree = degree;
    this->length++;

    if (p == nullptr) //this is a empty list
    {
        this->head = node;
        this->head->next = nullptr;
        return;
    }

    while (p != nullptr)
    {
        if (time > p->time)
        {
            prev = p;
            p = p->next;
        }
        else
        {
            break;
        }
    }

    if (prev == nullptr) //insert before head
    {
        node->next = this->head;
        this->head = node;
    }
    else
    {
        node->next = prev->next;
        prev->next = node;
    }
}

void sortedLinkedList::deleteFront()
{
    if (this->head != nullptr)
    {
        auto *temp = this->head;
        this->head = this->head->next;
        delete temp;
        this->length--;
    }
}

int sortedLinkedList::getFront()
{
  if (this->head == nullptr)
      return -1;
  else
      return this->head->degree;
}

int sortedLinkedList::getLength()
{
    return this->length;
}
