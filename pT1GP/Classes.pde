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
