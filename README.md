# NeXTCS Final Project
### Programmer 0: Hui Wang
### Programmer 1: Marc Jiang
### Class period: 10
---
### Proposal:
**Tetris**
**link:** *https://tetris.com/play-tetris*

**Description**
- video game where differently shaped blocks made of 4 squares are descending on a grid
- the goal is to survive as long as possible by filling up the grid and getting rows of blocks to clear that row
- the completed rows disappear and give the player points
- completing multiple lines at once will grant the player more points
- the game ends when the block reaches over the top of the grid

**Processing Libraries:**
- unsure at the moment
- might incorporate the sound library to add sounds to the blocks dropping and scoring points
- might use the sound library to have background music

**Course Relevance:**
- Processing to create a graphical program
- Using keyboard & mouse for input
- Using major control structures in Java in our code
- Writing classes
- Using 2 dimensional arrays for grid
- edge detection for interactions with different shaped objects (by color?)
- Image processing
- *Using processing libraries maybe*

---
### Design:

**Files/Classes:**
# Driver:
- Initialize grid in setup
- Update then display grid and shapes.
- Methods to check for if you lost, if there's a full row
- Method to display where the shape will land straight below it

# Grid:
- Generate a grid with a 2d array.
- Will serve as the field for the shapes.

# Shape:
- Construct one out of 7 static shapes.
- Methods to display, move, and rotate it.

**Course Concepts:**
- Uses different classes for objects
- 2D arrays
- Different loops to iterate these arrays

**User Interaction:**
- interact using mouse and keyboard
- mouse to start the game
- keyboard to control the blocks
  - left arrow to move left
  - right arrow to move right
  - up arrow to rotate
  - z to rotate the other direction
  - down arrow to move the block down faster
  - space to instantly drop the block
  - c to hold the current block and swap with either the block currently being held or the next block
- sound from the sound library maybe

**Mock-up**
![image](https://user-images.githubusercontent.com/88509047/169388114-fc80ae80-7a2a-4f49-8ae2-6f21cb8acaea.png)
