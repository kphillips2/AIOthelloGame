Board b = new Board();
Computer computer;

int gameState = 0;  // 0 - ask configuration, 1 - ask colour, 3 - black turn, 4 - white turn, 5 - game over
char playerColour;

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
}

void drawScoreBoard()
{
  fill(0);
  text("Black Score", 705,60);
  text(b.getScore('B'), 750,100);
    
  text("White Score", 695,180);
  text(b.getScore('W'), 750,220);
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
      computer = new Computer('W');
      playerColour = 'B';
      gameState = 2;
    }
    else if(mouseX > 780 && mouseX < 840 && mouseY > 410 && mouseY < 470)
    {
      computer = new Computer('B');
      playerColour = 'W';
      gameState = 2;
    }
  }
}