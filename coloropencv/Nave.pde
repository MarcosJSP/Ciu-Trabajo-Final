class Nave extends GameObject {
  
  Nave(int x, int y) {
    this.x = x;
    this.y = y;
    this.dx = 0;
    this.dy = 5;
  }  
   
  void show() {
    fill(255);
    //x = x + vx;
    //y = y + vy;
    rect(x,y,dy,dy);
  }
    
  
}
