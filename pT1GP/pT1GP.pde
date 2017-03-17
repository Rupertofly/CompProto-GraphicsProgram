PGraphics pCanvas;
color cCanvas_colour = color(20,20,20);
color cF_color = color(0,0,0);
PVector vOld_Pos = new PVector(0,0);

void setup() {
        size(1024,768,P2D);
        frameRate(120);
        background(cCanvas_colour);
        pCanvas = createGraphics(1024,768);
        pCanvas.beginDraw();
        pCanvas.clear();
        pCanvas.endDraw();

}
void draw() {
        background(cCanvas_colour);
        noStroke();
        fill(255);
        image(pCanvas,0,0);
        ellipse(mouseX,mouseY,20,20);

}
void mouseDragged(){
        pCanvas.beginDraw();
        pCanvas.noFill();
        pCanvas.stroke(abs(sin(radians(map(mouseX,0,width,0,360))))*255,abs(sin(radians(90+map(mouseX,0,width,0,360))))*255,abs(sin(radians(45+map(mouseX,0,width,0,360))))*255);
        pCanvas.strokeWeight(20);
        pCanvas.line(mouseX,mouseY,vOld_Pos.x,vOld_Pos.y);
        pCanvas.endDraw();
        vOld_Pos = new PVector(mouseX,mouseY);
}
void mousePressed(){
        vOld_Pos = new PVector(mouseX,mouseY);
}
