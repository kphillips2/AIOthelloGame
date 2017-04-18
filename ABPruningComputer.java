import java.util.ArrayList;

public class ABPruningComputer extends Player{
   ABPruningComputer(char c){
      super(c);
   }
   int[] makeMove(Board b){
      int[] move = {-1, -1};
      char[][] board = b.getBoardArrayCopy();
      double[] theReturn = recursiveDescent(board, move, Double.NEGATIVE_INFINITY, 
                                         Double.POSITIVE_INFINITY, 0);
      move[0] = (int)theReturn[0];
      move[1] = (int)theReturn[1];
      return move;
   }
   
   /**
    * This function will recusively do a depth first search while not going to
    * places that can be pruned. The function will not modify theBoard but can call
    * Board.copyBoard(theBoard) which will return a deep copy of the board. This copy
    * can be modified and passed down to the next call. The root is at height 0. The 
    * function will stop at height 3 and calculate heuristics at that height. Use
    * height (if it is even or odd) to determine whos move it is.
    *
    * Here is a helpful video for the algorithm: https://youtu.be/xBXHtz4Gbdo
    * 
    * Future implementation can have the tree be saved so the next makeMove() can already
    * know pruned places as well as some of the tree. This would make it more efficient
    *
    * @param theBoard    a representation of a board. DO NOT MODIFY argument as this will affect
                         previous recursive calls. Insead call Board.copyBoard(theBoard).
    * @param currentMove the move to be called on a copy of the board. If it is at the max
                         height, a heuristic will be calculated, else the new board will be
                         passed down
    * @param alpha       Contains the current alpha value can be -Infinity
    * @param beta        Contains the current beta value can be Infinity
    * @param height      Contains the current height of the move being checked
    * @return the best possible move and the heuristic. So [row,column,heuristic]
    */
   private double[] recursiveDescent(char[][] theBoard, int[] currentMove, double alpha, double beta,
                          int height){
      char[][] newBoard = Board.copyBoard(theBoard);
      // gets whos turn it is
      char currentPlayer = colour;
      double[] returnMove = new double[3];
      if(height%2 == 1)
         currentPlayer = Board.getOppositeColour(colour);
         
      // plays the move passed down
      if(currentMove[0] != -1){
         Board.moveBoard(newBoard, currentMove[0], currentMove[1], currentPlayer, true);
      }
      
      // If it's at the end then do the Heuristic
      if(height == 3){
         returnMove = new double[3];
         returnMove[0] = currentMove[0];
         returnMove[1] = currentMove[1];
         returnMove[2] = getHeuristic(newBoard);
         return returnMove;
      }else{
         ArrayList<int[]> possibleMoves = Board.getPossibleMoves(newBoard, currentPlayer);
         ArrayList<double[]> returnedMoves = new ArrayList<double[]>();
         
         if(possibleMoves.size() == 0){
            // if simulated player is unable to move
            int[] move = {-1, -1};
            returnedMoves.add(recursiveDescent(newBoard, move, alpha, beta, height + 1));
            
         }else{
            if(currentPlayer == colour){
            // This is simulating the computers turn
            
            }else{
            // This is simulating the humans turn
            
            }
         }
      }
      // This is so it compiles
      returnMove[0] = currentMove[0];
      returnMove[1] = currentMove[1];
      return returnMove;
   }
   
   private double getHeuristic(char[][] theBoard){
      return Board.getNumberOf(theBoard, colour);
   }
}