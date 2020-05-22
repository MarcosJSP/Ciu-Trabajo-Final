class Ship extends GameObject {
  
  Weapon weapon;
  
  Ship(float x, float y,Weapon weapon) {
    this.x = x;
    this.y = y;
    this.dx = 0;
    this.dy = 5;
    this.weapon=weapon;
  }  
   
  void show() {
    fill(255);
    //x = x + vx;
    //y = y + vy;
    rect(x,y,dy,dy);
  }
  
  Bullet shoot(){
    return weapon.shoot(this.x,this.y);
  }
    
  
}
