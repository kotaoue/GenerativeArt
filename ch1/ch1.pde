import gifAnimation.*;
GifMaker gifExport;  

float xstart = 0;
float ynoise = 0;
float bgColor = 150;

int fps = 120;
int movieSec = 5;

void setup() {
  size(640, 640, P3D);
  frameRate(fps);
  background(bgColor);
  stroke(0, 50);
  fill(255, 200);
  xstart = random(16);
  ynoise = random(16);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(10);
  gifExport.setDelay(fps);
}    

void draw() {
  translate(width / 2, height /2, 0);

  int increment = (int)random(1, 2.5);
  for (float y = -(height / 9); y <= (height / 9); y += increment) {
    ynoise += 0.035;
    float xnoise = xstart;
    for (float x = -(width / 9); x <= (width/ 9); x += increment) {
      xnoise += 0.035;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }

  if (frameCount <= fps * movieSec) {
    gifExport.addFrame();
  } else {
    gifExport.finish();
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x * noiseFactor * 4, y * noiseFactor * 4, - y);
  float edgeSize = noiseFactor * 32;
  ellipse(0, 0, edgeSize, edgeSize);
  popMatrix();

  if (edgeSize >= 23) {
    bgColor += 0.04;
    if (bgColor > 255) {
      bgColor = 0;
    }  
    background(bgColor);
  }
}
