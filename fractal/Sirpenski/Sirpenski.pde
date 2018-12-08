PVector a = new PVector(500,10);
PVector b = new PVector(50,900);
PVector c = new PVector(950,900);

int p = 1;
int q = 1;

Triangle tri;
void setup()
{
  size(1000,1000);
  background(0);
  stroke(255);
  strokeWeight(1);
  tri = new Triangle(a.copy(),b.copy(),c.copy(),0);
}

void draw()
{
  tri.tdraw();
  line(a.x,a.y,b.x,b.y);
  line(a.x,a.y,c.x,c.y);
  line(c.x,c.y,b.x,b.y);
}

public PVector middle(PVector a, PVector b)
{
  return a.copy().add(b).mult(0.5);
  //return new PVector((a.x * p + b.x * q) / (p + q), (a.y * p + b.y * q) / (p + q));
}
