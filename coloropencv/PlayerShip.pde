class PlayerShip extends Ship {
  
  
  PlayerShip(float x, float y,float size,float hitPoints,PImage imagen) {
    super(x,y,size,hitPoints,imagen);
    this.playerObject=true;
  }  
  
  @Override   
  void setPosition(float x,float y) {
    this.x = x;
    this.y = y;
  }
  
  @Override
  void show() {
    fill(255,255,255);
    x = x + vx;
    y = y + vy;
    
    //rect(x, y, this.objectSize,this.objectSize);
    image(this.asset,x,y);
  }
   
   boolean hasDied(){
     if (hitPoints <=0) return true;
     return false;
  }
  
  @Override
  Bullet shoot(){
    if(weapon==null)return null;
    return weapon.shoot(this.x+30,this.y+5);
  }
  
}
