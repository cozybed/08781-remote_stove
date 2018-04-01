#include "sortedLinkedList.h"
#include <TimeAlarms.h>

int led = D7;
int pulse = D6;
int dir = D5;
int currentAngle = 0;
String debug = "123";
uint32_t freemem = System.freeMemory();

void setup()
{
    /*
    auto *list = new LinkedList();
    for (int i = 0; i < 100; ++i)
    {
        list->add(rand() % 100);
    }
    */
    //Serial.println("Hello World!");

    pinMode(led, OUTPUT);
    pinMode(pulse, OUTPUT);
    pinMode(dir, OUTPUT);
    currentAngle = 0;

    Particle.function("pulse", pulseToggle);
    Particle.function("direction", dirToggle);
    Particle.function("turnAngleTo", turnAngleTo);
    Particle.function("newSchedule", newSchedule);

    Particle.variable("currentAngle", currentAngle);
    Particle.variable("debug", debug);
    Particle.variable("freemem", freemem);

    digitalWrite(led, LOW);
    digitalWrite(pulse, LOW);
    digitalWrite(dir, LOW);
}

void loop()
{
    Alarm.delay(100); // wait one second between clock display
}

int turnAngleTo(String command)
{
    int toAngle = command.toInt();
    int diff = toAngle - currentAngle;
    int pulseNum;
    if (diff > 0)
    {
        digitalWrite(dir, HIGH); //clockwise
        pulseNum = diff / 0.45;
    }
    else if (diff < 0)
    {
        digitalWrite(dir, LOW);
        pulseNum = -diff / 0.45;
    }
    else
        return 0;

    for (int i = 0; i < pulseNum; i++)
    {
        digitalWrite(pulse, HIGH);
        digitalWrite(led, HIGH);
        delay(10);
        digitalWrite(pulse, LOW);
        digitalWrite(led, LOW);
    }

    if (diff > 0)
        currentAngle += pulseNum * 0.45;
    else
        currentAngle -= pulseNum * 0.45;

    return currentAngle;
}

int pulseToggle(String command)
{
    if (command == "pulse")
    {
        for (int i = 0; i < 50; i++)
        {
            //one falling edge is 0.45 degree
            digitalWrite(pulse, HIGH);
            digitalWrite(led, HIGH);
            delay(10);
            digitalWrite(pulse, LOW);
            digitalWrite(led, LOW);
        }
        return 1;
    }
    else
    {
        return -1;
    }
}

int dirToggle(String command)
{
    freemem = System.freeMemory();
    if (command == "anti_clockwise")
    {
        digitalWrite(dir, LOW);
        return 1;
    }
    else if (command == "clockwise")
    {
        digitalWrite(dir, HIGH);
        return 0;
    }
    else
    {
        return -1;
    }
}

int newSchedule(String command)
{
    debug = command;
    int spacePosition = command.indexOf(' ');
    if (spacePosition > -1)
    {
        long seconds = command.substring(0, spacePosition).toInt();
        int degree = command.substring(spacePosition + 1).toInt();
    }
    else
        return -1;

    Alarm.timerOnce(3, OnceOnly);
    return 1;
}

void OnceOnly()
{
    digitalWrite(led, HIGH);
    delay(1000);
    digitalWrite(led, LOW);
    currentAngle = -1;
}
