class EnemyShip extends Ship {

  EnemyShip(float x, float y,float size,float hitPoints,PImage imagen) {
    super(x, y,size,hitPoints,imagen);
  }  

  @Override
  void show() {
    fill(255,0,0);
    x = x + vx;
    y = y + vy;
    image(this.asset,x-115,y-5);
    rect(x, y, this.objectSize, this.objectSize);
  }
  
  boolean hasDied(){
     if (hitPoints <=0) return true;
     return false;
  }

  
}
