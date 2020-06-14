class PlayerShip extends Ship {
  
  //Constructor sin imagen (necesitamos tamaño)
  PlayerShip(float x, float y, float vel, float acc, float angle, float size,int hitPoints) {
    super(null, null, x, y, vel, acc, angle,hitPoints);
    this.objectSize[0] = size;
    this.objectSize[1] = size;
  }  
  
  //Quiza quitas la vel, acc y angle y fijar los valores
  //Constructor con imagen
  PlayerShip(PImage imagen, float x, float y, float vel, float acc, float angle, int hitPoints) {
    super(imagen, null, x, y, vel, acc, angle, hitPoints);
  } 
  
  @Override
  void die(){
     if(GameObject.listaObjetos.contains(this)) GameObject.listaObjetos.remove(this);
     println("Oh vaya, has perdido");
     this.weapons = null;
     //cambiar estado
  }
  
  @Override
  void alternativeShow(){
    fill(color(0,255,0));
    triangle(-this.objectSize[0]/2.0, -this.objectSize[1]/2.0, 
              this.objectSize[0]/2.0,  this.objectSize[1]/2.0, 
              this.objectSize[0]/2.0, -this.objectSize[1]/2.0); 
  }
}
