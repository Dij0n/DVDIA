PVector particleVel;
PVector circlePos;
PVector linePrev;

int collisionCounter = 0;

//CHANGE THESE

float initalAngle = -405; //Angle ball is launched from
int calcsPerFrame = 500; //Basically speed
int particleSize = 0; //Size of particle
boolean linesOn = true; //Turns lines on or off
PFont font;
PrintWriter output;
PrintWriter rawOutput;
int timer = 0;

//CHANGE THESE
void setup() {
  size(600, 600);
  reset();
  font = createFont("Roboto-Medium.ttf", 100);
  frameRate(100);
  output = createWriter("seconds-" + hour() + "-" + minute() + "-" + second() + ".txt"); 
  rawOutput = createWriter("secondsRAW-" + hour() + "-" + minute() + "-" + second() + ".txt"); 
}

void reset(){
  collisionCounter = 0;
  circlePos = new PVector(width/2, height/2);
  linePrev = new PVector(circlePos.x, circlePos.y);
  particleVel = PVector.fromAngle(radians(initalAngle/10));
  circlePos.x += particleVel.x * 2;
  circlePos.y += particleVel.y * 2;
  background(220);
  timer = 0;
}

void draw() {
  for (int i=0; i<calcsPerFrame; i++){
    fill(0);
    circlePos.x += particleVel.x;
    circlePos.y += particleVel.y;
    timer++;
    checkBorders();
    drawText();
    push();
    fill(0);
    point(circlePos.x, circlePos.y);
    pop();
    if ((abs(circlePos.x - width/2) <= 0.5 && abs(circlePos.y - width/2) <= 0.5 && degrees(particleVel.heading()) - (initalAngle/10) <= 0.1 && degrees(particleVel.heading()) - (initalAngle/10) >= 0) || collisionCounter > 10000){
      println("Angle: " + initalAngle/-10 + "° Seconds: " + timer);
      output.println("Angle: " + initalAngle/-10 + "° Seconds: " + timer);
      rawOutput.println(timer);
      initalAngle--;
      if (initalAngle < -900){
        mouseClicked();
      }
      reset();
    }
  }
  //console.log(nfc(abs(circlePos.x - width/2), 2) + " " + nfc(abs(circlePos.y - width/2), 2) + " " + nfc(round(degrees(particleVel.heading())) - initalAngle, 2));
}

void checkBorders(){
  if (circlePos.x + particleSize > width || circlePos.x - particleSize < 0){
    particleVel.x *= -1;
    collisionCounter++;
  }
  if (circlePos.y + particleSize > height || circlePos.y - particleSize < 0){
    particleVel.y *= -1;
    collisionCounter++;
  }
}

void drawText(){
  push();
  fill(0);
  stroke(255);
  rect(10, height - 43, 100, 30);
  noStroke();
  fill(255);
  textFont(font);
  textSize(20);
  text(collisionCounter, 15, height - 21);
  pop();
}

void mouseClicked() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  rawOutput.flush(); // Writes the remaining data to the file
  rawOutput.close(); // Finishes the file
  exit(); // Stops the program
}
  
