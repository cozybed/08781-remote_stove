int led = D7;
int pulse = D6;
int dir = D5;


void setup() {
    pinMode(led, OUTPUT);
    pinMode(pulse, OUTPUT);
    pinMode(dir, OUTPUT);

    Particle.function("pulse", pulseToggle);
    Particle.function("diraction", dirToggle);


    digitalWrite(led, LOW);
    digitalWrite(pulse, LOW);
    digitalWrite(dir, LOW);
}

void loop() {

}

int pulseToggle(String command) {
    if (command=="pulse") {
        for (int i=0;i<400;i++){
            digitalWrite(pulse, HIGH);
            digitalWrite(led, HIGH);
            delay(10);
            digitalWrite(pulse, LOW);
            digitalWrite(led, LOW);
        }
        return 1;
    }
    else {
        return -1;
    }
}

int dirToggle(String command) {
    if (command=="anti_clockwise") {
        digitalWrite(dir, LOW);
        return 1;
    }
    else if (command=="clockwise") {
        digitalWrite(dir, HIGH);
        return 0;
    }
    else {
        return -1;
    }
}
