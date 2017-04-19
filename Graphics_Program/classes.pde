//-----------------------
class c_button {

  int x, y, w, h, ax, ay;
  color val, ov;
  String p_val;
  boolean b_c;
  PImage img_icon;
  //---
  c_button(int _x, int _y, int _w, int _h, color _def, int _ax, int _ay) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    val = _def;
    ax = _ax;
    ay = _ay;
    ov = color(240, 50);
    b_c = true;
  }
  //---
  void draw(PGraphics _p) {
    _p.fill(val);
    _p.stroke(255);
    _p.rect(x, y, w, h, 5);
    if (over()) {
      _p.fill(ov);
      _p.noStroke();
      _p.rect(x, y, w, h, 5);
    }
  }
  //---
  boolean over() {
    if (mouseX >= ax && mouseX <= ax+w && mouseY >= ay && mouseY <= ay+h) {
      return true;
    } else {
      return false;
    }
  }
  //---
  void col_get() {
    if (over()){
      col_current = val;
      b_col_change = true;
    }
  }
  //---
  void p_get() {
    if (over()){
      v_b_update.set_brush(img_icon);
      v_b_update.update();
    }
  }
  //---
  void p_set(String _i) {
    p_val = _i;
    b_c = false;
    img_icon = loadImage(p_val);
  }
  //---
  void p_draw(PGraphics _p) {
    _p.fill(val);
    _p.stroke(col_gui[2]);
    _p.strokeWeight(3);
    _p.rect(x, y, w, h, 5);
    _p.image(img_icon, x+5, y+5, w-10, h-10);
    if (over()) {
      _p.fill(ov);
      _p.noStroke();
      _p.rect(x, y, w, h, 5);
    }
  }
  //---
  void s_draw(PGraphics _p){
    _p.fill(0,0);
    _p.strokeWeight(3);
    if (over()){
      _p.stroke(col_gui[3]);
    } else {
      _p.stroke(col_gui[2]);
    }
    _p.shape(v_sav,x,y);
  }
  //---
  void s_add(){
    if (over() && b_c){
      if (al_cb.size() < 18){
        int i_loc = al_cb.size();
        int i_row = floor(i_loc/6);
        int i_col = i_loc%6;
        al_cb.add(new c_button(49*i_col,55+(50*i_row),35,35,col_current,710+(49*i_col),400+(50*i_row)));
      }
    }
  }
  //---
  void s_add_b(){
    if (over() && !b_c){
      v_b_update.add_brush();
    }
  }
  //---

  void set_sb(){
    b_c = false;
  }
}
//-----------------------
class c_slide {
  int x, y, w, h, ax, ay, i_val;
  color c_h, c_l, c_c, ov;
  //---
  c_slide(int _x, int _y, int _w, int _h, int _i, color _ch, color _cl, int _ax, int _ay) {
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
    c_c = lerpColor(c_l, c_h, float(i_val)/float(h));
  }
  //---
  boolean over() {
    if (mouseX >= ax && mouseX <= ax+w && mouseY >= ay && mouseY <= ay+h) {
      return true;
    } else {
      return false;
    }
  }
  //---
  void draw(PGraphics _p) {
    c_c = lerpColor(c_l, c_h, float(i_val)/float(h));
    _p.fill(0);
    _p.noStroke();
    _p.rect(x, y, w, h);
    _p.fill(c_c);
    _p.rect(x, y+(h-i_val), w, h-(h-i_val));
    _p.noFill();
    if (over()) {
      _p.stroke(col_gui[3]);
    } else {
      _p.stroke(col_gui[2]);
    }
    _p.strokeWeight(3);
    _p.rect(x, y, w, h);
  }
  //---
  void set_val(int _v) {
    i_val = int(map(_v, 0, 255, 0, 100));
  }
  //---
  int get_val() {
    return i_val;
  }
  //---
  void adj_val() {
    if (over()) {
      i_val = h-(mouseY-ay);
    }
  }
}
//-----------------------
class c_mix {

  int x, y, w, h, ax, ay;
  color c_a, c_b;
  PShader shad;
  int b0x, b1x, b0y, b1y, bw, bh, b0ax, b1ax, b0ay, b1ay;
  PShape b0s, b1s;
  boolean[] b_mo;
  //---
  c_mix(int _x, int _y, int _w, int _h, color _a, color _b, PShader _sh, int _ax, int _ay, PShape _but) {
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
  void update_shader() {
    shad.set("a_col", red(c_a)/255, green(c_a)/255, blue(c_a)/255, 1.0);
    shad.set("b_col", red(c_b)/255, green(c_b)/255, blue(c_b)/255, 1.0);
    shad.set("i_res", float(w), float(h));
  }
  //---
  void draw(PGraphics _p) {
    update_shader();
    _p.shader(shad);
    _p.fill(0);
    _p.rect(0, 0, w, h);
    _p.resetShader();
    _p.noFill();
    if (over()) {
      _p.stroke(col_gui[3]);
    } else {
      _p.stroke(col_gui[2]);
    }
    _p.strokeWeight(3);
    _p.rect(0, 0, w, h);
    _p.noStroke();
  }
  //---
  void draw_but(PGraphics _p) {
    b0s.disableStyle();
    b1s.disableStyle();
    b0s.setFill(color(0, 0));
    b1s.setFill(color(0, 0));
    if (over_b()[0]) {
      _p.stroke(col_gui[3]);
    } else {
      _p.stroke(col_gui[2]);
    }
    _p.shape(b0s, b0x, b0y);
    if (over_b()[1]) {
      _p.stroke(col_gui[3]);
    } else {
      _p.stroke(col_gui[2]);
    }
    _p.shape(b1s, b1x, b1y);
  }
  //---
  boolean[] over_b() {
    boolean[] b = new boolean[2];
    if (mouseX >= b0ax && mouseX <= b0ax+bw && mouseY >= b0ay && mouseY <= b0ay+bh) {
      b[0] = true;
    } else {
      b[0] = false;
    }
    if (mouseX >= b1ax && mouseX <= b1ax+bw && mouseY >= b1ay && mouseY <= b1ay+bh) {
      b[1] = true;
    } else {
      b[1] = false;
    }
    return b;
  }
  //---
  boolean over() {
    if (mouseX >= ax && mouseX <= ax+w && mouseY >= ay && mouseY <= ay+h) {
      return true;
    } else {
      return false;
    }
  }
  //---
  void col_get() {
    if (over()) {
      float val = map(float(mouseX-ax), 0.0, float(w), 0.0, 1.0);
      col_current = lerpColor(c_a, c_b, val);
      b_col_change = true;
    }
  }
  //---
  void update_col() {
    if (over_b()[0]) {
      c_a = col_current;
    }
    if (over_b()[1]) {
      c_b = col_current;
    }
  }
}
//-----------------------
public class c_brush {
  int x, y, w, h;
  PImage ig_brush;
  color col_paint;
  PGraphics bf_outputb;
  PShader sh_b;
  Path path;
  //---
  c_brush(PImage _in, color _c, PShader _b) {
    x=0;
    y=0;
    w=_in.width;
    h=_in.height;
    ig_brush = _in;
    col_paint = _c;
    bf_outputb = createGraphics(w, h, P2D);
    bf_outputb.beginDraw();
    bf_outputb.clear();
    bf_outputb.endDraw();
    sh_b = _b;
  }
  //---
  PGraphics update(){
    sh_b.set("in_col",red(col_paint)/255,green(col_paint)/255,blue(col_paint)/255);
    sh_b.set("i_res",float(w),float(h));
    sh_b.set("in_brush",ig_brush);
    bf_outputb.beginDraw();
    bf_outputb.clear();
    bf_outputb.shader(sh_b);
    bf_outputb.fill(255);
    bf_outputb.rect(0,0,w,h);
    bf_outputb.endDraw();
    return bf_outputb;
  }
  //---
  void set_brush(PImage _b){
    ig_brush = _b;
    w = _b.width;
    h = _b.height;
    bf_outputb = createGraphics(w, h, P2D);
    bf_outputb.beginDraw();
    bf_outputb.clear();
    bf_outputb.endDraw();
  }
  //---
  void set_col(color _c){
    col_paint = _c;
  }
  void add_brush(){
    selectInput("Select a png to add", "fileSelected", null, this);
  }
  //---
  void fileSelected(File selection){
    b_loading = true;
    if (selection == null) println("Window was closed or the user hit cancel.");

    else if (!selection.isFile()) println("\"" + selection + "\" is an invalid file.");

    else {
      println("User selected " + (path = Paths.get(selection.getAbsolutePath())));
      Path source = Paths.get(selection.getAbsolutePath());
      int f_size = al_bb.size();
      String new_b_name = nf(f_size+1,2)+".png";
      println(new_b_name);
      Path new_dir = Paths.get(sketchPath()+"/data/brush/"+new_b_name);
      println(new_dir);
      try{
        Files.copy(source, new_dir);
      } catch (IOException e) {
        println("it didnt work");}
      update_bpal();
    }
  b_loading = false;
  }
}
