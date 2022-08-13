class Grid {
  int rows;
  int cols;
  int size;
  color colors[][];
  
  Grid() {
    rows = 24;
    cols = 12;
    size = height / rows;
    colors = new color[rows][cols];
    for(int r =0;r < rows;r++){
      for(int c =0;c < cols;c++){
        colors[r][c] = 0;
      }
    }
  }
  
  void display() {
    strokeWeight(4);
    stroke(#7f7f7f, 100);
    for (int i = 0; i < cols + 1; i++) {
      line(i * size + width / 4, 0, i * size + width / 4, height);
    }//vertical lines
    for (int i = 0; i < rows + 1; i++) {
      line(0 + width / 4, i * size, width / 2 + width / 4, i * size);
    }//horizontal lines
    for(int r = 0; r < rows; r++){
      for(int c = 0; c < cols; c++){
        fill(colors[r][c]);
        rect(c * size + width / 4, r * size, size, size);
      }
    }
  }
  
  void drawShape(Shape s) {
    for (int i = 0; i < 4; i++){
      colors[s.shape[i][1]][s.shape[i][0]] = s.c;
    }
  }

  void clearRow(int row) {
    for (int c = 0; c < cols; c++) {
      colors[row][c] = 0;
    }
    for(int r = row; r > 0; r--){
      for(int c = 0; c < cols; c++){
        colors[r][c] = colors[r-1][c];
      }
    }
  }

  boolean isFullRow(int row) {
    for (int c = 0; c < cols; c++) {
      if (colors[row][c] == 0) {
        return false;
      }
    }
    return true;
  }
  
  void checkRow() {
    int count = 0;
    for (int i = 0; i < rows; i++) {
      if (isFullRow(i)) {
        clearRow(i);
        count++;
      }
    }
    lines += count;
    levelLines += count;
    if (count == 1) {
      score += 100 * level;
    }
    else if (count == 2) {
      score += 300 * level;
    }
    else if (count == 3) {
      score += 500 * level;
    }
    else if (count == 4) {
      score += 800 * level;
    }
  }
}
