float xStart, xNoise, yStart, yNoise;

void setup() {
  size(500, 300, P3D);
  background(0);
  sphereDetail(8);
  noStroke();

  xStart = random(10);
  yStart = random(10);
}


void draw() {
  background(0);

  xStart += 0.01;
  yStart += 0.01;

  for (int y = 0; y <= height; y+= 5) {
    yNoise += 0.1;
    xNoise = xStart;
    for (int x = 0; x <= width; x+= 5) {
      xNoise += 0.1;
      drawPoint(x, y, noise(xNoise, yNoise));
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, 250 - y, -y);
  float sphereSize = noiseFactor * 35;
  float grey = 150 + (noiseFactor * 120);
  float alph = 150 + (noiseFactor * 120);
  fill(grey, alph);
  sphere(sphereSize);
  popMatrix();
}
