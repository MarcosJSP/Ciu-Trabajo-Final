class Weapon{
  PImage bulletAsset;
  float vx,vy,size,damage,type;
  
  
  
  Weapon(float vx,float vy,float size,float type,float damage,PImage bulletAsset){
  this.size=size;
  this.vx=vx;
  this.vy= vy;
  this.type = type;
  this.damage = damage;
  this.bulletAsset = bulletAsset;
  }
  
  
  
  Bullet shoot(float x,float y){
    Bullet bullet = new Bullet(x,y,this.size,this.type,this.damage,this.bulletAsset);
    bullet.movement(vx,vy);
    return bullet;
  }
  
  
}
