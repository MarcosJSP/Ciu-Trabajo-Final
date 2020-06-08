class PlayerShip extends Ship {
  
  PlayerShip(float x, float y,float size,float hitPoints) {
    super(x,y,size,hitPoints);
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
    rect(x, y, this.objectSize, this.objectSize);
  }
   
   boolean hasDied(){
     if (hitPoints <=0) return true;
     return false;
  }
  
}
