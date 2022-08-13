class Shape {
  static final int SQUARE_SHAPE = 0;
  static final int LINE_SHAPE = 1;
  static final int T_SHAPE = 2;
  static final int L_SHAPE = 3;
  static final int J_SHAPE = 4;
  static final int Z_SHAPE = 5;
  static final int S_SHAPE = 6;

  static final int R0 = 0;
  static final int R1 = 1;
  static final int R2 = 2;
  static final int R3 = 3;

  private int[][] square = {
    {0, 0}, {1, 0},
    {0, 1}, {1, 1}
  }; //square shape
  private int[][] line = {{0, 0}, {1, 0}, {2, 0}, {3, 0}}; //line shape
  private int[][] tShape = {{0, 0}, {1, 0}, {2, 0},
    {1, 1}
  }; //T shape
  private int[][] lShape = {{0, 0}, {1, 0}, {2, 0},
    {0, 1}
  }; //L shape
  private int[][] jShape = {{0, 0}, {1, 0}, {2, 0}, {2, 1}}; //J shape
  private int[][] zShape = {{0, 0}, {1, 0}, {1, 1}, {2, 1}}; //Z shape
  private int[][] sShape = {{0, 1}, {1, 1}, {1, 0}, {2, 0}}; //S shape

  int[][] shape;
  int[][] copy;

  int type;
  int rotation;
  int size;
  color c;
  boolean moving;
  int rot = 0;

  Shape(int t) {
    size = height / 24;
    c = 255;
    type = t;
    if (type == SQUARE_SHAPE) {
      c = #ffff00;//yellow
      shape = square;
    }
    if (type == LINE_SHAPE) {
      c = #00ffff;//cyan
      shape = line;
    }
    if (type == T_SHAPE) {
      c = #800080;//purple
      shape = tShape;
    }
    if (type == L_SHAPE) {
      c = #ff7f00;//orange
      shape = lShape;
    }
    if (type == J_SHAPE) {
      c = #0000ff;//blue
      shape = jShape;
    }
    if (type == Z_SHAPE) {
      c = #ff0000;//red
      shape = zShape;
    }
    if (type == S_SHAPE) {
      c = #00ff00;//green
      shape = sShape;
    }
    copy = shape;
    moving = true;
  }

  Shape(Shape s) {
    this.shape = s.shape;
    this.copy = s.copy;

    this.type = s.type;
    this.rotation = s.rotation;
    this.size = s.size;
    this.c = s.c;
    this.moving = s.moving;
    this.rot = s.rot;
  }

  void display() {
    for (int i = 0; i < 4; i++) {
      fill(c);
      rect(shape[i][0] * size + width / 4, shape[i][1] * size, size, size);
    }
  }

  boolean checkLeft(Grid g) {
    for (int i = 0; i < 4; i++) {
      if (shape[i][0] < 1) {
        return false;
      }
      if (g.colors[ shape[i][1] ][ shape[i][0]-1 ] != 0) {
        return false;
      }
    }
    return true;
  }

  boolean checkRight(Grid g) {
    for (int i = 0; i < 4; i++) {
      if (shape[i][0] > 10) {
        return false;
      }
      if (g.colors[ shape[i][1] ][ shape[i][0]+1 ] != 0) {
        return false;
      }
    }
    return true;
  }

  boolean checkDown(Grid g) {
    for (int i = 0; i < 4; i++) {
      if (shape[i][1] > 22) {
        moving = false;
        return false;
      } else {
        if (g.colors[shape[i][1]+1][shape[i][0]] != 0) {
          for (int y = 0; y < 4; y++) {
            if (shape[y][1] == 0) {
              PLAYING = false;
            }
          }
          moving = false;
          return false;
        }
      }
    }
    return true;
  }

  void checkBottom() {
    if (!checkDown(grid)) {
      grid.drawShape(this);
      newPiece();
    }
  }

  void startRight() {
    for (int i = 0; i < 4; i++) {
      shape[i][0]++;
    }
  }

  void move(String direction, Grid g) {
    if (direction.equals("LEFT")) {
      if (checkLeft(g)) {
        for (int i = 0; i < 4; i++) {
          shape[i][0]--;
        }
      }
    }
    if (direction.equals("RIGHT")) {
      if (checkRight(g)) {
        for (int i = 0; i < 4; i++) {
          shape[i][0]++;
        }
      }
    }
    if (direction.equals("DOWN")) {
      if (checkDown(grid)) {
        for (int i = 0; i < 4; i++) {
          shape[i][1]++;
        }
      }
    }
  }

  void moveDown(int level, Grid g) {
    if (frameCount % (60 / level) == 0) {
      move("DOWN", g);
    }
  }

  void changeRot() {
    if (rot < R3) {
      rot++;
    } else {
      rot = R0;
    }
  }

  void rotate() {
    if (type != SQUARE_SHAPE) {
      int[][] tmp = new int[4][2];
      if (rot == R0) {
        for (int i = 0; i < 4; i++) {
          tmp[i][0] = -(copy[i][1] + shape[1][0]);
          tmp[i][1] = -(-copy[i][0] + shape[1][1]);
          //(x,y) --> (y,-x)
        }
      } else if (rot == R1) {
        for (int i = 0; i < 4; i++) {
          tmp[i][0] = -(-copy[i][0] + shape[1][0]);
          tmp[i][1] = -(-copy[i][1] + shape[1][1]);
          //(x,y) --> (-x,-y)
        }
      } else if (rot == R2) {
        for (int i = 0; i < 4; i++) {
          tmp[i][0] = -(-copy[i][1] + shape[1][0]);
          tmp[i][1] = -(copy[i][0] + shape[1][1]);
          //(x,y) --> (-y,x)
        }
      } else if (rot == R3) {
        for (int i = 0; i < 4; i++) {
          tmp[i][0] = -(copy[i][0] + shape[1][0]);
          tmp[i][1] = -(copy[i][1] + shape[1][1]);
          //(x,y) --> (x,y)
        }
      }
      shape = tmp;
    }
  }

  void rotate2() {
    if (type != SQUARE_SHAPE) {
      int[][] tmp = new int[4][2];
      if (rot == R0) {
        for (int i = 0; i < 4; i++) {
          tmp[i][0] = -(copy[i][1] + shape[1][0]);
          tmp[i][1] = -(-copy[i][0] + shape[1][1]);
          //(x,y) --> (y,-x)
        }
      } else if (rot == R1) {
        for (int i = 0; i < 4; i++) {
          tmp[i][0] = -(-copy[i][0] + shape[1][0]);
          tmp[i][1] = -(-copy[i][1] + shape[1][1]);
          //(x,y) --> (-x,-y)
        }
      } else if (rot == R2) {
        for (int i = 0; i < 4; i++) {
          tmp[i][0] = -(-copy[i][1] + shape[1][0]);
          tmp[i][1] = -(copy[i][0] + shape[1][1]);
          //(x,y) --> (-y,x)
        }
      } else if (rot == R3) {
        for (int i = 0; i < 4; i++) {
          tmp[i][0] = -(copy[i][0] + shape[1][0]);
          tmp[i][1] = -(copy[i][1] + shape[1][1]);
          //(x,y) --> (x,y)
        }
      }
      for (int i = 0; i<4; i++) {
        while (tmp[i][0] < 0) {
          for (int p = 0; p<4; p++) {
            tmp[p][0]++;
          }
        }
      }

      for (int i = 0; i<4; i++) {
        while (tmp[i][0] > 11) {
          for (int p = 0; p<4; p++) {
            tmp[p][0]--;
          }
        }
      }

      for (int i =0; i<4; i++) {
        while (tmp[i][1] < 0) {
          for (int p = 0; p<4; p++) {
            tmp[p][1]++;
          }
        }
      }

      for (int i =0; i<4; i++) {
        while (tmp[i][1] > 23) {
          for (int p = 0; p<4; p++) {
            tmp[p][1]--;
          }
        }
      }

      shape = tmp;
    }
  }  
  
  void drop(Grid g) {
    while (moving == true) {
      move("DOWN", g);
      score += 2;
    }
  }
}
