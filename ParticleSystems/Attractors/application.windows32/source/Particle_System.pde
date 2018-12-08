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
  cam = new PeasyCam(this,100);
  ps = new ParticleSystem(1,5,10000,1500);
  colorMode(RGB);
  a1 = new Attractor(new PVector(100,50, -100),0.01,0.5);
  a2 = new Attractor(new PVector(-100,-100,0),0.01,0.5);
  a3 = new Attractor(new PVector(-200,-200,-200),0.01,0.5);
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
  translate(a2.pos.x,a2.pos.y,a2.pos.z);
  sphere(5);
  translate(-a2.pos.x,-a2.pos.y,-a2.pos.z);
  translate(a3.pos.x,a3.pos.y,a3.pos.z);
  sphere(5);
  translate(-a3.pos.x,-a3.pos.y,-a3.pos.z);
  ps.draw();
}

class ParticleSystem
{
  Particle[] particles;
  int timePassed = 0;
  int spawnOffset;
  int particlesCount = 0;
  int particleLifetime = 0;
  int particlesPerFrame = 0;
  
  ParticleSystem(int spawnOffset, int particlesPerSpawnFrame, int maxParticles, int particleLifetime)
  {
    this.particles = new Particle[maxParticles];
    this.spawnOffset = spawnOffset;
    this.particleLifetime = particleLifetime;
    this.particlesPerFrame = particlesPerSpawnFrame;
  }
  
  void draw()
  {
    timePassed +=1;
    for(int i = 0; i < particles.length; i ++)
    {
      Particle p = particles[i];
      if(p != null)
      {
        p.draw();
        if(p.remainingLifetime == 0)
        {
          particles[i] = null;
          particlesCount --;
        }
      }
    }
    if(timePassed == spawnOffset)
    {
      for(int i = 0; i < particlesPerFrame; i ++)
      {
        for(int nextParticle = 0; nextParticle < particles.length ; nextParticle ++)
        {
          if(particles[nextParticle] == null)
          {
            timePassed = 0;
            float transparency = /*random(100,255)*/ 255;
            particles[nextParticle] = (new Particle(new PVector(),new PVector(random(-0.5,0.5),random(-1,-2),random(-0.5,0.5)),color(255,255,255,transparency),random(10,30),particleLifetime));
            particlesCount += 1;
            break;
          }
        }
      }
    }
  }
}

class Particle
{
  PVector pos;
  color Color;
  float size;
  PVector vel;
  int lifetime;
  int remainingLifetime;
  
  Particle(PVector pos, PVector vel, color Color, float size, int lifetime)
  {
    this.pos = pos;
    this.vel = vel;
    this.Color = Color;
    this.size = size;
    this.lifetime = lifetime;
    remainingLifetime = lifetime;
  }
  
  void draw()
  {
    {
      vel.add(a1.modify(pos));
      vel.add(a2.modify(pos));
      vel.add(a3.modify(pos));
      vel.limit(3);
      pos.add(vel);
    }
    {
      Color = color((vel.mag()- 0.5) * 300,(vel.mag()- 0.5) * 300,255,remainingLifetime);
      
      noFill();
      stroke(Color);
      point(pos.x,pos.y,pos.z);
    }
    remainingLifetime -= 1;
  }
}

class Attractor
{
  PVector pos = new PVector();
  float power = 0;
  float distAmp = 0;
  
  Attractor(PVector pos, float power, float distanceAmplifier)
  {
    this.pos = pos;
    this.power = power;
    this.distAmp = distanceAmplifier;
  }
  
  PVector modify(PVector p)
  {
    return pos.copy().sub(p).normalize().mult(power).mult(1/(pos.dist(p) / 100));
  }
}
