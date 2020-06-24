class BossShip extends EnemyShip{
  BossShip(PImage imagen, String type, float x, float y, float vel, float acc, float angle, int hitPoints){
    super(imagen, type, x, y, vel, acc, angle, hitPoints);
    this.setimageRotation(this.imageRotation+90);
  }
  
  @Override
  void die(){
    scene = GameScenes.WIN;
    if(GameObject.listaObjetos.contains(this)) GameObject.listaObjetos.remove(this);
  }
  
  //Cambiar armas según la vida que le quede
  @Override
  void sufferDamage(int damage){
    this.hitPoints -= damage;
    if(this.hitPoints > 50 && this.hitPoints < 75){
      changeWeapon(1);
    }else if(this.hitPoints > 15 && this.hitPoints < 50){
      changeWeapon(2);
    }else if(this.hitPoints > 0 && this.hitPoints < 15){
      changeWeapon(3);
    }else if(this.hitPoints <= 0){
      thread("playExplosionSound");
      this.die();
      println("Oh Vaya, ha muerto por disparos:" + this);
    }
    println("Al boss le quedan " + this.hitPoints + " Vidas");
  }
  
}
