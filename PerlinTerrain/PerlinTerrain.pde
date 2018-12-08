int cols;
int rows;
int scl = 20;
float[][] terrain;
float flyx = 0;
float flyy = 0;
boolean[] isKeyPressed = new boolean[182] ;

void setup()
{
  size(800, 600, P3D);
  int w = 1600;
  int h = 1200;
  cols = w/scl;
  rows = h/scl;

  terrain = new float[cols][rows];
  for(int i = 0;i<182; i++)
  {isKeyPressed[i]= false;}
}
void draw()
{
  checkKeys();
  float yoff = flyy;
  for (int y = 0; y < rows; y++) {
    float xoff = flyx;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = noise(xoff, yoff)*300-150;
      xoff+=0.1;
    }
    yoff+=0.1;
  }
  
  background(255);
  stroke(0);
  fill(150);
  //colorMode(10);

  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-width, -height);
  
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}
void checkKeys()
{
  if(isKeyPressed[65] == true)
  {
    flyx -=0.01;
  }
  if(isKeyPressed[87] == true)
  {
    flyy -=0.01;
  }
  if(isKeyPressed[68] == true)
  {
    flyx +=0.01;
  }
  if(isKeyPressed[83] == true)
  {
    flyy +=0.01;
  }
}
void keyPressed()
{
  isKeyPressed[keyCode] = true;
}
void keyReleased()
{
  isKeyPressed[keyCode] = false;
}