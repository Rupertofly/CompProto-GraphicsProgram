
PGraphics pCanvas;
PGraphics pFinal;
PGraphics pCursor;
PGraphics pGui;
PShader sShader;
color cCanvas_colour = color(20,20,20);
color cF_color = color(0,0,0);
PVector vOld_Pos = new PVector(0,0);
ArrayList<r_button> b_array = new ArrayList<r_button>();
r_slide slider;

//-----------------------------
void setup() {
  size(1280,1280,P2D);
  frameRate(120);
  background(cCanvas_colour);
  pCanvas = createGraphics(width-200,height,P2D);
  pFinal = createGraphics(width-200,height,P2D);
  pCursor = createGraphics(width-200,height,P2D);
  pGui = createGraphics(200,height,P2D);
  gui_init();
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
  pGui.beginDraw();
  pGui.clear();
  slider.update();
  slider.draw(pGui);
  for (int i = 0; i<b_array.size(); i++) {
	r_button but = b_array.get(i);
	but.update();
	but.draw(pGui);
  }
  pGui.endDraw();
  image(pGui,width-200,0);
}
//-----------------------------
void mouseDragged(){
  pCanvas.beginDraw();
  pCanvas.noFill();
  pCanvas.stroke(0);
  pCanvas.strokeWeight(20);
  pCanvas.line(mouseX,mouseY,pmouseX,pmouseY);
  pCanvas.endDraw();
  slider.val_update();
  vOld_Pos = new PVector(mouseX,mouseY);
}
//-----------------------------
void mousePressed(){
  vOld_Pos = new PVector(mouseX,mouseY);
  //if(mouseX>width-200) b_array.add(new r_button(mouseX-(width-200),mouseY,color(random(255),random(255),random(255))));
  for (int i = 0; i<b_array.size(); i++) {
	r_button but = b_array.get(i);
	if (but.test_pos()) {
    pCanvas.beginDraw();
	  pCanvas.clear();
    pCanvas.endDraw();
    pFinal.beginDraw();
    pFinal.clear();
    pFinal.endDraw();
	}
  }
}
//-------------------------------
void gui_init(){
  fill(10);
  noStroke();
  rect(width-195,5,width-5,height-5);
  for (int i = 0; i<5; i++) {
	for (int o = 0; o<8; o++) {
	  b_array.add(new r_button((i*40)+25,(o*40)+25,color(random(255),random(255),random(255))));
	}
  }
  slider = new r_slide(100,500,70,color(0,200,0),color(0,240,0));
}
