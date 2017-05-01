class DNA {
  int size = 3;
  Genes genes;
  public DNA(){
    genes = new Genes(this.size);
  }
  public DNA(int size){
    this.size = size;
    genes = new Genes(this.size);
  }
  public DNA(int size, ArrayList<DabPoly> dabs){
    this.size = size;
    this.genes = new Genes(size, dabs);
  }
  
  DNA crossover(DNA partner) {
    ArrayList<DabPoly> newdabs = new ArrayList<DabPoly>(this.genes.size);
    int mid = floor(random(this.genes.size));
    for (int i = 0; i < this.genes.size; i++) {
      if (i > mid) {
        DabPoly dab = this.genes.dabs.get(i);
        newdabs.add(new DabPoly(dab.numPoints, dab.points, dab.col));
        //newdabs.add(new DabRect(dab.x, dab.y, dab.h, dab.w, dab.a, dab.col));
      } else {
        DabPoly dab = partner.genes.dabs.get(i);
        newdabs.add(new DabPoly(dab.numPoints, dab.points, dab.col));
        //newdabs.add(new DabPoly(dab.x, dab.y, dab.h, dab.w, dab.a, dab.col));
      }
    }
    DNA newDNA =  new DNA(this.size, newdabs);
    newdabs = null;
    return newDNA;
  }

  void mutation() {
    if(pop.popsize == 2){
        if(this.genes.size < pop.maxShapes && random(1) < 1/150.0){
          this.genes.size++;
          this.genes.dabs.add(floor(random(this.genes.dabs.size())), new DabPoly());
        } 
         if(this.genes.size > 1 && random(1) < 1/1000.0){
          this.genes.dabs.remove(random(this.genes.dabs.size()));
          this.genes.size--; 
        }
    }       
    if(this.genes.size > 1 && random(1) < 1/700.0){
      int index = floor(random(this.genes.size));
      int index2 = floor(random(this.genes.size));
      Collections.swap(this.genes.dabs, index, index2);
    } 
    for (int i = 0; i < this.genes.size; i++) { 
      this.genes.dabs.get(i).mutate();
    }
  }

}