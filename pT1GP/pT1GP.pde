
PGraphics pCanvas;
PGraphics pFinal;
PGraphics pCursor;
PShader sShader;
color cCanvas_colour = color(20,20,20);
color cF_color = color(0,0,0);
PVector vOld_Pos = new PVector(0,0);
ArrayList<r_button> b_array = new ArrayList<r_button>();

//-----------------------------
void setup() {
  size(1280,1280,P2D);
  frameRate(120);
  background(cCanvas_colour);
  pCanvas = createGraphics(width-200,height,P2D);
  pFinal = createGraphics(width-200,height,P2D);
  pCursor = createGraphics(width-200,height,P2D);
  pCanvas.beginDraw();
  pCanvas.clear();
  pCanvas.endDraw();
  pFinal.beginDraw();
  pFinal.clear();
  pFinal.endDraw();
}
//-----------------------------
void draw() {
  sShader = loadShader("myShader.glsl");
  pFinal.shader(sShader);
  sShader.set("iResolution",float(width-200),float(height),0);
  sShader.set("tex",pCanvas);
  pFinal.beginDraw();
  pFinal.rect(0,0,width-200,height);
  pFinal.endDraw();
  background(cCanvas_colour);
  noStroke();

  image(pFinal,0,0);
  pCursor.beginDraw();
  pCursor.clear();
  pCursor.fill(255,200);
  pCursor.noStroke();
  pCursor.ellipse(mouseX,mouseY,20,20);
  pCursor.endDraw();
  image(pCursor,0,0);
  for (int i = 0; i<b_array.size(); i++) {
	r_button but = b_array.get(i);
	but.update();
	but.draw();
  }
}
//-----------------------------
void mouseDragged(){
  pCanvas.beginDraw();
  pCanvas.noFill();
  pCanvas.stroke(0);
  pCanvas.strokeWeight(20);
  pCanvas.line(mouseX,mouseY,pmouseX,pmouseY);
  pCanvas.endDraw();
  vOld_Pos = new PVector(mouseX,mouseY);
}
//-----------------------------
void mousePressed(){
  vOld_Pos = new PVector(mouseX,mouseY);
  b_array.add(new r_button(mouseX,mouseY,color(random(255),random(255),random(255))));
}
