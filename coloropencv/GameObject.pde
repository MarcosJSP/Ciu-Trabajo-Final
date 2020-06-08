abstract class GameObject {
  
  PVector locationV = new PVector();
  PVector velocityV = new PVector();
  float   velocity = 0.0;
  float   acceleration = 0.0;
  float   angle = 0.0;
  float   velocityLimit = -1;
  float   objectSize;
  
  GameObject(float x, float y, float vel, float acc, float angle){
    this.locationV.x = x;
    this.locationV.y = y;
    this.velocity = vel;
    this.acceleration = acc;
    this.angle = angle;
  }

  void show(){
  }
  
  void setPosition(float x, float y){
    this.locationV.set(x,y);
  }
  
  float getSize (){
    return 0;
  }
  
  float[] getPosition(){
    float [] result= {this.locationV.x,this.locationV.y};
    return result;
  }
  
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
  }
  
  
  void shoot(){
  }
  
  boolean hasDied(){
    return false;
  }
   
}
