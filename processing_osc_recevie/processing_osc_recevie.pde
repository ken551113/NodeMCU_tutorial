import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
NetAddress myRemoteLocation2;

int x_pos;
int y_pos;

void setup() {
  size(640, 640);
  frameRate(30);

  oscP5 = new OscP5(this, 32000);// listening to port 32000

  myRemoteLocation = new NetAddress("192.168.133.140", 12000);//ip  of the computer (the mine one!!!- change it!!! + the port where computer is listening
  myRemoteLocation2 = new NetAddress("192.168.133.138", 12000);
}

void draw() {
  background(0);
}

void mousePressed() {

  OscMessage x_myMessage = new OscMessage("/x");
  OscMessage y_myMessage = new OscMessage("/y");

  x_pos++;
  y_pos+=5;
  x_myMessage.add(x_pos); 
  y_myMessage.add(y_pos);
  oscP5.send(x_myMessage, myRemoteLocation);
  oscP5.send(x_myMessage, myRemoteLocation2);
  oscP5.send(y_myMessage, myRemoteLocation);
  oscP5.send(y_myMessage, myRemoteLocation2);
}



void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.addrPattern().equals("/x")) {
    x_pos = theOscMessage.get(0).intValue();
    println(x_pos);
  }
  if (theOscMessage.addrPattern().equals("/y")) {
    y_pos = theOscMessage.get(0).intValue();
    println(y_pos);
  }
}