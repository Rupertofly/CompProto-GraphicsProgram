//-----------------------
class c_button {

  int x, y, w, h, ax, ay;
  color val, ov;
  PImage p_val;
  //---
  c_button(int _x, int _y, int _w, int _h, color _def, int _ax, int _ay ){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    val = _def;
    ax = _ax;
    ay = _ay;
    ov = color(240,50);
  }
  //---
  void draw(PGraphics _p){
    _p.fill(val);
    _p.stroke(255);
    _p.rect(x,y,w,h,5);
    if (over()){
      _p.fill(ov);
      _p.noStroke();
      _p.rect(x,y,w,h,5);
    }
  }
  //---
  boolean over(){
    if (mouseX >= ax && mouseX <= ax+w && mouseY >= ay && mouseY <= ay+h){
      return true;
    } else {
      return false;
    }
  }
  //---
  void col_get(){
    col_current = val;
  }
  //---
  void p_set(PImage _i){
    p_val = _i;
  }
  //---
  void p_draw(PGraphics _p){
    _p.fill(val);
    _p.stroke(col_gui[2]);
    _p.strokeWeight(3);
    _p.rect(x,y,w,h,5);
    _p.image(p_val,x,y,w-5,h-5);
    if (over()){
      _p.fill(ov);
      _p.noStroke();
      _p.rect(x,y,w,h,5);
    }
  }
  //---
}
//-----------------------
class c_slide{
  int x, y, w, h, ax, ay, i_val;
  color c_h, c_l, c_c, ov;
  //---
  c_slide(int _x, int _y, int _w, int _h, int _i, color _ch, color _cl, int _ax, int _ay){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    ax = _ax;
    ay = _ay;
    c_h = _ch;
    c_l = _cl;
    i_val = _i;
    ov = color(240, 50);
    c_c = lerpColor(c_l,c_h,i_val/w);
  }
  //---
  boolean over(){
    if (mouseX >= ax && mouseX <= ax+w && mouseY >= ay && mouseY <= ay+h){
      return true;
    } else {
      return false;
    }
  }
  //---
  void draw(PGraphics _p){
    _p.fill(0);
    _p.noStroke();
    _p.rect(x,y,w,h);
    _p.fill(c_c);
    _p.rect(x,y+(w-i_val),w,h-(w-i_val));
    _p.noFill();
    if (over()){
      _p.stroke(col_gui[3]);
    } else {
      _p.stroke(col_gui[2]);
    }
    _p.strokeWeight(3);
    _p.rect(x,y,w,h);
  }
  //---
  void set_val(int _v){
    i_val = _v;
  }
  //---
  int get_val(){
    return i_val;
  }
  //---
  void adj_val(){
    if (over()){
      i_val = w-(mouseY-ay);
    }
  }
}
//-----------------------
class c_mix{

  int x, y, w, h, ax, ay;
  color c_a, c_b;
  PShader shad;
  int b0x, b1x, b0y, b1y, bw, bh, b0ax, b1ax, b0ay, b1ay;
  PShape b0s, b1s;
  boolean[] b_mo;
  //---
  c_mix(int _x, int _y, int _w, int _h, color _a, color _b, PShader _sh, int _ax, int _ay, PShape _but){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    ax = _ax;
    ay = _ay;
    c_a = _a;
    c_b = _b;
    shad = _sh;
    b0x = _x - 55;
    b1x = _x + 155;
    b0y = _y + 20;
    b1y = _y + 20;
    b0ax = _ax - 55;
    b1ax = _ax + 155;
    b0ay = _ay + 20;
    b1ay = _ay + 20;
    bw = 40;
    bh = 40;
    b0s = _but;
    b1s = _but;
  }
  //---
  void update_shader(){
    shad.set("a_col",red(c_a)/255,blue(c_a)/255,green(c_a)/255,1.0);
    shad.set("b_col",red(c_b)/255,blue(c_b)/255,green(c_b)/255,1.0);
    shad.set("i_res",float(w),float(h));
  }
  //---
  void draw(PGraphics _p){
    update_shader();
    _p.shader(shad);
    _p.rect(x,y,w,h);
    _p.resetShader();
    _p.noFill();
    if(over()) {
      _p.stroke(col_gui[3]);
    } else {
      _p.stroke(col_gui[2]);
    }
    _p.strokeWeight(3);
    _p.rect(x,y,w,h);
    _p.noStroke();
    //-
    if (over_b()[0]){
      b0s.setStroke(col_gui[3]);
    } else {
      b0s.setStroke(col_gui[2]);
    }
    _p.shape(b0s,b0x,b0y);
    if (over_b()[1]){
      b1s.setStroke(col_gui[3]);
    } else {
      b1s.setStroke(col_gui[2]);
    }
    _p.shape(b1s,b1x,b1y);
  }
  //---
  boolean[] over_b(){
    boolean[] b = new boolean[2];
    if (mouseX >= b0ax && mouseX <= b0ax+bw && mouseY >= b0ay && mouseY <= b0ay+bh){
      b[0] = true;
    } else {
      b[0] = false;
    }
    if (mouseX >= b1ax && mouseX <= b1ax+bw && mouseY >= b1ay && mouseY <= b1ay+bh){
      b[1] = true;
    } else {
      b[1] = false;
    }
    return b;
  }
  //---
  boolean over(){
    if (mouseX >= ax && mouseX <= ax+w && mouseY >= ay && mouseY <= ay+h){
      return true;
    } else {
      return false;
    }
  }
  //---
  void col_get(){
  if(over()){
    float val = map(float(mouseX-ax),0.0,float(w),0.0,1.0);
    col_current = lerpColor(c_a,c_b,val);
    }
  }
  //---
  void update_col(){
    if(over_b()[0]){
      c_a = col_current;
    }
    if (over_b()[1]){
      c_b = col_current;
    }
  }
}
