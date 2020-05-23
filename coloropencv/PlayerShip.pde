class PlayerShip extends Ship {
  
  PlayerShip(float x, float y,float size) {
    super(x,y,size);
  }  
  
  @Override   
  void setPosition(float x,float y) {
    this.x = x;
    this.y = y;
  }
   
  
}
