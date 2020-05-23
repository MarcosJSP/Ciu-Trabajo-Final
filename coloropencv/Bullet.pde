class Bullet extends GameObject {
   
  float bulletSize;
  
  Bullet (float x, float y, float size) {
    
    this.x = x;
    this.y = y;
    this.bulletSize = size;
  }
  
  float getSize () {
    return this.bulletSize;
  }
  
  
  void show () {
    fill (255,0,0);
    
    x = x + vx;
    y = y + vy;
    circle(x,y,bulletSize);
    
  }
  

}
