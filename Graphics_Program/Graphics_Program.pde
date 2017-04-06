import java.io.File;
import java.nio.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.io.IOException;
import java.io.BufferedWriter;
import java.nio.file.StandardCopyOption.*;
// -----------------
// Buffers (bf_*)

// Main
PGraphics bf_canvas;
PGraphics bf_cursor;

PGraphics bf_brush;
// GUI
PGraphics bf_gui;
PGraphics bf_mix;
PGraphics bf_window;
PGraphics bf_swatch;
PGraphics bf_bpallete;

// Shaders (sh_*)

PShader sh_mix;
PShader sh_brush;

// Relative buffer location  2D Arrays (loc_*)([x,y][w,h])

final int[][] loc_canvas = { {20, 20}, {640, 740} };
final int[][] loc_cursor = { {20, 20}, {640, 740} };

final int[][] loc_gui = { {700, 20}, {300, 740} };
final int[][] loc_mix = { {10, 10}, {280, 300} };
final int[][] loc_window = { {70, 130}, {140, 80} };
final int[][] loc_swatch = { {10, 325}, {280, 200} };
final int[][] loc_bpallete = { {10, 545}, {280, 195} };

// colors (col_*)
final color[] col_defaults = {#eb2b34, #f59535, #5fb94d, #2c92cd, #9f4dff, #000000, #FFFFFF};
final color[] col_gui = {#383839, #BCBDC0, #D9DADB, #ffffff};

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
PImage ig_splash;

// logic Booleans (b_*)

boolean b_col_change = false;
boolean b_loading = false;
boolean b_splash;

// various (v_*)
c_button[] v_def_buts = new c_button[7];
c_button v_sav_swatch;
c_button v_sav_brush;

c_mix v_mix;

c_slide v_slide_r;
c_slide v_slide_g;
c_slide v_slide_b;

c_brush v_b_update;

PShape v_but;
PShape v_sav;

// -----------------
void setup() {

  ig_import = loadImage("brush/01.png");
  ig_splash = loadImage("splash.png");
  b_splash = true;
  col_current = color(150,150,150);
  background(col_gui[0]);
  bf_gui = createGraphics(loc_gui[1][0], loc_gui[1][1], P2D);
  bf_canvas = createGraphics(loc_canvas[1][0], loc_canvas[1][1], P2D);
  sh_brush = loadShader("brush_shad.glsl");
  gui_setup();
  update_bpal();

  gui_draw();
  canvas_draw();
}
// -----------------
void draw() {
  if (b_splash){
    image(ig_splash,0,0);
  } else{
    gui_update();
    background(col_gui[0]);
    image(bf_gui, loc_gui[0][0], loc_gui[0][1]);
    fill(240);
    noStroke();
    rect(loc_canvas[0][0],loc_canvas[0][1],loc_canvas[1][0],loc_canvas[1][1]);
    image(bf_canvas, loc_canvas[0][0], loc_canvas[0][1]);
  }
  if (keyPressed) {
    if (key == ' ' && b_splash == true) {
      b_splash = false;
    }
  }
}
// -----------------
void gui_setup() {
  sh_mix = loadShader(pa_shader);
  v_but = loadShape("b.svg");
  v_sav = loadShape("save.svg");
  v_sav.disableStyle();
  bf_mix = createGraphics(loc_mix[1][0], loc_mix[1][1], P2D);
  bf_window = createGraphics(loc_window[1][0], loc_window[1][1], P2D);
  bf_swatch = createGraphics(loc_swatch[1][0], loc_swatch[1][1], P2D);
  bf_bpallete = createGraphics(loc_bpallete[1][0], loc_bpallete[1][1], P2D);
  bf_gui.beginDraw();
  bf_gui.clear();
  bf_gui.endDraw();
  bf_mix.beginDraw();
  bf_mix.clear();
  bf_mix.endDraw();
  bf_window.beginDraw();
  bf_window.clear();
  bf_window.endDraw();
  bf_swatch.beginDraw();
  bf_swatch.clear();
  bf_swatch.endDraw();
  bf_bpallete.beginDraw();
  bf_bpallete.clear();
  bf_bpallete.endDraw();
  v_mix = new c_mix(loc_window[0][0], loc_window[0][1],
    loc_window[1][0], loc_window[1][1],
    col_defaults[1], col_defaults[0], sh_mix,
    780, 160, v_but);
  v_slide_r = new c_slide(140, 10, 30, 100, 50, color(255, 0, 0), color(0, 0, 0), 850, 40);
  v_slide_g = new c_slide(185, 10, 30, 100, 50, color(0, 255, 0), color(0, 0, 0), 895, 40);
  v_slide_b = new c_slide(230, 10, 30, 100, 50, color(0, 0, 255), color(0, 0, 0), 940, 40);
  for (int s = 0; s < 7; s++){
    v_def_buts[s] = new c_button(40+(s*35),5,30,30,col_defaults[s],750+(s*35),350);
  }
  v_sav_swatch = new c_button(0,0,35,35,col_gui[3],710,345);
  v_sav_brush = new c_button(0,0,35,35,col_gui[3],710,565);
  v_sav_brush.set_sb();
  brush_setup();
}

// -----------------
void gui_update() {
  if (!b_col_change) {
    col_current = col_grab();
  } else {
    v_slide_r.set_val(int(red(col_current)));
    v_slide_g.set_val(int(green(col_current)));
    v_slide_b.set_val(int(blue(col_current)));
    b_col_change = false;
  }
  gui_draw();
}
// -----------------
void mouseClicked() {
  v_mix.update_col();
  for (int s = 0; s < 7; s++){
    v_def_buts[s].col_get();
  }
  v_sav_swatch.s_add();
  v_sav_brush.s_add_b();
  for (c_button b: al_cb){
    b.col_get();
  }
  for (c_button b: al_bb){
    b.p_get();
  }
}
// -----------------
void mouseDragged() {
  v_slide_r.adj_val();
  v_slide_b.adj_val();
  v_slide_g.adj_val();
  v_mix.col_get();
  p_draw();
}
// -----------------
color col_grab() {
  int r = int(map(v_slide_r.get_val(), 0, 100, 0, 255));
  int g = int(map(v_slide_g.get_val(), 0, 100, 0, 255));
  int b = int(map(v_slide_b.get_val(), 0, 100, 0, 255));
  return color(r, g, b);
}
void mousePressed(){
  v_slide_r.adj_val();
  v_slide_b.adj_val();
  v_slide_g.adj_val();
  v_mix.col_get();
  v_b_update.set_col(col_current);
  bf_brush = v_b_update.update();
  p_draw();
}
void brush_setup(){

  v_b_update = new c_brush(ig_import, col_current, sh_brush);
  bf_brush = v_b_update.update();
}
void settings(){
  smooth();
  size(1020, 780, P2D);
}
// -----------------
void gui_draw(){
  bf_window.beginDraw();
  v_mix.draw(bf_window);
  bf_window.endDraw();
  bf_mix.beginDraw();
  bf_mix.image(bf_window, loc_window[0][0], loc_window[0][1]);
  v_slide_r.draw(bf_mix);
  v_slide_g.draw(bf_mix);
  v_slide_b.draw(bf_mix);
  v_mix.draw_but(bf_mix);
  bf_mix.fill(col_current);
  bf_mix.stroke(col_gui[2]);
  bf_mix.strokeWeight(3);
  bf_mix.rect(0, 0, 120, 120, 5);
  bf_mix.endDraw();
  bf_swatch.beginDraw();
  for (int s = 0; s < 7; s++){
    v_def_buts[s].draw(bf_swatch);
  }
  for (c_button b: al_cb){
    b.draw(bf_swatch);
  }
  v_sav_swatch.s_draw(bf_swatch);
  bf_swatch.endDraw();
  if (!b_loading){
    bf_bpallete.beginDraw();
    for (c_button p: al_bb){
      p.p_draw(bf_bpallete);
    }
    v_sav_brush.s_draw(bf_bpallete);
    bf_bpallete.endDraw();
  }
  bf_gui.beginDraw();
  bf_gui.background(col_gui[1]);
  bf_gui.image(bf_mix, loc_mix[0][0], loc_mix[0][1]);
  bf_gui.image(bf_swatch, loc_swatch[0][0], loc_swatch[0][1]);
  bf_gui.image(bf_bpallete, loc_bpallete[0][0], loc_bpallete[0][1]);

  bf_gui.endDraw();
}
// -----------------
void update_bpal(){
  java.io.File folder = new java.io.File(dataPath("brush"));
  String[] filenames = folder.list();
  al_bb.clear();
  c_button bru;
  // display the filenames
  for (int i = 0; i < filenames.length; i++) {
    println(filenames[i]);
    int i_loc = al_bb.size();
    int i_row = floor(i_loc/6);
    int i_col = i_loc%6;
    bru = new c_button(49*i_col, 55+(50*i_row), 35, 35, col_gui[3], 710+(49*i_col), 620+(50*i_row) );
    bru.p_set("brush/"+filenames[i]);
    al_bb.add(bru);

  }
}
// -----------------
void canvas_draw(){

}
void p_draw(){
  if (mouseX > (loc_canvas[0][0]-5) && mouseX < (loc_canvas[0][0]+loc_canvas[1][0]+5) && mouseY > loc_canvas[0][1]+5 && mouseY < loc_canvas[0][1]+(loc_canvas[1][1]+5)){

    bf_canvas.beginDraw();
    bf_canvas.image(bf_brush,(mouseX-(32/2))-20,(mouseY-(32/2))-20,32,32);
    bf_canvas.endDraw();
  }
}
