class Weapon{
  
  float vx,vy,size;
  
  
  Weapon(int vx,int vy,int size){
  this.size=size;
  this.vx=vx;
  this.vy= vy;
  }
  
  
  
  Bullet shoot(float x,float y){
    Bullet bullet = new Bullet(x,y,this.size);
    bullet.movement(vx,vy);
    return bullet;
  }
  
  
}
