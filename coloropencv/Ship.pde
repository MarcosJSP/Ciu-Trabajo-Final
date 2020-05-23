class Ship extends GameObject {
  
  Weapon weapon;
  
  Ship(float x, float y) {
    this.x = x;
    this.y = y;
     
  }  
  void setWeapon(Weapon weapon){
    this.weapon=weapon;
  } 
  void show() {
    fill(255);
    //x = x + vx;
    //y = y + vy;
    rect(x,y,2,5);
  }
  
  Bullet shoot(){
    if(weapon==null)return null;
    return weapon.shoot(this.x,this.y);
  }
    
  
}
