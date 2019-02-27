
#include <CheapStepper.h>
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif


CheapStepper stepper (0,1,2,4); 
// here we declare our stepper using default pins:
// arduino pin <--> pins on ULN2003 board:
// 8 <--> IN1
// 9 <--> IN2
// 10 <--> IN3
// 11 <--> IN4

void turnOffStepper();
boolean moveClockwise = true;

int numRotations = 3;

//Neopixel ++++++++++++++++++++++++++
// Which pin on the Arduino is connected to the NeoPixels?
// On a Trinket or Gemma we suggest changing this to 1
#define PIN            5

// How many NeoPixels are attached to the Arduino?
#define NUMPIXELS      16

// When we setup the NeoPixel library, we tell it how many pixels, and which pin to use to send signals.
// Note that for older NeoPixel strips you might need to change the third parameter--see the strandtest
// example for more information on possible values.
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

int delayval = 500; // delay for half a second

int rotSpeed = 17;
//End Neopixel defines +++++++++++++++++++++++++
void setup() {
  
  stepper.setRpm(rotSpeed);

  pixels.begin(); // This initializes the NeoPixel library.

  //setup test, move this to code after inital neopixel test run
  for(int i=0;i<NUMPIXELS;i++){

    // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
    pixels.setPixelColor(i, pixels.Color(0,150,0)); // Moderately bright green color.
  }

  stepper.newMoveTo(moveClockwise,4076);

}

void loop() {

  stepper.run();
  //DO stuff here
  //


  int stepsLeft = stepper.getStepsLeft();
  if (stepsLeft == 0){//move is done
    if(numRotations > 0) 
    { 
      delay(200);
      numRotations--;
      stepper.newMoveTo(moveClockwise,4076); //do another round in the same direction
    }
    else
    {
      // let's start a new move in the reverse direction
      delay(1000);
      numRotations = 3;
      moveClockwise = !moveClockwise; // reverse direction
      stepper.newMoveTo(moveClockwise,4076); //do another round
    }

  }
}

void turnOffStepper()
{
  for (int i=0; i<4; i++)
  {
    digitalWrite(stepper.getPin(i), 0);
  }
}