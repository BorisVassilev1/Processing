

final int modif = 1;

int index(int x, int y, int max_x)
{
  return x + y * max_x;
}

PImage resize(PImage img) {
  PImage out;
  out = createImage(img.width * modif, img.height * modif,255);
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
  out.save("out.jpg");
  return out;
}
