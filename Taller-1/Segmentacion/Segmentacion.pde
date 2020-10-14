PGraphics py;
PGraphics pg;
PImage image_1, image_2;
float brightnessM;

//Función para dibujar el rectangulo de explicacion del ejercicio 
void draw_rectangles(){
  fill(210);
  rect(10, image_1.height + 10, (image_1.width + 10) * 2, 100); 
}
// texto a mostrar
void draw_text(){
  fill(0);
  text("Segmentacion de la imagen el brillo se controla al mover el mouse de manra horizontal sobre la imagen a la derecha indica mas brillo y a la izquierda una reduccion del brillo en la imagen de la derecha se ve la imagen segmentada dependiendo del brillo elegido" , 35, image_1.height + 20, (image_1.width + 10) * 2, 100);
}
// carga de imagenes y variables por medio de la funcion setup
void setup() {
  size(1000, 500);
  image_1 = loadImage("image1.png");
  image_2 = loadImage("image1.png");
  image_1.resize(410, 350);
  image_2.resize(410, 350);
  brightnessM = 255.0/image_1.width;
  draw_rectangles();
  draw_text();
}

// se inicia todo el proceso en la funcion draw empezando por el histograma 
void draw() {
  image(image_1, 10, 0);
  image(image_2, image_1.width+20, 0);
  int[] hist = new int[256];

  image_2.loadPixels();

  // Histograma
  for (int i = 0; i < image_1.width; i++) {
    for (int j = 0; j < image_1.height; j++) {
      int bright = int(brightness(get(i, j)));
      hist[bright]++;
    }
  }

  // Find the largest value in the histogram
  int histMax = max(hist);
  
  stroke(255);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < image_1.width; i += 2) {    
    int which = int(map(i, 0, image_1.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, image_1.height, 0));
    line(i+10, image_1.height, i+10, y);
  }
  image_2.updatePixels();
}


//funcion de procesing que se activa cada vez que se mueve el mouse busca el brillo de indicado por el mouse y marca los pixeles con un brillo similiar en un rango dado (20)  
void mouseMoved() {  
  for (int i = 0; i < image_1.pixels.length; i++) {
    if (!(brightness(image_1.pixels[i]) <= mouseX*brightnessM+10 && brightness(image_1.pixels[i]) >= mouseX*brightnessM-10)) {
      image_2.pixels[i] = color(0);
    }else{
      image_2.pixels[i] = image_1.pixels[i];
    }
  }
  print(mouseX*brightnessM);
  print("\n");
}
