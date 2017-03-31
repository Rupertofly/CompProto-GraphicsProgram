// -----------------
// Buffers (bf_*)

// Main
PGraphics bf_canvas;
PGraphics bf_cursor;
PGraphics bf_splash;
// GUI
PGraphics bf_gui;
PGraphics bf_mix;
PGraphics bf_window;
PGraphics bf_swatch;
PGraphics bf_brush;

// Shaders (sh_*)

PShader sh_mix;

// Relative buffer location  2D Arrays (loc_*)([x,y][w,h])

final int[][] loc_canvas = { {20,20},{640,740} };
final int[][] loc_cursor = { {20,20},{640,740} };

final int[][] loc_gui = { {700,20},{300,740} };
final int[][] loc_mix = { {10,10},{280,300} };
final int[][] loc_window = { {70,130},{140,80} };
final int[][] loc_swatch = { {10,325},{280,200} };
final int[][] loc_brush = { {10,545},{280,195} };

// colors (col_*)
final color[] col_defaults = {#eb2b34,#f59535,#5fb94d,#2c92cd,#9f4dff,#000000,#ffffff};
final color[] col_gui = {#383839,#BCBDC0,#D9DADB,#ffffff};

color col_current;
color col_ga;
color col_gb;

// file paths (pa_*)
String pa_shader = "mix_shad.glsl";
String pa_bush = "brush/";

// Array Lists (al_*)
ArrayList<c_button> al_cb = new ArrayList<c_button>();
ArrayList<c_button> al_bb = new ArrayList<c_button>();

// images (ig_*)

PImage ig_current;
PImage ig_import;

// logic Booleans (b_*)

boolean b_col_change = false;

// various (v_*)
c_mix v_mix;

c_slide v_slide_r;
c_slide v_slide_g;
c_slide v_slide_b;

PShape v_but;

// -----------------
void setup(){
  size(1020,780,P2D);
  background(col_gui[0]);
  bf_gui = createGraphics(loc_gui[1][0],loc_gui[1][1],P2D);
  bf_canvas = createGraphics(loc_canvas[1][0],loc_canvas[1][1],P2D);
  gui_setup();
}
// -----------------
void draw(){
  smooth();
  gui_draw();
  image(bf_gui,loc_gui[0][0],loc_gui[0][1]);
}

// -----------------
void gui_setup(){
  sh_mix = loadShader(pa_shader);
  v_but = loadShape("b.svg");
  bf_mix = createGraphics(loc_mix[1][0],loc_mix[1][1],P2D);
  bf_window = createGraphics(loc_window[1][0],loc_window[1][1],P2D);
  bf_gui.beginDraw();
  bf_gui.clear();
  bf_gui.endDraw();
  bf_mix.beginDraw();
  bf_mix.clear();
  bf_mix.endDraw();
  bf_window.beginDraw();
  bf_window.clear();
  bf_window.endDraw();
  v_mix = new c_mix(loc_window[0][0],loc_window[0][1],
                    loc_window[1][0],loc_window[1][1],
                    col_defaults[1],col_defaults[0],sh_mix,
                    780,160,v_but);
  v_slide_r = new c_slide(140,10,30,100,50,color(255,0,0),color(0,0,0),850,40);
  v_slide_g = new c_slide(185,10,30,100,50,color(0,255,0),color(0,0,0),895,40);
  v_slide_b = new c_slide(230,10,30,100,50,color(0,0,255),color(0,0,0),940,40);

}

// -----------------
void gui_draw(){
  col_current = color(v_slide_r.get_val(),v_slide_g.get_val(),v_slide_b.get_val());
  if (mouseX >= loc_gui[0][0] && mouseX <= loc_gui[0][0]+loc_gui[1][0]&&
      mouseY >= loc_gui[0][1] && mouseY <= loc_gui[0][1]+loc_gui[1][1]){

    bf_window.beginDraw();
    v_mix.draw(bf_window);
    bf_window.endDraw();
    bf_mix.beginDraw();
    bf_mix.image(bf_window,loc_window[0][0],loc_window[0][1]);
    v_slide_r.draw(bf_mix);
    v_slide_g.draw(bf_mix);
    v_slide_b.draw(bf_mix);
    v_mix.draw_but(bf_mix);
    bf_mix.endDraw();

    bf_gui.beginDraw();
    bf_gui.background(col_gui[1]);
    bf_gui.image(bf_mix,loc_mix[0][0],loc_mix[0][1]);

    bf_gui.endDraw();
  }
}
// -----------------
void mouseClicked(){
  v_mix.update_col();
}
