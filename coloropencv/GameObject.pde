
static class synchronizedGameObjectList {
  ArrayList <GameObject> lista;
  synchronizedGameObjectList(){
    this.lista = new  ArrayList <GameObject>();
  }

  synchronizedGameObjectList copy(){
    synchronized(lista){
      synchronizedGameObjectList result = new synchronizedGameObjectList();
      result.lista = new ArrayList <GameObject> (this.lista);
      return result;
    }
  }

  GameObject get(int i){
    synchronized(lista){
      return this.lista.get(i);
    }
  }

  void add(GameObject o){
    synchronized(lista){
      this.lista.add(o);
    }
  }

  void remove(GameObject o){
    synchronized(lista){
      this.lista.remove(o);
    }
  }
  
  void clear(){
    synchronized(lista){
      this.lista.clear();
    }
  }

  boolean contains(GameObject o){
    synchronized(lista){
      return this.lista.contains(o);
    }
  }

  int size(){
    synchronized(lista){
      return this.lista.size();
    }
  }

  Iterator iterator(){
    synchronized(lista){
     return this.lista.iterator();
    }
  }
}
static abstract class GameObjectUniverse {
  static final synchronizedGameObjectList listaObjetos = new synchronizedGameObjectList();
  static final float top = 270.0 ;
  static final float bot = 90.0;
  static final float right = 0.0;
  static final float left = 180.0;
}

public class GameObject extends GameObjectUniverse{
  PVector locationV = new PVector();
  PVector velocityV = new PVector();
  float   velocity = 0.0;
  float   acceleration = 0.0;
  float   angle = 0.0;
  float   angleR = 0.0;
  float   angleVariation = 5.0;
  PVector locationR = new PVector();
  float   velocityLimit = -1;
  float[] objectSize =new float [2];
  String  type;
  PImage  asset = null;
  float   imageRotation;
  boolean hitBox_flag = false;
  hitBox  hitBox;
  int lifeTimer = -1;

  GameObject(PImage imagen, String type, float x, float y, float vel, float acc, float angle){
    this.locationV.x = x;
    this.locationV.y = y;
    this.velocity = vel;
    this.acceleration = acc;
    this.angle = angle;
    this.type = type;
    this.asset = imagen;

    if (asset == null){
      this.objectSize[0] = 10;
      this.objectSize[0] = 10;
    }else{
      this.objectSize[0] = imagen.width;
      this.objectSize[1] = imagen.height;
    }

    this.angleR = angle;
    this.locationR = locationV.copy();

    this.imageRotation = angle+90;
    velocityV = PVector.fromAngle(radians(angle));
    velocityV.setMag(velocity);
    this.hitBox = new hitBox(this.objectSize[0], this.objectSize[1]);
    this.hitBox.rotateHitBox(imageRotation);

    synchronized (GameObject.listaObjetos){
      GameObject.listaObjetos.add(this);
    }
  }

  void show(){
    if(this.asset == null){
      //Si el GameObject no tiene imagen se dibuja una alternativa en su lugar
      alternativeShow();
    }else{
      pushMatrix();
      imageMode(CENTER);
      translate(locationV.x, locationV.y);
      rotate(radians(imageRotation));
      image(this.asset,0, 0);
      imageMode(CORNER);
      popMatrix();
    }

    //dibujamoshitbox
    if(hitBox_flag){
        pushMatrix();
        translate(locationV.x, locationV.y);
        float [] a;
        float [] b;
        stroke(color(255,0,0));
        for(int i = 0; i<3 ; i++){
          a = this.hitBox.corners.get(i);
          b = this.hitBox.corners.get(i+1);
          line(a[0],a[1],b[0],b[1]);
        }
        a = this.hitBox.corners.get(3);
        b = this.hitBox.corners.get(0);
        line(a[0],a[1],b[0],b[1]);
        popMatrix();
      }
  }

  void alternativeShow(){
     fill(random(0,255),random(0,255),random(0,255));
     rect(locationV.x, locationV.y, this.objectSize[0], this.objectSize[1]);
  }

  //setters
  void setPosition(float x, float y){
    this.locationV.set(x,y);
  }

  void setangleVariation(float a){
    this.angleVariation = a;
  }

  void setLifeTimer(int time){
    this.lifeTimer = time;
  }

  void sethitBox(boolean a){
    this.hitBox_flag = a;
  }

  void setimageRotation(float r){
    this.hitBox.rotateHitBox((r - this.imageRotation));
    this.imageRotation = r;
  }
//   --  getters --
  float[] getPosition(){
    float [] result= {this.locationV.x,this.locationV.y};
    return result;
  }

  float[] getSize () {
    return this.objectSize;
  }

  float getangleVariation(){
    return this.angleVariation;
  }

  float getAngle(){
    return this.angle;
  }

  //Sigue su física
  //modificar como se trata la velocidad y la aceleracion
  void movement(){
    float velocityMag = velocityV.mag();
    velocityV = PVector.fromAngle(radians(angle));
    //Creamos el vector velocityV como un vector unitario que apunta a la dirección donde se mueve el objeto
    PVector accelerationV = velocityV.copy();

    //la magnitud del vector lo define la velocidad
    velocityV.setMag(velocityMag);
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
        //println("Se le acabo el tiempo de vida a:" + this);
        this.die();
      }else{
        this.lifeTimer--;
      }
    }
  }

  //Le pasamos las coordenadas
  void movement(float x, float y){
    this.locationV.x = x;
    this.locationV.y = y;
  }

  void movementEffects(){
    switch(type){
      case "serpiente":
        this.angle += this.angleVariation;
        if((this.angle > this.angleR+45) || (this.angle < this.angleR-45)){
          this.angleVariation *= -1;
        }
        break;
      case "rebote":
        if(this.hasExited(0)){
          this.angle = this.angle+180;
          this.setimageRotation(this.imageRotation);
        }
        break;
    }
  }


  void die(){
     if(GameObject.listaObjetos.contains(this)) GameObject.listaObjetos.remove(this);
     
     //println("He muerto");
  }

  boolean hasCollisioned(GameObject b){

    float aRight = this.locationV.x + this.hitBox.getWidth();
    float aLeft  = this.locationV.x - this.hitBox.getWidth();
    float aBot = this.locationV.y - this.hitBox.getHeight();
    float aTop = this.locationV.y + this.hitBox.getHeight();

    float bRight = b.locationV.x + b.hitBox.getWidth();
    float bLeft  = b.locationV.x - b.hitBox.getWidth();
    float bBot = b.locationV.y - b.hitBox.getHeight();
    float bTop = b.locationV.y + b.hitBox.getHeight();

    if(((aTop   > bBot  && aTop   < bTop   )&&
        (aRight > bLeft && aRight < bRight))||
       ((aBot   > bBot  && aBot   < bTop   )&&
        (aRight > bLeft && aRight < bRight))||
       ((aTop   > bBot  && aTop   < bTop   )&&
        (aLeft  > bLeft && aLeft  < bRight))||
       ((aBot   > bBot  && aBot   < bTop   )&&
        (aLeft  > bLeft && aLeft  < bRight)))
    {
      return true;
    }else{
      return false;
    }
  }

  //mirar teoria de hitboxx
  boolean hasExited(float offset){

    float axright = this.locationV.x + this.hitBox.getWidth();
    float axleft  = this.locationV.x - this.hitBox.getWidth();
    float aytop = this.locationV.y - this.hitBox.getHeight();
    float aybot = this.locationV.y + this.hitBox.getHeight();

    if(axright > width  + offset||
       axleft  < 0      - offset||
       aytop   < 0      - offset||
       aybot   > height + offset){
         return true;

       }else{
         return false;
       }
  }


  //Devolvemos una copia
  GameObject copy(){
    GameObject copia = new GameObject(this.asset, this.type, this.locationV.x, this.locationV.y, this.velocity, this.acceleration, this.angle);
    copia.velocityLimit = this.velocityLimit;
    copia.setangleVariation(this.angleVariation);
    copia.setLifeTimer(this.lifeTimer);
    copia.sethitBox(this.hitBox_flag);
    copia.setimageRotation(this.imageRotation);
    return copia;
  }

  //Devolvemos un array de copias
  GameObject[] multyCopy(int n){
    GameObject[] multy = new GameObject[n];
    for(int i= 0; i<n; i++){
       multy[i] = new GameObject(this.asset, this.type, this.locationV.x, this.locationV.y, this.velocity, this.acceleration, this.angle);
       multy[i].setangleVariation(this.angleVariation);
       multy[i].setimageRotation(this.imageRotation);
       multy[i].setLifeTimer(this.lifeTimer);
       multy[i].sethitBox(this.hitBox_flag);
    }
    return multy;
  }
}


class hitBox{
  ArrayList <float[]> corners = new ArrayList <float[]>();
  float w;
  float h;

  hitBox(float w, float h){
    float [] leftTop  = {-w/2, h/2};
    float [] rightTop = {w/2 , h/2};
    float [] leftBot  = {-w/2,-h/2};
    float [] rightBot = {w/2 ,-h/2};
    corners.add(leftTop);
    corners.add(rightTop);
    corners.add(rightBot);
    corners.add(leftBot);
    this.w = w;
    this.h = h;
  }

  void rotateHitBox(float rot){
    Iterator iter = this.corners.iterator();
    float maxX = 0;
    float maxY = 0;
    boolean first = true;
    while(iter.hasNext()){
      float [] obj = (float []) iter.next();
      float x = obj[0];
      float y = obj[1];
      obj[0] = x * cos(radians(rot)) - y * sin(radians(rot));
      obj[1] = x * sin(radians(rot)) + y * cos(radians(rot));

      if (first){
        maxX = obj[0];
        maxY = obj[1];
        first = false;
      }else{
        if (obj[0] > maxX) maxX = obj[0];
        if (obj[1] > maxY) maxY = obj[1];
      }
    }
    this.w = maxX;
    this.h = maxY;
  }

  float getWidth(){
    return this.w;
  }

  float getHeight(){
    return this.h;
  }
}
