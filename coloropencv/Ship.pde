class Ship extends GameObject {
  
  float hitPoints;
  Weapon weapon;
  
  Ship(float x, float y, float vel, float acc, float angle, float size, float hitPoints) {
    super(x, y, vel, acc, angle);
    this.locationV.set(x,y);
    this.locationV.y = y;
    this.objectSize = size;
    this.hitPoints = hitPoints;
  }
  
  void setWeapon(String tipo, float damage, float angle, int size, color col){
    this.weapon = new Weapon(tipo,PVector.add(this.locationV, new PVector(this.objectSize/2,this.objectSize/2)), angle, size, col, damage);
  } 
  
  void show() {
    fill(255);
    //x = x + vx;
    //y = y + vy;
    rect(locationV.x, locationV.y, this.objectSize, this.objectSize);
  }
  
  float getSize () {
    return this.objectSize;
  }
  
  @Override 
  void movement(){
    //Creamos el vector velocityV como un vector unitario que apunta a la dirección donde se mueve el objeto
    velocityV = PVector.fromAngle(radians(angle));
    PVector accelerationV = velocityV.copy();
    
    //la magnitud del vector lo define la velocidad
    velocityV.setMag(velocity);
    accelerationV.setMag(acceleration);
    
    //Añadimos la aceleración
    velocityV.add(accelerationV);
    
    //Limitamos la velocidad
    if (velocityLimit != -1){
      velocityV.limit(velocityLimit);
    }
    
    locationV.add(velocityV);
    
    if(weapon != null){
      weapon.movement(this.locationV);
    }
  }
  
  void shoot(){
    if(weapon!=null) weapon.shoot();
  }
    
  
}
