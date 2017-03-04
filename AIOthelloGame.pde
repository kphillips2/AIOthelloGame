Board b = new Board();
Computer computer;

int gameState = 0;  // 0 - ask configuration, 1 - ask colour, 3 - black turn, 4 - white turn, 5 - game over
PFont font = createFont("Segoe UI Light", 22);

char playerColour;

void setup()
{
  size(900,600);
  background(98,95,63);
}

void draw()
{
  clear();
  background(98,95,63);
  drawBoard();
  fill(255);
  strokeWeight(2);
  rect(620,20, 250,560);
  strokeWeight(1);
    
  if(gameState == 0)
  {    
    fill(0);
    textFont(font);
    text("Select Configuration:", 650,50);
    fill(255);
    ellipse(710, 160, 60, 60);
    ellipse(780, 230, 60, 60);
    fill(0);
    ellipse(710, 230, 60, 60);
    ellipse(780, 160, 60, 60);
    
    ellipse(710, 370, 60, 60);
    ellipse(780, 440, 60, 60);
    fill(255);
    ellipse(710, 440, 60, 60);
    ellipse(780, 370, 60, 60);
  }
  else if(gameState == 1)
  {
    fill(0);
    textFont(font);
    text("Computer Score", 670,50);
    text("2", 740,90);
    text("Player Score", 685,170);
    text("2", 740,210);
    text("Play as Black or White?", 640,370);
    ellipse(700, 430, 60, 60);
    fill(255);
    ellipse(800, 430, 60, 60);
  }
}

void drawBoard()
{
  for(int i = 0; i < 8; i++)
    for(int j = 0; j < 8; j++)
    {
      if((i % 2 == 0 && j % 2 == 0) | (i % 2 == 1 && j % 2 == 1))
        fill(50,140,50);
      else
        fill(50,170,50);
    
      rect(20 + j*70, 20 + i*70, 70,70);
      
      if(b.board[i][j] == 'W')
      {
        fill(255);
        ellipse((20 + j*70) + 35, (20 + i*70) + 35, 60, 60);
      }
      else if(b.board[i][j] == 'B')
      {
        fill(0);
        ellipse((20 + j*70) + 35, (20 + i*70) + 35, 60, 60);
      }
    }
}

void mousePressed()
{
  if(gameState == 0)
  {
    if(mouseX > 680 && mouseX < 810 && mouseY > 130 && mouseY < 260)
    {
      b.setLayout(1);
      gameState = 1;
    }
    else if(mouseX > 680 && mouseX < 810 && mouseY > 340 && mouseY < 470)
    {
      b.setLayout(0);
      gameState = 1;
    }
  }
  
  else if(gameState == 1)
  {
    if(mouseX > 670 && mouseX < 730 && mouseY > 400 && mouseY < 460)
    {
      computer = new Computer('W');
      playerColour = 'B';
      gameState = 2;
    }
    else if(mouseX > 770 && mouseX < 830 && mouseY > 400 && mouseY < 460)
    {
      computer = new Computer('B');
      playerColour = 'W';
      gameState = 2;
    }
  }
}