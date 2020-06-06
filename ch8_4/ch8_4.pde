int _numChildren = 3;
int _maxLevels = 3;

Branch _trunk;

void setup() {
  size(750, 500);
  background(255);
  noFill();
  smooth();
  newTree();
}

void draw() {
  background(255);
  _trunk.updateMe(width /2, height / 2);
  _trunk.drawMe();
}

void newTree() {
  _trunk = new Branch(1, 0, width /2, 50);
  _trunk.drawMe();
}

class Branch {
  float level, index;
  float x, y;
  float endx, endy;
  float strokeW, alph;
  float len, lenChange;
  float rot, rotChange;
  Branch[] children = new Branch[0];

  Branch(float lev, float ind, float  ex, float why) {
    level = lev;
    index = ind;
    strokeW = (1 / level) * 100;
    alph = 255 / level;
    len = (1 / level) * random(200);
    rot = random(360);
    lenChange = random(10) - 5;
    rotChange = random(10) - 5;

    updateMe(ex, why);

    if (level < _maxLevels) {
      children = new Branch[_numChildren];
      for (int i = 0; i < _numChildren; i ++ ) {
        children[i] = new Branch(level + 1, i, endx, endy);
      }
    }
  }

  void updateMe(float ex, float why) {
    x = ex;
    y = why;

    rot += rotChange;
    if ( rot > 360) {
      rot = 0;
    } else if (rot < 0) {
      rot = 360;
    }

    len -= lenChange;
    if ((len < 0) || (len > 200)) {
      lenChange *= -1;
    }

    endx = x + (level * (random(100) - 50));
    endy = y + 50 + (level * random(50));
  }

  void drawMe() {
    strokeWeight(strokeW);
    stroke(0, alph);
    fill(255, alph);
    line(x, y, endx, endy);
    circle(endx, endy, len / 12);

    for (int i = 0; i < children.length; i ++ ) {
      children[i].drawMe();
    }
  }
}
