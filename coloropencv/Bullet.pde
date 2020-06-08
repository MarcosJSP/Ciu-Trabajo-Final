class Bullet extends GameObject {
   
  float bulletSize,damage;
  color colour;
    
  Bullet (float x, float y, float vel, float acc, float angle, float size, color colour, float damage) {
    super(x, y, vel, acc, angle);
    this.bulletSize = size;
    this.colour = colour;
    this.damage = damage;
  }
  
  float getSize () {
    return this.bulletSize;
  }
  
  
  void show () {
    fill (this.colour);
    this.movement();
    circle(locationV.x, locationV.y, bulletSize);
    
  }
  
  
 

}
