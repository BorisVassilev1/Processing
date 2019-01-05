public class Triangle
{
  PVector a,b,c;
  Triangle[] tris = new Triangle[3];
  int depth;
  public Triangle(PVector d,PVector e,PVector f,int depth)
  {
    this.a = d;
    this.b = e;
    this.c = f;
    this.depth = depth;
    if(depth >= 0){
      tris[0] = new Triangle(this.a,middle(this.a,this.b),middle(this.a,this.c),depth - 1);
      tris[1] = new Triangle(this.b,middle(this.a,this.b),middle(this.c,this.b),depth - 1);
      tris[2] = new Triangle(this.c,middle(this.a,this.c),middle(this.b,this.c),depth - 1);
    }
  }
  
  void tdraw()
  {
    stroke(255);
    line(this.a.x,this.a.y,this.b.x,this.b.y);
    line(this.a.x,this.a.y,this.c.x,this.c.y);
    line(this.c.x,this.c.y,this.b.x,this.b.y);
    if(tris[0] != null)
    tris[0].tdraw();
    if(tris[1] != null)
    tris[1].tdraw();
    if(tris[2] != null)
    tris[2].tdraw();
  }
  
  void drawOnCanvas(PGraphics c)
  {
    c.stroke(255);
    c.line(this.a.x * resolutionMultiplier,this.a.y * resolutionMultiplier,this.b.x * resolutionMultiplier,this.b.y * resolutionMultiplier);
    c.line(this.a.x * resolutionMultiplier,this.a.y * resolutionMultiplier,this.c.x * resolutionMultiplier,this.c.y * resolutionMultiplier);
    c.line(this.c.x * resolutionMultiplier,this.c.y * resolutionMultiplier,this.b.x * resolutionMultiplier,this.b.y * resolutionMultiplier);
    if(tris[0] != null)
    tris[0].drawOnCanvas(c);
    if(tris[1] != null)
    tris[1].drawOnCanvas(c);
    if(tris[2] != null)
    tris[2].drawOnCanvas(c);
  }
}
