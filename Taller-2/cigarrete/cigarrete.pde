color white = 255;
color black = 0;
float pos_cig_mobile;
float rotation;

boolean stop_drawing_background;

void setup(){
  pos_cig_mobile = width/4-5;
  rotation = 0;
  size(1024,500,P3D);
  stop_drawing_background = false;
}

void draw(){
  if(!stop_drawing_background){
    left_wall();
    main_wall();
    right_wall();
    line_cigarrete_static();
  }
  line_cigarrete_mobile();
  rotation += 0.005;
  pos_cig_mobile = map(abs(sin(rotation)), 0, 1, width/4-5,2.5*width/4);
}

void mouseClicked(){
  stop_drawing_background = !stop_drawing_background;
}

void line_cigarrete_mobile(){
 fill(128);
 rect(pos_cig_mobile, height/4, 10, height/2);
 fill(255);
}

void line_cigarrete_static(){
  fill(128);
 rect(2.5*width/4, height/4, 10, height/2);
 fill(255);
}


void left_wall(){
  beginShape();
  vertex( -417, 10, -417);
  vertex( width/4, 10, 0);
  vertex( width/4, height-10, 0);
  vertex( -417, height-10, -417);
  vertex( -417, 10, -417);
  endShape();
  beginShape();
  vertex( -417, height/4, -417);
  vertex( width/4, height/4, 0);
  vertex( width/4, 3*height/4, 0);
  vertex( -417, 3*height/4, -417);
  vertex( -417, height/4, -417);
  endShape();
}

void main_wall(){
  beginShape();
  vertex( width/4, 10, 0);
  vertex( 3*width/4, 10, -417);
  vertex( 3*width/4, height-10, -417);
  vertex( width/4, height-10, 0);
  vertex( width/4, 10, 0);
  endShape();
  beginShape();
  vertex( width/4, height/4, 0);
  vertex( 3*width/4, height/4, -417);
  vertex( 3*width/4, 3*height/4, -417);
  vertex( width/4, 3*height/4, 0);
  vertex( width/4, height/4, 0);
  endShape();
}

void right_wall(){
  beginShape();
  vertex( 3*width/4, 10, -417);
  vertex( width, 10, 0);
  vertex( width, height-10, 0);
  vertex( 3*width/4, height-10, -417);
  vertex( 3*width/4, 10, -417);
  endShape();
  beginShape();
  vertex( 3*width/4, height/4, -417);
  vertex( width, height/4, 0);
  vertex( width, 3*height/4, 0);
  vertex( 3*width/4, 3*height/4, -417);
  vertex( 3*width/4, height/4, -417);
  endShape();
}
