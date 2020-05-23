void setup() {
  size(800, 800);
  background(255);
  strokeWeight(0.5);
  smooth();
}


void draw() {
  background(255);
  float radius = 10;
  float centx = width * 0.25;
  float centy = height * 0.30;
  float radiusNoise = random(10);

  stroke(0, 30);
  noFill();
  ellipse(centx, centy, (radius + frameCount % 12) * 2, (radius + frameCount % 12) * 2);

  float x, y;
  for (int i = 0; i < 100; i++) {
    stroke(random(20), random(50), random(70));

    int startangle = int(random(360));
    int endangle = 1440 + int(random(1440));
    int anglestep = 5 + int(random(3));

    float lastx = -999;
    float lasty = -999;
    for (float ang = startangle; ang <= endangle; ang += anglestep) {
      radius += 0.5;
      radiusNoise += 0.05;
      float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
      float rad = radians(ang);
      x = centx + (thisRadius * cos(rad));
      y = centy + (thisRadius * sin(rad));

      if (lastx > -999) {
        line(x, y, lastx, lasty);
      }
      lastx = x;
      lasty = y;
    }
  }
}
