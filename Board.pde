/*
 * https://en.wikipedia.org/wiki/Reversi
 * As per Othello layout origin is in top right.
 * x is letters increasing to the right
 * and y is numbers increasing downward
 * we will not use letters however
 * Ex: (I is where we Init)
 *  	0	1	2	3	4	5	6	7
 *	 0 ___|___|___|___|___|___|___|___
 *	 1 ___|___|___|___|___|___|___|___
 *	 2 ___|___|___|___|___|___|___|___
 *	 3 ___|___|___|_I_|_I_|___|___|___
 *	 4 ___|___|___|_I_|_I_|___|___|___
 *	 5 ___|___|___|___|___|___|___|___
 *	 6 ___|___|___|___|___|___|___|___
 *	 7    |   |   |   |   |   |   |   
 */

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

  public boolean isLegal(int x, int y, char colour)
  {
    return 0 < checkMove(colour, x, y, false);
    
  }

  public int getScore(char colour)
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

  public void makeMove(int x, int y, char colour)
  {
    if(isLegal(x,y,colour))
    {
      //Place character in array
      //Check for tiles and flip
      
    }
  }
  
  /**
   * Returns a double array of the possible moves for a player as well as the 
   * number of Pieces that can be flipped from the move.
   * Format: [ [ row, column, num_flipped], ... ]
   * @param	 color either 'B' or 'W'
   * @return 	   two-dimensional array of xindex, yindex, num_flipped
   */
  private int[][] checkBoard(char colour){
	  return new int[0][3];
  }
  
  /**
   * Returns the number of pieces that can be flipped by a certains colors move
   * if toFlip is true then it will flip the pieces if a valid move.
   * @param color either 'B' or 'W'
   * @param xindex x index of the move
   * @param yindex y index of the move
   * @param toFlip tell is the move is actually being played
   * @return number of tokens that would be flipped
   */
  private int checkMove(char colour, int xindex, int yindex, boolean toFlip){
	  return 0;
  }
  
  /**
   * Returns the number of pieces that can be flipped in a certain direction
   * if toFlip is true then it will flip the pieces if possible to flip in that.
   * Direction is indicated by the x and y increments.
   * base the examples off of the board at the top of file
   * Ex: if xincrement is 0 and yincrement is -1 then the direction is North
   *     if xincrement is 1 and yincrement is 1 then the direction is South East
   * @param color either 'B' or 'W'
   * @param xindex 		x index of the move
   * @param yindex 		y index of the move
   * @param toFlip 		tell is the move is actually being played
   * @param xincrement  tells the x direction to iterate can either be -1, 0, or 1
   * @param yincrement  tells the y direction to iterate can either be -1, 0, or 1
   * @return number of tokens that would be flipped
   */
  private int checkDirection(char colour, int xindex, int yindex, boolean toFlip,
							 int xincrement, int yincrement){
	  return 0;
  }
}