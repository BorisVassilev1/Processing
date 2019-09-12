
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

ParticleSystem ps;

Attractor a1;
Attractor a2;
Attractor a3;

PeasyCam cam;


void setup()
{
  size(800,600,P3D);
  //translate(100,100,-1000);
  cam = new PeasyCam(this,100);
  ps = new ParticleSystem(1,50,100000,1500);
  colorMode(RGB);
  a1 = new Attractor(new PVector(-100,-300, -100),0.01,0.5);
  a2 = new Attractor(new PVector(-100,-100,0),0.01,0.5);
  a3 = new Attractor(new PVector(-200,-200,-200),0.01,0.5);
}

void draw()
{
  //translate(width / 2, height / 2);
  background(0);
  //noStroke();
  stroke(255,0,0);
  noStroke();
  fill(255,0,0);
  translate(a1.pos.x,a1.pos.y,a1.pos.z);
  sphere(5);
  translate(-a1.pos.x,-a1.pos.y,-a1.pos.z);
  fill(0,255,0);
  translate(a2.pos.x,a2.pos.y,a2.pos.z);
  sphere(5);
  translate(-a2.pos.x,-a2.pos.y,-a2.pos.z);
  fill(0,0,255);
  translate(a3.pos.x,a3.pos.y,a3.pos.z);
  sphere(5);
  translate(-a3.pos.x,-a3.pos.y,-a3.pos.z);
  ps.draw();
  translate(-100,-200,-100);
  //rotateZ(0.1f);
}

void mouseClicked()
{
  println(ps.particlesCount);
}
