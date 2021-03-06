PImage catin;
int variations = 1;

void setup()
{
  size(2000,696);
  catin = loadImage("cat.jpg");
  catin.filter(GRAY);
  PImage cat = resize(catin);
  image(cat,0,0,1000,696);
  
  cat.loadPixels();
  for(int y = 0; y < cat.height - 1; y ++)
  {
    for(int x = 1; x < cat.width - 1; x ++)
    {
      color pix = cat.pixels[index(x,y,cat.width)];
      
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = green(pix);
      
      int newR = round(variations * oldR / 255) * (255 / variations);
      int newG = round(variations * oldG / 255) * (255 / variations);
      int newB = round(variations * oldB / 255) * (255 / variations);
      
      cat.pixels[index(x,y,cat.width)] = color(newR,newG,newB);
      
      float errR = oldR - newR;
      float errG  = oldG - newG;
      float errB = oldB - newB;
      
      int index  = index(x + 1,y    ,cat.width);
      color c = cat.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r += errR * 7 / 16f;
      g += errG * 7 / 16f;
      b += errB * 7 / 16f;
      cat.pixels[index] = color(r,g,b);
      
      index  = index(x - 1,y + 1,cat.width);
      c = cat.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r += errR * 3 / 16f;
      g += errG * 3 / 16f;
      b += errB * 3 / 16f;
      cat.pixels[index] = color(r,g,b);
      
      index  = index(x    ,y + 1,cat.width);
      c = cat.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r += errR * 5 / 16f;
      g += errG * 5 / 16f;
      b += errB * 5 / 16f;
      cat.pixels[index] = color(r,g,b);

      index  = index(x + 1,y + 1,cat.width);
      c = cat.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r += errR * 1 / 16f;
      g += errG * 1 / 16f;
      b += errB * 1 / 16f;
      cat.pixels[index] = color(r,g,b);
    }
  }
  cat.updatePixels();
  
  image(cat,catin.width * 2, 0, 1000, 696);
  cat.save("dithered_cat.jpg");
}

void draw()
{
  
}
