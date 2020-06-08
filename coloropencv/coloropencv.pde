import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;


int status;
DebugCDCalibrator debugCDCalibrator;
InGameCDCalibrator ingameCDCalibrator;

CDController cdController;

int value;
int count;
int posX;
int posY;
int y;
int y2;
Capture cam;
PImage back;
PImage imagejugador1,imageEnemy1,bulletJugador1;

PlayerShip jugador1;
EnemyShip enemigo1;
Bullet bala1;


ArrayList<GameObject> gameObjects;

void setup() {
  size(1280, 720, P3D);
  status = 2;
  cam = new Capture(this, 1280, 720);

  debugCDCalibrator = new DebugCDCalibrator();
  ingameCDCalibrator = new InGameCDCalibrator();
  back=loadImage("./Assets/background.png");
  cdController = new CDController(cam, ingameCDCalibrator);
  gameObjects = new ArrayList<GameObject>();
  setupObjects();
  count = 0;
  value = 5;
  y=0;
  y2=0;
  posX=width/2;
  posY= height/2;
}

void draw() {
  background(0);
  cdController.updateColorDetection();
  if (status == 0) {
    drawDebugScreen();
  } else if (status == 1) {
    drawIngameScreen();
  } else if (status == 2) {
    
    if(y>=height){
      y=0;
    }else{
      y=y+20;
    }
    
    y2=y-back.height;
    //y = constrain(y, 0, back.height - height);
    image(back, 0, y);
    image(back, 0, y2);
    
    int i = gameObjects.size()-1;
    //image(cdController.getFilteredImage(),0,0);
    println(cdController.getRecognizedRect());
    while (i >=0) {
      

      GameObject obj = gameObjects.get(i);  
      obj.show();
      
      // seccion de tratamiento de la nave del jugador
      if (obj instanceof PlayerShip) {
        Rect posRect=cdController.getRecognizedRect();
        if(posRect!= null){
          posX=posRect.x;
          posY=posRect.y;
        }
        obj.setPosition(mouseX, mouseY);
      }

      // seccion de tratamiento de los enemigos
      if (obj instanceof EnemyShip) {
        if (obj.getPostion()[0] - obj.getSize()/2 <= 0 ||obj.getPostion()[0] + obj.getSize()/2 >= width) {
          value = - value;
          obj.movement(value, 0);
        }
        
        if (count == 10 ) gameObjects.add(0, obj.shoot());
      }
      if(obj instanceof Bullet){
        int j = gameObjects.size()-1;
        
        while(j>=0 && obj.playerObject){
          GameObject obj2 = gameObjects.get(j);
          if(!obj2.playerObject){
            checkBullet(obj,obj2);
          }
          j--;
        }
      }
      if(obj instanceof Bullet){
        int j = gameObjects.size()-1;
        
        while(j>=0 && !obj.playerObject){
          GameObject obj2 = gameObjects.get(j);
          if(obj2.playerObject){
            checkBullet(obj,obj2);
          }
          j--;
        }
      
      }

      
      // seccion de colisiones

      if (obj.hasDied() ||obj.getPostion()[1] >height+40 || obj.getPostion()[1]<-40 || obj.getPostion()[0] <-40 ||obj.getPostion()[0]>width+40) gameObjects.remove(i);
      //println(gameObjects.size());
      i--;
    }
    if (count > 10) {
      count = 0;
    }
    count++;
  }
  println("Frames: " + frameRate);
}

void checkBullet(GameObject obj, GameObject obj2){
  float [] positionObj=obj.getPostion();
          float obj2Size=obj2.getSize();
          float objSize=obj.getSize();
          //if(!obj2Player){
          
            if(obj2 instanceof Ship){
              float [] positionObj2=obj2.getPostion();
              if(((positionObj2[0]<=positionObj[0]+objSize && positionObj2[0]>=positionObj[0])
              || (positionObj[0] <= positionObj2[0]+obj2Size && positionObj[0]>=positionObj2[0]))
              &&
               ((positionObj2[1]<=positionObj[1]+objSize && positionObj2[1]>=positionObj[1])
              || (positionObj[1] <= positionObj2[1]+obj2Size && positionObj[1]>=positionObj2[1]))
               ){
               ((Ship) obj2).reduceHitPoints(((Bullet) obj).getDamage());
               ((Bullet) obj).setDied(true);
              }
            }
          //}
}


void drawDebugScreen() {
  PImage originalImg = cdController.getOriginalImage();
  PImage filteredImg = cdController.getFilteredImage();
  Rect rect = cdController.getRecognizedRect();
  CDCalibrator calibrator = cdController.getCalibrator();
  push();
  translate(0, height/2-originalImg.height/2);

  //left
  image(filteredImg, 0, 0);
  translate(width/2, 0);

  //right
  image(originalImg, 0, 0);
  if (rect!=null) {
    noFill();
    stroke(250, 0, 0);
    rect(rect.x, rect.y, rect.width, rect.height);
  }
  pop();
  calibrator.draw();
}

void drawIngameScreen(){
  PImage img = cdController.getOriginalImage();
  if(img == null) return;
  CDCalibrator calibrator = cdController.getCalibrator();
  Rect rect = cdController.getRecognizedRect();
  push();
  translate(width/2-img.width/2, height/2-img.height/2);
  image(img, 0, 0);
  if (rect!=null) {
    noFill();
    stroke(250, 0, 0);
    rect(rect.x, rect.y, rect.width, rect.height);
  }
  pop();
  calibrator.draw();
}



void keyPressed(){
  if (key=='1'){
    status=0;
  }else if( key == '2'){
    status=1;
  }else if(key=='3'){
    status=2;
  }
}

void mouseDragged() {
  if (status == 0 || status == 1){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mouseDragged();
  }
}

void setupObjects() {
  imagejugador1=loadImage("./Assets/SpaceShip.png");
  imageEnemy1=loadImage("./Assets/Boss.png");
  bulletJugador1=loadImage("./Assets/SpaceShipBullet.png");
  image(bulletJugador1,10,10);
  jugador1 = new PlayerShip(50, 50, imagejugador1.width ,10,imagejugador1);
  enemigo1 = new EnemyShip(width/2, height/16, 50,10,imageEnemy1);
  enemigo1.setWeapon(new Weapon(0, 3, 10,0,1,bulletJugador1));
  enemigo1.movement(5, 0);


  gameObjects.add(enemigo1);

  gameObjects.add(jugador1);
}

void mousePressed() {

  if(status == 0 || status == 1){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mousePressed();
  }else if (status == 2){
    if (mouseButton==LEFT) {
      jugador1.setWeapon(new Weapon(0, -8, 10,1,1,bulletJugador1));
    } else {
      jugador1.setWeapon(new Weapon(0, -4, 10,1,1,bulletJugador1));
    }
    Bullet bullet=jugador1.shoot();
    bullet.setPlayerObject(true);
    gameObjects.add(0, bullet);
  }
  
}
