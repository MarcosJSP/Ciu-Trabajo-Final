class Bullet extends GameObject {
   
  float bulletSize,damage;
  color colour;
  String type;
  float angle2;
  float angleVariation = 5;
  
  Bullet (float x, float y, float vel, float acc, float angle, float size, color colour, float damage) {
    super(x, y, vel, acc, angle);
    this.bulletSize = size;
    this.colour = colour;
    this.damage = damage;
  }
  
  Bullet (String type, float x, float y, float vel, float acc, float angle, float size, color colour, float damage) {
    super(x, y, vel, acc, angle);
    this.bulletSize = size;
    this.colour = colour;
    this.damage = damage;
    this.angle2 = angle;
    this.type = type;

  }
  
  float getSize () {
    return this.bulletSize;
  }
  
  
  void show () {
    fill (this.colour);
    if(type != null){
      this.movementEffects(); 
    }
    this.movement();
    circle(locationV.x, locationV.y, bulletSize);
  }
  
  void movementEffects(){
    switch(type){
      case "serpiente":
        this.angle += angleVariation;
        if((this.angle > this.angle2+45) || (this.angle < this.angle2-45)){
          this.angleVariation *= -1;
        }
        break;
    }
  }
}
