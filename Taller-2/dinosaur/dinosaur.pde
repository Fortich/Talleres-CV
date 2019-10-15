PImage img,img2;
float i=0,x=.005;;
void setup() {
  size(640, 360, P3D);
}

void draw() {
  img = loadImage("mandibula.png");
  img2 = loadImage("cara.png");
  background(0);
  //camera(mouseX*2, 0, (height) / tan(PI/6), width/1.5, height/1.5, 0, 0, 1, 0);
  //translate(width/2, height/2, -100);
  
  camera((width*3)/2, 0, (height) / tan(PI/6), width/1.5, height/1.5, 0, 0, 1, 0);
  translate(width>>1, height>>1);
  rotateY(i += x);
  System.out.println(i);
  if(i > 1){
    x=-x;
  }else if(i < -0.9){
    x=-x;
  } 
 
 
  
  
  stroke(0);
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

/*
  beginShape();
    texture(img);
    line( 0, 0, 0, 100, 0, 0 );
    line( 100, 0, 0, 100, 100, 0 );
    line( 100, 100, 0, 0, 100, 0 );  
    line( 0, 100, 0, 0, 0, 0);
  endShape(CLOSE);
*/  
  drawbody();
  drawmouth();
  drawilusion1();
  drawilusion2();
  drawilusion3();
  drawilusion4();
}

 void drawmouth(){
 
 beginShape();
   texture(img);
   vertex( 0, -100, 0, 194 ,115);   
   vertex( -94, -100, 0, 97, 115);
   vertex( -94, -110, 0, 97, 105);
   vertex( -194, -110, 0, 0, 105 ); 
   vertex( -194, -169, 0, 0, 61 ); 
   vertex( -97, -180, 0, 97, 36);
   vertex( -87, -215, 0, 108, 0 );
   vertex( 0, -215, 0, 194, 0);   
 endShape(CLOSE);
 
 } 
 
 void drawilusion1(){
   beginShape();
     texture(img2);
     vertex(0, -215, 0, 263, 0);
     vertex(0, -215, 95, 263, 95);
     vertex(-87, -215, 95, 176,95);
     vertex(-87, -215,0, 176, 0);     
   endShape(CLOSE);
 }
 

 void drawilusion2(){
   beginShape();
     texture(img2);
     vertex(-97, -180, 0, 141, 95);
     vertex(-97, -180, 95, 141, 0);
     vertex(-87, -215, 95, 176, 0);
     vertex(-87, -215, 0, 176, 95 );     
   endShape(CLOSE);
 }


 void drawilusion3(){
   beginShape();
     texture(img2);  
     vertex(-97, -180, 0, 141, 0);
     vertex(-97, -180, 95, 141, 95);     
     vertex( -194, -169, 95, 97, 95);
     vertex( -194, -169, 0, 97, 0);
   endShape(CLOSE);
 }

 void drawilusion4(){
   beginShape();
     texture(img2);
     vertex( -194, -169, 0, 97, 0);
     vertex( -194, -169, 95, 97, 95);
     vertex( -194, -110, 95, 0, 95);
     vertex( -194, -110, 0, 0, 0);    
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
