/**
 * Press 'q' to quit
 * Press 'z' to undo
 * This program runs Othello. In order to run this program, make sure you
 * have processing downloaded/installed. It took a while for it to 
 * download for me - Evan
 * From there open AIOthelloGame and click the play button at the top left
 * There you go! The game will be running and the output for the 
 * best first + ABpruning will be at the bottom of the screen that has
 * our code displayed.
 * One of us can bring it into your office hours as well to show you.
 *
 * CPSC 427-02
 * Assignment 12
 * Evan Srock (esrock)
 * Patrick Chadbourne
 * Katie Phillips
 * 
 */
Board b = new Board();
char[][] savedBoardState = new char[8][8];
Computer computer;
Human human;
int flashText = 0;
int[] threadedMove;
boolean moveMade = false;
boolean makingMove = false;
int timer = 600;

int gameState = 0;  // 0 - ask configuration 
                    // 1 - ask color 
                    // 2 - confirm AI will make a move
                    // 3 - AI makes move
                    // 4 - confirm after AI can't move
                    // 5 - confirm after AI move
                    // 6 - player makes move
                    // 7 - confirm after player move
                    // 8 - player's turn, but they have no possible moves
                    // 9 - game over
                    // 10 - AI time out

void setup()
{
  size(910,610);
  textFont(createFont("Segoe UI Light", 22));
}

void draw()
{
  clear();
  background(98,95,63);
  drawBoard();
  fill(255);
  strokeWeight(2);
  rect(630,30, 250,560);
  strokeWeight(1);
  if(flashText > 0){
    fill(255,0,0,(255/30)*flashText);
    text("Move Undone", 680,330);
    flashText--;
  }
  
  //Select Initial Configuration
  if(gameState == 0)
  {    
    fill(0);
    text("Select Configuration:", 660,60);
    fill(255);
    ellipse(720, 170, 60, 60);
    ellipse(790, 240, 60, 60);
    fill(0);
    ellipse(720, 240, 60, 60);
    ellipse(790, 170, 60, 60);
    
    ellipse(720, 380, 60, 60);
    ellipse(790, 450, 60, 60);
    fill(255);
    ellipse(720, 450, 60, 60);
    ellipse(790, 380, 60, 60);
  }
  
  //Select Black or White
  else if(gameState == 1)
  {
    drawScoreBoard();
    text("Play as Black or White?", 650,370);
    fill(0);
    ellipse(710, 440, 60, 60);
    fill(255);
    ellipse(810, 440, 60, 60);
  }
  
  //Announce A will make a move
  else if(gameState == 2)
  {
    drawScoreBoard();
    fill(0);
    text("A is about to make", 665,370);
    text("a move.", 720,390);
    text("Please confirm.", 680,420);
    drawConfirmButton();
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        savedBoardState[i][j] = char(b.board[i][j]);
      }
    }
  }
  
  //A makes its move
  else if(gameState == 3)
  {
    drawScoreBoard();
    if(makingMove == false){
      makingMove = true;
      moveMade = false;
      thread("makeThreadedMove");
    }
    //Check for timeout and update timer
    timer--;
    pushStyle();
    fill(240,0,0);
    textFont(createFont("Segoe UI Bold", 72));
    text(float(timer)/60.0, 640, 430);
    popStyle();
    if(timer <= 0){
      gameState = 10;
    }

    if(moveMade && timer > 0){
      if(threadedMove[0] == -1)
      {
        if(b.possibleMoves(human.getColor()).size() == 0)
          gameState = 9;
        else
          gameState = 4;
      }
      else
      {
        b.makeMove(threadedMove[0], threadedMove[1], computer.getColor(), false);
        gameState = 5;
      }
      makingMove = false;
      timer = 600;
    }
  }
  
  //Have user confirm
  else if(gameState == 4 || gameState == 5 || gameState == 7 || gameState == 8)
  {
    drawScoreBoard();
    fill(0);
    if(gameState == 4)
      text("A cannot make a move.", 650,370);
    else if(gameState == 8)
      text("You cannot make a move.", 640,370);
    else
      text("Please confirm.", 685,370);
    drawConfirmButton();
    highlightChanges();
  }
  
  //Ask user to make move
  else if(gameState == 6)
  {
    drawScoreBoard();
    fill(0);
    text("Please make a move.", 660,370);
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        savedBoardState[i][j] = char(b.board[i][j]);
      }
    }
  }
  
  else if(gameState == 9)
  {
    drawScoreBoard();
    fill(0);
    text("GAME OVER", 690,370);
  }
  
  else if(gameState == 10)
  {
    drawScoreBoard();
    fill(0);
    text("AI timed out, FAILURE", 690,370);
  }
}

void makeThreadedMove(){
  moveMade = false;
  //delay(5000);
  threadedMove = computer.makeMove(b);
  moveMade = true;
  return;
}

void drawConfirmButton()
{
  fill(255);
  strokeWeight(2);
  rect(655,440, 200,50);
  strokeWeight(1);
  fill(0);
  text("CONFIRM", 710,475);
}

void drawScoreBoard()
{
  fill(0);
  text("Black Score", 705,60);
  text(b.getScore('B'), 750,100);
    
  text("White Score", 695,180);
  text(b.getScore('W'), 750,220);
}

void highlightChanges(){
  for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        if(char(savedBoardState[i][j]) != char(b.board[i][j])){
          fill(255,255,0,70);
          rect(30 + j*70, 30 + i*70, 70,70);
      }
    }
  }
}

void drawBoard()
{
  addCoordinates();
  
  for(int i = 0; i < 8; i++)
    for(int j = 0; j < 8; j++)
    {
      if((i % 2 == 0 && j % 2 == 0) | (i % 2 == 1 && j % 2 == 1))
        fill(50,140,50);
      else
        fill(50,170,50);
    
      rect(30 + j*70, 30 + i*70, 70,70);
      
      // Draw tokens
      if(b.board[i][j] == 'W')
      {
        fill(255);
        ellipse((30 + j*70) + 35, (30 + i*70) + 35, 60, 60);
      }
      else if(b.board[i][j] == 'B')
      {
        fill(0);
        ellipse((30 + j*70) + 35, (30 + i*70) + 35, 60, 60);
      }
    }
}

void addCoordinates()
{
  fill(0);

  text("A", 60, 25);
  text("B", 130, 25);
  text("C", 200, 25);
  text("D", 270, 25);
  text("E", 340, 25);
  text("F", 410, 25);
  text("G", 480, 25);
  text("H", 550, 25);
  
  text("1", 10, 70);
  text("2", 10, 140);
  text("3", 10, 210);
  text("4", 10, 280);
  text("5", 10, 350);
  text("6", 10, 420);
  text("7", 10, 490);
  text("8", 10, 560);
}

// Checks whether or not human has moves, if not, check if game over
void enterHumanTurn()
{
  if(b.possibleMoves(human.getColor()).size() == 0)
  {
    if(b.possibleMoves(computer.getColor()).size() == 0)
      gameState = 9;
    else
      gameState = 8;
  }
  else
    gameState = 6;
}

void mousePressed()
{
  // Check if one of the configurations was clicked
  if(gameState == 0)
  {
    if(mouseX > 690 && mouseX < 820 && mouseY > 140 && mouseY < 270)
    {
      b.setLayout(1);
      gameState = 1;
    }
    else if(mouseX > 690 && mouseX < 820 && mouseY > 350 && mouseY < 480)
    {
      b.setLayout(0);
      gameState = 1;
    }
  }
  
  // Check if black or white circle was clicked
  else if(gameState == 1)
  {
    if(mouseX > 680 && mouseX < 740 && mouseY > 410 && mouseY < 470)
    {
      computer = new ABPruningComputer('W');
      human = new Human('B');
      enterHumanTurn();
    }
    else if(mouseX > 780 && mouseX < 840 && mouseY > 410 && mouseY < 470)
    {
      computer = new ABPruningComputer('B');
      human = new Human('W');
      gameState = 2;
    }
  }
  
  //Check if confirmed
  else if(gameState == 2 || gameState == 4 || gameState == 5 || gameState == 7 || gameState == 8)
  {
    if(mouseX > 655 && mouseX < 855 && mouseY > 440 && mouseY < 490)
    {
      if(gameState == 2) gameState = 3;
      else if(gameState == 7 || gameState == 8) gameState = 2;
      else enterHumanTurn();
    }
  }
  
  //Pass clicked coordinates to Human, make move if possible
  else if(gameState == 6)
  {
    int[] move = human.makeMove(mouseX, mouseY);
    if(move[0] != -1)
    {
      boolean success = b.makeMove(move[0], move[1], human.getColor(), true);
      if(success) gameState = 7;
    }
  }
}

// Allow quit game by pressing 'q'
void keyPressed()
{
  if(key == 'q') exit();
  if(key == 'z'){
    if(gameState == 6){
      b.undo();
      b.undo();
      flashText = 60;
    }
  }
}