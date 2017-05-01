class Population {
  ArrayList<ProtoImage> pImages;
  int popsize;
  int[] matingpool;
  boolean newFit;
  int gen = 0;
  int maxShapes = 300;  
  int numShapes = 0;
  public Population(int size){
    this.pImages = new ArrayList<ProtoImage>();
    //this.matingpool = new ArrayList<Integer>();
    this.popsize = size;
    this.newFit = false;
    for (int i = 0; i < this.popsize; i++) {
      //ProtoImage proto = new ProtoImage(cnvCalc);
      this.pImages.add(new ProtoImage(cnvCalc));
    }
  }
  
    public Population(int size, int numShapes){
      this.pImages = new ArrayList<ProtoImage>();
      //this.matingpool = new ArrayList<Integer>();
      this.popsize = size;
      this.numShapes = numShapes;
      this.newFit = false;
      for (int i = 0; i < this.popsize; i++) {
        //ProtoImage proto = new ProtoImage(cnvCalc, numShapes);
        this.pImages.add(new ProtoImage(cnvCalc, numShapes));
      }
  }
  
  void eval() {
    if(this.popsize == 2){
      this.newFit = false;
      this.pImages.get(1).calcFitness();
      if (this.pImages.get(1).fitness < this.pImages.get(0).fitness) {
         this.newFit = true;
      }
    }
    else {
     for (int i = 0; i < this.popsize; i++) {
        this.pImages.get(i).calcFitness();
      }
     Collections.sort(this.pImages);
     this.matingpool = new int[this.popsize * 10];
     for (int i = 0; i < this.popsize * 10; i++) {
       float index = 0.5 + 1;
       float r = random(1);
       while(r < 1.0/index) {
         index++;     
         if(round(index - (0.5 + 1)) >= this.popsize){
           index = 0.5 + 1;
           r = random(1);
         }
       }
       this.matingpool[i] = round(index - (0.5 + 1));
     }
    }       //<>//
  }

  void selections() {    
    
    if(this.popsize == 2){
    
      if(this.newFit){
        this.pImages.get(0).fitness = this.pImages.get(1).fitness;
        
        this.pImages.get(0).dna.genes.dabs = new ArrayList<DabPoly>();
        for (int i = 0; i < this.pImages.get(1).dna.genes.size; i++) {
          DabPoly dab = this.pImages.get(1).dna.genes.dabs.get(i);
          this.pImages.get(0).dna.genes.dabs.add(new DabPoly(dab.numPoints, dab.points, dab.col));
          //this.pImages.get(0).dna.genes.dabs.add(new DabRect(dab.x, dab.y, dab.h, dab.w, dab.a, dab.col));
        }
        this.pImages.get(0).dna.genes.size = this.pImages.get(1).dna.genes.size;  
        this.pImages.get(1).dna.mutation();
      } 
      else {   
        this.pImages.get(1).dna.genes.dabs = new ArrayList<DabPoly>();
        for (int i = 0; i < this.pImages.get(0).dna.genes.size; i++) {
          DabPoly dab = this.pImages.get(0).dna.genes.dabs.get(i);
          this.pImages.get(1).dna.genes.dabs.add(new DabPoly(dab.numPoints, dab.points, dab.col));
          //this.pImages.get(0).dna.genes.dabs.add(new DabRect(dab.x, dab.y, dab.h, dab.w, dab.a, dab.col));
        }
        this.pImages.get(1).dna.genes.size = this.pImages.get(0).dna.genes.size;     
        this.pImages.get(1).dna.mutation();
      }
      
    }
    else {
       for (int i = 0; i < 4*(this.popsize / 5); i++) {
         DNA parentA = this.pImages.get(this.matingpool[floor(random(this.popsize * 10))]).dna;
         DNA parentB = this.pImages.get(this.matingpool[floor(random(this.popsize * 10))]).dna;
         DNA child = parentA.crossover(parentB);
         child.mutation();
         this.pImages.get(i + (this.popsize / 5)).dna = child;
       }
       this.matingpool = null;
    } 
     this.gen++;
  }

  void showBest() {
    
    //println("Generation: " + this.gen);
    //println("Number of shapes: " + this.pImages.get(0).dna.genes.size);
    //println("Fitness: " + this.pImages.get(0).fitness);
    generation.setText("Generation: " + this.gen);
    shapes.setText("Number of shapes: " + this.pImages.get(0).dna.genes.size);
    fitness.setText("Fitness: " + this.pImages.get(0).fitness);
    this.pImages.get(0).show(cnv);
    //System.gc();
  }
}