import processing.sound.*;

class Ship extends GameObject {
  int hitPoints;
  int n = 0;
  ArrayList<Weapon> weapons = new ArrayList<Weapon>();
  
  Ship(PImage imagen, String type, float x, float y, float vel, float acc, float angle, int hitPoints) {
    super(imagen, type, x, y, vel, acc, angle);
    this.locationV.set(x,y);
    this.hitPoints = hitPoints;
    
  }

  void setWeapon(PImage bulletI, String tipo, int damage, float angle, int size, float freqShoot, color col){
    weapons.add(new Weapon(bulletI, tipo, angle, size, objectSize, damage, freqShoot ,this));  //<>// //<>//
  }

  //Constructor alternativo sin freq de disparo
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

  @Override
  void movementEffects(){
    switch(type){
      case "serpiente":
        this.angle += this.angleVariation;
        if((this.angle > this.angleR+45) || (this.angle < this.angleR-45)){
          this.angleVariation *= -1;
        }
        break;

      case "rebote":
        if(this.hasExited(-1)){
          this.angle = this.angle+180;
          this.imageRotation = this.imageRotation+180;
          Iterator iter = this.weapons.iterator();

          while (iter.hasNext()){
            Weapon weapon = (Weapon) iter.next();
            weapon.angle = weapon.angle + 180;
            weapon.offset.rotate(weapon.angle + 180);
            weapon.offset = PVector.fromAngle(radians(this.angle));
            weapon.offset.setMag(this.objectSize[1]);
          }
        }
        break;
    }
  }

  void shoot(){
    if(weapons != null) {
      weapons.get(this.n).shoot(this.velocityV);
      thread("playshootSound");
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
      thread("playExplosionSound");
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
