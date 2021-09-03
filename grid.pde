class Grid {
  
  int nSquares;
  float squareSize;
  boolean showEverything;
  
  int[][] grid;
  boolean[][] shouldDraw;
  boolean[][] isFlagged;
  
  int hoverX, hoverY;
  
  Grid(int squares){
    nSquares = squares;    
    
    grid = new int[nSquares][nSquares];
    shouldDraw = new boolean[nSquares][nSquares];
    isFlagged = new boolean[nSquares][nSquares];
  }
  
  float getSquareSize(){
    return width / float(nSquares);
  }
  
  void set(){
    squareSize = getSquareSize();
    reset();
  }
  
  void reset(){
    for(int x = 0; x < nSquares; x++){
      for(int y = 0; y < nSquares; y++){
        grid[x][y] = 0;
        shouldDraw[x][y] = false;
        isFlagged[x][y] = false;
      }
    }
  }
  
  void draw(){
    strokeWeight(1);
    stroke(black);
    for(int i = 1; i < nSquares; i++){
      float linePos = getCoord(i);
      
      line(linePos, 0, linePos, height);
      line(0, linePos, width, linePos);
    }
    
    drawCells();
  }
  
  void drawCells(){
    for(int x = 0; x < nSquares; x++){
      for(int y = 0; y < nSquares; y++){
        boolean canDraw = shouldDraw[x][y] || isFlagged[x][y] || showEverything;
        if(canDraw)
          drawCell(x, y); 
      }
    }
  }
  
  void drawCell(int x, int y){
    float coordX = getCenterCoord(x);
    float coordY = getCenterCoord(y);
    
    int cellValue = getValue(x, y);
    
    if(isFlagged[x][y]  && !showEverything){
      fill(red);
      circle(coordX, coordY, squareSize/2);
      return;
    }
        
    //empty box
    if(grid[x][y] == 0){
      coordX = getCoord(x);
      coordY = getCoord(y);
      
      fill(grey);
      square(coordX, coordY, squareSize);
      return;
    }
      
    //bomb box
    if(grid[x][y] == -1)
      fill(red);
    else
      fill(cellsColor[cellValue - 1]);
            
    textSize(24);
    text(cellValue, coordX, coordY);
  }
  
  void hover(){
    hoverX = floor(mouseX / squareSize);
    hoverY = floor(mouseY / squareSize);
    
    float centerX = getCoord(hoverX);
    float centerY = getCoord(hoverY);
    
    strokeWeight(4);
    stroke(red);
    noFill();
    square(centerX, centerY, squareSize);
  }

  int getValue(int x, int y){
    return grid[x][y];
  }
  
  void setValue(int x, int y, int val){
    grid[x][y] = val;
  }
        
  float getCoord(int num){
    return num * squareSize;
  }
  
  float getCenterCoord(int num){
    return getCoord(num) + squareSize / 2;
  }
}
