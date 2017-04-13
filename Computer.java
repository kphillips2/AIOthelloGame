import java.util.ArrayList;
public class Computer extends Player
{
  Computer(char c)
  {
    super(c);
  }
  
  int[] makeMove(Board b)
  {
    int[] move = new int[2];
    ArrayList<int[]> moves = b.possibleMoves(colour);
    if(moves.size() == 0)
      move[1] = move[0] = -1;
    else{
      move[0] = moves.get(0)[0];
      move[1] = moves.get(0)[1];
    }
    return move;
  }
}