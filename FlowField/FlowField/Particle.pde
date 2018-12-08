
public class Particle
{
  public PVector pos;
  public PVector prevPos = new PVector(0,0);
  PVector delta = new PVector(0, 0);
  
  Particle(float x, float y)
  {
    this.pos = new PVector(x, y);
  }

  Particle()
  {
    this.pos = new PVector(random(width), random(height));
  }

  void addForce(PVector v)
  {
    delta.add(v);
    delta.limit(7);
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