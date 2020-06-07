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
Capture cam;

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

  cdController = new CDController(cam, ingameCDCalibrator);
  gameObjects = new ArrayList<GameObject>();
  setupObjects();
  count = 0;
  value = 5;
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
        obj.setPosition(posX, posY);
      }

      // seccion de tratamiento de los enemigos
      if (obj instanceof EnemyShip) {
        if (obj.getPostion()[0] - obj.getSize()/2 <= 0 ||obj.getPostion()[0] + obj.getSize()/2 >= width) {
          value = - value;
          obj.movement(value, 0);
        }
        
        if (count == 10 ) gameObjects.add(0, obj.shoot());
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
  jugador1 = new PlayerShip(50, 50, 20,1);
  enemigo1 = new EnemyShip(width/2, height/16, 50,1);
  enemigo1.setWeapon(new Weapon(0, 3, 20,color(255,0,0),1));
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
      jugador1.setWeapon(new Weapon(0, -8, 20,color(0,0,255),1));
    } else {
      jugador1.setWeapon(new Weapon(0, -4, 80,color(255,0,255),1));
    }
    gameObjects.add(0, jugador1.shoot());
  }
  
}
