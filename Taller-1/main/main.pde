
  
PGraphics pg;
PImage img_lindo1;
PImage img_lindo_result;

void setup() {
  size(1054, 532);
  pg = createGraphics(40, 40);
  img_lindo1 = loadImage("Glow-parties.jpg");
}

void draw() {
  g.background(220,220,220) ;
  pg.beginDraw();
  pg.background(100);
  pg.stroke(255);
  pg.line(20, 20, mouseX, mouseY);
  pg.endDraw();
  image(img_lindo1, 10, 10);
  draw_image();
  gray_scale_rgb();
  image(img_lindo_result, 532, 10);
}

void draw_image() {
  img_lindo_result = img_lindo1.get();
  for (int i = 0; i < 512; i++) {
    for (int j = 0; j < 512; j++) {
      color c = img_lindo1.get(i,j);
      img_lindo_result.set(i, j, c);
    }
  }
}

void gray_scale_rgb() {
  img_lindo_result = img_lindo1.get();
  for (int i = 0; i < 512; i++) {
    for (int j = 0; j < 512; j++) {
      color c = img_lindo1.get(i,j);
      float hola = (   red(c) + green(c) + blue(c))/3;
      color c_new = color(hola, hola, hola);
      img_lindo_result.set(i, j, c_new);
    }
  }
}

void gray_scale_luma() {
  img_lindo_result = img_lindo1.get();
  for (int i = 0; i < 512; i++) {
    for (int j = 0; j < 512; j++) {
      color c = img_lindo1.get(i,j);
      float hola = (0.2126*red(c) + 0.7152*green(c) + 0.0722*blue(c))/3;
      color c_new = color(hola, hola, hola);
      img_lindo_result.set(i, j, c_new);
    }
  }
}


void histogram(){
int[] hist = new int[256];

// Calculate the histogram
for (int i = 0; i < img_lindo_result.width; i++) {
  for (int j = 0; j < img_lindo_result.height; j++) {
    int bright = int(brightness(img_lindo_result.get(i, j)));
    hist[bright]++; 
  }
}

// Find the largest value in the histogram
int histMax = max(hist);

stroke(255);
// Draw half of the histogram (skip every second value)
for (int i = 0; i < img_lindo_result.width; i += 2) {
  // Map i (from 0..img.width) to a location in the histogram (0..255)
  int which = int(map(i, 0, img_lindo_result.width, 0, 255));
  // Convert the histogram value to a location between 
  // the bottom and the top of the picture
  int y = int(map(hist[which], 0, histMax, img_lindo_result.height, 0));
  line(i+100, img_lindo_result.height, i+100, y);
}
}

void kernel_edge_recognition() {
  img_lindo_result = img_lindo1.get();
  for (int i = 0; i < 512; i++) {
    for (int j = 0; j < 512; j++) {
      color c1 = img_lindo1.get(i-1,j-1);
      color c2 = img_lindo1.get(i,j-1);
      color c3 = img_lindo1.get(i+1,j-1);
      color c4 = img_lindo1.get(i-1,j);
      color c5 = img_lindo1.get(i,j);
      color c6 = img_lindo1.get(i+1,j);
      color c7 = img_lindo1.get(i-1,j+1);
      color c8 = img_lindo1.get(i,j+1);
      color c9 = img_lindo1.get(i+1,j+1);
      color result = c1*-1 + c2*-2 + c3*-1 + c4*-1 + c5*8 + c6*-1 + c7*-1 + c8*-1 + c9*-1;
      img_lindo_result.set(i, j, result);
    }
  }
}

void kernel_sharpen() {
  img_lindo_result = img_lindo1.get();
  for (int i = 0; i < 512; i++) {
    for (int j = 0; j < 512; j++) {
      color c1 = img_lindo1.get(i-1,j-1);
      color c2 = img_lindo1.get(i,j-1);
      color c3 = img_lindo1.get(i+1,j-1);
      color c4 = img_lindo1.get(i-1,j);
      color c5 = img_lindo1.get(i,j);
      color c6 = img_lindo1.get(i+1,j);
      color c7 = img_lindo1.get(i-1,j+1);
      color c8 = img_lindo1.get(i,j+1);
      color c9 = img_lindo1.get(i+1,j+1);
      color result = c1*0 + c2*-1 + c3*0 + c4*-1 + c5*5 + c6*-1 + c7*0 + c8*-1 + c9*0;
      img_lindo_result.set(i, j, result);
    }
  }
}

void kernel_emboss() {
  img_lindo_result = img_lindo1.get();
  for (int i = 0; i < 512; i++) {
    for (int j = 0; j < 512; j++) {
      color c1 = img_lindo1.get(i-1,j-1);
      color c2 = img_lindo1.get(i,j-1);
      color c3 = img_lindo1.get(i+1,j-1);
      color c4 = img_lindo1.get(i-1,j);
      color c5 = img_lindo1.get(i,j);
      color c6 = img_lindo1.get(i+1,j);
      color c7 = img_lindo1.get(i-1,j+1);
      color c8 = img_lindo1.get(i,j+1);
      color c9 = img_lindo1.get(i+1,j+1);
      color result = c1*-2 + c2*-1 + c3*0 + c4*-1 + c5*1 + c6*1 + c7*0 + c8*1 + c9*2;
      img_lindo_result.set(i, j, result);
    }
  }
}
