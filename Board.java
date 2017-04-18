import java.util.ArrayList;
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
  // stored as black move, white move
  int[][] lastTwoMoves = {{-1, -1}, {-1, -1}};
  ArrayList<char[][]> moveStack = new ArrayList<char[][]>();
  //ArrayList<Move> moves = new ArrayList<Move>();
  char[][] board = new char[8][8];
  int layout;
  
  Board()
  {
    for(int row = 0; row < 8; row++)
      for(int column = 0; column < 8; column++)
        board[row][column] = 'E';
  }
  
  void setLayout(int layout)
  {
    this.layout = layout;
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
    return 0 < checkMove(board, colour, row, column, false);
    
  }
  
  public char[][] getBoardArrayCopy(){
    return copyBoard(board);
  }
  
  public static char[][] copyBoard(char[][] theBoard){
    char[][] returnArray = new char[8][];
    for(int i = 0; i < 8; i++){
      returnArray[i] = theBoard[i].clone();
    }
    return returnArray;
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

  /**
   * reverts the last two moves
   */
  public void undo(){
    if(moveStack.size() < 1)
      return;
    
    /*for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        board[i][j] = moveStack.get(moveStack.size() - 1)[i][j];
      }
    }*/
    board = moveStack.get(moveStack.size() - 1);
    moveStack.remove(moveStack.size() - 1);
  }
  
  /*public void reset(){
    //moves = new ArrayList<Move>();
    setUpBoard();
  }*/
  
  /*private void setUpBoard(){
    for(int row = 0; row < 8; row++)
      for(int column = 0; column < 8; column++)
        board[row][column] = 'E';
    setLayout(layout);
    /*for(Move m : moves){
      makeMove(m.row, m.column, m.colour);
    }
  }*/
  
  public boolean makeMove(int row, int column, char colour, boolean save)
  {
    if(save){
      char[][] tempArray = new char[8][8];
      for(int i = 0; i < 8; i++){
        for(int j = 0; j < 8; j++){
          tempArray[i][j] = board[i][j];
        }
      }
      moveStack.add(tempArray);
    }
    if (0 < checkMove(board, colour, row, column, true)){
      //moves.add(new Move(row, column, colour));
      return true;
    }else{
      if(save)
        moveStack.remove(moveStack.size() - 1);
      return false;
    }
  }
  
  /**
   * Pass in a board array to make a move on it
   */
  public static void moveBoard(char[][] theBoard, int row, int column, 
                               char colour, boolean toFlip){
      checkMove(theBoard, colour, row, column, toFlip);
  }
  
  public int getNumberPresent(char colour){
    return getNumberOf(board, colour);
  }
  
  public static int getNumberOf(char[][] theBoard, char colour){
    int total = 0;
    for(int row = 0; row < 8; row++){
      for(int column = 0; column < 8; column++){
        if(theBoard[row][column] == colour)
          total++;
      }
    }
    return total;
  }
  
  public ArrayList<int[]> possibleMoves(char colour){
    return getPossibleMoves(board, colour);
  }
  
  /**
   * Returns a double array of the possible moves for a player as well as the 
   * number of Pieces that can be flipped from the move.
   * Format: [ [ row, column, numFlipped], ... ]
   * @param	 color either 'B' or 'W'
   * @return 	   two-dimensional array of xindex, yindex, num_flipped
   *             empty if no possible moves
   */
  public static ArrayList<int[]> getPossibleMoves(char[][] theBoard, char colour){
    ArrayList<int[]> stats = new ArrayList<int[]>();
    for(int row = 0; row < 8; row++){
      for(int column = 0; column < 8; column++){
        if(theBoard[row][column] == 'E'){
          int numFlipped = checkMove(theBoard, colour, row, column, false);
          if(numFlipped > 0){
            int[] moveStats = {row, column, numFlipped};
            stats.add(moveStats);
          }
        }
      }
    }
    return stats;
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
  private static int checkMove(char[][] theBoard, char colour, int row, int column, boolean toFlip){
    if(theBoard[row][column] != 'E'){
      return 0;
    }
    int total = 0;
    for(int rowIncrement = -1; rowIncrement <= 1; rowIncrement++){
      for(int columnIncrement = -1; columnIncrement <= 1; columnIncrement++){
        int currentCheck = checkDirection(theBoard, colour, row, column,
                                          toFlip, rowIncrement, columnIncrement);
        if (currentCheck != -1)
          total += currentCheck;
      }
    }
    if (toFlip && total > 0)
      theBoard[row][column] = colour;
    return total;
  }
  
  /**
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
   * @param rowIncrement  tells the row direction to iterate can either be -1, 0, or 1
   * @param columnIncrement  tells the column direction to iterate can either be -1, 0, or 1
   * @return number of tokens that would be flipped, -1 none flipped in direction
   */
  private static int checkDirection(char[][] theBoard, char colour, int row, int column, boolean toFlip,
							 int rowIncrement, int columnIncrement){
    row += rowIncrement;
    column += columnIncrement;
    if (columnIncrement == 0 && rowIncrement == 0) // no direction indicated
      return -1;
    else if(column < 0 || column > 7 || row < 0 || row > 7)
      return -1;
    else if(theBoard[row][column] == colour)
      return 0;
    else if(theBoard[row][column] == getOppositeColour(colour)){
      // recursively check next piece
      int checkedMoves = checkDirection(theBoard, colour, row, column, 
                                        toFlip, rowIncrement, columnIncrement);
      if(checkedMoves == -1)
        return -1;
      else if (toFlip)
        theBoard[row][column] = colour;
      return checkedMoves + 1; // This is a successfull direction
      
    }else // this case catches if the space is empty
      return -1;
  }
  
  /**
   * gets the opposite colour. Must be given either 'W' or 'B'
   */
  public static char getOppositeColour(char colour) throws IllegalArgumentException{
    if (colour == 'W')
      return 'B';
    else if (colour == 'B')
      return 'W';
    else
      throw new IllegalArgumentException();    
  }
  
  /**
   * Used to store the move data
   *
  private class Move{
    public final int row;
    public final int column;
    public final char colour;
    
    Move(int row, int column, char colour){
      this.row = row;
      this.column = column;
      this.colour = colour;
    }
  }*/
  
}