FractalRoot pentagon;
int _maxLevels = 4;
float _structFactor = 0.2;
float _structNoise;

void setup() {
  size(1000, 1000);
  smooth();
}

void draw() {
  background(255);

  _structNoise += 0.01;
  _structFactor = noise(_structNoise) * 2;

  pentagon = new FractalRoot(frameCount);
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

  FractalRoot(float startAngle) {
    float centX = width / 2;
    float centY = height / 2;
    int count = 0;
    for (int i = 0; i < 360; i+=72) {
      float x = centX + (400 * cos(radians(startAngle + i)));
      float y = centY + (400 * sin(radians(startAngle + i)));
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
  Branch[] myBranches = {};

  Branch(int lev, int n, PointObj[] points) {
    level = lev;
    num = n;
    outerPoints = points;

    midPoints = calcMidPoints();
    projPoints = calcStructPoints();

    if ((level + 1) < _maxLevels) {
      Branch childBranch = new Branch(level + 1, 0, projPoints);
      myBranches = (Branch[])append(myBranches, childBranch);
      for (int i = 0; i < outerPoints.length; i++) {
        int nexti = i - 1;

        if (nexti < 0) {
          nexti += outerPoints.length;
        }
        PointObj[] newPoints = {projPoints[i], midPoints[i], outerPoints[i], midPoints[nexti], projPoints[nexti]};

        childBranch = new Branch(level + 1, i + 1, newPoints);
        myBranches = (Branch[])append(myBranches, childBranch);
      }
    }
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
      line(midPoints[i].x, midPoints[i].y, projPoints[i].x, projPoints[i].y);
    }

    for (int i = 0; i < myBranches.length; i++) {
      myBranches[i].drawMe();
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
