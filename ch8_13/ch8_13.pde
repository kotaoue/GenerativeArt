FractalRoot pentagon;
int _maxLevels = 5;
float _structFactor = 0.2;

void setup() {
  size(1000, 1000);
  smooth();
  pentagon = new FractalRoot();
  pentagon.drawShape();
}

class PointObj {
  float x, y;
  PointObj(float ex, float why) {
    x =ex;
    y = why;
  }
}

class FractalRoot {
  PointObj[] pointArr = new PointObj[5];
  Branch rootBranch;

  FractalRoot() {
    float centX = width / 2;
    float centY = height / 2;
    int count = 0;
    for (int i = 0; i < 360; i+=72) {
      float x = centX + (400 * cos(radians(i)));
      float y = centY + (400 * sin(radians(i)));
      pointArr[count] = new PointObj(x, y);
      count++;
    }

    rootBranch = new Branch(0, 0, pointArr);
  }

  void drawShape() {
    rootBranch.drawMe();
  }
}

class Branch {
  int level, num;
  PointObj[] outerPoints = {};
  PointObj[] midPoints = {};
  PointObj[] projPoints = {};

  Branch(int lev, int n, PointObj[] points) {
    level = lev;
    num = n;
    outerPoints = points;

    midPoints = calcMidPoints();
    projPoints = calcStructPoints();
  }

  void drawMe() {
    strokeWeight(5 - level);
    // draw outer shape
    for (int i = 0; i < outerPoints.length; i++) {
      int nexti = i + 1;
      if (nexti == outerPoints.length) {
        nexti = 0;
      }
      line(outerPoints[i].x, outerPoints[i].y, outerPoints[nexti].x, outerPoints[nexti].y);
    }

    strokeWeight(0.5);
    fill(255, 150);
    for (int i = 0; i < midPoints.length; i++) {
      circle(midPoints[i].x, midPoints[i].y, 15);
      line(midPoints[i].x, midPoints[i].y, projPoints[i].x, projPoints[i].y);
      circle(projPoints[i].x, projPoints[i].y, 15);
    }
  }

  PointObj[] calcMidPoints() {
    PointObj[] mpArray = new PointObj[outerPoints.length];
    for ( int i = 0; i < outerPoints.length; i++) {
      int nexti = i + 1;
      if (nexti == outerPoints.length) {
        nexti = 0;
      }
      PointObj thisMp = calcMidPoint(outerPoints[i], outerPoints[nexti]);

      mpArray[i] = thisMp;
    }

    return mpArray;
  }

  PointObj calcMidPoint(PointObj end1, PointObj end2) {
    float mx, my;

    if (end1.x > end2.x) {
      mx = end2.x + ((end1.x - end2.x) / 2);
    } else {
      mx = end1.x + ((end2.x - end1.x) / 2);
    }
    if (end1.y > end2.y) {
      my = end2.y + ((end1.y - end2.y) / 2);
    } else {
      my = end1.y + ((end2.y - end1.y) / 2);
    }

    return new PointObj(mx, my);
  }

  PointObj[] calcStructPoints() {
    PointObj[] structArray = new PointObj[midPoints.length];
    for (int i = 0; i < midPoints.length; i++) {
      int nexti = i + 3;
      if (nexti >= midPoints.length) {
        nexti -= midPoints.length;
      }

      PointObj thisSP = calcProjPoint(midPoints[i], outerPoints[nexti]);
      structArray[i] = thisSP;
    }
    return structArray;
  }

  PointObj calcProjPoint(PointObj mp, PointObj op) {
    float px, py;
    float adj, opp;
    if (op.x > mp.x) {
      opp = op.x - mp.x;
    } else {
      opp = mp.x - op.x;
    }
    if (op.y > mp.y) {
      adj = op.y - mp.y;
    } else {
      adj = mp.y - op.y;
    }

    if (op.x > mp.x) {
      px = mp.x + (opp * _structFactor);
    } else {
      px = mp.x - (opp * _structFactor);
    }
    if (op.y > mp.y) {
      py = mp.y + (adj * _structFactor);
    } else {
      py = mp.y - (adj * _structFactor);
    }

    return new PointObj(px, py);
  }
}
