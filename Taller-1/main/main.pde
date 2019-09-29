import VLCJVideo.*;

PGraphics py;
PGraphics pg;
String image_str;
String video_str;
PImage image_1, image_2, image_3, image_4;
VLCJVideo video_1, video_2, video_3, video_4;

int padding_x = 10;
int padding_y = 10;
float relative_distance_x = 0.15;
float relative_distance_y = 0.1;

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
  size(1024, 540);
  background(255);
  fill(0);
  image_str = "nazuko.png";
  video_str = "video.mp4";
  image_1 = loadImage(image_str);
  image_2 = loadImage(image_str);
  image_3 = loadImage(image_str);
  image_4 = loadImage(image_str);
  video_1 = new VLCJVideo(this);
  video_2 = new VLCJVideo(this);
  video_3 = new VLCJVideo(this);
  video_4 = new VLCJVideo(this); 
  
  draw_image_reset_4();
}

void draw_image_reset_4(){
  image(image_1, padding_x*3 + width*relative_distance_x*1.00, padding_y, padding_x*3 + width*relative_distance_x*2.40, height*relative_distance_y*4.25);
  image(image_2, padding_x*8 + width*relative_distance_x*3.40, padding_y, padding_x*3 + width*relative_distance_x*2.40, height*relative_distance_y*4.25);
  image(image_3, padding_x*3 + width*relative_distance_x*1.00, padding_y*2 + height*relative_distance_y*4.25, padding_x*3 + width*relative_distance_x*2.40, height*relative_distance_y*4.25);
  image(image_4, padding_x*8 + width*relative_distance_x*3.40, padding_y*2 + height*relative_distance_y*4.25, padding_x*3 + width*relative_distance_x*2.40, height*relative_distance_y*4.25);
}

void draw_video_reset(){
  image(video_1, padding_x*3 + width*relative_distance_x*1.00, padding_y*2 + height*relative_distance_y*4.25, padding_x*3 + width*relative_distance_x*2.40, height*relative_distance_y*4.25);
  //image(video_1, padding_x*8 + width*relative_distance_x*3.40, padding_y*2 + height*relative_distance_y*4.25, padding_x*3 + width*relative_distance_x*2.40, height*relative_distance_y*4.25);
}

void open_video(){
  video_1.openMedia(video_str);
  //video_2.openMedia(video_str);
  //video_3.openMedia(video_str);
  //video_4.openMedia(video_str);
  video_1.loop();
  //video_2.loop();
  //video_3.loop();
  //video_4.loop();
  video_1.play();
  //video_2.play();
  //video_3.play();
  //video_4.play();
}

void gray_scale_image(){
  print("Gray scaling images!");
  draw_image_reset_4();
  image_2.loadPixels();
  image_3.loadPixels();
  image_4.loadPixels();

  gray_scale_tresshold(image_2, 128);
  for (int i = 0; i < image_2.pixels.length; i++) {
    image_3.pixels[i] = color(brightness(image_1.pixels[i])); 
    
  }
  image_2.updatePixels();
  image_3.updatePixels();
  image_4.updatePixels(); 
}

void gray_scale_tresshold(PImage image, int tresshold){
  for (int i = 0; i < image.pixels.length; i++) {
    if (brightness(image.pixels[i]) < tresshold) {
      image_2.pixels[i] = color(0);
    } else {
      image_2.pixels[i] = color(255);
    }
  }
  image.updatePixels();
}

void gray_scale_raw_avg(PImage image){
  for (int i = 0; i < image.pixels.length; i++) {
    float avg = (red(image.pixels[i]) + blue(image_1.pixels[i]) + green(image_1.pixels[i]))/3;
    image_4.pixels[i] = color(avg);
  }
  image.updatePixels();
}


void gray_scale_video(){
  print("gray_scale_video()");
}

void convolution_mask_image(){
  draw_image_reset_4();
  
  image_2 = makeConvolution(image_1,sharpen);
  image_3 = makeConvolution(image_1,edgeDetection);
  image_4 = makeConvolution(image_1,identity);
  
  image_2.updatePixels();
  image_3.updatePixels();
  image_4.updatePixels(); 
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
}

void kernel_edge_recognition() {
  image_2 = image_1.get();
  for (int i = 0; i < 512; i++) {
    for (int j = 0; j < 512; j++) {
      color c1 = image_1.get(i-1,j-1);
      color c2 = image_1.get(i,j-1);
      color c3 = image_1.get(i+1,j-1);
      color c4 = image_1.get(i-1,j);
      color c5 = image_1.get(i,j);
      color c6 = image_1.get(i+1,j);
      color c7 = image_1.get(i-1,j+1);
      color c8 = image_1.get(i,j+1);
      color c9 = image_1.get(i+1,j+1);
      color result = c1*-1 + c2*-2 + c3*-1 + c4*-1 + c5*8 + c6*-1 + c7*-1 + c8*-1 + c9*-1;
      image_2.set(i, j, result);
      image_2.updatePixels();
  image_2.updatePixels();
  image_3.updatePixels();
  image_4.updatePixels(); 

}


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
  draw_buttom_rectangles();
  draw_buttom_texts();
  set_buttom_listeners();
}

void draw_buttom_rectangles(){
  fill(210);
  rect(padding_x, height*relative_distance_y*0 + padding_y*1, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*1 + padding_y*2, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*2 + padding_y*3, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*3 + padding_y*4, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*4 + padding_y*5, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*5 + padding_y*6, width*relative_distance_x, height*relative_distance_y);
  rect(padding_x, height*relative_distance_y*6 + padding_y*7, width*relative_distance_x, height*relative_distance_y);
}

void draw_buttom_texts(){
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

void set_buttom_listeners(){
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
