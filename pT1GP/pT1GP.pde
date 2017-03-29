
PGraphics pCanvas;
PGraphics pFinal;
PGraphics pCursor;
PGraphics pGui;
PGraphics pMixer;
PShader sShader;
PShader sMixShader;
color cCanvas_colour = color(20,20,20);
color cF_color = color(0,0,0);
PVector vOld_Pos = new PVector(0,0);
ArrayList<r_button> b_array = new ArrayList<r_button>();
ArrayList<r_slide> s_array = new ArrayList<r_slide>();
r_mixer mixer;

//-----------------------------
void setup() {
  size(1200,800,P2D);
  frameRate(120);
  background(cCanvas_colour);
  pCanvas = createGraphics(width-200,height,P2D);
  pFinal = createGraphics(width-200,height,P2D);
  pCursor = createGraphics(width-200,height,P2D);
  pGui = createGraphics(200,height,P2D);
  pMixer = createGraphics(150,50,P2D);
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
  sShader.set("iResolution",float(width-200),float(height),1.0,1.0);
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
  int[] Acolor = new int[3];
  for (int i = 0; i < 3; i ++){
    r_slide a = s_array.get(i);
    Acolor[i] = floor(map(a.getVal(),0,150,0,255));
  }
  mixer.setA(Acolor[0],Acolor[1],Acolor[2]);
  pMixer.beginDraw();
  mixer.draw(pMixer);
  pMixer.endDraw();
  pGui.beginDraw();
  pGui.clear();
  pGui.imageMode(CENTER);
  pGui.image(pMixer,mixer.getX(),mixer.getY());
  for (int i = 0; i<s_array.size(); i++){
   r_slide slider = s_array.get(i);
   slider.update();
   slider.draw(pGui);
  }
  for (int i = 0; i<b_array.size(); i++) {
	r_button but = b_array.get(i);
	but.update();
	but.draw(pGui);
  }
  pGui.endDraw();
  image(pGui,width-200,0);
  int[] col = new int[3];
  for (int i = 0;i<s_array.size();i++){
    r_slide slider = s_array.get(i);
    col[i] = ceil(map(slider.getVal(),0,150,0,255));
  }
  rectMode(CENTER);
  fill(color(col[0],col[1],col[2]));
  rect(width/2,height/2,50,50);
}
//-----------------------------
void mouseDragged(){
  pCanvas.beginDraw();
  pCanvas.noFill();
  pCanvas.stroke(0);
  pCanvas.strokeWeight(20);
  pCanvas.line(mouseX,mouseY,pmouseX,pmouseY);
  pCanvas.endDraw();
  for (r_slide slider : s_array){
    slider.val_update();
  }
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
	  b_array.add(new r_button((i*40)+15,(o*40)+25,color(random(255),random(255),random(255))));
	}
  }
  s_array.add(new r_slide(100,500,70,color(200,0,0),color(240,0,0)));
  s_array.add(new r_slide(100,600,70,color(0,200,0),color(0,240,0)));
  s_array.add(new r_slide(100,700,70,color(0,0,200),color(0,0,240)));
  mixer = new r_mixer (100,400,"mixShader.glsl");
}
