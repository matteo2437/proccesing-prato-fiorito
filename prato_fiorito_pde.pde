Grid grid = new Grid(7);
Prato prato = new Prato(5, grid);

void setup()
{
  size(720, 720);
  grid.set();
}


void draw(){
  background(white);
  
  grid.draw();
  grid.hover();
}

void keyPressed() {
  if (keyCode == ENTER) {
    prato.startGame();
  }  
  
  if(keyCode == ' ' && prato.isGameStarted)
    grid.showEverything = true;
}

void keyReleased(){
  if(keyCode == ' ')
    grid.showEverything = false;
}

void mousePressed(){ 
    
  if(!prato.isGameStarted){
    prato.startGame();
    return;
  }
  
  int x = grid.hoverX;
  int y = grid.hoverY;
  
  
  if(mouseButton == LEFT){
    if(prato.isFlagged(x, y))
      return;
    
    if(prato.isABomb(x, y)){
      println("Hai perso");
      prato.showBombs();
      return;
    }
      
    prato.lookCell(x, y);
  }
  
  if(mouseButton == RIGHT){
    prato.placeAFlag(x, y);
    if(prato.isAWin())
      println("Hai vinto");
  }
}
