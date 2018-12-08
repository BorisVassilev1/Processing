
ArrayList<PVector> lightSources = new ArrayList<PVector>();
PVector wallBegin;

ArrayList<Segment> walls = new ArrayList<Segment>();
ArrayList<PVector> points = new ArrayList<PVector>();

ArrayList<Boolean> calcHelper = new ArrayList<Boolean>();

boolean isDragged = false;

void setup()
{
  size(500,500,P2D);
  colorMode(RGB,255);
  
  lightSources.add(new PVector(100,100));
  lightSources.add(new PVector(300,300));
}

void draw()
{
  loadPixels();
  for(int y = 0; y < height; y ++)
  {
    for(int x = 0; x < width; x ++)
    {
      calcHelper = new ArrayList<Boolean>();
      for(int i = 0; i < lightSources.size(); i ++)
      {
        calcHelper.add(false);
        for(int j = 0; j < walls.size(); j ++)
        {
          if(walls.get(j).intersect(new Segment(lightSources.get(i),new PVector(x,y))) != null || dist(lightSources.get(i).x,lightSources.get(i).y,x,y) >= 255/2)
          {
             calcHelper.set(i,true);
          }
        }
      }
      if(walls.size() == 0)
      calcHelper.add(false);
      
      float minDist = 255;
      
      for(int i = 0; i < lightSources.size(); i ++)
      {
        float dist = dist(x,y,lightSources.get(i).x,lightSources.get(i).y);
        for(int j = 0; j < walls.size(); j ++)
        {
          if(dist < minDist && (walls.get(j).intersect(new Segment(lightSources.get(i),new PVector(x,y))) == null || walls.size() == 0))
          {
            minDist = dist;
          }
        }
      }
      
      if(isFilledWith(calcHelper,true))
      {
        pixels[y * width + x] = color(0);
      }
      else
      {
        pixels[y * width + x] = color(255 - minDist * 2);
      }
    }
  }
  updatePixels();
  
  for(int i = 0; i < walls.size(); i ++)
  {
    walls.get(i).draw(255);
  }
  for(int i = 0; i < points.size(); i ++)
  {
    ellipse(points.get(i).x,points.get(i).y,4,4);
  }
  
  fill(255,0,0);
  for(int i = 0; i < lightSources.size(); i ++)
  {
    if(dist(lightSources.get(i).x, lightSources.get(i).y,mouseX,mouseY) < 40 && isDragged)
    {
      lightSources.set(i,new PVector(mouseX,mouseY));
    }
    
    PVector current = lightSources.get(i);
    ellipse(current.x,current.y,5,5);
  }
}
void keyPressed()
{
  wallBegin = new PVector(mouseX,mouseY);
}

void keyReleased()
{
  walls.add(new Segment(wallBegin,new PVector(mouseX,mouseY)));
}

void mousePressed()
{
  isDragged = true;
}

void mouseReleased()
{
  isDragged = false;
}

boolean isFilledWith(ArrayList<Boolean> array, boolean something)
{
  for(int i = 0; i < array.size(); i ++)
  {
    if(array.get(i) != something)
    return false;
  }
  return true;
}
