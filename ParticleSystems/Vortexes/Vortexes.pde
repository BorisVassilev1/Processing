import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

ParticleSystem ps;

Vortex a1;

PeasyCam cam;


void setup()
{
  size(800,600,P3D);
  cam = new PeasyCam(this,100);
  ps = new ParticleSystem(1,5,10000,500);
  colorMode(RGB);
  a1 = new Vortex(new PVector(0,0,0),0.1,0.5);
}

void draw()
{
  //translate(width / 2, height / 2);
  background(0);
  //noStroke();
  stroke(255,0,0);
  noFill();
  translate(a1.pos.x,a1.pos.y,a1.pos.z);
  sphere(5);
  translate(-a1.pos.x,-a1.pos.y,-a1.pos.z);
  ps.draw();
}

void mouseClicked()
{
  println(ps.particlesCount);
}

PVector RotateY(float angle, PVector p)
{
  float[][] rotationY = {
    {cos(angle), 0, -sin(angle)},
    {0         , 1, 0          },
    {sin(angle), 0,  cos(angle)}
  };
  return matrixToVec(matMul(rotationY,p));
}
