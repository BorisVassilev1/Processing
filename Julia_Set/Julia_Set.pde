
int iterations = 100;
float cx = -0.8;
float cy = 0.156;

float x = 0; 
float y = 0;

float zoom = 3.5;

void setup()
{
  size(800 , 600, P2D);
  colorMode(HSB, 1.0);
}
float calculatepoint(float x, float y) {
  int i = 0;

  for (; i < iterations; i++) {
    float nx = x * x - y * y + cx;
    float ny = 2 * x * y + cy;
    x = nx;
    y = ny;

    if (x * x + y * y > 4)
    {
      break;
    }
  }
  return float(i)/float(iterations);
}
void draw()
{
  background(0);
  loadPixels();
  //cx = map(mouseX,0,width,-1,1);
  //cy = map(mouseY,0,height,-1,1);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float h = calculatepoint((x - width / 2f)/width/zoom, (y - height / 2f)/height/zoom);
      if (h == 255)
      {
        pixels[x + y * width] = color(0);
      } else
      {
        pixels[x + y * width] = color(h, 1, 1);
      }
    }
  }

  updatePixels();
}

void keyPressed()
{
  if (key == UP)
  {
    y -= 10;
  }else if(key == LEFT)
  {
    x -=10;
  }else if(key == RIGHT)
  {
    x +=10;
  }else if(key == DOWN)
  {
    y -=10;
  }
  else if(key == 'w')
  {
    zoom --;
  }else if(key == 's')
  {
    zoom ++;
  }
}
