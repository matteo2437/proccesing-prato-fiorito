class Prato {

  int nBombs;
  boolean isGameStarted;
  Grid grid;
  
  Prato(int bombs, Grid myGrid){
    nBombs = bombs;
    grid = myGrid;
  }
  
  boolean isAWin(){    
    for(int x = 0; x < grid.nSquares; x++){
      for(int y = 0; y < grid.nSquares; y++){
        if(isFlagged(x, y) != isABomb(x, y))
          return false;
      }
    }
    
    return true;
  }
  
  void placeBombs(){
    grid.reset();
    
    for(int i = 0; i < nBombs; i++){
       int squares = grid.nSquares;
      
      int x = int(random(0, squares));
      int y = int(random(0, squares));
      
      while(isABomb(x,y)){
        x = int(random(0, squares));
        y = int(random(0, squares));
      }  
      
      grid.setValue(x, y, -1);
    }    
    
    updateCellsValue();
  }
    
  void showBombs(){
    for(int x = 0; x < grid.nSquares; x++){
      for(int y = 0; y < grid.nSquares; y++){
        if(isABomb(x, y))
          grid.shouldDraw[x][y] = true;
      }
    }
  }  
    
  /**
  * Look cells
  */
  
  void lookAround(int x, int y){
    if(!isEmpty(x,y))
      return;
      
    int startLineX = x - 1;
    
    int topLineY = y - 1;    
    int bottomLineY = y + 1;
    
    lookLine(startLineX, topLineY);
    lookLine(startLineX, bottomLineY);
        
    lookCell(x - 1, y);
    lookCell(x + 1, y);
  }
  
  void lookLine(int x, int y){
    boolean isYOutside = y < 0 || y > grid.nSquares - 1;
    if(isYOutside)
      return;
      
    for(int i = 0; i < 3; i++){
      int updateX = x + i;
      
      lookCell(updateX, y);
    }
  }
  
  void lookCell(int x, int y){
    boolean isNotOutside = !(x < 0 || x > grid.nSquares - 1);   
    if(isNotOutside){     
      
      if(grid.shouldDraw[x][y])
        return;      
      
      if(isABomb(x,y))
        return;
        
      if(isFlagged(x,y))
        return;
       
      grid.shouldDraw[x][y] = true;
      lookAround(x, y);       
    }
  }
  
  
  /**
  * Update cells
  */
  
  void updateCellsValue(){
    for(int x = 0; x < grid.nSquares; x++){    
      for(int y = 0; y < grid.nSquares; y++){
        if(isABomb(x,y))
          updateAround(x, y);
      }
    }
  }
  
  void updateAround(int x, int y){    
    int startLineX = x - 1;
    
    int topLineY = y - 1;    
    int bottomLineY = y + 1;  
    
    updateLine(startLineX, topLineY);
    updateLine(startLineX, bottomLineY);
        
    updateCell(x - 1, y);
    updateCell(x + 1, y);
  }
  
  void updateLine(int x, int y){
    boolean isYOutside = y < 0 || y > grid.nSquares - 1;
    if(isYOutside)
      return;
      
    for(int i = 0; i < 3; i++){
      int updateX = x + i;
      
      updateCell(updateX, y);
    }
  }
  
  void updateCell(int x, int y){    
    boolean isNotOutside = !(x < 0 || x > grid.nSquares - 1);   
    if(isNotOutside){
      
      if(isABomb(x,y))
        return;
        
      grid.grid[x][y]++;
    }
  }
  
  /**
  * Flags
  */
  
  void placeAFlag(int x, int y){
    if(!grid.shouldDraw[x][y])
      grid.isFlagged[x][y] = !isFlagged(x, y); 
  }
  
  /**
  * Utilities
  */
  
  boolean isEmpty(int x, int y){
    return grid.grid[x][y] == 0;
  }
    
  boolean isABomb(int x, int y){
    return grid.grid[x][y] == -1;
  }
  
  boolean isFlagged(int x, int y){
    return grid.isFlagged[x][y];
  }
  
  void startGame(){
    int x = grid.hoverX;
    int y = grid.hoverY;
    
    isGameStarted = true;
    prato.placeBombs();
    
    while(!prato.isEmpty(x,y)){
      x = grid.hoverX;
      y = grid.hoverY;
      prato.placeBombs();
    }
    
    prato.lookCell(x, y);
  }
}
