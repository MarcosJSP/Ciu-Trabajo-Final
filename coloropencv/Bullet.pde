class Bullet extends GameObject {
   
  int bulletSize;
  
  Bullet (int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.bulletSize = size;
  }
  
  void show () {
    fill (255);
    x = x + vx;
    y = y + vy;
    circle(x,y,bulletSize);
    
  }
  

  
}
