import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
NetAddress myRemoteLocation2;

int x=800*3-15, y=15;
int x_step = 5;
int y_step = 5;
int circle_width = 30;
int circle_height = 30;
int finalX;

void setup() {
  size(800, 400);
  frameRate(30);
  background(0);
  noStroke();
  oscP5 = new OscP5(this, 32000);// listening to port 32000
  myRemoteLocation = new NetAddress("192.168.133.140", 12000);//ip  of the computer (the mine one!!!- change it!!! + the port where computer is listening
  myRemoteLocation2 = new NetAddress("192.168.133.138", 12000);
}


void draw() {
  background(0);
  fill(255);
  if (x+circle_width/2>=800*3) {
    x_step = int(random(-10, -5));
  } 
  if (x-circle_width/2<=0) {
    x_step = int(random(5, 10));
  }
  if (y+circle_height/2>=400) {
    y_step = int(random(-10, -5));
  }
  if (y-circle_height/2<=0) {
    y_step=int(random(5, 10));
  }
  x+=x_step;
  y+=y_step;
  finalX=x-800*2;
  ellipse(finalX, y, circle_width, circle_height);
  OscMessage x_myMessage = new OscMessage("/x");
  OscMessage y_myMessage = new OscMessage("/y");
  x_myMessage.add(x); 
  y_myMessage.add(y);
  oscP5.send(x_myMessage, myRemoteLocation);
  oscP5.send(x_myMessage, myRemoteLocation2);
  oscP5.send(y_myMessage, myRemoteLocation);
  oscP5.send(y_myMessage, myRemoteLocation2);
}