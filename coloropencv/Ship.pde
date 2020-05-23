class Ship extends GameObject {
  
  
  Weapon weapon;
  
  Ship(float x, float y,float size) {
    this.x = x;
    this.y = y;
    this.objectSize = size;
  }  
  void setWeapon(Weapon weapon){
    this.weapon=weapon;
  } 
  void show() {
    fill(255);
    //x = x + vx;
    //y = y + vy;
    rect(x,y,this.objectSize,this.objectSize);
  }
  
  float getSize () {
    return this.objectSize;
  }
  
  Bullet shoot(){
    if(weapon==null)return null;
    return weapon.shoot(this.x,this.y);
  }
    
  
}
