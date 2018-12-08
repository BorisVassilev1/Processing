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
            float angle = random(0,TWO_PI);
            float radius = 100;
            PVector position = new PVector(sin(angle),0, cos(angle)).mult(random(0,radius));
            particles[nextParticle] = (new Particle(position,new PVector(0,random(1,2),0),color(255),particleLifetime));
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
  PVector vel;
  int lifetime;
  int remainingLifetime;
  
  Particle(PVector pos, PVector vel, color Color, int lifetime)
  {
    this.pos = pos;
    this.vel = vel;
    this.Color = Color;
    this.lifetime = lifetime;
    remainingLifetime = lifetime;
  }
  
  void draw()
  {
    {
      vel.add(a1.modify(pos));
      //vel.limit(3);
      pos.add(vel);
    }
    {
      PVector XZ = vel.copy();
      XZ.y = 0;
      Color = color((XZ.mag()- 0.5) * 300,(XZ.mag()- 0.5) * 300,255,remainingLifetime);
      
      noFill();
      stroke(Color);
      point(pos.x,pos.y,pos.z);
    }
    remainingLifetime -= 1;
  }
}

class Vortex
{
  PVector pos = new PVector();
  float power = 0;
  float distAmp = 0;
  
  Vortex(PVector pos, float power, float distanceAmplifier)
  {
    this.pos = pos;
    this.power = power;
    this.distAmp = distanceAmplifier;
  }
  
  PVector modify(PVector p)
  {
    PVector delta = p.copy().sub(pos).normalize();
    PVector deltaXZ = pos.copy().sub(p);
    deltaXZ.y = 0;
    delta.y = 0;
    PVector result = RotateY(PI * 0.5,delta).mult(power);
    float multiplier = 1/(deltaXZ.mag() / 100);
    //result.mult(multiplier);
    result.y = 0;
    return result;
  }
}
