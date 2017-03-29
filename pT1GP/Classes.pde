class r_button {

  int x;
  int y;
  color i_color;
  int istroke;
  int b_width = 30;
  int b_height = 30;
  int x_a = width-200;

	//--
  r_button(int _x, int _y, color _c) {
	x = _x;
	y = _y;
	i_color = _c;
  }
	//--
  void draw(PGraphics _p) {
	_p.stroke(255);
	_p.fill(i_color);
	_p.strokeWeight(istroke);
	_p.rectMode(CENTER);
	_p.rect(x,y,b_width,b_height,5);
  }
	//--
  void update(){
		if(test_pos()) {
	  	istroke = 3;

		} else{
	  istroke = 1;
		}
  }
	//--
  boolean test_pos(){
	if(
	  x-(floor(b_width/2)) < mouseX-x_a && mouseX-x_a < x+(floor(b_width/2)) &&
	  y-(floor(b_height/2)) < mouseY && mouseY < y+(floor(b_height/2))
	  ) {
	  return true;
	} else {
	  return false;
	}
  }
}

class r_slide{
	int x;
	int y;
	int sWid=150;
	int sHei=30;
	int sVal;
	int iStroke;
	color aCol;
	color bCol;
	//--
	r_slide(int _x, int _y, int _sVal, color _a, color _b){
		x = _x;
		y = _y;
		sVal = _sVal;
		aCol = _a;
		bCol = _b;
	}
	//--
	boolean test_pos(){
		if (
			x-(floor(sWid/2)) < mouseX - (width-200) && mouseX - (width-200) < x+(floor(sWid/2)) &&
			y-(floor(sHei/2)) < mouseY && mouseY < y+(floor(sHei/2))
			){
				return true;
			} else {
				return false;
			}
	}
	//--
	void update(){
		if(test_pos()){
			iStroke = 3;
		} else {
			iStroke = 1;
		}
	}
	//--
	void draw(PGraphics _p){
		_p.rectMode(CENTER);
		_p.stroke(255);
		_p.strokeWeight(iStroke);
		_p.fill(aCol);
		_p.rect(x,y,sWid,sHei,2);
		_p.rectMode(CORNER);
		_p.noStroke();
		_p.fill(bCol);
		_p.rect((x-floor(sWid/2))+2,(y-floor(sHei/2))+2,sVal,sHei-2);
	}
	//--
	void val_update(){
		if (test_pos()){
			sVal = mouseX - ((width-200)+(x-floor(sWid/2)));
			println(sVal);
		}
	}
	int getVal(){
		return sVal;
	}
}

class r_mixer{

  int x;
  int y;
  int[] aIn = new int[3];
  int[] bIn = new int[3];
  int wid = 150;
  int hei = 50;
  String shaderP;
  PShader shader;
//--
  r_mixer(int _x, int _y, String _sPath){
    x = _x;
    y = _y;
    shaderP = _sPath;
    aIn[0] = 0;
    aIn[1] = 0;
    aIn[2] = 100;
    bIn[0] = 0;
    bIn[1] = 250;
    bIn[2] = 0;
  }
	//--
  void draw(PGraphics _p){
    shader = loadShader(shaderP);
		//shader.set("iResolution",150.0,50.0,0.0);
		shader.set("aCol",float(aIn[0])/255.0,float(aIn[1])/255.0,float(aIn[2])/255.0,0.0);
		shader.set("bCol",float(bIn[0])/255.0,float(bIn[1])/255.0,float(bIn[2])/255.0,0.0);
    shader.set("pos",float(x),float(y));
    shader.set("size",float(wid),float(hei));
    shader.set("time",float(millis()));
		_p.shader(shader);
		_p.noStroke();
		_p.rect(0,0,wid,hei);
  }
	int getX(){
		return x;
	}
	int getY(){
		return y;
	}
	void setA( int _r, int _g, int _b){
		aIn[0] = _r;
		aIn[1] = _g;
		aIn[2] = _b;
	}
}
