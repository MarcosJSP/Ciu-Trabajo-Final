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
    
    rect(x, y, this.asset.width,this.asset.height);
    image(this.asset,x,y);
  }
   
   boolean hasDied(){
     if (hitPoints <=0) return true;
     return false;
  }
  
}
