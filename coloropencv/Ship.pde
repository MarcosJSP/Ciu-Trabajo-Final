class Ship extends GameObject {
  
  Weapon weapon;
  
  Ship(float x, float y) {
    this.x = x;
    this.y = y;
    this.dx = 0;
    this.dy = 5;
  }  
  void setWeapon(Weapon weapon){
    this.weapon=weapon;
  } 
  void show() {
    fill(255);
    //x = x + vx;
    //y = y + vy;
    rect(x,y,dy,dy);
  }
  
  Bullet shoot(){
    if(weapon==null)return null;
    return weapon.shoot(this.x,this.y);
  }
    
  
}
