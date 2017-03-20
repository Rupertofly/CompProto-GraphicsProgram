PGraphics pCanvas;
PGraphics pFinal;
PShader sShader;
color cCanvas_colour = color(20,20,20);
color cF_color = color(0,0,0);
PVector vOld_Pos = new PVector(0,0);

void setup() {
        size(1024,768,P2D);
        frameRate(120);
        background(cCanvas_colour);
        pCanvas = createGraphics(1024,768,P2D);
        pFinal = createGraphics(1024,768,P2D);
        pCanvas.beginDraw();
        pCanvas.clear();
        pCanvas.endDraw();
        pFinal.beginDraw();
        pFinal.clear();
        pFinal.endDraw();

}
void draw() {
        sShader = loadShader("myShader.glsl");
        pFinal.shader(sShader);
        sShader.set("iResolution",float(width),float(height),0);
        sShader.set("tex",pCanvas);
        pFinal.beginDraw();
        pFinal.rect(0,0,width,height);
        pFinal.endDraw();
        background(cCanvas_colour);
        noStroke();
        fill(255);
        image(pFinal,0,0);
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
