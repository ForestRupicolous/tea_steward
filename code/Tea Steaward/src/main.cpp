
#include <CheapStepper.h>
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define BLACKTEATIME 180000//1000*60*3 Mins
#define DEBUGTIME 20000 //20 s 
#define BOOTLOADERDELAY 5000
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
int currentState = 0;
int stepsLeft = 0;
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

unsigned long startTime;
unsigned long teaTime;
unsigned long currentMillis;


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

  startTime = millis(); //+ BOOTLOADERDELAY; //store start Time and add 5 seconds (bootloader delay)

}

void loop() {
  stepper.run();

  currentMillis = millis();
  switch (currentState)
  {
    case 0:
      //up and wait//
      if(currentMillis - startTime > 3000)
      {
        moveClockwise = true; //go down
        numRotations = 2; 
        stepper.newMove(moveClockwise,4076);//start moving
        currentState = 1;
      }
      break;

    case 1:
      //down position reached
      if((numRotations == 1) && (stepsLeft == 0))
      {
        teaTime = currentMillis;
        currentState = 2;
      }
      break;

    case 2:
      //time to go up
      if(currentMillis - teaTime > DEBUGTIME)//tea ready
      {
        moveClockwise = false; //go up
        numRotations = 2; 
        stepper.newMove(moveClockwise,4076);//start moving
        currentState = 3;
      }
      break;

    case 3:
      //up position reached
      if((numRotations == 1) && (stepsLeft == 0))
      {
        currentState = 4;
      }
      break;

    default:
      turnOffStepper();
      break;
  }

  stepsLeft = stepper.getStepsLeft();
  if (stepsLeft == 0){//move is done
    if(numRotations > 1) 
    { 
      delay(200);
      numRotations--;
      stepper.newMove(moveClockwise,4076); //do another round in the same direction
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