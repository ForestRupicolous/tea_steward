#include <Arduino.h>
#include <CheapStepper.h>

CheapStepper stepper (5,6,7,1); 
// here we declare our stepper using default pins:
// arduino pin <--> pins on ULN2003 board:
// 8 <--> IN1
// 9 <--> IN2
// 10 <--> IN3
// 11 <--> IN4


boolean moveClockwise = true;


void setup() {
  
  // let's just set up a serial connection and test print to the console
  pinMode(0, OUTPUT);
}

void loop() {

  // let's move a full rotation (4096 mini-steps)
  // we'll go step-by-step using the step() function
    digitalWrite(0,HIGH); //Turn the pin HIGH (5 V)
    delay(1000);
    digitalWrite(0,LOW); //Turn the pin LOW (GND)
    delay(1000);
  for (int s=0; s<4096; s++){
    // this will loop 4096 times
    // 4096 steps = full rotation using default values
    /* Note:
     * you could alternatively use 4076 steps... 
     * if you think your 28BYJ-48 stepper's internal gear ratio is 63.68395:1 (measured) rather than 64:1 (advertised)
     * for more info, see: http://forum.arduino.cc/index.php?topic=71964.15)
     */

    // let's move one "step" (of the 4096 per full rotation)
    
    stepper.step(moveClockwise);
    /* the direction is based on moveClockwise boolean:
     * true for clockwise, false for counter-clockwise
     * -- you could also say stepper.stepCW(); or stepper.stepCCW();
     */

    // now let's get the current step position of motor
    
    int nStep = stepper.getStep();

    // and if it's divisible by 64...
      }

  // now we've moved 4096 steps
  
  // let's wait one second
  
  delay(1000);

  // and switch directions before starting loop() again
  
  moveClockwise = !moveClockwise;
}