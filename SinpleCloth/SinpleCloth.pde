import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;

import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.physics.constraints.*;

PImage img;

int res = 2;
int cols = 60 / res;
int rows = 40 / res;

Particle[][] particles = new Particle[cols][rows];
ArrayList<Spring> springs;

float w = 10 * res;

VerletPhysics physics;

void setup()
{
  size(1000, 800, P3D);
  lights();
  //frameRate(50);
  springs = new ArrayList<Spring>();

  physics = new VerletPhysics();
  Vec3D gravity = new Vec3D(0, 0.5, 0);
  GravityBehavior gb = new GravityBehavior(gravity);
  physics.addBehavior(gb);

  float x = -cols*w/2-100;
  for (int i = 0; i< cols; i++) {
    float y = -rows*w/2;
    for (int j = 0; j< rows; j++) {
      Particle p = new Particle(x, y, 0);
      particles[i][j] = p;
      physics.addParticle(p);
      y = y + w;
    }
    x = x + w;
  }

  for (int i = 0; i< cols-1; i++) {
    for (int j = 0; j< rows-1; j++) {
      Particle a = particles[i][j];
      Particle b1 = particles[i+1][j];
      Particle b2 = particles[i][j+1];
      Spring s1 = new Spring(a, b1);
      springs.add(s1);
      physics.addSpring(s1);
      Spring s2 = new Spring(a, b2);
      springs.add(s2);
      physics.addSpring(s2);
    }
  }
  for (int i = 0; i<cols-1; i++)
  {
    Particle a = particles[i][rows-1];
    Particle b = particles[i+1][rows-1];
    Spring s = new Spring(a, b);
    springs.add(s);
    physics.addSpring(s);
  }
  for (int i = 0; i<rows-1; i++)
  {
    Particle a = particles[cols-1][i];
    Particle b = particles[cols-1][i+1];
    Spring s = new Spring(a, b);
    springs.add(s);
    physics.addSpring(s);
  }
  
  for(int i = 0; i<rows; i++)
  {
    //if(i%5 == 0)
    particles[0][i].lock();
  }

  img = loadImage("flag.png");
}
float a = 0;
float zoff = 0;
void draw()
{
  background(51);
  translate(width/2, height/2);
  //rotateY(a);
  a+=0.01;
  physics.update();

  float xoff = 0;
  for (int i = 0; i< cols; i++) {
    float yoff = 0;
    for (int j = 0; j< rows; j++) {
      float windx = map(noise(xoff, yoff, zoff), 0, 1, 0, 3);
      float windz = map(noise(xoff+3000, yoff+3000, zoff), 0, 1, -1, 1);

      Vec3D wind = new Vec3D(windx, 0, windz/3);
      particles[i][j].addForce(wind);
      yoff+=0.1;
    }
    xoff+=0.1;
  }
  zoff+=0.1;


  noFill();
  stroke(100);
  textureMode(NORMAL);
  for (int j = 0; j< rows-1; j++) {
    beginShape(TRIANGLE_STRIP);
    texture(img);
    for (int i = 0; i< cols; i++) {
      float x1 = particles[i][j].x;
      float y1 = particles[i][j].y;
      float z1 = particles[i][j].z;
      float u = map(i, 0, cols-1, 0, 1);
      float v = map(j, 0, rows-1, 0, 1);
      float x2 = particles[i][j+1].x;
      float y2 = particles[i][j+1].y;
      float z2 = particles[i][j+1].z;
      vertex(x1, y1, z1, u, v);
      v = map(j+1, 0, rows-1, 0, 1);
      vertex(x2, y2, z2, u, v);
    }
    endShape();
  }


  //for (Spring s : springs)
  //{
  //  s.display();
  //}

  stroke(255);
  strokeWeight(4);

  line(-cols*w/2-100, -rows*w/2, -cols*w/2-100, height);
  strokeWeight(1);
}  