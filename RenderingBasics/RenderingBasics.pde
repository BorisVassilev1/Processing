PVector result;

float angle = 0;

PVector[] points = new PVector[8];
PVector[] Ppoints = new PVector[8];

PVector[] connections = {
  new PVector(0,1),
  new PVector(1,2),
  new PVector(2,3),
  new PVector(3,0),
  new PVector(4,5),
  new PVector(5,6),
  new PVector(6,7),
  new PVector(7,4),
  new PVector(0,4),
  new PVector(1,5),
  new PVector(2,6),
  new PVector(3,7),
};


float[][] projection = {
      {1, 0, 0}, 
      {0, 1, 0}
    };
float scale = 200;
    
void setup()
{
  size(800,600);
  
  points[0] = new PVector(-0.5,-0.5,-0.5);
  points[1] = new PVector( 0.5,-0.5,-0.5);
  points[2] = new PVector( 0.5, 0.5,-0.5);
  points[3] = new PVector(-0.5, 0.5,-0.5);
  points[4] = new PVector(-0.5,-0.5, 0.5);
  points[5] = new PVector( 0.5,-0.5, 0.5);
  points[6] = new PVector( 0.5, 0.5, 0.5);
  points[7] = new PVector(-0.5, 0.5, 0.5);
}

void draw()
{
  background(0);
  noFill();
  stroke(255);
  strokeWeight(16);
  translate(width / 2, height / 2);
  
  angle += 0.01;
  
  float[][] rotationZ = {
    {cos(angle), -sin(angle), 0},
    {sin(angle),  cos(angle), 0},
    {0         ,0           , 1}
  };
  
  float[][] rotationY = {
    {cos(angle), 0, -sin(angle)},
    {0         , 1, 0          },
    {sin(angle), 0,  cos(angle)}
  };
  
  float[][] rotationX = {
    { 1, 0         , 0          },
    { 0, cos(angle), -sin(angle)},
    { 0, sin(angle), cos(angle) }
  };
  
  for(int i = 0; i < points.length; i ++)
  {
    PVector v = points[i];
    PVector r = matrixToVec(matMul(rotationX,v));
    r = matrixToVec(matMul(rotationY,r));
    r = matrixToVec(matMul(rotationZ,r));
    
    float distance = 3;
    float z = 2 / (distance - r.z);
    float[][] projection = {
      {z, 0, 0}, 
      {0, z, 0}
    };
    r.mult(scale);
    PVector p = matrixToVec(matMul(projection,r));
    
    point(p.x,p.y);
    Ppoints[i] = p;
  }
  strokeWeight(1);
  for(PVector v: connections)
  {
    line(Ppoints[(int)v.x].x,Ppoints[(int)v.x].y,Ppoints[(int)v.y].x,Ppoints[(int)v.y].y);
  }
}
