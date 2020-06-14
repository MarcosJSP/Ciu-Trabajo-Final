class EnemyShip extends Ship {

   //Constructor sin imagen (necesitamos tamaño)
   /*
  EnemyShip(String type, float x, float y, float vel, float acc, float angle, float size, int hitPoints) {
    super(null, type, x, y, vel, acc, angle,hitPoints);
    this.objectSize[0] = size;
    this.objectSize[1] = size;
  }  
  */
  //Constructor con imagen
  EnemyShip(PImage imagen, String type, float x, float y, float vel, float acc, float angle, int hitPoints) {
    super(imagen, type, x, y, vel, acc, angle, hitPoints);
  }
  
  @Override
  void alternativeShow(){
    fill(color(255,0,0));
    triangle(-this.objectSize[0]/2.0, -this.objectSize[1]/2.0, 
              this.objectSize[0]/2.0,  this.objectSize[1]/2.0, 
              this.objectSize[0]/2.0, -this.objectSize[1]/2.0); 
  }
}
