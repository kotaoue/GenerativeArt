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

void newTree() {
  _trunk = new Branch(1, 0, width /2, 50);
  _trunk.drawMe();
}

class Branch {
  float level, index;
  float x, y;
  float endx, endy;
  Branch[] children = new Branch[0];

  Branch(float lev, float ind, float  ex, float why) {
    level = lev;
    index = ind;
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
    endx = x + 150;
    endy = y + 15;
  }

  void drawMe() {
    line(x, y, endx, endy);
    circle(x, y, 5);
  }
}
