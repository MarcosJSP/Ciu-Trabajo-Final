class Bullet extends GameObject {
   
  int damage;
  color colour = color(random(0,255),random(0,255),random(0,255));
  Bullet (PImage imagen, String type, float x, float y, PVector origV, float vel, float acc, float angle, int damage) {
    super(imagen, type, x, y, vel, acc, angle);
    this.damage = damage;
    this.objectSize[0] = 5;
    this.objectSize[1] = 5;
    //Una bullet es siempre lanzado desde un objeto, por lo tanto este recibe su velocidad
    //this.velocityV.add(PVector.fromAngle(this.angle).setMag(origV.mag()));
    this.velocityV.setMag(this.velocityV.mag()+origV.mag());
  }
  
  Bullet (String type, float x, float y, PVector origV, float vel, float acc, float angle, float size, color colour, int damage) {
    super(null, type, x, y, vel, acc, angle);
    this.objectSize[0] = size;
    this.objectSize[1] = size;
    this.colour = colour;
    this.damage = damage;
    this.velocityV.setMag(this.velocityV.mag()+origV.mag());
  }
  
  float[] getSize () {
    return this.objectSize;
  }
  
  @Override
  void alternativeShow(){
    fill (this.colour);
    circle(locationV.x, locationV.y, objectSize[0]);
  }
  
}
