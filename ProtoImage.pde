class ProtoImage implements Comparable<ProtoImage> {
  float fitness;
  PGraphics g; //createGraphics(400, 400);
  DNA dna;
  
  @Override
  int compareTo(ProtoImage other){
    ProtoImage p = (ProtoImage)other;
    if(this.fitness < p.fitness) return -1;
    if(this.fitness > p.fitness) return 1;
    return 0;
  }
  
  public ProtoImage(PGraphics canv){
    this.g = canv;
    this.fitness = Float.MAX_VALUE;
    this.dna = new DNA();
    for(int i = 0; i < this.dna.genes.size; i++) this.dna.genes.dabs.add(new DabPoly());
  }
  
  public ProtoImage(PGraphics canv, int numShapes){
    this.g = canv;
    this.fitness = Float.MAX_VALUE;
    this.dna = new DNA(numShapes);
    for(int i = 0; i < this.dna.genes.size; i++) this.dna.genes.dabs.add(new DabPoly());
  }
  
  void restart(){
    for(int i = 0; i < this.dna.genes.dabs.size(); i++)
    this.dna.genes.dabs.get(i).restart();
  }
    
  void show(PGraphics canv){
    for(int i = 0; i < this.dna.genes.size; i++) {
      this.dna.genes.dabs.get(i).load(canv);
    }
  }

  void calcFitness(){ 
    this.fitness = 0.0;
    this.g.beginDraw();
    this.g.background(bg);
    this.g.noStroke();
    int size = this.dna.genes.size;
    for(int i = 0; i < size; i++) {
      this.dna.genes.dabs.get(i).load(this.g);
    } 
    this.g.endDraw();
    this.g.loadPixels(); 
    float redImg, redPro, greenImg, greenPro, blueImg, bluePro;
    int len = img.pixels.length;
    for(int i = 0; i < len; i++){
      redImg = red(img.pixels[i]);
      redPro = red(this.g.pixels[i]);
      greenImg = green(img.pixels[i]);
      greenPro = green(this.g.pixels[i]);
      blueImg = blue(img.pixels[i]);
      bluePro = blue(this.g.pixels[i]);
      this.fitness += (redImg - redPro) * (redImg - redPro)
         + (greenImg - greenPro) * (greenImg - greenPro)
         + (blueImg - bluePro) * (blueImg - bluePro);
      //float[] imgarr = {redImg, greenImg, blueImg};
      //float[] cnvarr = {redPro, greenPro, bluePro};
      //this.fitness += cu.deltaE(cu.rgb2lab(imgarr), cu.rgb2lab(cnvarr));
    }
  }

}