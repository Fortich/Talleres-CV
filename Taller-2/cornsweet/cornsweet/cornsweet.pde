boolean draw_square;

void setup(){
  size(1024,500);
  draw_square = true;
}

void draw(){
  background(125);
  fill(135);
  stroke(135);
  rect(width/2,0,width,height);
  if (draw_square) {
    fill(color(210, 180, 140));
    rect((width/2) - 100, 0, 200, height);
  }
}

void mousePressed() {
  draw_square = !draw_square;
}
