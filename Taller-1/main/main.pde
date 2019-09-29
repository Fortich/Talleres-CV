import processing.video.*;

String image_str;
String video_str;
PImage image_1, image_2, image_3, image_4, video_2, video_3, video_4;

float image_1_x, image_1_y;
float image_2_x, image_2_y;
float image_3_x, image_3_y;
float image_4_x, image_4_y;
float image_width, image_height;

boolean showing_video;
boolean gray_scaling_video;
boolean convolution_masks_video;
boolean showing_frame_rate;

Movie video_1;

float padding_x = 10;
float padding_y = 10;
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
float[][] gaussianBlur = {
  { 1.0/16, 2.0/16, 1.0/16}, 
  { 2.0/16, 4.0/16, 2.0/16}, 
  { 1.0/16, 2.0/16, 1.0/16},
};

void setup(){
  size(1024, 540);
  //fullScreen();
  background(200);
  fill(0);
  image_str = "image1.png";
  video_str = "video1.mov";
  
  image_1 = loadImage(image_str);
  image_2 = loadImage(image_str);
  image_3 = loadImage(image_str);
  image_4 = loadImage(image_str);
  
  video_1 = new Movie(this, video_str);
  video_1.loop();
  
  image_1_x = padding_x*3 + width*relative_distance_x*1.00;
  image_1_y = padding_y;
  image_2_x = padding_x*8 + width*relative_distance_x*3.40;
  image_2_y = padding_y;
  image_3_x = padding_x*3 + width*relative_distance_x*1.00;
  image_3_y = padding_y*2 + height*relative_distance_y*4.25;
  image_4_x = padding_x*8 + width*relative_distance_x*3.40;
  image_4_y = padding_y*2 + height*relative_distance_y*4.25;
  
  image_width = padding_x*3 + width*relative_distance_x*2.40;
  image_height = height*relative_distance_y*4.25;
  
  set_image_4();
  draw_buttoms();
  
  showing_video = false;
  gray_scaling_video = false;
  convolution_masks_video = false;
  showing_frame_rate = false;
}

void movieEvent(Movie movie) {
  movie.read();
  if (gray_scaling_video){
    gray_scale_tresshold(video_1, image_2, 128);
    gray_scale_raw_avg(video_1, image_3);
    gray_scale_raw_luma(video_1, image_4); 
  }
  if (convolution_masks_video){
    image_1 = makeConvolution(video_1,identity);
    image_2 = makeConvolution(image_1,sharpen);
    image_3 = makeConvolution(image_1,edgeDetection);
    image_4 = makeConvolution(image_1,gaussianBlur);
  }
  if (showing_frame_rate) {
    fill(220);
    rect(width-55,height-17,55,17);
    fill(0);
    text(frameRate, width-45, height-5);
  }
}

void set_image_4(){
  image(image_1, image_1_x, image_1_y, image_width, image_height);
  image(image_2, image_2_x, image_2_y, image_width, image_height);
  image(image_3, image_3_x, image_3_y, image_width, image_height);
  image(image_4, image_4_x, image_4_y, image_width, image_height);
}

void set_video_4(){
  image(video_1, image_1_x, image_1_y, image_width, image_height);
  image(image_2, image_2_x, image_2_y, image_width, image_height);
  image(image_3, image_3_x, image_3_y, image_width, image_height);
  image(image_4, image_4_x, image_4_y, image_width, image_height);
}

void gray_scale_image(){
  showing_video = false;
  gray_scaling_video = false;
  convolution_masks_video = false;
  showing_frame_rate = false;
  gray_scale_tresshold(image_1, image_2, 128);
  gray_scale_raw_avg(image_1, image_3);
  gray_scale_raw_luma(image_1, image_4);
  println("Gray scaling images!");
}

void gray_scale_tresshold(PImage image_source, PImage image_destination, int tresshold){
  for (int i = 0; i < image_source.pixels.length; i++) {
    if (brightness(image_source.pixels[i]) < tresshold) {
      image_destination.pixels[i] = color(0);
    } else {
      image_destination.pixels[i] = color(255);
    }
  }
  image_destination.updatePixels();
}

void gray_scale_raw_avg(PImage image_source, PImage image_destination){
  for (int i = 0; i < image_source.pixels.length; i++) {
    float avg = (red(image_source.pixels[i]) + blue(image_source.pixels[i]) + green(image_source.pixels[i]))/3;
    image_destination.pixels[i] = color(avg);
  }
  image_destination.updatePixels();
}

void gray_scale_raw_luma(PImage image_source, PImage image_destination){
  for (int i = 0; i < image_source.pixels.length; i++) {
    float avg = (0.2126*red(image_source.pixels[i]) + 0.0722*blue(image_source.pixels[i]) + 0.7152*green(image_source.pixels[i]))/3;
    image_destination.pixels[i] = color(avg);
  }
  image_destination.updatePixels();
}


void gray_scale_video(){
  showing_video = true;
  gray_scaling_video = true;
  convolution_masks_video = false;
  showing_frame_rate = false;
  println("Gray scaling videos!");
}

void convolution_mask_image(){
  showing_video = false;
  gray_scaling_video = false;
  convolution_masks_video = false;
  showing_frame_rate = false;
  println("convolution_mask_image!");
  
  set_image_4();
  
  image_1 = makeConvolution(image_1,identity);
  image_2 = makeConvolution(image_1,sharpen);
  image_3 = makeConvolution(image_1,edgeDetection);
  image_4 = makeConvolution(image_1,gaussianBlur);

  image_1.updatePixels();
  image_2.updatePixels();
  image_3.updatePixels();
  image_4.updatePixels(); 
}

void convolution_mask_video(){
  showing_video = true;
  gray_scaling_video = false;
  convolution_masks_video = true;
  showing_frame_rate = false;
  println("convolution_mask_video()");
}

void histogram(){
  showing_video = false;
  gray_scaling_video = false;
  convolution_masks_video = false;
  showing_frame_rate = false;
  image_1 = loadImage(image_str);
  image_2 = loadImage(image_str);
  image_3 = loadImage(image_str);
  image_4 = loadImage(image_str);
  draw_histogram(image_1, image_1_x, image_1_y, image_width, image_height);
  draw_histogram(image_2, image_2_x, image_2_y, image_width, image_height);
  draw_histogram(image_3, image_3_x, image_3_y, image_width, image_height);
  draw_histogram(image_4, image_4_x, image_4_y, image_width, image_height);
  println("histogram!");
}

void draw_histogram(PImage image, float image_x, float image_y, float image_width, float image_height){
  int[] hist = new int[256];
  image.loadPixels();

  for (int i = 0; i < image.width; i++) {
    for (int j = 0; j < image.height; j++) {
      int bright = int(brightness(get(i, j)));
      hist[bright]++; 
    }
  }
  int histMax = max(hist);
  stroke(255);
  for (int i = 0; i < 256; i++) {
    float i_x = map(i, 0, 255, image_x, image_x + image_width);
    float i_y = map(hist[i], 0, histMax, image_y + image_height, image_y);
    line(i_x, image_y + image_height - 1, i_x, i_y - 1);
  }
  stroke(0);
  image.updatePixels();
}

void show_frame_rate(){
  showing_video = true;
  showing_frame_rate = true;
  println("show_frame_rate()");
}

void reset(){
  showing_video = false;
  gray_scaling_video = false;
  convolution_masks_video = false;
  showing_frame_rate = false;
  image_1 = loadImage(image_str);
  image_2 = loadImage(image_str);
  image_3 = loadImage(image_str);
  image_4 = loadImage(image_str);
  println("reset!");
}

void draw() {
  set_buttom_listeners();
  if (showing_video){
    set_video_4();
  }else{
    set_image_4();
  }
}

PImage makeConvolution(PImage img, float[][] kernel) {
  // https://processing.org/examples/convolution.html
  PImage img_result = createImage(img.width, img.height, RGB);
  img.loadPixels();
  // for para cada uno de los pixeles de la imagen
  for (int y = 1; y < img.height-1; y++) { // se evitan los bordes de la imaegn
    for (int x = 1; x < img.width-1; x++) { // se evitan los bordes de la imaegn 
      float red = 0;
      float green = 0;
      float blue = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*img.width + (x + kx);
          red += kernel[ky+1][kx+1] * red(img.pixels[pos]);
          green += kernel[ky+1][kx+1] * green(img.pixels[pos]);
          blue += kernel[ky+1][kx+1] * blue(img.pixels[pos]);
        }
      }

      // color con la suma de los colores
      img_result.pixels[y*img.width + x] = color(red, green, blue);
    }
  }
  return img_result;
}

void draw_buttoms(){
  draw_buttom_rectangles();
  draw_buttom_texts();
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
