import processing.video.*;
import java.lang.*;
import cvimage.*;
import java.util.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;

int status;
DebugCDCalibrator debugCDCalibrator;
InGameCDCalibrator ingameCDCalibrator;

SceneDrawer sceneDrawer;
MyButton quitButton, confirmButton;

CDController cdController;
int rotation = 0;
int value;
int count = 0;
int posX;
int posY;
int y;
int y2;
Capture cam;
PImage back;

PlayerShip jugador1;
EnemyShip enemigo1;
Bullet bala1;

void setup() {
  size(1280, 720, P3D);
  status = 2;
  cam = new Capture(this, 1280, 720);

  debugCDCalibrator = new DebugCDCalibrator();
  ingameCDCalibrator = new InGameCDCalibrator();
  back=loadImage("./Assets/Background.png");
  cdController = new CDController(cam, ingameCDCalibrator);
  setupObjects();
  
  value = 5;
  y=0;
  y2=0;
  posX=width/2;
  posY= height/2;


  sceneDrawer = new SceneDrawer();
  confirmButton = new MyButton(loadImage("./Assets/Confirm button.png"), loadImage("./Assets/Confirm button-pressed.png"));
  quitButton = new MyButton(loadImage("./Assets/Quit button.png"), loadImage("./Assets/Quit button-pressed.png"));
}

void setupObjects() {
  //PImage imagen, String type, float x, float y, float vel, float acc, float angle, float hitPoints
  //types -> normal, rebote, serpiente
  PImage shipI=loadImage("./Assets/Space Ship.png");
  //PImage bossI=loadImage("./Assets/Boss Body.png");
  PImage bulletS=loadImage("./Assets/Space Ship Bullet.png");
  PImage bulletB=loadImage("./Assets/Boss small bullet.png");
  PImage shipI1=loadImage("./Assets/Enemy - satellite.png");
  shipI1.resize(50,50);
  bulletB.resize(20,20);
  //naves
  jugador1 = new PlayerShip(shipI, width/2, height/2, 5.0, 0.0, 270.0, 100);
  //enemigo1 = new EnemyShip(bossI, "rebote", width/2, height/16, 5.0, 1.0, 0.0, 200);
  //enemigo1.imageRotation = 270.0;
  jugador1.sethitBox(true);
  
  EnemyShip enemigo2 = new EnemyShip(shipI1, "rebote", width/2 + 50, 0, 5.0, 0.1, GameObject.bot, 100);
  EnemyShip enemigo3 = new EnemyShip(shipI1, "serpiente", 0+30, height-30, 5.0, 2.0, GameObject.right-45, 100);
  enemigo3.sethitBox(true);
  EnemyShip enemigo4 = new EnemyShip(shipI1, "rebote", width/2 - 50, height-50, 10.0, 0.0, GameObject.top, 100);
  enemigo4.sethitBox(true);
  //armas
  //enemigo1.setWeapon(bulletB, "normal", 1, 90.0, 10, color(255,0,0));
  enemigo2.setWeapon(bulletB, "normal", 1, enemigo2.getAngle(), 10, color(255,0,0));
  enemigo3.setWeapon(bulletB, "circuloInvertido2", 1, enemigo3.getAngle(), 10, color(255,0,0));
  enemigo4.setWeapon(bulletB, "normal",1, enemigo4.getAngle(), 10, color(255,0,0));
  
  jugador1.setWeapon(bulletS, "circulo", 1, 270.0, 10, color(0,255,0));
  jugador1.setWeapon(bulletS, "normal", 1, 270.0, 10, color(255,0,255));
  jugador1.setangleVariation(10);
  
  enemigo2.die();
}

void draw() {
  background(0);
  //println("Frames: " + frameRate);
  cdController.updateColorDetection();
  if (status == 1) {
    sceneDrawer.drawDebugScreen(cdController);
  }else if (status == 2) {
    sceneDrawer.drawIngameScreen(cdController, confirmButton, quitButton);
  }else if (status == 3) {
    
    if(y>=height){
      y=0;
    }else{
      y=y+20;
    }
    
    y2=y-back.height;
    //y = constrain(y, 0, back.height - height);
    image(back, 0, y);
    image(back, 0, y2);
    //image(cdController.getFilteredImage(),0,0);
    //println(cdController.getRecognizedRect());
    
    //Control de los objetos
    for (int i = 0; i < GameObject.listaObjetos.size(); i++){
      GameObject obj = GameObject.listaObjetos.get(i) ;
      
      
      // Seccion de tratamiento de la nave del jugador
      
      if (obj instanceof Ship){
        Ship objES = (Ship) obj;
        if (count == 10) objES.shoot(); 
      }
      
      // Sección de jugador
      if (obj instanceof PlayerShip) {
        Rect posRect=cdController.getRecognizedRect();
        if(posRect!= null){
          posX=posRect.x;
          posY=posRect.y;
        }
        obj.setPosition(mouseX, mouseY);
        if (this.frameCount%15 == 0){
          obj.setimageRotation(rotation);
          rotation = (rotation + 15)%360;
        }
        
        //Colisiones (solo con las balas de otras naves)
        for (int j = 0; j < GameObject.listaObjetos.size(); j++){
          GameObject objj = GameObject.listaObjetos.get(j);
          PlayerShip pS = (PlayerShip) obj;
          if(objj instanceof EnemyShip){
            EnemyShip eS = (EnemyShip) objj;
            for (int k = 0; k < eS.weapons.size(); k++){
              Weapon eW = eS.weapons.get(k);
              for(int l = 0; l < eW.balas.size(); l++){
                Bullet bala = eW.balas.get(l);
                if(bala.hasCollisioned(pS)){
                  pS.sufferDamage(bala.damage);
                  bala.die();
                }
              }
            }
          }
        }
      }
      
      if (obj instanceof EnemyShip){
        //Colisiones (solo con las balas de otras naves)
        for (int j = 0; j < GameObject.listaObjetos.size(); j++){
          GameObject objj = GameObject.listaObjetos.get(j);
          EnemyShip eS = (EnemyShip) obj;
          if(objj instanceof PlayerShip){
            PlayerShip pS = (PlayerShip) objj;
            for (int k = 0; k < pS.weapons.size(); k++){
              Weapon pW = pS.weapons.get(k);
              for(int l = 0; l < pW.balas.size(); l++){
                Bullet bala = pW.balas.get(l);
                if(bala.hasCollisioned(eS)){
                  eS.sufferDamage(bala.damage);
                  println("vida: " + eS.hitPoints);
                  bala.die();
                }
              }
            }
          }
        }
      }  
      
      // seccion de colisiones
      // exterior
      if (obj.hasExited(100)){
        obj.die(); 
      }
      obj.movement();
      obj.show();
      
      // contador
      if (count > 10) {
        count = 0;
      }
      
      count++;
    }
  }
//println("Frames: " + frameRate);
}


void keyPressed(){
  if (key=='1'){
    status=1;
  }else if( key == '2'){
    status=2;
  }else if(key=='3'){
    status=3;
  }
}

void mouseDragged() {
  if(status == 1){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mouseDragged();
  }else if(status == 2){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mouseDragged();
  }
}

void mousePressed() {
  if(status == 1){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mousePressed();
  }else if(status == 2){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mousePressed();
    confirmButton.mousePressed();
    quitButton.mousePressed();
  }else if (status == 3){
    if (mouseButton==LEFT) {
      jugador1.changeWeapon(0);
    } else if(mouseButton==RIGHT){
      jugador1.changeWeapon(1);
    }
  }
  jugador1.shoot();
}

void mouseReleased(){
  if(status == 1){
  }else if(status == 2){
    confirmButton.mouseReleased();
    quitButton.mouseReleased();
  }
}
