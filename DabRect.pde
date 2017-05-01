class DabRect extends Dab{
  float x, y, h, w, a;
  color col;
  
  public DabRect(){
    this.x = random(cnv.width);
    this.y = random(cnv.height);
    this.h = random(10, 150);
    this.w = this.h;//random(50, 200);
    this.a = 0;//random(0 , 2 * PI);
    this.col =  color(random(255), random(255), random(255), 80);
  }
  public DabRect(float x, float y, float h,float w, float a,color col){
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    this.a = a;
    this.col = col;
  }
  
  
  void restart(){
    this.x = random(cnv.width);
    this.y = random(cnv.height);
    this.h = random(10, 150);
    this.w = this.h;//random(50, 200);
    this.a = 0;//random(0 , 2 * PI);
    this.col = color(random(255), random(255), random(255), 80);
  }

  void mutate(){
    if(random(1) < 0.1) this.x = random(cnv.width);
    if(random(1) < 0.1) this.y = random(cnv.height);
    if(random(1) < 0.1){ this.h = random(10, 150); this.w=this.h;}
    //if(random(1) < 0.1) this.w = random(50, 200);
    if(random(1) < 0.1) this.a = 0;//random(0 , 2 * PI);
    if(random(1) < 0.1) this.col = color(random(255), random(255), random(255), 80);
  }
  
  void load(PGraphics c){
      c.pushMatrix();
      c.rotate(a);
      c.fill(this.col);
      c.noStroke();
      c.rect(this.x, this.y, this.h, this.w);
      c.popMatrix();
  }
}