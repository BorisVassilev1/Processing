PImage img;

ArrayList<Particle> particles;

int barrier;

PGraphics canvas;

void setup()
{
  size(250,250);
  canvas = createGraphics(width,height);
  img = loadImage("frog_2.jpg");
  canvas.beginDraw();
  noStroke();
  canvas.noStroke();
  barrier = img.width;
  //image(img,0,0);
  
  particles = new ArrayList<Particle>();
  
  img.loadPixels();
  for(int y = 0; y < img.height; y ++)
  {
    for(int x = 0; x < img.width; x ++)
    {
      if(img.pixels[y * img.width + x]!= color(255,255,255))
      {
        Particle p = new Particle(x,y);
        p.c = img.pixels[y * img.width + x];
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
      if(p.pos.x > img.width || p.pos.y < 0 || p.pos.y > img.height || p.pos.x < 0)
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