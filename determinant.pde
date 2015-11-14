//"The Determinant Experiment"

PVector[][] locations = new PVector[500][500];
 
void setup() {
  size(500,500);
  smooth();
  //set shape locations
  for (int y = 0; y < height; y+=50) {
    for(int x = 0; x < width; x+=50) {
      PVector temp = new PVector(x,y);
      locations[x][y] = temp;
    }
  }
}
 
void draw() {
  colorMode(HSB);
  background(0, 0, 240); fill(0, 0, 240);
  for (int y = 0; y < height; y+=50) {
    for(int x = 0; x < width; x+=50) {
      pushMatrix();
      
      translate(locations[x][y].x, locations[x][y].y); // relocate to shape location
      float determinant =  det((int)locations[x][y].x, (int)locations[x][y].y, mouseX,mouseY, width/2, height/2); // 3 by 3 determinant
      if (mousePressed)
        rotate(abs(determinant/10000)); 
          // shapes rotate slowly while clicked
      stroke(abs(determinant)/500,200,230,75); 
        //vary color of shapes based on determinant with 75% opacity
      strokeWeight(abs(determinant)/1000); 
        // vary thickness of lines based on determinant
      float distance = dist(mouseX, mouseY,locations[x][y].x, locations[x][y].y); 
        //distance between mouse and shape location
      ellipse(0,0, mouseX - pmouseX - distance/5, mouseY - pmouseY - distance/5); 
        //width and height of shape are based on distance from mouse and mouse speed
      
      popMatrix();
    }
  }
}
 
float det(int x1, int y1, int x2, int y2, int x3, int y3) {
  return (float) ((x2-x1)*(y3-y1) - (x3-x1)*(y2-y1));
}
