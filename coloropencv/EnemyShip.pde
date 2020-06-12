class EnemyShip extends Ship {

   //Constructor sin imagen (necesitamos tamaño)
  EnemyShip(String type, float x, float y, float vel, float acc, float angle, float size, int hitPoints) {
    super(null, type, x, y, vel, acc, angle,hitPoints);
    this.objectSize[0] = size;
    this.objectSize[1] = size;
  }  
  
  //Constructor con imagen
  EnemyShip(PImage imagen, String type, float x, float y, float vel, float acc, float angle, int hitPoints) {
    super(imagen, type, x, y, vel, acc, angle, hitPoints);
  }
}
