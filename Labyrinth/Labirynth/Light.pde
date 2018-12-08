
//ArrayList<Segment> segments = new ArrayList<Segment>();


//ArrayList<ArrayList<PVector>> polygons = new ArrayList<ArrayList<PVector>>();
//PVector boundPoint = null;
//PVector lightSource = new PVector(width / 2, height / 2);
//int pointSize = 10;

class Segment {
  PVector begin;
  PVector end;
  public Segment(PVector start, PVector end) {
      this.begin = start;
      this.end = end;
  }
  float side(PVector vector) {
      float x = vector.x;
      float y = vector.y;
      return (x - begin.x) * (end.y - begin.y) - (y - begin.y) * (end.x - begin.x);
  }
  void draw() {
      line(begin.x,begin.y,end.x,end.y);
  }
  PVector intersect1(Segment a){
        float multi = this.delta().y - a.delta().y * this.delta().x / a.delta().x;
        float other = a.begin.y + a.delta().y * this.begin.x / a.delta().x - a.delta().y * a.begin.x / a.delta().x - this.begin.y;
        float q = other / multi;
        float t = (this.begin.x - a.begin.x + this.delta().x * q) / a.delta().x;
        float ansx = a.begin.x + a.delta().x * t;
        float ansy = a.begin.y + a.delta().y * t;
        if(q > 0 && q < 1 && t > 0 && t < 1){
        return new PVector(ansx, ansy);
        } else {
            return null;
        }
  }
  
  PVector intersect2(Segment a)
  {
    //koga ne se presichat?
    if(this.dist() < new Segment(begin,a.begin).dist())
    {
      
    }
    //else kude se presichat?
    
    return new PVector(0,0);
  }
  
  PVector delta() {return this.end.add(this.begin.mult(-1));}
  
  float dist() {return sqrt((begin.x - end.x) * (begin.x - end.x) + (begin.y - end.y) * (begin.y - end.y));};
}
 
//float area_determinant (PVector p1, PVector p2, PVector p3) {
//    return (p2.x - p1.x) * (p3.y - p2.y) - (p3.x - p2.x) * (p2.y - p1.y);
//}
 
//boolean clockwise (PVector p1, PVector p2, PVector p3) {
//    return area_determinant (p1, p2, p3) < 0;
//}
 
//int quadrant(PVector origin, PVector vec) {
//    if (vec.x <= origin.x && vec.y >= origin.y) {
//        return 1;
//    } if (vec.x <= origin.x && vec.y <= origin.y) {
//        return 2;
//    } if (vec.x >= origin.x && vec.y <= origin.y) {
//        return 3;
//    } if (vec.x >= origin.x && vec.y >= origin.y) {
//        return 4;
//    }
//    return 0;
//}
 
//PVector canvasIntersectionPoint(Segment seg) {
//    float k = (seg.end.y - seg.start.y) / (seg.end.x - seg.start.x);
//    float offset = seg.start.y - k * seg.start.x;
 
//    PVector vec1, vec2, vec3, vec4;
//    vec1 = new PVector(0, offset);
//    vec2 = new PVector(- offset / k, 0);
//    vec3 = new PVector(width, k * width + offset);
//    vec4 = new PVector((height - offset) / k, height);
 
//    int quad = quadrant(seg.start, seg.end);
 
//    if (seg.start.x == seg.end.x) {
//        if (seg.end.y < seg.start.y) {
//            return new PVector(seg.start.x, 0);
//        } else {
//            return new PVector(seg.start.x, height);
//        }
//    } if (seg.start.y == seg.end.y) {
//        if (seg.end.x > seg.start.x) {
//            return new PVector(width, seg.start.y);
//        } else {
//            return new PVector(0, seg.start.y);
//        }
//    }
//    if (quad == 1) {
//        if (vec1.y < vec4.y) {
//            return vec1;
//        } else {
//            return vec4;
//        }
//    } if (quad == 2) {
//        if (vec2.y > vec1.y) {
//            return vec2;
//        } else {
//            return vec1;
//        }
//    } if (quad == 3) {
//        if (vec3.x < vec2.x) {
//            return vec3;
//        } else {
//            return vec2;
//        }
//    } if (quad == 4) {
//        if (vec4.x < vec3.x) {
//            return vec4;
//        } else {
//            return vec3;
//        }
//    }  
//    return null;
//}
 
//void updatePolygons() {
//    polygons = new ArrayList<ArrayList<PVector>>();
 
//    for (int i=0; i<segments.size(); i++) {
//        PVector start = segments.get(i).start, end = segments.get(i).end;
//        if (clockwise(lightSource, start, end)) {
//            start = segments.get(i).end;
//            end = segments.get(i).start;
//        }
 
//        polygons.add(new ArrayList<PVector>());
//        PVector intersection1 = canvasIntersectionPoint( new Segment(lightSource, start) );
//        PVector intersection2 = canvasIntersectionPoint( new Segment(lightSource, end) );
 
//        if ((intersection1.x == intersection2.x && (intersection1.x == 0 || intersection1.x == width))
//         || (intersection1.y == intersection2.y && (intersection1.y == 0 || intersection1.y == height))) {
 
//            polygons.get(i).add(intersection1);
//            polygons.get(i).add(start);
//            polygons.get(i).add(end);
//            polygons.get(i).add(intersection2);
 
//        } else {
//            ArrayList<PVector> additionals = new ArrayList<PVector>();
//            if (intersection1.y == 0 && intersection2.x == width) {
//                additionals.add(new PVector(width, 0));
//            } else if (intersection1.x == width && intersection2.y == height) {
//                additionals.add(new PVector(width, height));
//            } else if (intersection1.y == height && intersection2.x == 0) {
//                additionals.add(new PVector(0, height));
//            } else if (intersection1.x == 0 && intersection2.y == 0) {
//                additionals.add(new PVector(0, 0));
//            } else if (intersection1.x == 0 && intersection2.x == width) {
//                additionals.add(new PVector(0, 0));
//                additionals.add(new PVector(width, 0));
//            } else if (intersection1.y == 0 && intersection2.y == height) {
//                additionals.add(new PVector(width, 0));
//                additionals.add(new PVector(width, height));
//            } else if (intersection1.x == width && intersection2.x == 0) {
//                additionals.add(new PVector(width, height));
//                additionals.add(new PVector(0, height));
//            } else if (intersection1.y == height && intersection2.y == 0) {
//                additionals.add(new PVector(0, height));
//                additionals.add(new PVector(0, 0));
//            } else if (intersection1.x == 0 && intersection2.y == height) {
//                additionals.add(new PVector(0, 0));
//                additionals.add(new PVector(width, 0));
//                additionals.add(new PVector(width, height));
//            } else if (intersection1.y == 0 && intersection2.x == 0) {
//                additionals.add(new PVector(width, 0));
//                additionals.add(new PVector(width, height));
//                additionals.add(new PVector(0, height));
//            } else if (intersection1.x == width && intersection2.y == 0) {
//                additionals.add(new PVector(width, height));
//                additionals.add(new PVector(0, height));
//                additionals.add(new PVector(0, 0));
//            } else if (intersection1.y == height && intersection2.x == width) {
//                additionals.add(new PVector(0, height));
//                additionals.add(new PVector(0, 0));
//                additionals.add(new PVector(width, 0));
//            }
 
//            polygons.get(i).add(intersection1);
//            for (int j=0; j<additionals.size(); j++) {
//                polygons.get(i).add(additionals.get(j));
//            }
//            polygons.get(i).add(intersection2);
//            polygons.get(i).add(end);
//            polygons.get(i).add(start);
//        }
//    }
//}
 
//void drawPolygons() {
//    if (segments.size() >= 1) {
//        for (int i=0; i<polygons.size(); i++) {
//          beginShape();
//          for (int j=0; j<polygons.get(i).size(); j++) {
//              vertex(polygons.get(i).get(j).x, polygons.get(i).get(j).y);
//          }
//          endShape();
//        }
//    }
//}
 
//function draw() {
//    context.fillStyle = "black";
//    context.fillRect(0, 0, canvas.width, canvas.height);
 
//    var gradient = context.createRadialGradient(lightSource.x, lightSource.y, 1000, lightSource.x, lightSource.y, 0);
//    gradient.addColorStop(0, 'rgba(0, 0, 0, 0)');
//    gradient.addColorStop(1, 'rgba(255, 255, 0, 1)');
//    context.fillStyle = gradient;
//    context.fillRect(0, 0, canvas.width, canvas.height);
 
//    context.fillStyle = "black";
//    context.strokeStyle = "black";
//    drawPolygons();
 
//    for (var i=0; i<segments.length; i++) {
//        var rgbStr = "blue";
//        context.strokeStyle = rgbStr;
//        context.lineWidth = 1;
//        segments[i].draw();
//    }
 
//    context.fillStyle = "green";
//    context.fillRect(lightSource.x - pointSize / 2, lightSource.y - pointSize / 2, pointSize, pointSize);
//}
 

 
//void mouseMoved() {
//    if (boundPoint != null) {
//        boundPoint.x = mouseX;
//        boundPoint.y = mouseY;
 
//        updatePolygons();
//    }
//}
 
//void mousePressed() {
//    if (boundPoint != null) {
//        boundPoint = null;
//    } else {
//        if (areColliding(lightSource.x - pointSize / 2, lightSource.y - pointSize / 2, pointSize, pointSize,
//                        mouseX, mouseY, 1, 1)) {
//            boundPoint = lightSource;
//        } else {
//            segments.add(new Segment(
//                new Vector(mouseX, mouseY),
//                new Vector(mouseX, mouseY)
//            ));
//            boundPoint = segments[segments.length - 1].end;
//        }
 
//        updatePolygons();
//    }
//}
