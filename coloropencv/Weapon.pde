class Weapon{
  
  float vx,vy,size,damage;
  color colour;
  
  
  Weapon(int vx,int vy,int size,color colour,float damage){
  this.size=size;
  this.vx=vx;
  this.vy= vy;
  this.colour = colour;
  this.damage = damage;
  }
  
  
  
  Bullet shoot(float x,float y){
    Bullet bullet = new Bullet(x,y,this.size,this.colour,this.damage);
    bullet.movement(vx,vy);
    return bullet;
  }
  
  
}
