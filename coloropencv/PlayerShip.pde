class PlayerShip extends Ship {
  
  PlayerShip(float x, float y) {
    super(x,y);
  }  
  
  @Override   
  void setPosition(float x,float y) {
    this.x = x;
    this.y = y;
  }
  
  
  
}
