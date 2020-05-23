int border = 20;

void setup() {
  size(500, 500);
  background(255);

  int[] kindList = {0, 1, 2, 3, 4, 5};

  for (int i=0; i< kindList.length; i++) {
    drawLine(kindList[i], (height / kindList.length) * i);
  }
}

void draw() {
}

void drawLine(int kind, float basey) {
  float lastx = -999;
  float lasty = -999;
  int beginx = (width / 20);
  int endx = width - (width / 20);
  float y = basey;
  float lineHeight = width * 0.025;
  float ynoise = random(10);
  float angle = 0;

  stroke(128, 50);
  line(0, basey, width, basey);

  stroke(0);
  for (int x=beginx; x<=endx; x+=(width / 50)) {
    switch(kind) {
    case 0:
      y = basey;
      break;
    case 1:
      y = random(basey - lineHeight, basey + lineHeight); //<>//
      break;
    case 2:
      float ystep = random(lineHeight * 2) - lineHeight;
      y += ystep;
      break;
    case 3:
      y = (basey - lineHeight) + (noise(ynoise) * (lineHeight * 2));
      ynoise += 0.1;
      break;
    case 4:
      y = (basey - lineHeight) + (noise(ynoise) * (lineHeight * 2));
      ynoise += 0.5;
      break;
    case 5:
      y = (basey - lineHeight) + (sin(angle) * (lineHeight * 2));
      angle++;
      break;
    }
    if (lastx > -999) {
      line(x, y, lastx, lasty);
    }

    lastx = x;
    lasty = y;
  }
}
