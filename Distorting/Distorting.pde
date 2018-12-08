PImage img1;
PImage img2;


int variations = 2;

int index(int x, int y)
{
  return x + y * img2.width;
}

void setup()
{
  img1 = loadImage("smile.jpg");
  img2 = loadImage("smile.jpg");
  size(1920 ,960 ,P2D);
  
  img2.loadPixels();
  for(int x = 0; x < img2.width - 1; x ++)
  {
    for(int y = 1; y < img2.height - 1; y ++)
    {
      color pix =img2.pixels[index(x,y)];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      
      //r += noise(x / 20f,y / 1f,1) * 255 - 127;
      //g += noise(x / 20f,y / 1f,2) * 255 - 127;
      //b += noise(x / 20f,y / 1f,3) * 255 - 127;
      
      oldR = (oldR - 125) * 4 + 125;
      oldG = (oldG - 125) * 4 + 125;
      oldB = (oldB - 125) * 4 + 125;
      
      if(noise(x / 20f,y / 20f) > 0.3)
      {
        oldR -= abs(oldR-255) * noise(x / 20f, y / 20f,1) * 4;
        oldG -= abs(oldG-255) * noise(x / 20f, y / 20f,2) * 4;
        oldB -= abs(oldB-255) * noise(x / 20f, y / 20f,3) * 4;
      }
        
      //
      int newR = round(variations * oldR / 255) * (255 / variations);
      int newG = round(variations * oldG / 255) * (255 / variations);
      int newB = round(variations * oldB / 255) * (255 / variations);
        
      img2.pixels[index(x,y)] = color(newR,newG,newB);
        
      float errR = oldR - newR;
      float errG  = oldG - newG;
      float errB = oldB - newB;
        
      int index  = index(x + 1,y    );
      color c = img2.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r += errR * 7 / 16f;
      g += errG * 7 / 16f;
      b += errB * 7 / 16f;
      img2.pixels[index] = color(r,g,b);
        
      index  = index(x - 1,y + 1);
      c = img2.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r += errR * 3 / 16f;
      g += errG * 3 / 16f;
      b += errB * 3 / 16f;
      img2.pixels[index] = color(r,g,b);
        
      index  = index(x    ,y + 1);
      c = img2.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r += errR * 5 / 16f;
      g += errG * 5 / 16f;
      b += errB * 5 / 16f;
      img2.pixels[index] = color(r,g,b);
  
      index  = index(x + 1,y + 1);
      c = img2.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r += errR * 1 / 16f;
      g += errG * 1 / 16f;
      b += errB * 1 / 16f;
      img2.pixels[index] = color(r,g,b);
      //
      
      img2.pixels[index(x,y)] = color(newR,newG,newB);
    }
  }
  img2.updatePixels();
  
  img2.save("distorted_smile.jpg");
}

void draw()
{
  image(img1,0,0);
  image(img2,img1.width,0);
}
