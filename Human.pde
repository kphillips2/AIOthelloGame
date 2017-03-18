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
  
  // Uses clicked coordinates of mouse to determine move
  int[] makeMove(Board b, int x, int y){
    int[] move = {-1,-1};
    
    for(int i = 0; i < 8; i++)
      for(int j = 0; j < 8; j++)
      {
        if(x > 30 + j*70 && x < 100 + j*70 && y > 30 + i*70 && y < 100 + i*70)
        {
          move[0] = i;
          move[1] = j;
          return move;
        }
      }
    return move;
  }
}