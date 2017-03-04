class Board
{
  char[][] board = new char[8][8];
  
  Board(int layout)
  {
    //If 0, BW;WB. If 1, WB;BW
  }

  boolean isLegal(int x, int y, char colour)
  {
    //Check to see if specified move is legal for the
    //specified colour.
  }

  int getWhiteScore()
  {
    //Count all white tiles on board and return number
  }

  int getBlackScore()
  {
    //Count all black tiles on board and return number
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