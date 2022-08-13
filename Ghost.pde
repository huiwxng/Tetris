class Ghost extends Shape {

  Ghost(Shape s) {
    super(s.type);
    for (int i = 0; i<4; i++) {
      this.shape[i][0] = s.shape[i][0];
      this.shape[i][1] = s.shape[i][1];
    }
    this.copy = s.copy;

    this.type = s.type;
    this.rotation = s.rotation;
    this.size = s.size;
    this.c = 200;
    this.moving = s.moving;
    this.rot = s.rot;
  }

  void drop(Grid g) {
    while (moving == true) {
      move("DOWN", g);
    }
  }
}
