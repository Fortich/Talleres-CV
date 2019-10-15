PImage img;

void setup() {
  size(640, 360, P3D);
}

void draw() {
  img = loadImage("nezuko.png");
  img.resize(400,400);
  background(0);
  camera(mouseX, height/2, (height) / tan(PI/6), width/2.5, height/2.5, 0, 0, 1, 0);
  translate(width/2, height/2, 10);
  stroke(255);
  noFill();
  
 
/*
  translate(width / 2, height / 2);
  beginShape();
  texture(img);
  vertex(-100, -100, 0, 0,   0);
  vertex( 100, -100, 0, 400, 0);
  vertex( 100,  100, 0, 400, 400);
  vertex(-100,  100, 0, 0,   400);
  endShape();
*/

  beginShape();
    texture(img);
    line( 0, 0, 0, 100, 0, 0 );
    line( 100, 0, 0, 100, 100, 0 );
    line( 100, 100, 0, 0, 100, 0 );  
    line( 0, 100, 0, 0, 0, 0);
  endShape(CLOSE);
  
  //drawbody();
  //drawmouth();
  
}
/*
 void drawmouth(){
 
 beginShape();
   vertex( 0, -100, 0);   
   vertex( -97, -100, 0);
   vertex( -197, -100, 0);
   
   vertex( 0, -215, 0);
   
 endShape(CLOSE);
 
 } 

 void drawbody(){
 
  beginShape();
    fill(40,130,70);
    vertex(-100, 100, -100);
    vertex( 100, 100, -100);
    vertex( 100, 100, 100);
    vertex(-100, 100, 100);
  endShape(CLOSE);  
  
 
  beginShape();
    vertex( 100, 100, -100);
    vertex( 100, 100, 100);
    vertex( 0, -100, 0);  
  endShape(CLOSE);
  
   beginShape();    
    vertex( 100, 100, 100);
    vertex( -100, 100, 100);
    vertex( 0, -100, 0);   
  endShape(CLOSE);
  
  
  beginShape();
    vertex(-100, 100, -100);
    vertex( 100, 100, -100);
    vertex( 0, -100, 0);   
  endShape(CLOSE);
  
  beginShape();
  
    vertex(-100, 100, 100);
    vertex(-100, 100, -100);
    vertex( 0, -100, 0);   
  endShape(CLOSE);
 
}
*/
