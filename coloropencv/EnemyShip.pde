class EnemyShip extends Ship {
  //Constructor con imagen
  EnemyShip(PImage imagen, String type, float x, float y, float vel, float acc, float angle, int hitPoints) {
    super(imagen, type, x, y, vel, acc, angle, hitPoints);
    this.setimageRotation(this.imageRotation+180);
    this.bulletI = bulletS;
  }

  @Override
  void alternativeShow(){
    fill(color(255,0,0));
    triangle(-this.objectSize[0]/2.0, -this.objectSize[1]/2.0,
              this.objectSize[0]/2.0,  this.objectSize[1]/2.0,
              this.objectSize[0]/2.0, -this.objectSize[1]/2.0);
  }

  @Override
  EnemyShip copy(){
    EnemyShip copia = new EnemyShip(this.asset, this.type, this.locationV.x, this.locationV.y, this.velocity, this.acceleration, this.angle, this.hitPoints);
    copia.velocityLimit = this.velocityLimit;
    return copia;
  }

  //Devolvemos un array de copias
  @Override
  EnemyShip[] multyCopy(int n){
    EnemyShip[] multy = new EnemyShip[n];
    for(int i= 0; i<n; i++){
       multy[i] = new EnemyShip(this.asset, this.type, this.locationV.x, this.locationV.y, this.velocity, this.acceleration, this.angle, this.hitPoints);
       multy[i].setangleVariation(this.angleVariation);
       multy[i].setimageRotation(this.imageRotation);
       multy[i].setLifeTimer(this.lifeTimer);
       multy[i].sethitBox(this.hitBox_flag);  
  }
    return multy;
  }

}
