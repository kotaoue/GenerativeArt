void setup() {
  size(300, 300);
  smooth();
}


void draw() {
  background(255);

  float xstart = random(10);
  float xnoise = xstart;
  float ynoise = random(10);

  for (int y = 0; y <+ height; y+=5) {
    ynoise += 0.1;
    xnoise = xstart;
    for (int x = 0; x <= width; x+=5) {
      xnoise += 0.1;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  float len = 10 * noiseFactor;
  rect(x, y, len, len);
}
