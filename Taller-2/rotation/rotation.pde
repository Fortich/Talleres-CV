PShape shape;

float rotation = 0;
boolean w_mouse = false;
boolean w_no_mouse = true;

void setup(){
  size(1024,600, P2D);
  shape = loadShape("princess.svg");
  shapeMode(CENTER);
}

void draw() {
  rotate();
  handle_rotation();
}

void rotate(){
  background(20);
  
  translate(width/2, height/2);
  rotate(rotation);
  shape(shape);
}

void handle_rotation(){
  if (w_mouse) {
    if (mouseX <= width/4 || mouseX >= 3*width/4){
      rotation = rotation + map(mouseX, 0, width, -0.01, 0.01);
    }
  } else {
    rotation += 0.01;
  }
}

void mouseClicked(){
  w_mouse = w_no_mouse;
  w_no_mouse = !w_no_mouse;
}
