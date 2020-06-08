class Weapon{
  
  float size, damage, angle;
  PVector location = new PVector();
  color colour;
  String tipo = "normal";
  
  Weapon(String tipo, PVector loc, float angle, int size, color colour, float damage){
    this.size=size;
    this.location = loc.copy();
    this.angle = angle;
    this.colour = colour;
    this.damage = damage;
    this.tipo = tipo;
  }
  
  void movement(PVector loc){
    this.location = loc.copy();
  }
  
  void shoot(){
    ArrayList <Bullet> balas = new ArrayList<Bullet>();
    switch(this.tipo){
      case "normal":
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle, this.size, this.colour, this.damage));
        break;
      case "triple":
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle+20, this.size, this.colour, this.damage));
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle, this.size, this.colour, this.damage));
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle-20, this.size, this.colour, this.damage));
        break;
      case "circle":
        int nBullets = 8;
        for(int i = 0; i<nBullets; i++){
        balas.add(new Bullet(location.x,location.y, 5.0, 1.0, this.angle+i*(360/nBullets), this.size, this.colour, this.damage));
        }
        break;
    }
    Iterator<Bullet> iter = balas.iterator();
    
    while(iter.hasNext()){
       gameObjects.add(0,iter.next()); 
    }
    
    //Bullet bullet = new Bullet(location.x,location.y, 5.0, 1.0, this.angle, this.size, this.colour, this.damage);
    //gameObjects.add(0, bullet);
  }
}
