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

// -----------------
void setup(){
  size(1020,780,P2D);
  bf_gui = createGraphics(loc_gui[1][0],loc_gui[1][1]);
}
// -----------------
void draw(){

}

// -----------------


// -----------------
