class Genes{
   int size;
   ArrayList<DabPoly> dabs;
   public Genes(int size){
     this.size = size;
     this.dabs = new ArrayList<DabPoly>();
   }
   public Genes(int size, ArrayList<DabPoly> dabs){
     this.size = size;
     this.dabs = dabs;
   }
}