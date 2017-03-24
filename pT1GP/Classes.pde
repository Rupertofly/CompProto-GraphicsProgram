class r_button {

  int x;
  int y;
  color b_color;
  int b_width = 50;
  int b_height = 50;


  r_button(int _x, int _y, color _c) {
    x = _x;
    y = _y;
    b_color = _c;
  }
  void draw() {
    stroke(255);
    rectMode(CENTER);
    rect(x,y,b_width,b_height,5);
  }
  void update(){
    if (x-(b_width/2) < mouseX && mouseX < x+(b_width/2) && y-(b_height/2) < mouseY && mouseY < y+(b_height/2)){
      fill((b_color >> 8)+20,(b_color>>16)+20,(b_color>>24)+20);
    } else{
      fill(b_color);
    }
  }
}
