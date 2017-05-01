// Need G4P library
import g4p_controls.*;
//other things
import java.util.Collections;
PImage img;
PGraphics cnv, cnvCalc;
Population pop;
ColorUtil cu;
color bg;
int w, h;
int steps;
boolean resize = true;
boolean loop = false;
boolean started = false;
String selMethod = "Dynamic";
int t = 0;
int tOff = 0;
int tempTime = 0;
boolean bw = false;


public void setup(){
  surface.setResizable(true);
  size(100, 100, P2D);
  createGUI();
  customGUI();
  // Place your setup code here
  
}

public void draw(){
  
  if(loop){
    if(resize){
      surface.setSize(w * 2, h);
      resize = false;
    }
    image(img, 0, 0);
    for(int i = 0; i < steps; i++){
      pop.eval();   
      pop.selections();
    }
    cnv.beginDraw();
    cnv.background(bg);
    cnv.noStroke();
    pop.showBest();
    cnv.endDraw();   
    image(cnv, w, 0); 
  } else tOff = int(System.nanoTime()/1E9) - tempTime;
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}

//helper functions
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    selected.setText(selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
  }
}

void preload(){
  selectInput("Select an image to process:", "fileSelected");
  while(img == null) delay(100);
  img.loadPixels();
  w = img.width;
  h = img.height;
  while(w > 700 || h > 700) {
    w *= 0.8;
    h *= 0.8;
  }
  img.resize(w, h);
  img.loadPixels();
  cnv = createGraphics(w, h);
  cnvCalc = createGraphics(w, h, P2D); 
}