class Wall
{
  Segment seg;
  
  PVector arrayIndex;
  
  public Wall(Segment s, PVector arrayIndex)
  {
    this.seg = s;
    this.arrayIndex = arrayIndex;
  }
  
  void draw()
  {
    Segment drawS = new Segment(
    new PVector(seg.begin.x - player.pos.x + width / 2,seg.begin.y - player.pos.y + height / 2),
    new PVector(seg.end.x - player.pos.x + width / 2  ,seg.end.y - player.pos.y + height / 2  )
    );
    drawS.draw();
  }
}

class Player
{
  PVector pos;
  PImage tex;
  
  int sizeX = 10;
  int sizeY = 15;
  public Player(PVector pos,PImage tex)
  {
    this.pos = pos;
    this.tex = tex;
  }
  
  void checkKeys()
  {
    if(isKeyPressed[65] == true)
    {
      this.move(new PVector(-5,0));
    }
    if(isKeyPressed[87] == true)
    {
      this.move(new PVector(0,-5));
    }
    if(isKeyPressed[68] == true)
    {
      this.move(new PVector(5,0));
    }
    if(isKeyPressed[83] == true)
    {
      this.move(new PVector(0,5));
    }
  }
  void draw()
  {
     image(tex, width/2 - sizeX / 2, height/2 - sizeY / 2, sizeX , sizeY);
  }
  
  void move(PVector vec)
  {
    //pos.add(vec);
    boolean canMove= true;
    PVector newPos = pos.copy().add(vec);
    for(int i = 0; i < walls.size(); i ++)
    {
      Wall w = walls.get(i);
      if(w.seg.begin.x == w.seg.end.x){  
        if(((this.pos.x - this.sizeX >= w.seg.begin.x && newPos.x - this.sizeX <= w.seg.begin.x) ||
            (this.pos.x + this.sizeX <= w.seg.begin.x && newPos.x + this.sizeX >= w.seg.begin.x)) && 
            ((w.seg.begin.y <= this.pos.y - this.sizeY / 2 && w.seg.end.y >= this.pos.y  ) || 
             (w.seg.begin.y >= this.pos.y && w.seg.end.y <= this.pos.y)))
        {
          canMove = false;
          //println("You cant move");
          
        }
      }
      if(w.seg.begin.y == w.seg.end.y){
        if(((this.pos.y >= w.seg.begin.y && newPos.y <= w.seg.begin.y) ||
            (this.pos.y <= w.seg.begin.y && newPos.y >= w.seg.begin.y)) && 
            ((w.seg.begin.x <= this.pos.x && w.seg.end.x >= this.pos.x  ) || 
             (w.seg.begin.x >= this.pos.x && w.seg.end.x <= this.pos.x)))
        {
          canMove = false;
          //println("You cant move");
          
        }
        //println("hello");
      }
    }
    if(canMove)
    {
      pos.add(vec);
      //println(pos);
      //println(walls.get(0).seg.begin + " " + walls.get(0).seg.end);
    }
  }
}
