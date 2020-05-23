float lastx = -999;
float lasty = -999;
int border = 20;

void setup() {
  size(500, 500);
  background(255);
}

void draw() {
  // drawLine(0, height * 0.2);
  drawLine(1, height * 0.4);
}

void drawLine(int kind, float y) {
  int beginx = (width / 20);
  int endx = width - (width / 20);

  stroke(128);
  line(beginx, y, endx, y);

  stroke(0);
  for (int x=beginx; x<=endx; x+=(width/50)) {
    switch(kind) {
    case 1:
      float bordery = height * 0.1;
      y = bordery + random(height - 2*bordery);
      break;
    }
    if (lastx > -999) {
      line(x, y, lastx, lasty);
    }

    lastx = x;
    lasty = y;
  }
}
