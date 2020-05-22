class PlayerShip extends Ship {
  
  PlayerShip(float x, float y,Weapon weapon) {
    super(x,y,weapon);
  }  
  
  @Override   
  void setPosition(float x,float y) {
    this.x = x;
    this.y = y;
  }
  
  
  
}
