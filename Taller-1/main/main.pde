import VLCJVideo.*;

PGraphics py;
PGraphics pg;
<<<<<<< HEAD
PImage imagen_1, imagen_2, imagen_3, imagen_4;
VLCJVideo video;

boolean taller1 = false;
=======
PImage imagen_1, imagen_2, imagen_3, imagen_4, imgconvol_1;

boolean taller1 = false;
float x = 1170;
float y = 60;
float w = 180;
float h = 50;
float y2 = 120;
float y3 = 180;
float y4 = 240;
float[][] identity = {
  { 0, 0, 0}, 
  { 0, 1, 0}, 
  { 0, 0, 0}
};
float[][] edgeDetection = {
  { -1, -1, -1}, 
  { -1, 8, -1}, 
  { -1, -1, -1}
};
float[][] sharpen = {
  { 0, -1, 0}, 
  { -1, 5, -1}, 
  { 0, -1, 0}
};

>>>>>>> 32abe812bd7ebdebae4ceab610d9e6aa2f2e00a2

void setup(){
  size(1024, 540);
  //fullScreen();

// 2. Dibujar el texto del boton color negro
fill(0);

//image(video,0,0);
  background(255);
  imagen_1 = loadImage("nazuko.png");
  imagen_2 = loadImage("nazuko.png");
  imagen_3 = loadImage("nazuko.png");
  imagen_4 = loadImage("nazuko.png");
  video = new VLCJVideo(this);
  
}

<<<<<<< HEAD
void open_video(){
  video.openMedia("video.mp4");
  video.loop();
  video.play();
}

void gray_scale_image(){
  print("gray_scale_image()");
}

void gray_scale_video(){
  print("gray_scale_video()");
}

void convolution_mask_image(){
  print("convolution_mask_image()");
}

void convolution_mask_video(){
  print("convolution_mask_video()");
}

void histogram(){
  print("histogram()");
}

void show_frame_rate(){
  print("show_frame_rate()");
}

void reset(){
  print("reset()");
}

void draw() {
  draw_buttoms();
if (mouseX > 0 && mouseX < 0 && mouseY > 0 && mouseY < 0 && mousePressed==true){
=======
void draw() {
// 1. Dibujar el boton borde negro relleno gris
fill(128);
stroke(0);
rect(x, y, w, h);
rect(x, y2, w, h);
rect(x, y3, w, h);
rect(x, y4, w, h);

// 2. Dibujar el texto del boton color negro
fill(0);
text("Reiniciar", x+60, y+h/2+4);
text("Escala de Grises", x+40, y2+h/2+4);
text("Histograma", x+60, y3+h/2+4);
text("Mascaras de convolucion", x+25, y4+h/2+4);


if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed==true){
>>>>>>> 32abe812bd7ebdebae4ceab610d9e6aa2f2e00a2
  imagen_1 = loadImage("nazuko.png");
  imagen_2 = loadImage("nazuko.png");
  imagen_3 = loadImage("nazuko.png");
  imagen_4 = loadImage("nazuko.png");
  image(imagen_1, 0, 0);
  image(imagen_2, imagen_1.width, 0);
  image(imagen_3, 0, imagen_1.height);
  image(imagen_4, imagen_1.width, imagen_1.height);
}
// verificar si se dio click en el boton
<<<<<<< HEAD
if (mouseX > 0 && mouseX < 0 && mouseY > 0 && mouseY < 0 && mousePressed==true){
=======
if (mouseX > x && mouseX < x+w && mouseY > y2 && mouseY < y2+h && mousePressed==true){
>>>>>>> 32abe812bd7ebdebae4ceab610d9e6aa2f2e00a2
taller1=true; 
imagen_2.loadPixels();
imagen_3.loadPixels();
imagen_4.loadPixels();
image(imagen_1, 0, 0);
image(imagen_2, imagen_1.width, 0);
image(imagen_3, 0, imagen_1.height);
image(imagen_4, imagen_1.width, imagen_1.height);


int tresshold = 128;
for (int i = 0; i < imagen_2.pixels.length; i++) {

//escala de grises usando tresshold se cambian los pixeles dependiendo si su valor es mayor o menor a un entero dado
if (brightness(imagen_2.pixels[i]) < tresshold) {
imagen_2.pixels[i] = color(0);
} else {
imagen_2.pixels[i] = color(255);
}

//se cambia el pixel por el color que indica el brillo del pixel que se evalua ej:si el brillo del pixel es 24 se le asigna el color 24 a ese pixel
imagen_3.pixels[i] = color(brightness(imagen_1.pixels[i]));

//Escala de grises por promedio simplemente se cambia el valor de cada pixel por el promedio rgb 
float avg = (red(imagen_1.pixels[i]) + blue(imagen_1.pixels[i]) + green(imagen_1.pixels[i]) )/3;
imagen_4.pixels[i] = color(avg);


   
}  
imagen_2.updatePixels();
imagen_3.updatePixels();
imagen_4.updatePixels(); 
}



<<<<<<< HEAD
if (mouseX > 0 && mouseX < 0 && mouseY > 0 && mouseY < 0 && mousePressed==true){
=======
if (mouseX > x && mouseX < x+w && mouseY > y3 && mouseY < y3+h && mousePressed==true){
>>>>>>> 32abe812bd7ebdebae4ceab610d9e6aa2f2e00a2
int[] hist = new int[256];

  // Calculate the histogram
  for (int i = 0; i < imagen_2.width; i++) {
    for (int j = 0; j < imagen_2.height; j++) {
      int bright = int(brightness(get(i, j)));
      hist[bright]++; 
    }
  }

  // Find the largest value in the histogram
  int histMax = max(hist);
  
  stroke(255);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < imagen_2.width; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, imagen_2.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, imagen_2.height, 0));
    line(i, imagen_2.height, i, y);
  }
  imagen_2.updatePixels();

}
<<<<<<< HEAD
if (mouseX > 0 && mouseX < 0 && mouseY > 0 && mouseY < 0 && mousePressed==true){
image(imagen_1, 0, 0);
image(imagen_2, imagen_1.width, 0);
image(imagen_3, 0, imagen_1.height);
image(imagen_4, imagen_1.width, imagen_1.height);
=======
if (mouseX > x && mouseX < x+w && mouseY > y4 && mouseY < y4+h && mousePressed==true){
>>>>>>> 32abe812bd7ebdebae4ceab610d9e6aa2f2e00a2
  
  image(imagen_1, 0, 0);
  image(imagen_2, imagen_1.width, 0);
  image(imagen_3, 0, imagen_1.height);
  image(imagen_4, imagen_1.width, imagen_1.height);
    
  imagen_2 = makeConvolution(imagen_1,sharpen);
  imagen_3 = makeConvolution(imagen_1,edgeDetection );
  imagen_4 = makeConvolution(imagen_1,identity);
  
<<<<<<< HEAD
kernel_edge_recognition();
kernel_sharpimagen_1en();
kernel_emboss();
}


}

void kernel_edge_recognition() {
  imagen_2 = imagen_1.get();
  for (int i = 0; i < 512; i++) {
    for (int j = 0; j < 512; j++) {
      color c1 = imagen_1.get(i-1,j-1);
      color c2 = imagen_1.get(i,j-1);
      color c3 = imagen_1.get(i+1,j-1);
      color c4 = imagen_1.get(i-1,j);
      color c5 = imagen_1.get(i,j);
      color c6 = imagen_1.get(i+1,j);
      color c7 = imagen_1.get(i-1,j+1);
      color c8 = imagen_1.get(i,j+1);
      color c9 = imagen_1.get(i+1,j+1);
      color result = c1*-1 + c2*-2 + c3*-1 + c4*-1 + c5*8 + c6*-1 + c7*-1 + c8*-1 + c9*-1;
      imagen_2.set(i, j, result);
      imagen_2.updatePixels();
=======
  imagen_2.updatePixels();
  imagen_3.updatePixels();
  imagen_4.updatePixels(); 
>>>>>>> 32abe812bd7ebdebae4ceab610d9e6aa2f2e00a2

}


}

PImage makeConvolution(PImage img, float[][] kernel) {
  // https://processing.org/examples/convolution.html
  PImage img_result = createImage(img.width, img.height, RGB);
  img.loadPixels();
  // for para cada uno de los pixeles de la imagen
  for (int y = 1; y < img.height-1; y++) { // se evitan los bordes de la imaegn
    for (int x = 1; x < img.width-1; x++) { // se evitan los bordes de la imaegn 
      float sum = 0; // variable para la suma del color
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // calcular el pixel adyacente
          int pos = (y + ky)*img.width + (x + kx);
          // se usa el valor de solo uno de los colores dado que la escaa de grises se conseguigue con el promedio rgb de la imagen original
          float val = red(img.pixels[pos]);
          sum += kernel[ky+1][kx+1] * val;
        }
      }

      // color con la suma de los colores
      img_result.pixels[y*img.width + x] = color(sum, sum, sum);
    }
  }
  return img_result;
}

void draw_buttoms(){
  int padding_x = 10;
  int padding_y = 10;
  float relative_distance_x = 0.15;
  float relative_distance_y = 0.1;
  draw_buttom_rectangles(padding_x, padding_y, relative_distance_x, relative_distance_y);
  draw_buttom_texts(padding_x, padding_y, relative_distance_x, relative_distance_y);
  set_buttom_listeners(padding_x, padding_y, relative_distance_x, relative_distance_y);
}

void draw_buttom_rectangles(int padding_x, int padding_y, float relative_distance_x, float relative_distance_y){
  fill(210);
  rect(padding_x, height*relative_distance_y*0 + padding_y*1, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*1 + padding_y*2, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*2 + padding_y*3, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*3 + padding_y*4, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*4 + padding_y*5, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*5 + padding_y*6, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*6 + padding_y*7, width*relative_distance_x, height*relative_distance_y);
}

void draw_buttom_texts(int padding_x, int padding_y, float relative_distance_x, float relative_distance_y){
  fill(0);
  text("Escala de Grises imagen" , padding_x*2 + relative_distance_x*0, height*relative_distance_y*0 + padding_y*1 + padding_y*3.25);
  text("Escala de Grises video"  , padding_x*2 + relative_distance_x*0, height*relative_distance_y*1 + padding_y*2 + padding_y*3.25);
  text("Máscaras de convolución" , padding_x*2 + relative_distance_x*0, height*relative_distance_y*2 + padding_y*3 + padding_y*2.15);
  text("imagen"                  , padding_x*2 + relative_distance_x*0, height*relative_distance_y*2 + padding_y*3 + padding_y*3.3);
  text("Máscaras de convolución" , padding_x*2 + relative_distance_x*0, height*relative_distance_y*3 + padding_y*4 + padding_y*2.15);
  text("video"                   , padding_x*2 + relative_distance_x*0, height*relative_distance_y*3 + padding_y*4 + padding_y*3.3);
  text("Despliegue de Histograma", padding_x*2 + relative_distance_x*0, height*relative_distance_y*4 + padding_y*5 + padding_y*3.25);
  text("Medición frame rate"     , padding_x*2 + relative_distance_x*0, height*relative_distance_y*5 + padding_y*6 + padding_y*3.25);
  text("Reiniciar"               , padding_x*2 + relative_distance_x*0, height*relative_distance_y*6 + padding_y*7 + padding_y*3.25);
}

void set_buttom_listeners(int padding_x, int padding_y, float relative_distance_x, float relative_distance_y){
  if (mouseX > padding_x && mouseX < padding_x + width*relative_distance_x && mouseY > height*relative_distance_y*0 + padding_y*1 && mouseY < height*relative_distance_y*1 + padding_y*1 && mousePressed==true){
    gray_scale_image();
  }
  if (mouseX > padding_x && mouseX < padding_x + width*relative_distance_x && mouseY > height*relative_distance_y*1 + padding_y*2 && mouseY < height*relative_distance_y*2 + padding_y*2 && mousePressed==true){
    gray_scale_video();
  }
  if (mouseX > padding_x && mouseX < padding_x + width*relative_distance_x && mouseY > height*relative_distance_y*2 + padding_y*3 && mouseY < height*relative_distance_y*3 + padding_y*3 && mousePressed==true){
    convolution_mask_image();
  }
  if (mouseX > padding_x && mouseX < padding_x + width*relative_distance_x && mouseY > height*relative_distance_y*3 + padding_y*4 && mouseY < height*relative_distance_y*4 + padding_y*4 && mousePressed==true){
    convolution_mask_video();
  }
  if (mouseX > padding_x && mouseX < padding_x + width*relative_distance_x && mouseY > height*relative_distance_y*4 + padding_y*5 && mouseY < height*relative_distance_y*5 + padding_y*5 && mousePressed==true){
    histogram();
  }
  if (mouseX > padding_x && mouseX < padding_x + width*relative_distance_x && mouseY > height*relative_distance_y*5 + padding_y*6 && mouseY < height*relative_distance_y*6 + padding_y*6 && mousePressed==true){
    show_frame_rate();
  }
  if (mouseX > padding_x && mouseX < padding_x + width*relative_distance_x && mouseY > height*relative_distance_y*6 + padding_y*7 && mouseY < height*relative_distance_y*7 + padding_y*7 && mousePressed==true){
    reset();
  }
}
