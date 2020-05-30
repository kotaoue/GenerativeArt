float xstart, ystart;
float xnoise, ynoise;
float xStartNoise, yStartNoise;

void setup() {
  size(300, 300);
  smooth();

  frameRate(24);
  xStartNoise = random(20);
  yStartNoise = random(20);
  xstart = random(10);
  ystart = random(10);
}


void draw() {
  background(0);

  xStartNoise += 0.01;
  yStartNoise += 0.01;
  float xBlur = 0.75;
  float yBlur = 0.75;
  xstart += (noise(xStartNoise) * xBlur) - (xBlur / 2);
  ystart += (noise(yStartNoise) * yBlur) - (yBlur / 2);

  xnoise = xstart;
  ynoise = ystart;

  for (int y = 0; y <+ height; y+=random(5)) {
    ynoise += 0.1;
    xnoise = xstart;
    for (int x = 0; x <= width; x+=random(5)) {
      xnoise += 0.1;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(540));

  float edgeSize = noiseFactor * 35;
  float grey = 150 + (noiseFactor * 120);
  float alph = 150 + (noiseFactor * 120);
  noStroke();
  fill(grey, alph);
  ellipse(0, 0, edgeSize, edgeSize / 2);
  popMatrix();
}
