class Board
{
  char[][] board = new char[8][8];
  
  Board()
  {
    for(int i = 0; i < 8; i++)
      for(int j = 0; j < 8; j++)
        board[i][j] = 'E';
  }
  
  void setLayout(int layout)
  {
    if(layout == 0)
    {
      board[3][3] = 'B';
      board[4][3] = 'W';
      board[3][4] = 'W';
      board[4][4] = 'B';
    }
    else
    {
      board[3][3] = 'W';
      board[4][3] = 'B';
      board[3][4] = 'B';
      board[4][4] = 'W';
    }
  }

  boolean isLegal(int x, int y, char colour)
  {
    //Check to see if specified move is legal for the
    //specified colour.
    return true;
    
  }

  int getScore(char colour)
  {
    int score = 0;
    
    for(int i = 0; i < 8; i++)
      for(int j = 0; j < 8; j++)
      {
        if(board[i][j] == colour)
          score++;
      }
    
    return score;
  }

  void makeMove(int x, int y, char colour)
  {
    if(isLegal(x,y,colour))
    {
      //Place character in array
      //Check for tiles and flip
      
    }
  }
}