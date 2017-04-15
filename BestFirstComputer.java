import java.util.ArrayList;
import java.util.Arrays;

public class BestFirstComputer extends Computer
{
  BestFirstComputer(char c)
  {
    super(c);
  }
  
  int[] makeMove(Board b)
  {
    int[] move = {0, 0};
    char[][] board = b.getBoardArrayCopy();
    ArrayList<int[]> possibleMoves = b.possibleMoves(colour);
    
    if(possibleMoves.size() == 0)
      return move;
    
    int[] checkMove = possibleMoves.get(0);
    move[0] = checkMove[0];
    move[1] = checkMove[1];
    int bestHeuristic = getHeuristic(board, checkMove[0], checkMove[1], checkMove[2]);
    int nextHeuristic;
    //System.out.println("Here are the possible moves\n" + Arrays.toString(checkMove));
    for(int i = 1; i < possibleMoves.size(); i++){
      checkMove = possibleMoves.get(i);
      //System.out.println(Arrays.toString(checkMove));

      nextHeuristic = getHeuristic(board, checkMove[0], checkMove[1], checkMove[2]);
      if(nextHeuristic > bestHeuristic){
         bestHeuristic = nextHeuristic;
         move[0] = checkMove[0];
         move[1] = checkMove[1];
      }
    }
    
    return move;
  }
  
  /**
   * Generates a Heuristic for the given move.
   */
  int getHeuristic(char[][] board, int row, int column, int numFlipped){
    return numFlipped;
  }
}