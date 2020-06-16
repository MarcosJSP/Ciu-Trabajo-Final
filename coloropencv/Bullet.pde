class Bullet extends GameObject {
  int damage;
  //ArrayList <Bullet> bulletList = new ArrayList <Bullet>();
  Ship myShip;

  Bullet (PImage imagen, String type, float x, float y, PVector origV, float vel, float acc, float angle, int damage, Ship myShip) {
    super(imagen, type, x, y, vel, acc, angle);
    this.damage = damage;
    if(this.asset == null){
      this.objectSize[0] = 5;
      this.objectSize[1] = 5;
    }
    //Una bullet es siempre lanzado desde un objeto, por lo tanto este recibe su velocidad
    //this.velocityV.add(PVector.fromAngle(this.angle).setMag(origV.mag()));
    this.velocityV.setMag(this.velocityV.mag()+origV.mag());
    this.myShip = myShip;
    this.hitBox_flag = hitBoxBullets;
  }
  /*
  Bullet (String type, float x, float y, PVector origV, float vel, float acc, float angle, float size, color colour, int damage) {
    super(null, type, x, y, vel, acc, angle);
    this.objectSize[0] = size;
    this.objectSize[1] = size;
    this.colour = colour;
    this.damage = damage;
    this.velocityV.setMag(this.velocityV.mag()+origV.mag());
  }
  */
  float[] getSize () {
    return this.objectSize;
  }

  /*
  void setBulletList(ArrayList <Bullet> a){
     this.bulletList = a;
  }
  */
  int getDamage(){
    return this.damage;
  }

  @Override
  void alternativeShow(){
    if (this.myShip instanceof PlayerShip){
      fill(color(0,250,0));
    }else if(this.myShip instanceof EnemyShip){
      fill(color(250,0,0));
    }
    //
    circle(locationV.x, locationV.y, objectSize[0]);
  }
}
