/* Variable a is used for determining the shape's y position, coupled with the distance they are from the center. */
float a;

/* Movie tools */
int framect;

void setup()
{
  size(500,500); //720p for filming
  colorMode(HSB, 6); //colorMode(RGB, 6);
  stroke(0); //black borders on all the quads
  frameRate(30); //framerate 30
}

void draw()
{
  /*
  a is decreased by 0.02. It represents the height change of each box (in radians) per tick.
  */
  a -= 0.02;

  background(6); //clear bg to white (6; see colorMode in setup)
  /*
  (x,z) is the ground and y is the height, which varies.  (use 80x80 for 720p filming)
  */
  for (int x = -7; x < 7; x++) {
   for (int z = -7; z < 7; z++) {
    /*
    The y variable is set to determine the height of the box.
    We use formula radius * cos(angle) to determine this.
    Since cosine, when graphed, creates a wave, we can use this to have the boxes transition from small to big smoothly.
      
    The radius pretty much stands for our range. cosine alone will return values between -1 and 1, so we multiply this by
    a constant to increase this value. The formula will return something in between -24 and 24.

    again, the variable a is responsible for the change in each frame
    */
    int y = int(24 * cos(0.4 * distance(x,z,0,0) + a));
      
    /*
    These are 2 coordinate variations for each quadrilateral.
    Since they can be found in 4 different quadrants (+ and - for x, and + and - for z),
    we'll only need 2 coordinates for each quadrilateral (but we'll need to pair them up differently
    for this to work fully).
      
    Multiplying the x and z variables by 17 will space them 17 pixels apart.
    The 8.5 will determine half the width of the box ()
    8.5 is used because it is half of 17. Since 8.5 is added one way, and 8.5 is subtracted the other way, the total
    width of each box is 17. This will eliminate any sort of spacing in between each box.
    */
    
    
    float xm = x*17 -8.5;
    float xt = x*17 +8.5;
    float zm = z*17 -8.5;
    float zt = z*17 +8.5;
      
    /* We use an integer to define the width and height of the window. This is used to save resources on further calculating */
    int halfw = (int)width/2;
    int halfh = (int)height/2;
      
    /*
    Here is where all the isometric calculating is done.
    We take our 4 coordinates for each quadrilateral, and find their (x,y) coordinates using an isometric formula.
    You'll probably find a similar formula used in some of my other isometric animations. However, I normally use
    these in a function. To avoid using repetitive calculation (for each coordinate of each quadrilateral, which
    would be 3 quads * 4 coords * 3 dimensions = 36 calculations).
      
    Formerly, the isometric formula was ((x - z) * cos(radians(30)) + width/2, (x + z) * sin(radians(30)) - y + height/2).
    however, the cosine and sine are constant, so they could be precalculated. Cosine of 30 degrees returns roughly 0.866, which can round to 1,
    Leaving it out would have little artifacts (unless placed side-by-side to accurate versions, where everything would appear wider in this version)
    Sine of 30 returns 0.5.
      
    We left out subtracting the y value, since this changes for each quadrilateral coordinate. (-40 for the base, and our y variable)
    These are later subtracted in the actual quad().
    */
    int isox1 = int(xm - zm + halfw);
    int isoy1 = int((xm + zm) * 0.5 + halfh);
    int isox2 = int(xm - zt + halfw);
    int isoy2 = int((xm + zt) * 0.5 + halfh);
    int isox3 = int(xt - zt + halfw);
    int isoy3 = int((xt + zt) * 0.5 + halfh);
    int isox4 = int(xt - zm + halfw);
    int isoy4 = int((xt + zm) * 0.5 + halfh);
      
    /* The side quads. 2 and 4 is used for the coloring of each of these quads */
    fill (2);
    quad(isox2, isoy2-y, isox3, isoy3-y, isox3, isoy3+40, isox2, isoy2+40);
    fill (4);
    quad(isox3, isoy3-y, isox4, isoy4-y, isox4, isoy4+40, isox3, isoy3+40);
      
    /*
    The top quadrilateral.
    y, which ranges between -24 and 24, multiplied by 0.05 ranges between -1.2 and 1.2
    We add 4 to get the values up to between 2.8 and 5.2.
    This is a very fair shade of grays, since it doesn't become one extreme or the other.
    */
    fill(1+y*0.05, 4, 5); //fill(4 + y * 0.05);
    quad(isox1, isoy1-y, isox2, isoy2-y, isox3, isoy3-y, isox4, isoy4-y);
   }
  }
  /*
  if (framect < 1024) {
    saveFrame("frames/####.png");
    println(framect + " capture");
    framect++;
  } else {
    stop();
    println("-------DONE-------");
  }*/
  
} //end of draw function


/* The distance formula */
float distance(float x,float y,float cx,float cy) {
  return sqrt(sq(cx - x) + sq(cy - y));
}
