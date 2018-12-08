//x,y to x+1,y
boolean horizontalWalls[][];
//x,y to x,y+1
boolean verticalWalls[][];

boolean isChecked[][];

boolean isKeyPressed[] = new boolean[183];

int sizeX = 100;
int sizeY = 100;

int cellSizeX = 40;
int cellSizeY = 40;

ArrayList<Wall> walls = new ArrayList<Wall>();

PImage man;
Player player;

void setup()
{
  size(800, 800, P2D);
  background(0);
  noFill();
  stroke(255);
  
  man = loadImage("choveche.png");
  player = new Player(new PVector((float)(Math.random() * cellSizeX * sizeX),(float)(Math.random() * cellSizeY * sizeY)),man);
  
  //player.pos = new PVector(0.5 * cellSizeX * sizeX,0.5 * cellSizeX * sizeX);
  //player.pos = new PVector(0,0);
  
  horizontalWalls = new boolean[sizeX][sizeY];
  verticalWalls = new boolean[sizeX][sizeY];
  isChecked = new boolean[sizeX][sizeY];

  for (int x = 0; x < sizeX; x ++)
  {
    for (int y = 0; y < sizeY; y ++)
    {
      horizontalWalls[x][y] = true;
      verticalWalls[x][y] = true;
      isChecked[x][y] = false;
    }
  }
  
  for(int i = 0;i<182; i++)
  {isKeyPressed[i]= false;}
  
  generateTerrain(sizeX / 2, sizeY / 2);
  
  for(int x = 0; x < sizeX; x ++)
  {
    for(int y = 0; y < sizeY; y ++)
    {
      if(horizontalWalls[x][y])
      {
        walls.add(new Wall(new Segment(
          new PVector(x * cellSizeX + cellSizeX - 5, y * cellSizeY - 5             ),
          new PVector(x * cellSizeX + cellSizeX - 5, y * cellSizeY + cellSizeY - 5)),
          new PVector(x,y)
          ));
      }
      if(verticalWalls[x][y])
      {
        walls.add(new Wall(new Segment(
          new PVector(x * cellSizeX - 5            , y * cellSizeY + cellSizeY - 5),
          new PVector(x * cellSizeX + cellSizeX - 5, y * cellSizeY + cellSizeY - 5)),
          new PVector(x,y)
          ));
      }
    }
  }
  //walls.add(new Wall(new Segment(new PVector(105,105),new PVector(305,105)),new PVector(0,0)));
}

void draw()
{
  background(0);
  line(0 - player.pos.x + width / 2 - 5,
  0 - player.pos.y + height / 2 - 5,
  cellSizeX * sizeX - player.pos.x + width / 2 - 5,
  0 - player.pos.y + width / 2 - 5);
  line(0 - player.pos.x + width / 2 - 5,
  0 - player.pos.y + height / 2 - 5,
  0 - player.pos.x + width / 2 - 5,
  cellSizeY * sizeY - player.pos.y + height / 2 - 5);
  //for (int x = 0; x < sizeX; x ++)
  //{
  //  for (int y = 0; y < sizeY; y ++)
  //  {
  //    if (horizontalWalls[x][y])
  //    {
  //      line(
  //        x * cellSizeX + cellSizeX - player.pos.x, 
  //        y * cellSizeY - player.pos.y,
  //        x * cellSizeX + cellSizeX - player.pos.x, 
  //        y * cellSizeY + cellSizeY - player.pos.y
  //        );
  //    }
  //    if (verticalWalls[x][y])
  //    {
  //      line(
  //        x * cellSizeX - player.pos.x, 
  //        y * cellSizeY + cellSizeY - player.pos.y, 
  //        x * cellSizeX + cellSizeX - player.pos.x, 
  //        y * cellSizeY + cellSizeY - player.pos.y
  //        );
  //    }
  //  }
  //}
  
  for(Wall w : walls)
  {
    w.draw();
  }
 
  
  player.checkKeys();
  player.draw();
}

void generateTerrain(int x, int y)
{
  isChecked[x][y] = true;
  int r = (int) Math.floor(Math.random() * 4);
  for (int i = r; i < r + 4; i ++)
  {
    if (i % 4 == 0) {
      if (x < sizeX - 1 && !isChecked[x + 1][y]) {
        horizontalWalls[x][y] = false;
        generateTerrain(x + 1, y);
      }
    }
    else if (i % 4 == 1) {
      if (x > 0 && !isChecked[x - 1][y]) {
        horizontalWalls[x - 1][y] = false;
        generateTerrain(x - 1, y);
      }
    }
    else if (i % 4 == 2) {
      if (y < sizeY - 1 && !isChecked[x][y + 1]) {
        verticalWalls[x][y] = false;
        generateTerrain(x, y + 1);
      }
    }
    else if(i % 4 == 3)
    {
      if (y > 0 && !isChecked[x][y - 1]) {
        verticalWalls[x][y - 1] = false;
        generateTerrain(x, y - 1);
      }
    }
  }
}

void keyPressed()
{
  isKeyPressed[keyCode] = true;
}

void keyReleased()
{
  isKeyPressed[keyCode] = false;
}
