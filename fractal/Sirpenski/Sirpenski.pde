PVector a = new PVector(500,10);
PVector b = new PVector(50,900);
PVector c = new PVector(950,900);

int p = 1;
int q = 1;

int resolutionMultiplier = 15;

Triangle tri;
void setup()
{
  size(1000,1000);
  background(0);
  stroke(255);
  strokeWeight(1);
  tri = new Triangle(a.copy(),b.copy(),c.copy(),10);
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

void keyReleased()
{
  if(key == ' ')
  {
    PGraphics canvas;
    canvas = createGraphics(width * resolutionMultiplier,height * resolutionMultiplier);
    canvas.beginDraw();
    canvas.background(0);
    canvas.colorMode(HSB,255.0);
    canvas.stroke(0, 1.0, 0.9);
    tri.drawOnCanvas(canvas);
    canvas.line(a.x * resolutionMultiplier,a.y * resolutionMultiplier,b.x * resolutionMultiplier,b.y * resolutionMultiplier);
    canvas.line(a.x * resolutionMultiplier,a.y * resolutionMultiplier,c.x * resolutionMultiplier,c.y * resolutionMultiplier);
    canvas.line(c.x * resolutionMultiplier,c.y * resolutionMultiplier,b.x * resolutionMultiplier,b.y *resolutionMultiplier);
    canvas.endDraw();
    canvas.save("shit.png");
  }
}
