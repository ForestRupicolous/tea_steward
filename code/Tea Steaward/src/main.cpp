
#include <CheapStepper.h>
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif


CheapStepper stepper (5,6,7,3); 
// here we declare our stepper using default pins:
// arduino pin <--> pins on ULN2003 board:
// 8 <--> IN1
// 9 <--> IN2
// 10 <--> IN3
// 11 <--> IN4

boolean moveClockwise = true;

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
//End Neopixel defines +++++++++++++++++++++++++
void setup() {
  
  pixels.begin(); // This initializes the NeoPixel library.

  //setup test, move this to code after inital neopixel test run
  for(int i=0;i<NUMPIXELS;i++){

    // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
    pixels.setPixelColor(i, pixels.Color(0,150,0)); // Moderately bright green color.
  }
}

void loop() {

  // let's move a full rotation (4096 mini-steps)
  // we'll go step-by-step using the step() function
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
     }
  // now we've moved 4096 steps  
  // let's wait one second  
  delay(1000);

  // and switch directions before starting loop() again
  moveClockwise = !moveClockwise;
}