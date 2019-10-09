void setup()
{
  size(600, 600);
  background(205);
  noStroke();
  
}

void draw()
{
  stroke(0);
 
  
  for(int j = 100 ; j < 600 ; j= j + 200){
    for(int k = 100 ; k < 600 ; k= k + 200){
      for(int i = 200 ; i >= 0 ; i= i - 20){
        circle(k, j, i);       
        //circle(100, 100, i); 
       // circle(300, 100, i);       
       // circle(500, 100, i);  
      }
    }
  }
  Draw_lines();
  
  if (mousePressed==true){
    background(205);
    Draw_lines();
  }
  
}

void Draw_lines(){
  stroke(255,100,100);
  strokeWeight(2);
  line(100,0,600,500);
  line(0,100,500,600);
  
  line(100,0,0,100);
  line(600,500,500,600);
  line(0,500,100,600);
  
  
  line(300,0,0,300);
  line(500,0,0,500);
  
  line(600,100,100,600);
  line(500,0,600,100);
  line(300,0,600,300);
  line(0,300,300,600);
  line(300,600,600,300);
}

//line(0, 80, 80, 0);
//stroke(204, 102, 0);
