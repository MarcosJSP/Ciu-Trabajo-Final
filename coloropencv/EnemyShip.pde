class EnemyShip extends Ship {

  EnemyShip(float x, float y,float size,float hitPoints) {
    super(x, y,size,hitPoints);
  }  

  @Override
  void show() {
    fill(255,0,0);
    x = x + vx;
    y = y + vy;
    rect(x, y, this.objectSize, this.objectSize);
  }
  
  boolean hasDied(){
     if (hitPoints <=0) return true;
     return false;
  }

  
}
