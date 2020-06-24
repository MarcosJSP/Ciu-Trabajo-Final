import processing.sound.*;

class Ship extends GameObject {
  int hitPoints;
  int n = 0;
  ArrayList<Weapon> weapons = new ArrayList<Weapon>();
  PImage bulletI;
  int weaponTimer = -1;

  Ship(PImage imagen, String type, float x, float y, float vel, float acc, float angle, int hitPoints) {
    super(imagen, type, x, y, vel, acc, angle);
    this.locationV.set(x,y);
    this.hitPoints = hitPoints;
  }
 //<>// //<>//
  void setWeapon(PImage bulletI, String tipo, int damage, float angle, int size, float freqShoot, color col){
    weapons.add(new Weapon(bulletI, tipo, angle, size, objectSize, damage, freqShoot ,this));  //<>// //<>//
  }

  //Constructor alternativo sin freq de disparo //<>// //<>//
  void setWeapon(PImage bulletI, String tipo, int damage, float angle, int size, color col){
    weapons.add(new Weapon(bulletI, tipo, angle, size, objectSize, damage, this));  //<>// //<>//
  }

  void changeWeapon(int n){
    if (n < weapons.size()){
      this.n = n;
    }else{
      println("Número de arma incorrecto");
    }
  }

  void changeWeaponT(int n, int weaponTimer){
    if (n < weapons.size()){
      this.n = n;
      this.weaponTimer = weaponTimer;
    }else{
      println("Número de arma incorrecto");
    }
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

    if(type != null){
        this.movementEffects();
      }

    //Realiza la automoricion
    if(this.lifeTimer != -1){
      if(this.lifeTimer == 0){
        println("Se le acabo el tiempo de vida a:" + this);
        this.die();
      }else{
        this.lifeTimer--;
      }
    }

    if(weapons != null){
      for(Weapon weapon : weapons){
        weapon.movement(this.locationV);
      }
    }
  }

  void shoot(){
    if(weapons != null) {
      weapons.get(this.n).shoot(this.velocityV);
      new HiloSonido("shoot");
      //thread("playshootSound");
      if(weaponTimer>0){
        weaponTimer--;
        println(weaponTimer);
      }else if(weaponTimer == 0){
        this.changeWeapon(0);
        weaponTimer = -1;
      }
    }
  }
  
  Weapon getWeapon(){
    return weapons.get(this.n);
  }

  boolean hasWeapon(){
    if (this.weapons.size() == 0){
      return false;
    }else{
      return true;
    }
  }

  void sufferDamage(int damage){
    this.hitPoints -= damage;
    if(this.hitPoints <= 0){
      new HiloSonido("explosion");
      this.die();
      println("Oh Vaya, ha muerto por disparos:" + this);
    }
  }

  @Override
  void alternativeShow(){
    fill(color(76,40,130));
    triangle(-this.objectSize[0]/2.0, -this.objectSize[1]/2.0,
              this.objectSize[0]/2.0,  this.objectSize[1]/2.0,
              this.objectSize[0]/2.0, -this.objectSize[1]/2.0);
  }
  
  @Override
  void die(){
     if(GameObject.listaObjetos.contains(this)) GameObject.listaObjetos.remove(this);
       
     //println("He muerto");
  }
}
