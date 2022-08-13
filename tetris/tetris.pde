boolean PLAYING = true;

Grid grid;
Shape current;
Shape next;
Shape next1;
Shape next2;
Shape held;
Ghost ghost;
int level;
int score;
int lines;
int levelLines;
int holdCount;
IntList bag;

void setup() {
  setupBag();
  frameRate(60);
  size(720, 720);
  textAlign(CENTER, CENTER);
  textSize(25);
  newGame();
}

void draw() {
  showStats();
  grid.display();
  if (PLAYING) {
    run();
  }
  if (!PLAYING) {
    endScreen();
  }
}

void run() {
  ghost();
  current.display();
  current.moveDown(level, grid);
  current.checkBottom();
  grid.checkRow();
  updateLevel();
}

void newGame() {
  level = 1;
  score = 0;
  lines = 0;
  holdCount = 0;
  grid = new Grid();
  next = nextPiece();
  next1 = nextPiece();
  next2 = nextPiece();
  held = null;
  newPiece();
}

void setupBag(){
  bag = new IntList();
  for(int i=0;i<7;i++){
    bag.append(i);
  }
}

void newPiece() {
  holdCount = 0;
  current = next;
  next = next1;
  next1 = next2;
  next2 = nextPiece();
  setupPiece();
  current.moving = true;
}

Shape nextPiece(){
  if(bag.size() == 0){
    setupBag();
  }
  Shape tmp;
  int random = int(random(bag.size()));
  int n = bag.get(random);
  bag.remove(random);
  tmp = new Shape(n);
  return tmp;
}

void endScreen() {
  stroke(#7f7f7f);
  fill(0);
  rect(width / 4 - 50, height / 4 + 10, width / 2 + 100, height / 4 + 50, 20);
  fill(255);
  text("GAME OVER", width / 2, height / 4 + 50);
  text("YOUR SCORE:", width / 2, height / 4 + 100);
  text(score, width / 2, height / 4 + 150);
  text("CLICK ANYWHERE TO START A NEW GAME", width / 2, height / 4 + 200);
}

void hold() {
  if (held == null) {
    held = new Shape(current.type);
    newPiece();
  } else {
    Shape tmp = new Shape(current.type);
    current = held;
    setupPiece();
    held = tmp;
  }
}

void showStats() {
  stroke(#7f7f7f);
  background(0, 0, 100);
  showHold();
  showScore();
  showNext();
}

void showHold() {
  fill(#7f7f7f);
  rect(20, 20, 140, height / 4, 20);
  fill(0);
  rect(20, 60, 140, height / 4 - 20, 20);
  fill(255);
  text("HOLD", 90, 40);
  if (held != null) {
    for (int i = 0; i < 4; i++) {
      fill(held.c);
      if (held.shape == held.square) {
        rect(held.shape[i][0] * held.size + 60, held.shape[i][1] * held.size + 90, held.size, held.size);
      } else if (held.shape == held.line) {
        rect(held.shape[i][0] * held.size + 30, held.shape[i][1] * held.size + 90, held.size, held.size);
      } else {
        rect(held.shape[i][0] * held.size + 45, held.shape[i][1] * held.size + 90, held.size, held.size);
      }
    }
  }
}

void showScore() {
  fill(#7f7f7f);
  rect(20, height / 2 - 20, 140, 280, 20);
  fill(0);
  rect(20, height / 2 + 20, 140, 50, 20);
  rect(20, height / 2 + 110, 140, 50, 20);
  rect(20, height / 2 + 200, 140, 50, 20);
  fill(255);
  text("SCORE", 90, height / 2);
  text(score, 90, height / 2 + 40);
  text("LEVEL", 90, height / 2 + 90);
  text(level, 90, height / 2 + 130);
  text("LINES", 90, height / 2 + 180);
  text(lines, 90, height / 2 + 220);
}

void showNext() {
  fill(#7f7f7f);
  rect(width / 2 + width / 4 + 20, 20, 140, 600, 20);
  fill(0);
  rect(width / 2 + width / 4 + 20, 60, 140, 580, 20);
  fill(255);
  text("NEXT", width / 2 + width / 4 + 90, 40);
  displayNextPiece(next, 0);
  displayNextPiece(next1, 1);
  displayNextPiece(next2, 2);
}

void displayNextPiece(Shape s, int n) {
  for (int i = 0; i < 4; i++) {
    fill(s.c);
    if (s.shape == s.square) {
      rect(s.shape[i][0] * s.size + width / 2 + width / 4 + 60, s.shape[i][1] * s.size + 120 + 180 * n, s.size, s.size);
    } else if (s.shape == s.line) {
      rect(s.shape[i][0] * s.size + width / 2 + width / 4 + 30, s.shape[i][1] * s.size + 120 + 180 * n, s.size, s.size);
    } else {
      rect(s.shape[i][0] * s.size + width / 2 + width / 4 + 45, s.shape[i][1] * s.size + 120 + 180 * n, s.size, s.size);
    }
  }
}

void updateLevel() {
  if (levelLines >= 10 * level) {
    level++;
    levelLines = 0;
  }
}

void setupPiece() {
  for (int i = 0; i < 4; i++) {
    current.startRight();
  }
  if (current.type == Shape.SQUARE_SHAPE) {
    current.startRight();
  }
  for (int i = 0; i < 6; i++) {
    current.rotate();
    current.rotate2();
    current.changeRot();
  }
}

void ghost() {
  ghost = new Ghost(current);
  ghost.drop(grid);
  ghost.display();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      current.move("LEFT", grid);
    }
    if (keyCode == RIGHT) {
      current.move("RIGHT", grid);
    }
    if (keyCode == DOWN) {
      current.move("DOWN", grid);
      score += 1;
    }
    if (keyCode == UP) {
      current.rotate();
      current.rotate2();
      current.changeRot();
    }
  }
  if (key == ' ') {
    current.drop(grid);
  }
  if (key == 'c') {
    if (holdCount == 0) {
      hold();
    }
    holdCount++;
  }
}

void mousePressed() {
  if (!PLAYING) {
    if (mousePressed) {
      newGame();
      PLAYING = true;
    }
  }
}
