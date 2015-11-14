//Q and W to zoom in and out.

int tileSize_x = 50;
int tileSize_y = 50;
int nTiles_x;
int nTiles_y;
float odds = 0.618;
 
color c2 = color(60, 194, 157);
color c1 = color(255);
 
void setup() {
    size(800, 800);
    nTiles_x = (int) (width / tileSize_x);
    nTiles_y = (int) (width / tileSize_y);
    background(c2);
    fill(c1);
    noStroke();
    noLoop();
    smooth();
}
 
void draw() {
    doMaze();
}
 
void keyPressed() {
    if (key == 'q') {
        resizeTile(0.5);
    }
 
    if (key == 'w') {
        resizeTile(2);
    }
 
    if (key == 's') {
//        save("10print_PosNeg.png");
    }
    else {
        background(c2);
        redraw();
    }
}
 
void resizeTile(float v) {
    tileSize_x /= v;
    tileSize_y /= v;
    nTiles_x = (int) (width / tileSize_x);
    nTiles_y = (int) (width / tileSize_y);
}
 
void doMaze() {
    for(int i = -1; i < nTiles_x + 1; i++) {
        for (int j = -1; j < nTiles_y + 1; j++) {
            int x1 = i * tileSize_x;
            int y1 = j * tileSize_y;
            int x2 = x1;
            int y2 = y1 + tileSize_y;
            float d = height / (tileSize_y / 2);;
            float n = y1 / d;
            float x = y2 / d;
 
            if (random(1.0) > odds) {
                x1 += tileSize_x;
                quad(x1, y1 - n, x1 + n, y1, x2, y2 + x, x2 - x, y2);
            }
            else {
                x2 += tileSize_x;
                quad(x1 - n, y1, x1, y1 - n, x2 + x, y2, x2, y2 + x);
            }
        }
    }
}
