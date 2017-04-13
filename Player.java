public abstract class Player{
  char colour;
  
  Player(char c)
  {
    colour = c;
  }
  
  public char getColor(){
    return colour;  
  }
  
  abstract int[] makeMove(Board b);
}