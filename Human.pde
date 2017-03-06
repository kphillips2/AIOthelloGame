/*
 * Make this class able to get what was the mouse pressed or
 * the coordinates on the board last pressed in order to make move.
 * Maybe pass in the instance of the graphics controller in the
 * constructor?
 */

public class Human extends Computer{
  Human(char c){
    super(c);
  }
  
  int[] makeMove(Board b){
    int[] moves = {0,0};
    return moves;
  }
  
}