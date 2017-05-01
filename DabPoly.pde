class DabPoly extends Dab{
  float[] points;
  int numPoints;
  color col;
  
  public DabPoly(){
    this.points = new float[14];
    float x = random(cnv.width);
    float y = random(cnv.height);
    for(int i = 0; i < 14; i++) if(i % 2 == 0) this.points[i] = x + random(-20,20); else this.points[i] = y + random(-20,20);
    this.numPoints = floor(random(3, 5));
    if(!bw) this.col =  color(random(255), random(255), random(255), random(10, 60));
    else this.col = color(random(255), random(10, 60));

  }
  public DabPoly(int numPoints, float[] ps, color col){
    this.numPoints = numPoints;
    this.points = ps.clone();
    this.col = color(col);
  }
  
  void restart(){
    //this.points = null;
    //this.points = new float[10];
    float x = random(cnv.width);
    float y = random(cnv.height);
    for(int i = 0; i < 14; i++) if(i % 2 == 0) this.points[i] = x + random(-3,3); else this.points[i] = y + random(-3,3);
    this.numPoints = floor(random(3, 5));
    if(!bw) this.col =  color(random(255), random(255), random(255), random(10, 60));
    else this.col = color(random(255), random(10, 60));
  }

  void mutate(){
    float prob1 = 1/1500.0;
    if(random(1) < prob1) {
      if(this.numPoints < 7) this.numPoints++;
    }
    if(random(1) < prob1) {
      if(this.numPoints > 3) this.numPoints--;
    }
    float r = red(this.col);
    float g = green(this.col);
    float b = blue(this.col);
    float a = alpha(this.col);
    if(!bw){
      if(random(1) < prob1) this.col = color(random(255), g, b, a);
      if(random(1) < prob1) this.col = color(r, random(255), b, a);
      if(random(1) < prob1) this.col = color(r, g, random(255), a);
      if(random(1) < prob1) this.col = color(r, g, b, random(10, 60)); 
      if(random(1) < prob1) this.col = color(r +random(-5,5), g +random(-5,5), b +random(-5,5), a +random(-5,5)); 
    }
    else{
      if(random(1) < prob1) this.col = color(random(255), random(10, 60)); 
      if(random(1) < prob1) this.col = color((r + g + b)/3.0 + random(-10, 10), a + random(-5,5)); 
    }


    for(int i = 0; i < 14; i++) {
      if(random(1) < prob1) if(i % 2 == 0) this.points[i] = random(cnv.width); else this.points[i] = random(cnv.height);
      if(random(1) < prob1) this.points[i] += random(-20, 20);
      if(random(1) < prob1) this.points[i] += random(-3, 3); 
    }
    
    if(random(1) < prob1){
      int index = floor(random(14));
      int index2 = floor(random(14));
      float p = this.points[index];
      this.points[index] = this.points[index2];
      this.points[index2] = p;
    }
    if(random(1) < prob1) this.restart();
  }
  
  void load(PGraphics c){
    c.fill(this.col);    
    //c.noStroke();
    c.beginShape();
    for(int i = 0; i < this.numPoints * 2; i += 2) c.vertex(this.points[i], this.points[i+1]);
    c.endShape(CLOSE);
  }
}