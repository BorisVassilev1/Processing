float Distance(PVector point1,PVector point2)
{
    return sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y));
}

class Segment
{
    PVector begin;
    PVector end;
    
    public Segment(PVector begin, PVector end)
    {
        this.begin = begin;
        this.end = end;
    }
    
    PVector delta() {
      
      return new PVector(
        end.x - begin.x,
        end.y - begin.y
      );
      //return end.add(begin.mult(-1));
  
}
    
    void draw(color Color){
        fill(Color);
        ellipse(begin.x,begin.y,4,4);
        ellipse(end.x,end.y,4,4);
        
        stroke(Color);
        line(begin.x,begin.y,end.x,end.y);
    }
    
    PVector intersect(Segment a){
        float multi = this.delta().y - a.delta().y * this.delta().x / a.delta().x;
        float other = a.begin.y + a.delta().y * begin.x / a.delta().x - a.delta().y * a.begin.x / a.delta().x - begin.y;
        float q = other / multi;
        float t = (begin.x - a.begin.x + this.delta().x * q) / a.delta().x;
        float ansx = a.begin.x + a.delta().x * t;
        float ansy = a.begin.y + a.delta().y * t;
        if(q > 0 && q < 1 && t > 0 && t < 1){
        return new PVector(ansx, ansy);
        } else {
            return null;
        }
    }
    
     Segment add(PVector translationVector){
        return new Segment(
            this.begin.add(translationVector),
            this.end.add(translationVector));
    }
}
