import oscP5.*;
import netP5.*;
import controlP5.*;

// OSC
OscP5 oscP5;
ControlP5 cp5;
NetAddress NodeMCULocation;
String HOST = "192.168.0.11";  //nodemcu's IP
int HOST_PORT = 8000;          //port for Ground_Control Computer 
int LOCAL_PORT = 9000;         //port for my incoming port 

int slider = 0;
int preSlider;
boolean toggle = false;
boolean preToggle;

void setup() {
  size(200, 200);
  cp5 = new ControlP5(this);
  cp5.addToggle("toggle")
    .setPosition(100, 100)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    ;
  cp5.addSlider("slider")
    .setPosition(50, 50)
    .setRange(0, 255)
    .setSize(20, 100)
    ;
  // OSC SETUP
  oscP5 = new OscP5(this, LOCAL_PORT);
  NodeMCULocation = new NetAddress(HOST, HOST_PORT);
}

void draw() {
  background(0);
  if (preToggle!=toggle) {
    if (toggle == true) {
      sendControlInt("/led", 1);
    } else {
      sendControlInt("/led", 0);
    }
  }
  if (preSlider!=slider) {
    sendControlInt("/analogLed", slider);
  }
  preSlider = slider;
  preToggle = toggle;
}

void sendControlInt(String tag, int val) {
  OscMessage myOscMessage = new OscMessage(tag);
  myOscMessage.add(val);                            
  oscP5.send(myOscMessage, NodeMCULocation);
  print(tag+",");
  println(val);
}