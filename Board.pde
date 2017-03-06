/*
 * https://en.wikipedia.org/wiki/Reversi
 * As per Othello layout origin is in top right.
 * x is letters increasing to the right
 * and y is numbers increasing downward
 * we will not use letters however
 * Ex: (I is where we Init)
 *      0   1   2   3   4   5   6   7
 *   0 ___|___|___|___|___|___|___|___
 *   1 ___|___|___|___|___|___|___|___
 *   2 ___|___|___|___|___|___|___|___
 *   3 ___|___|___|_I_|_I_|___|___|___
 *   4 ___|___|___|_I_|_I_|___|___|___
 *   5 ___|___|___|___|___|___|___|___
 *   6 ___|___|___|___|___|___|___|___
 *   7    |   |   |   |   |   |   |   
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

  public boolean isLegal(int row, int column, char colour)
  {
    return 0 < checkMove(colour, row, column, false);
    
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

  public boolean makeMove(int row, int column, char colour)
  {
    return 0 < checkMove(colour, row, column, true);
  }
  
  /**
   * Returns a double array of the possible moves for a player as well as the 
   * number of Pieces that can be flipped from the move.
   * Format: [ [ row, column, num_flipped], ... ]
   * @param	 color either 'B' or 'W'
   * @return 	   two-dimensional array of xindex, yindex, num_flipped
   */
  public int[][] checkBoard(char colour){
	  return new int[0][3];
  }
  
  /**
   * Returns the number of pieces that can be flipped by a certains colors move
   * if toFlip is true then it will flip the pieces if a valid move. Checks the 8
   * possible directions
   * @param color either 'B' or 'W'
   * @param row row index of the move
   * @param column column index of the move
   * @param toFlip tell is the move is actually being played
   * @return number of tokens that would be flipped
   */
  private int checkMove(char colour, int row, int column, boolean toFlip){
    if(board[row][column] != 'E'){
      return 0;
    }
    int total = 0;
    for(int rowincrement = -1; rowincrement <= 1; rowincrement++){
      for(int columnincrement = -1; columnincrement <= 1; columnincrement++){
        int currentCheck = checkDirection(colour, row + rowincrement, column + columnincrement,
                                          toFlip, rowincrement, columnincrement);
        if (currentCheck != -1)
          total += currentCheck;
      }
    }
    if (toFlip && total > 0)
      board[row][column] = colour;
    return total;
  }
  
  /**
   * Must start on a white piece
   * Returns the number of pieces that can be flipped in a certain direction
   * if toFlip is true then it will flip the pieces if possible to flip in that.
   * Direction is indicated by the row and column increments.
   * base the examples off of the board at the top of file
   * Ex: if rowincrement is 0 and columnincrement is -1 then the direction is West
   *     if rowincrement is 1 and columnincrement is 1 then the direction is South East
   * @param color either 'B' or 'W'
   * @param row 		  row index of the move
   * @param column 		column index of the move
   * @param toFlip 		tell is the move is actually being played
   * @param rowincrement  tells the row direction to iterate can either be -1, 0, or 1
   * @param columnincrement  tells the column direction to iterate can either be -1, 0, or 1
   * @return number of tokens that would be flipped, -1 none flipped in direction
   */
  private int checkDirection(char colour, int row, int column, boolean toFlip,
							 int rowincrement, int columnincrement){
    if (columnincrement == 0 && rowincrement == 0) // no direction indicated
      return -1;
    else if(column < 0 || column > 7 || row < 0 || row > 7)
      return -1;
    else if(board[row][column] == colour)
      return 0;
    else if(board[row][column] == getOppositeColour(colour)){
      // recursively check next piece
      int checkedMoves = checkDirection(colour, row + rowincrement, 
                                        column + columnincrement, 
                                        toFlip, rowincrement, columnincrement);
      if(checkedMoves == -1)
        return -1;
      else if (toFlip)
        board[row][column] = colour;
      return checkedMoves + 1; // This is a successfull direction
      
    }else // this case catches if the space is empty
      return -1;
  }
  /**
   * gets the opposite colour. Must be given either 'W' or 'B'
   */
  private char getOppositeColour(char colour) throws IllegalArgumentException{
    if (colour == 'W')
      return 'B';
    else if (colour == 'B')
      return 'W';
    else
      throw new IllegalArgumentException();    
  }
  
}