class Bullet extends GameObject {
   
  float bulletSize,damage;
  color colour;
    
  Bullet (float x, float y, float size,color colour,float damage) {
    
    this.x = x;
    this.y = y;
    this.bulletSize = size;
    this.colour = colour;
    this.damage = damage;
  }
  
  float getSize () {
    return this.bulletSize;
  }
  
  
  void show () {
    fill (this.colour);
    
    x = x + vx;
    y = y + vy;
    circle(x,y,bulletSize);
    
  }
  
  
 

}
