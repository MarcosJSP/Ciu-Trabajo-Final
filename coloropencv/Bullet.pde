class Bullet extends GameObject {
   
  PImage asset;
  float bulletSize,damage,type;
  boolean died=false;
  
    
  Bullet (float x, float y, float size,float type,float damage,PImage asset) {
    
    this.x = x;
    this.y = y;
    this.bulletSize = size;
    this.type = type;
    this.damage = damage;
    this.asset = asset;
  }
  
  float getSize () {
    return this.bulletSize;
  }
  
  float getDamage(){
    return this.damage;  
  }
  
  
  void show () {
    //fill (this.colour);
    
    x = x + vx;
    y = y + vy;
    if (type == 1) { 
      image(this.asset,x-20,y-20);
      //circle(x,y,bulletSize);
    } else {
      circle(x,y,bulletSize);
    }
    
    
  }
  
  void setDied(boolean die){
    died=die;
  }
  
  @Override
  boolean hasDied(){
    return died;
  }
  
  
 

}
