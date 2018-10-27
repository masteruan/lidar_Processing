/*****************************
* Processing for Lidar with Arduino UNO
* and HC-SR04
* Giovanni Gentile
* October 2018
* You can read the right port
* on Processing serial console. Setting the right port.
******************************/
int xPos = 0;
int yPos = 10;
float change = 0;
int dim = 10;
int changey = 0;
float inByte;

import processing.serial.*;
Serial myPort;

  void setup() {
    size (700, 200);
    background(0);
    printArray(Serial.list());
    String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);
  }

  void serialEvent (Serial myPort) {
    String inString = myPort.readStringUntil('\n');
    if (inString != null) {
      inString = trim(inString); // trim off whitespaces.
      inByte = float(inString); // convert to a number.
      if (inByte == 999) {change = 999; inByte = 20;}
      inByte = map(inByte, 0, 170, 0, 20); //map to the screen height.
      inByte = 20 / inByte;
      if (inByte >= 20) {inByte = 20;}
      xPos += dim;
      change += dim;
    
    if (change >= width){
      yPos += dim;
      xPos = dim;
      change = 0;
      changey += 1;
    }
    if (yPos >= height){
      xPos = dim;
      yPos = dim;
      change = 0;
      changey = 0;
      background(0);
    }
      println(inByte); //print it out in the console
    }
  }

  void draw() { 
    if ( myPort.available() > 0) {  
      myPort.read();
    }
    noStroke();
    ellipse(xPos, yPos,inByte,inByte);
  }
