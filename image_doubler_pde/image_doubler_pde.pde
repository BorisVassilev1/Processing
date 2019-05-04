PImage img;
PImage out;

final int modif = 4;

int index(int x, int y, int max_x)
{
  return x + y * max_x;
}

void setup() {
  size(1000,696);
  img = loadImage("cat.jpg");
  image(img,0,0);
  out = createImage(img.width * modif, img.height * modif,0);
  image(out,0,0);
  img.loadPixels();
  out.loadPixels();
  for(int x = 0; x < out.width; x ++) {
    for(int y = 0; y < out.height; y ++) {
      color pix = img.pixels[index(x / modif,y / modif,img.width)];
      out.pixels[index(x,y,out.width)] = pix;
    }
  }
  out.updatePixels();
  image(out,0,0);
  out.save("out.jpg");
  noLoop();
}

void draw(){
  
}
