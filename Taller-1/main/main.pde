PGraphics py;
PGraphics pg;
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


void setup(){
  size(1444, 1178);
  background(255);
  imagen_1 = loadImage("nazuko.png");
  imagen_2 = loadImage("nazuko.png");
  imagen_3 = loadImage("nazuko.png");
  imagen_4 = loadImage("nazuko.png");
}

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
if (mouseX > x && mouseX < x+w && mouseY > y2 && mouseY < y2+h && mousePressed==true){
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



if (mouseX > x && mouseX < x+w && mouseY > y3 && mouseY < y3+h && mousePressed==true){
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
if (mouseX > x && mouseX < x+w && mouseY > y4 && mouseY < y4+h && mousePressed==true){
  
  image(imagen_1, 0, 0);
  image(imagen_2, imagen_1.width, 0);
  image(imagen_3, 0, imagen_1.height);
  image(imagen_4, imagen_1.width, imagen_1.height);
    
  imagen_2 = makeConvolution(imagen_1,sharpen);
  imagen_3 = makeConvolution(imagen_1,edgeDetection );
  imagen_4 = makeConvolution(imagen_1,identity);
  
  imagen_2.updatePixels();
  imagen_3.updatePixels();
  imagen_4.updatePixels(); 

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
