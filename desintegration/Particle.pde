class Particle
{
  PVector pos = new PVector(0,0);
  PVector vel = new PVector(0,0);
  
  color c = color(255,255,255);
  
  boolean isRandomised = false;
  boolean isAlive = true;
  
  public Particle(int x, int y)
  {
    this.pos.set(x,y);
  }
  
  void randomise()
  {
    this.vel.set(random(4) - 2, random(4) - 2);
    isRandomised = true;
  }
  
  void update()
  {
    pos.add(vel);
    fill(c);
    rect(pos.x,pos.y,1,1);
    canvas.fill(c);
    canvas.rect(pos.x,pos.y,1,1);
  }
}