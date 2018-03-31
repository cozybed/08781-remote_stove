int led = D7;
int pulse = D6;
int dir = D5;
int currentAngle = 0;

void setup()
{
    pinMode(led, OUTPUT);
    pinMode(pulse, OUTPUT);
    pinMode(dir, OUTPUT);
    currentAngle = 0;

    Particle.function("pulse", pulseToggle);
    Particle.function("diraction", dirToggle);
    Particle.function("test", testToggle);

    digitalWrite(led, LOW);
    digitalWrite(pulse, LOW);
    digitalWrite(dir, LOW);
}

void loop()
{
}

int testToggle(String command)
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
        return 1;

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
