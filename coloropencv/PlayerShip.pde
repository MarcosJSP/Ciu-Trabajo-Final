class PlayerShip extends Ship {
  
  PlayerShip(float x, float y, float vel, float acc, float angle, float size,float hitPoints) {
    super(x, y, vel, acc, angle, size,hitPoints);
  }  
  
  @Override
  void show() {
    fill(255,255,255);
    this.movement();
    rect(locationV.x, locationV.y, this.objectSize, this.objectSize);
  }
  
  @Override
  void movement(){
  }
  
  boolean hasDied(){
     if (hitPoints <=0) return true;
     return false;
  }
  
}
