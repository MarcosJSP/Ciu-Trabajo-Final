class EnemyShip extends Ship {
  
  EnemyShip(float x, float y) {
    super(x,y);
  }  
  
  void movement(float vx, float vy){
    this.vx = vx;
    this.vy = vy;
  }
   
   
  
}
