#include "Keyboard.h"
char key;
int count;
void setup() {
  Keyboard.begin();
  Serial1.begin(9600);
}

void loop() {
  if (Serial1.available()) {     // If anything comes in Serial1 (pins 0 & 1)
    key = Serial1.read();
    Keyboard.press(key); //press key that came in
    delay(35);
  }
  else{
    Keyboard.releaseAll(); //release all keys
  }
}
