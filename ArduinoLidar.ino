/***********************************************
 *   Arduino Lidar works with
 *   ProcessingLidar.pde program.
 *   You can connect HC-SR04
 *   Trig to 12 and Echo to 13 Arduino UNO
 *   Also connect Servo to Arduino UNO pin No. 3
 ************************************************/

#include <Ultrasonic.h>
#include <Servo.h>

Servo myServo;  // create a servo object
int mesure;
int angle;

Ultrasonic ultrasonic(12, 13);

void setup() {
  Serial.begin(9600);
  myServo.attach(3); // attaches the servo on pin 3
  myServo.write(0);
  delay(1000);
}

void loop() {
  delay(200);
  for (int i = 0; i<10; i++){
    mesure = mesure + ultrasonic.distanceRead();
    delay(10);
  }
  mesure = mesure/10;
  Serial.println(mesure);
  mesure = 0;
  angle = angle + 3;
  myServo.write(angle);
  if (angle >= 170){
    angle = 0;
    myServo.write(angle);
    Serial.println(999);
    Serial.println(999);
  }
}
