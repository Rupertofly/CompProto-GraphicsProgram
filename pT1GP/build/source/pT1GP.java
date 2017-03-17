import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pT1GP extends PApplet {

PGraphics pCanvas;
int cCanvas_colour = color(20,20,20);
int cF_color = color(0,0,0);
PVector vOld_Pos = new PVector(0,0);

public void setup() {
        
        frameRate(120);
        background(cCanvas_colour);
        pCanvas = createGraphics(1024,768);
        pCanvas.beginDraw();
        pCanvas.clear();
        pCanvas.endDraw();

}
public void draw() {
        background(cCanvas_colour);
        noStroke();
        fill(255);
        image(pCanvas,0,0);
        ellipse(mouseX,mouseY,20,20);

}
public void mouseDragged(){
        pCanvas.beginDraw();
        pCanvas.noFill();
        pCanvas.stroke(abs(sin(radians(map(mouseX,0,width,0,360))))*255,abs(sin(radians(90+map(mouseX,0,width,0,360))))*255,abs(sin(radians(45+map(mouseX,0,width,0,360))))*255);
        pCanvas.strokeWeight(20);
        pCanvas.line(mouseX,mouseY,vOld_Pos.x,vOld_Pos.y);
        pCanvas.endDraw();
        vOld_Pos = new PVector(mouseX,mouseY);
}
public void mousePressed(){
        vOld_Pos = new PVector(mouseX,mouseY);
}
  public void settings() {  size(1024,768,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pT1GP" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
