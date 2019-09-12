PImage img;

ArrayList<Particle> particles;

int barrier;

PGraphics canvas;

void setup()
{
  size(500,500);
  canvas = createGraphics(width,height);
  img = loadImage("frog_2.jpg");
  canvas.beginDraw();
  noStroke();
  canvas.noStroke();
  barrier = img.width * 2;
  //image(img,0,0);
  
  particles = new ArrayList<Particle>();
  
  img.loadPixels();
  for(int y = 0; y < img.height * 2; y ++)
  {
    for(int x = 0; x < img.width * 2; x ++)
    {
      if(img.pixels[y / 2 * img.width  + x/2]!= color(255,255,255))
      {
        Particle p = new Particle(x,y);
        p.c = img.pixels[y / 2 * img.width + x/2];
        particles.add(p);
      }
    }
  }
  img.updatePixels();
  canvas.endDraw();
}

void draw()
{
  canvas.beginDraw();
  background(255);
  canvas.background(255);
  canvas.colorMode(RGB);
  barrier -= 1;
  for(int i = 0; i < particles.size(); i ++)
  {
    Particle p = particles.get(i);
    if(p.isAlive)
    {
      if(p.pos.x > barrier && !p.isRandomised)
      {
        p.randomise();
      }
      p.update();
      if(p.pos.x > img.width * 2 || p.pos.y < 0 || p.pos.y > img.height * 2 || p.pos.x < 0)
      {
        p.isAlive = false;
      }
    }
  }
  canvas.endDraw();
}

void keyPressed()
{
  canvas.save("desintegration.jpg");
}
