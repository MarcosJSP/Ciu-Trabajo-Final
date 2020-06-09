class Weapon{
  
  float size, damage, angle;
  PVector location = new PVector();
  color colour;
  String type = "normal";
  
  Weapon(String type, PVector loc, float angle, int size, color colour, float damage){
    this.size=size;
    this.location = loc.copy();
    this.angle = angle;
    this.colour = colour;
    this.damage = damage;
    this.type = type;
  }
  
  void movement(PVector loc){
    this.location = loc.copy();
  }
  
  void shoot(){
    ArrayList <Bullet> balas = new ArrayList<Bullet>();
    int nBullets;
    switch(this.type){
      case "normal":
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle, this.size, this.colour, this.damage));
        break;
      case "triple":
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle+20, this.size, this.colour, this.damage));
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle, this.size, this.colour, this.damage));
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle-20, this.size, this.colour, this.damage));
        break;
      case "circle":
        nBullets = 16;
        for(int i = 0; i<nBullets; i++){
          balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle+i*(360/nBullets), this.size, this.colour, this.damage));
        }
        break;
     case "serpiente":
        balas.add(new Bullet("serpiente",location.x,location.y, 5.0, 1.0, this.angle, this.size, this.colour, this.damage));
        break;
     case "muro":
        nBullets = 8;
        for(int i = -nBullets/2; i<nBullets/2; i++){
          balas.add(new Bullet(location.x + i*this.size*3 ,location.y, 5.0, 1.0, this.angle, this.size, this.colour, this.damage));
        }
    }
    Iterator<Bullet> iter = balas.iterator();
    
    while(iter.hasNext()){
       gameObjects.add(0,iter.next()); 
    }
    
    //Bullet bullet = new Bullet(location.x,location.y, 5.0, 1.0, this.angle, this.size, this.colour, this.damage);
    //gameObjects.add(0, bullet);
  }
}
