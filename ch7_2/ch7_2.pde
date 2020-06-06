Cell[][] _cellArray;
int _cellSize = 10;
int _numX, _numY;

void setup() {
  size(500, 300);
  _numX = floor(width / _cellSize );
  _numY = floor(height / _cellSize );
  restart();
}

void restart() {
  _cellArray = new Cell[_numX][_numY];
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y< _numY; y++) {
      Cell newCell = new Cell(x, y);
      _cellArray[x][y] = newCell;
    }
  }

  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y< _numY; y++) {
      int above = y - 1;
      int below = y + 1;
      int left = x - 1;
      int right = x + 1;
      if (above < 0) {
        above = _numY -1;
      }
      if (below >= _numY) {
        below = 0;
      }
      if (left < 0) {
        left = _numX-1;
      }
      if (right >= _numX) {
        right = 0;
      }

      _cellArray[x][y].addNeighbour(_cellArray[left][above]);
      _cellArray[x][y].addNeighbour(_cellArray[left][y]);
      _cellArray[x][y].addNeighbour(_cellArray[left][below]);

      _cellArray[x][y].addNeighbour(_cellArray[x][above]);
      _cellArray[x][y].addNeighbour(_cellArray[x][below]);

      _cellArray[x][y].addNeighbour(_cellArray[right][above]);
      _cellArray[x][y].addNeighbour(_cellArray[right][y]);
      _cellArray[x][y].addNeighbour(_cellArray[right][below]);
    }
  }
}

void draw() {
  background(200);

  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y< _numY; y++) {
      _cellArray[x][y].calcNextState();
    }
  }

  translate(_cellSize / 2, _cellSize / 2);

  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y< _numY; y++) {
      _cellArray[x][y].drawMe();
    }
  }
}

void mouserPressed() {
  restart();
}

/**--------------------------------------------
 * Cell class
 --------------------------------------------*/
class Cell {
  float x, y;
  boolean state, nextState;
  Cell[] neighbours;
  int liveCount = 0;

  Cell(float ex, float why) {
    x = ex * _cellSize;
    y = why * _cellSize;

    nextState = (boolean) (random(2) > 1);
    state = nextState;
    neighbours = new Cell[0];
  }

  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell);
  }

  void calcNextState() {
    liveCount = 0;
    for (int i = 0; i < neighbours.length; i++) {
      if (neighbours[i].state) {
        liveCount++;
      }
    }

    if (state) {
      nextState = (boolean)((liveCount == 2) || (liveCount == 3));
    } else {
      nextState = (boolean)(liveCount == 3);
    }
  }

  void drawMe() {
    state = nextState;
    stroke(0);

    if (state) {
      fill(0);
    } else {
      fill(floor(255 / (liveCount + 1)));
    }

    int neighboursEffect = liveCount * 5;
    circle(x - (neighboursEffect / 2), y  - (neighboursEffect / 2), _cellSize + neighboursEffect);
  }
}
