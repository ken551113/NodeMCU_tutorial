import controlP5.*;

ControlP5 cp5;
int myColor = color(0, 0, 0);

int slider1 = 100;
int slider2 = 100;
int slider3 = 30;
int slider4 = 30;
Slider abc;

boolean toggle = false;
boolean toggleValue = false;

int knob = 100;
int knobValue = 100;
int col = color(255);
Knob myKnobA;
Knob myKnobB;

void setup() {
  size(700, 400);
  noStroke();
  cp5 = new ControlP5(this);

  // add a horizontal sliders, the value of this slider will be linked
  // to variable 『sliderValue'

  myKnobA = cp5.addKnob("knob")
    .setRange(0, 100)
    .setValue(50)
    .setPosition(450, 270)
    .setRadius(50)
    .setDragDirection(Knob.VERTICAL)
    ;

  myKnobB = cp5.addKnob("knobvalue")
    .setRange(0, 100)
    .setValue(50)
    .setPosition(570, 270)
    .setRadius(50)
    .setDragDirection(Knob.VERTICAL)
    ;

  cp5.addToggle("toggle")
    .setPosition(300, 300)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    ;

  cp5.addToggle("toggleValue")
    .setPosition(300, 350)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    ;

  cp5.addSlider("slider1")
    .setPosition(50, 100)
    .setRange(0, 100)
    .setSize(20, 100)
    ;

  cp5.addSlider("slider2")
    .setPosition(150, 100)
    .setSize(20, 100)
    .setRange(0, 100)

    ;

  cp5.addSlider("slider3")
    .setPosition(350, 70)
    .setSize(100, 20)
    .setRange(0, 100)
    ;

  cp5.addSlider("slider4")
    .setPosition(350, 175)
    .setSize(100, 20)
    .setRange(0, 100)
    ;
}
void draw() {
  background(myColor);

  fill(slider1);
  rect(0, 0, 100, 400);

  fill(slider2);
  rect(100, 0, 100, 400);

  fill(slider3);
  rect(200, 0, 500, 125);

  fill(slider4);
  rect(200, 125, 500, 125);
  println(knob);
}

void slider(float theColor) {
  myColor = color(theColor);
  println("a slider event. setting background to "+theColor);
}