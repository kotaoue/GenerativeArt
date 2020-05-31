float xStart, xNoise;
float yStart, yNoise;
float zStart, zNoise;

int sideLength = 200;
int spacing = 5;

void setup() {
  size(500, 300, P3D);
  background(0);
  sphereDetail(8);
  noStroke();

  xStart = random(10);
  yStart = random(10);
  zStart = random(10);
}


void draw() {
  background(0);

  xStart += 0.01;
  yStart += 0.01;
  zStart += 0.01;

  for (int z = 0; z <= sideLength; z+= spacing) {
    zNoise += 0.1;
    yNoise = yStart;
    for (int y = 0; y <= sideLength; y+= spacing) {
      yNoise += 0.1;
      xNoise = xStart;
      for (int x = 0; x <= sideLength; x+= spacing) {
        xNoise += 0.1;
        drawPoint(x, y, noise(xNoise, yNoise));
      }
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
