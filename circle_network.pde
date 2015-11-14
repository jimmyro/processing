boolean savePDF = false;
 
int maxCount = 5000; //max count of the cirlces
int currentCount = 1;
float[] x = new float[maxCount];
float[] y = new float[maxCount];
float[] r = new float[maxCount]; //radius
int[] closestIndex = new int[maxCount]; //index
 
float minRadius = 3;
float maxRadius = 50;
 
// for mouse and arrow up/down interaction
float mouseRect = 30;

//style
//click and drag to draw circles

color bg = color(255);
color border = color(255);
color fill = color(255);
 
void setup() {
  size(600,600);
  noFill();
  smooth();
  cursor(CROSS);
 
  // first circle
  x[0] = 200;
  y[0] = 100;
  r[0] = 50;
  closestIndex[0] = 0;
}
 
 
 
void draw() {
  background(230);
 
  // create a random position
  float newX = random(0+maxRadius,width-maxRadius);
  float newY = random(0+maxRadius,height-maxRadius);
  float newR = minRadius;
 
  // create a random position according to mouse position
  if (mousePressed == true) {
    newX = random(mouseX-mouseRect/2,mouseX+mouseRect/2);
    newY = random(mouseY-mouseRect/2,mouseY+mouseRect/2);
    newR = 1;
  }
 
  boolean intersection = false;
 
  // find out, if new circle intersects with one of the others
  for(int i=0; i < currentCount; i++) {
    float d = dist(newX,newY, x[i],y[i]);
    if (d < (newR + r[i])) {
      intersection = true;
      break;
    }
  }
 
  // no intersection ... add a new circle
  if (intersection == false) {
    // get closest neighbour and closest possible radius
    float newRadius = width;
    for(int i=0; i < currentCount; i++) {
      float d = dist(newX,newY, x[i],y[i]);
      if (newRadius > d-r[i]) {
        newRadius = d-r[i];
        closestIndex[currentCount] = i;
      }
    }
 
    if (newRadius > maxRadius) newRadius = maxRadius;
     
    x[currentCount] = newX;
    y[currentCount] = newY;
    r[currentCount] = newRadius;
    currentCount++;
  }
 
  // draw them
  for (int i=0 ; i < currentCount; i++) {
    stroke(0);
    strokeWeight(1.5);
    fill(255);
    ellipse(x[i],y[i], r[i]*2,r[i]*2);
    stroke(226, 185, 0);
    strokeWeight(0.75);
    int n = closestIndex[i];
    line(x[i],y[i], x[n],y[n]);
  }
 
  // visualize the random range of the new positions
  if (mousePressed == true) {
    stroke(255,200,0);
    strokeWeight(2);
    rect(mouseX-mouseRect/2,mouseY-mouseRect/2,mouseRect,mouseRect);
  }
 
  if (currentCount >= maxCount) noLoop();
 
  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}
 
void keyPressed() {
  // mouseRect ctrls arrowkeys up/down
  if (keyCode == UP) mouseRect += 4;
  if (keyCode == DOWN) mouseRect -= 4;
}

