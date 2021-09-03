
Grid grid = new Grid(77);

void setup()
{
  size(720, 720);
}

void draw(){
  background(255);
  grid.draw();
}


class Grid {
  
  int nSquares;
  int squareSize;
  int 
  Grid(int squares){
    nSquares = squares;
  }
  
  float getSquareSize(){
    return width / float(nSquares);
  }
  
  void draw(){
    float squareSize = getSquareSize();
      
    for(int i = 1; i < nSquares; i++){
      float linePos = i*squareSize;
      
      line(linePos, 0, linePos, height);
      line(0, linePos, width, linePos);
    }
  }
  
  void hover(){
  
  }
}
