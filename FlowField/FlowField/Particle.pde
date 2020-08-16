
public class Particle
{
  public PVector pos;
  public PVector prevPos = new PVector(0,0);
  PVector delta = new PVector(0, 0);
  color col; 
  
  color randomColor() {
    return color(random(255), random(255), random(255), 255); 
  }
  
  Particle(float x, float y)
  {
    this.pos = new PVector(x, y);
    this.col = randomColor();
  }

  Particle()
  {
    this.pos = new PVector(random(width), random(height));
    this.col = randomColor();
  }

  Particle(PVector pos) {
    this.pos = pos;
    this.col = randomColor();
  }
  
  Particle(color col) {
    this.pos = new PVector(random(width), random(height));
    this.col = col;
  }
  
  Particle(PImage img) {
    this.pos = new PVector(random(width), random(height));
    int w = img.width;
    int h = img.height;
    
    int pixel_x = int(pos.x / float(width) * w);
    int pixel_y = int(pos.y / float(height) * h);
    //println(pixel_x + " " + pixel_y);
    int pixel = pixel_y * w + pixel_x;
    img.loadPixels();
    this.col = img.pixels[pixel];
    //println(this.col >> 24);
    img.updatePixels();
  }
  
  void addForce(PVector v)
  {
    delta.add(v);
    delta.limit(2);
  }

  void update()
  {
    prevPos.set(pos);
    pos.add(delta);
  }

  void draw()
  {
    stroke(128, 128, 0);
    strokeWeight(4);
    point(pos.x,pos.y);
  }

  void checkLoc()
  {
    float x = pos.x;
    float y = pos.y;
    if (x >= width)
      x = 0;
    if (x <0)
      x = width-1;
    if (y >= height)
      y = 0;
    if (y <0)
      y = height-1;
    pos.set(x,y);
  }
}
