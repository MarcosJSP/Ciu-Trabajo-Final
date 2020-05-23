class EnemyShip extends Ship {

  EnemyShip(float x, float y,float size) {
    super(x, y,size);
  }  

  @Override
  void show() {
    fill(255);
    x = x + vx;
    y = y + vy;
    rect(x, y, this.objectSize, this.objectSize);
  }
  

  
}
