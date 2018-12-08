float Ys[][] = new float[5][100];

float frame = 0;



void setup()
{
  size(800,600);
  fill(255);
  stroke(0,255,255,100);
  strokeWeight(2);
  background(0);
  for(int i = 0 ; i < 5; i ++)
  {
    Ys[i][0] = noise(frame, (float)i) * 100;
  }
}

void draw()
{
  background(0);
  frame += 0.01;
  
  for(int i = 0; i < 5; i ++)
  {
    for(int j = 99; j > 0; j --)
    {
      Ys[i][j] = Ys[i][j - 1];
      line(j * 2, Ys[i][j],(j - 1) * 2, Ys[i][j-1]);
    }
    Ys[i][0] = noise(frame, (float)i) * 100;
  }
}