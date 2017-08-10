float x=320;
float y =240;

float x_step = 5;
float y_step = 5;
float radius = 25;
float rect_width = 150;
float rect_height = 30;

boolean gameover = false;

void setup() {
  size(640, 480);
  frameRate(60);

  background(0);
  noStroke();
}

void keyPressed() {
  if (key == ' ') {
    if (gameover == true) {
      gameover = false;
    }
  }
  if (key == 'r') {
    x=320;
    y =240;
    x_step = random(-10, 10);
    y_step = random(5, 10);
  }
}

void draw() {
  if (gameover == true) {
    background(0);
    textAlign(CENTER);
    textSize(32);
    text("GameOver", width/2, height/2); 
    fill(0, 102, 153);
    x=320;
    y =240;
    x_step = random(-10, 10);
    y_step = random(5, 10);
  } else {
    background(0);
    fill(255);
    rectMode(CENTER);
    rect(mouseX, 480-15, rect_width, rect_height);
    if (x+radius>=640) {
      x_step = random(-10, -5);
    } 
    if (x-radius<=0) {
      x_step = random(5, 10);
    }
    if (y+radius>=480-rect_height) {
      if (x<mouseX+rect_width/2 && x>mouseX-rect_width/2) {
        y_step = random(-10, 5);
      }
    }
    if (y-radius<=0) {
      y_step=random(5, 10);
    }
    if (y+radius>=480) {
      gameover=true;
    }
    x+=x_step;
    y+=y_step;
    ellipse(x, y, radius*2, radius*2);
  }
}