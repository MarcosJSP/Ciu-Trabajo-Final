class Bullet extends GameObject {
   
  float bulletSize,damage;
  boolean died=false;
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
  
  float getDamage(){
    return this.damage;  
  }
  
  
  void show () {
    fill (this.colour);
    
    x = x + vx;
    y = y + vy;
    circle(x,y,bulletSize);
    
  }
  
  void setDied(boolean die){
    died=die;
  }
  
  @Override
  boolean hasDied(){
    return died;
  }
  
  
 

}
