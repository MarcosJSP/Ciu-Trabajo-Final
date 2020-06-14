class Weapon{
  
  //ArrayList <Bullet> balas;
  Ship myShip;
  float size, angle;
  int damage;
  PVector location = new PVector();
  PVector offset; 
  //color colour;
  String type = "normal";
  PImage balaI;
  float [] shipSize;
  
  Weapon(PImage asset, String type, float angle, int size, float[] shipSize, int damage, Ship myShip){
    this.size=size;
    this.angle = angle;
    //this.colour = colour;
    this.damage = damage;
    this.type = type;
    this.balaI = asset;
    this.shipSize = shipSize;
    this.offset = PVector.fromAngle(radians(this.angle));
    this.offset.setMag(shipSize[1]);
    
    this.myShip = myShip;
    //this.balas = new ArrayList<Bullet>();
  }
  
  void movement(PVector loc){
    this.location = loc.copy();
    this.location.add(offset);
  }
  
  void shoot(PVector shipV){
    int nBullets;
    PVector a;
    switch(this.type){
     case "normal":
          new Bullet(balaI,null, location.x,location.y , shipV, 5.0, 0, this.angle, this.damage, this.myShip);
          break;
          
        case "triple":
          new Bullet(balaI, null, location.x,location.y, shipV, 5.0, 0.0, this.angle+20, this.damage, this.myShip);
          new Bullet(balaI, null, location.x,location.y, shipV, 5.0, 0.0, this.angle, this.damage, this.myShip);
          new Bullet(balaI, null, location.x,location.y, shipV, 5.0, 0.0, this.angle-20, this.damage, this.myShip);
          break;
         
        case "limon":
          nBullets = 36;
          a = this.location.copy().sub(offset);
          for(int i = 0; i<nBullets; i++){
            //PVector aOffset = PVector.fromAngle(radians(i*360/nBullets));
            PVector aOffset = PVector.fromAngle(radians(360-(i*360/nBullets)));
            aOffset.setMag(offset.mag());
            new Bullet(balaI, null, PVector.add(a,aOffset).x, PVector.add(a,aOffset).y, shipV, 5.0, 1.0, this.angle + i*360/nBullets, this.damage, this.myShip);
          }
          break;  
          
        case "circuloInvertido":
          nBullets = 16;
          a = this.location.copy().sub(offset);
          for(int i = 0; i<nBullets; i++){
            //PVector aOffset = PVector.fromAngle(radians(i*360/nBullets));
            PVector aOffset = PVector.fromAngle(radians((i* (360/nBullets))));
            aOffset.setMag(offset.mag()/2);
            new Bullet(balaI, null, PVector.add(a,aOffset).x, PVector.add(a,aOffset).y, shipV, 1.0, 0.0, this.angle + i*(360/nBullets), this.damage, this.myShip);
          }
          break;
          
        case "circuloInvertido2":
          nBullets = 16;
          a = this.location.copy().sub(offset);
          for(int i = 0; i<nBullets; i++){
            //PVector aOffset = PVector.fromAngle(radians(i*360/nBullets));
            PVector aOffset = PVector.fromAngle(radians(90+(i*360/nBullets)));
            aOffset.setMag(offset.mag());
            new Bullet(balaI, null, PVector.add(a,aOffset).x, PVector.add(a,aOffset).y, shipV, 1.0, 0.0, this.angle + i*360/nBullets, this.damage, this.myShip);
          }
          break;
          
        case "circulo":
          nBullets = 16;
          a = this.location.copy().sub(offset);
          for(int i = 0; i<nBullets; i++){
            //PVector aOffset = PVector.fromAngle(radians(i*360/nBullets));
            PVector aOffset = PVector.fromAngle(radians((i*360/nBullets)-90));
            aOffset.setMag(offset.mag()/2.0);
            new Bullet(balaI, null, PVector.add(a,aOffset).x, PVector.add(a,aOffset).y, shipV, 1.0, 0.0, this.angle + i*360/nBullets, this.damage, this.myShip);
          }
          break;
          
        case "serpiente":
          new Bullet(balaI, "serpiente", location.x,location.y, shipV, 10.0, 0.0, this.angle, this.damage, this.myShip);
          break;
          
        case "rebote":
          new Bullet(balaI, "rebote", location.x,location.y, shipV, 5.0, 0.2, this.angle, this.damage, this.myShip);
          break;
          
        case "muro":
          nBullets = 8;
          for(int i = -nBullets/2; i<nBullets/2; i++){
            new Bullet(balaI, null, location.x + i*this.size*3 ,location.y, shipV, 5.0, 1.0, this.angle, this.damage, this.myShip);  
          }
          break;
        case "default":
          println("Este modo no existe");
          new Bullet(balaI,null, location.x,location.y , shipV, 5.0, 0, this.angle, this.damage, this.myShip);
          break;
    }
  }   
}     
    /*
      if(this.balaI == null){
        switch(this.type){
        case "normal":
          balas.add(new Bullet(null, location.x,location.y, shipV, 5.0, 0.0, this.angle,  this.size, this.colour, this.damage));
          break;
        
        case "triple":
          balas.add(new Bullet(null, location.x,location.y, shipV, 5.0, 0.0, this.angle+20, this.size, this.colour, this.damage));
          balas.add(new Bullet(null, location.x,location.y, shipV, 5.0, 0.0, this.angle, this.size, this.colour, this.damage));
          balas.add(new Bullet(null, location.x,location.y, shipV, 5.0, 0.0, this.angle-20, this.size, this.colour, this.damage));
          break;
       
        case "circle":
          nBullets = 16;
          for(int i = 0; i<nBullets; i++){
            balas.add(new Bullet(null, location.x,location.y, shipV, 5.0, 0.0, this.angle+i*(360/nBullets), this.size, this.colour, this.damage));
            
          }
          break;
       
       case "serpiente":
          balas.add(new Bullet("serpiente",location.x, location.y, shipV, 5.0, 0.0, this.angle, this.size, this.colour, this.damage));
          balas.get(balas.size()).setangleVariation(10);
          break;
          
       case "muro":
          nBullets = 8;
          for(int i = -nBullets/2; i<nBullets/2; i++){
            balas.add(new Bullet(null, location.x + i*this.size*3 ,location.y, shipV, 5.0, 0.0, this.angle, this.size, this.colour, this.damage));
          }
      }
    }else{
      switch(this.type){
        case "normal":
          balas.add(new Bullet(balaI,null, location.x,location.y , shipV, 5.0, 0, this.angle, this.damage));
          break;
          
        case "triple":
          balas.add(new Bullet(balaI, null, location.x,location.y, shipV, 5.0, 0.0, this.angle+20, this.damage));
          balas.add(new Bullet(balaI, null, location.x,location.y, shipV, 5.0, 0.0, this.angle, this.damage));
          balas.add(new Bullet(balaI, null, location.x,location.y, shipV, 5.0, 0.0, this.angle-20, this.damage));
          break;
         
        case "limon":
          nBullets = 36;
          a = this.location.copy().sub(offset);
          for(int i = 0; i<nBullets; i++){
            //PVector aOffset = PVector.fromAngle(radians(i*360/nBullets));
            PVector aOffset = PVector.fromAngle(radians(360-(i*360/nBullets)));
            aOffset.setMag(offset.mag());
            balas.add(new Bullet(balaI, null, PVector.add(a,aOffset).x, PVector.add(a,aOffset).y, shipV, 5.0, 1.0, this.angle + i*360/nBullets, this.damage));
          }
          break;  
          
        case "circuloInvertido1":
          nBullets = 16;
          a = this.location.copy().sub(offset);
          for(int i = 0; i<nBullets; i++){
            //PVector aOffset = PVector.fromAngle(radians(i*360/nBullets));
            PVector aOffset = PVector.fromAngle(radians((i* (360/nBullets))));
            aOffset.setMag(offset.mag()/2);
            balas.add(new Bullet(balaI, null, PVector.add(a,aOffset).x, PVector.add(a,aOffset).y, shipV, 1.0, 0.0, this.angle + i*(360/nBullets), this.damage));
          }
          break;
          
        case "circuloInvertido2":
          nBullets = 16;
          a = this.location.copy().sub(offset);
          for(int i = 0; i<nBullets; i++){
            //PVector aOffset = PVector.fromAngle(radians(i*360/nBullets));
            PVector aOffset = PVector.fromAngle(radians(90+(i*360/nBullets)));
            aOffset.setMag(offset.mag());
            balas.add(new Bullet(balaI, null, PVector.add(a,aOffset).x, PVector.add(a,aOffset).y, shipV, 1.0, 0.0, this.angle + i*360/nBullets, this.damage));
          }
          break;
          
        case "circulo":
          nBullets = 16;
          a = this.location.copy().sub(offset);
          for(int i = 0; i<nBullets; i++){
            //PVector aOffset = PVector.fromAngle(radians(i*360/nBullets));
            PVector aOffset = PVector.fromAngle(radians((i*360/nBullets)-90));
            aOffset.setMag(offset.mag()/2.0);
            balas.add(new Bullet(balaI, null, PVector.add(a,aOffset).x, PVector.add(a,aOffset).y, shipV, 1.0, 0.0, this.angle + i*360/nBullets, this.damage));
        }
          break;
          
        case "serpiente":
          balas.add(new Bullet(balaI, "serpiente", location.x,location.y, shipV, 10.0, 0.0, this.angle, this.damage));
          break;
          
        case "rebote":
          balas.add(new Bullet(balaI, "rebote", location.x,location.y, shipV, 5.0, 0.2, this.angle, this.damage));
          break;
          
        case "muro":
          nBullets = 8;
          for(int i = -nBullets/2; i<nBullets/2; i++){
            balas.add(new Bullet(balaI, null, location.x + i*this.size*3 ,location.y, shipV, 5.0, 1.0, this.angle, this.damage));  
          }
          break;
        case "default":
          println("Este modo no existe");
          balas.add(new Bullet(balaI,null, location.x,location.y , shipV, 5.0, 0, this.angle, this.damage));
          break;
       }
    }
    
    Iterator<Bullet> iter = balas.iterator();
    while(iter.hasNext()){
      Bullet bala = (Bullet) iter.next();
      bala.setLifeTimer(100);
      bala.setBulletList(this.balas);
    }
    */
