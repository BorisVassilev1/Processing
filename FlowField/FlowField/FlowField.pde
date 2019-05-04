
float field[][];

int sizex;
int sizey;

float z = 0;

ArrayList<Particle> particles = new ArrayList<Particle>();

PGraphics canvas;

boolean isPlaying = false;

void setup()
{
  size(1200, 1000,P2D);
  canvas = createGraphics(width,height);
  //canvas.background(255);
  canvas.beginDraw();
  canvas.colorMode(HSB,255.0);
  canvas.stroke(0, 1.0, 0.9);
  canvas.endDraw();
  sizex = width/20;
  sizey = height/20;

  field = new float[sizex][sizey];
  for (int i = 0; i < 10000; i ++)
  {
    particles.add(new Particle());
  }
}

void draw()
{
  background(255);
  for (int x = 0; x < sizex; x ++)
  {
    for (int y = 0; y < sizey; y ++)
    {
      field[x][y] = noise(x * 0.1, y * 0.1, z);
    }
  }
  canvas.beginDraw();
  if (isPlaying)
  {
    z+=0.01;
    for (Particle p : particles)
    {
      p.checkLoc();
      int x = (int)(p.pos.x/20);
      int y = (int)(p.pos.y/20);
      float fx = cos(field[x][y] * TWO_PI * 2);
      float fy = sin(field[x][y] * TWO_PI * 2);
      p.addForce(new PVector(fx, fy));
      p.update();
      p.draw();
      canvas.strokeWeight(1);
      canvas.stroke((frameCount/2) % 255,255,255,10);
      canvas.line(p.prevPos.x, p.prevPos.y, p.pos.x, p.pos.y);
    }
  }
  //canvas.point(width/2,height/2);
  canvas.endDraw();
  image(canvas,0,0,width,height);
}

void keyPressed()
{
  if(key == ' ')
  {
    isPlaying = !isPlaying;
  }
  if(key == 'r')
  {
    canvas.save("image3.png");
  }
}
