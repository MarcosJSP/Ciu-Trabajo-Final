import processing.video.*;
import java.lang.*;
import cvimage.*;
import java.util.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;
import java.util.concurrent.*;
import processing.sound.*;

public enum GameScenes {
  DEBUG_MODE,
  MAIN_MENU,
  GAME,
  WIN,
  LOSE
}
boolean gameHasStarted = false;

GameScenes scene;

DebugCDCalibrator debugCDCalibrator;
InGameCDCalibrator ingameCDCalibrator;

SceneDrawer sceneDrawer;
MyButton quitButton, confirmButton, playAgainButton, quitButton2, backButton, configButton;

CDController cdController;
int rotation = 0;
int value;
int count = 0;
int posX;
int posY;
int y;
int y2;

PImage back;
SoundFile shootSound;
SoundFile explosionSound;
PImage hitPoints_image;

PlayerShip jugador1;
Bullet bala1;

int counter;
int nThreads;
ExecutorService executor;
float timer;
static volatile int objectCount;

boolean hitBoxBullets = false;

//Imagenes
PImage shipI;
PImage bossI;
PImage bulletS;
PImage bulletB;
PImage bigBulletBoss;
PImage smallBulletBoss;
PImage shipI1;
PImage mejoraSerpiente;
PImage mejoraTriple;
PImage mejoraLimon;
PImage mejoraCirculo;

//Hilos
HiloGeneracionNivel hilo2;
Juego juego;
void setup() {
  size(1280, 720, P3D);
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  
  //Inicializamos las imagenes
  shipI=loadImage("./Assets/Images/Space Ship.png");
  bossI=loadImage("./Assets/Images/Boss - UFO.png");
  bulletS=loadImage("./Assets/Images/Space Ship Bullet.png");
  bulletB=loadImage("./Assets/Images/Satellite small bullet.png");
  shipI1=loadImage("./Assets/Images/Enemy - satellite.png");
  bigBulletBoss = loadImage("./Assets/Images/Boss big bullet.png");
  smallBulletBoss = loadImage("./Assets/Images/Boss small bullet.png");
  mejoraSerpiente = loadImage("./Assets/Images/Upgrade - Snake shot.png");
  mejoraTriple = loadImage("./Assets/Images/Upgrade - Triple shot.png");
  mejoraLimon = loadImage("./Assets/Images/Upgrade - Lemon shot.png");  
  mejoraCirculo = loadImage("./Assets/Images/Upgrade - Circle shot.png");
  //Cosas
  scene = GameScenes.MAIN_MENU;
  Capture cam = new Capture(this, 1280, 720);
  cam.start();

  debugCDCalibrator = new DebugCDCalibrator();
  ingameCDCalibrator = new InGameCDCalibrator();
  back=loadImage("./Assets/Images/Background.png");
  shootSound=new SoundFile(this,"./Assets/Sounds/shot_1.wav");
  shootSound.amp(0.3);
  explosionSound=new SoundFile(this,"./Assets/Sounds/explosion.wav");
  explosionSound.amp(0.1);
  cdController = new CDController(cam, ingameCDCalibrator);
  
  value = 5;
  y=0;
  y2=0;
  posX=width/2;
  posY= height/2;

  //Creamos los hilos
  println("Numero de procesadores: " + Runtime.getRuntime().availableProcessors());
  //El mejor número de hilos es un poco más que el número de procesadores
  nThreads = Runtime.getRuntime().availableProcessors()+2;
  //println("Numero de hilos: " + nThreads);
  executor = Executors.newFixedThreadPool(nThreads);

  // Creamos la clase que usaremos para pintar por pantalla
  sceneDrawer = new SceneDrawer();
  confirmButton = new MyButton(loadImage("./Assets/Images/Confirm button.png"), loadImage("./Assets/Images/Confirm button-pressed.png"));
  quitButton = new MyButton(loadImage("./Assets/Images/Quit button.png"), loadImage("./Assets/Images/Quit button-pressed.png"));

  playAgainButton = new MyButton(loadImage("./Assets/Images/Play again button.png"), loadImage("./Assets/Images/Play again button-pressed.png"));
  quitButton2 = new MyButton(loadImage("./Assets/Images/Quit button2.png"), loadImage("./Assets/Images/Quit button2-pressed.png"));
  backButton = new MyButton(loadImage("./Assets/Images/Back button.png"), loadImage("./Assets/Images/Back button-pressed.png"));
  configButton = new MyButton(loadImage("./Assets/Images/Config button.png"), loadImage("./Assets/Images/Config button-pressed.png"));

  // cargamos la vida 
  hitPoints_image = loadImage("./Assets/Images/Heart.png");

  //Inicializamos el juego
  setupObjects();
}

void initGame(){
  GameObject.listaObjetos.clear();
  setupObjects();
  juego = new Juego();
  juego.cargarNivelesPredeterminados();
  hilo2 = new HiloGeneracionNivel();
}
void setupObjects() {
  //PImage imagen, String type, float x, float y, float vel, float acc, float angle, float hitPoints
  //types -> normal, rebote, serpiente
  hitBoxBullets = false;
  shipI1.resize(50, 50);
  bulletB.resize(20, 20);
  //naves
  jugador1 = new PlayerShip(shipI, width/2, height/2, 5.0, 0.0, GameObject.top, 10);
  jugador1.setWeapon(bulletS, "normal",    1, 270.0, 10, 150, color(0,255,0));
  jugador1.setWeapon(bulletS, "triple",    1, 270.0, 10, 150, color(255,0,255));
  jugador1.setWeapon(bulletS, "serpiente", 1, 270.0, 10, 150, color(255,0,255));
  jugador1.setWeapon(bulletS, "limon",     1, 270.0, 10, 150, color(255,0,255));
  
}

void draw() {
  println("Frames: " + frameRate + "\t-- Número de objetos: " + GameObject.listaObjetos.size());
  background(0);
  if (scene == GameScenes.DEBUG_MODE) {
    sceneDrawer.drawDebugScreen(cdController);
  }else if (scene == GameScenes.MAIN_MENU) {
    if(!gameHasStarted) sceneDrawer.drawIngameScreen(cdController, confirmButton, quitButton);
    else sceneDrawer.drawIngameScreen(cdController, confirmButton, backButton, quitButton);
  }else if (scene == GameScenes.GAME) {
    gameHasStarted=true;
    drawGame();
  }else if(scene == GameScenes.WIN){
    sceneDrawer.gameEndScreen(cdController, playAgainButton, quitButton2, configButton, true);
  }else if(scene == GameScenes.LOSE){
    sceneDrawer.gameEndScreen(cdController, playAgainButton, quitButton2, configButton, false);
  }
}

void drawGame (){
  if(jugador1.hitPoints<=0){
    scene = GameScenes.LOSE;
  }
  if(y>=height){
    y=0;
  }else{
    y=y+5;
  }
  
  y2=y-back.height;
  //y = constrain(y, 0, back.height - height);
  //surface.setSize(width, height);
  //back.resize(width, height);
  image(back, 0, y);
  image(back, 0, y2);

  push();
  tint(255,25);
  image(cdController.getOriginalImage(), 0, 0);
  Rect rect = cdController.getRecognizedRect();
  //paint recognized color square
  if (rect!=null) {
    noFill();
    stroke(100, 100, 100);
    rect(rect.x, rect.y, rect.width, rect.height);
  }
  pop();

  push();
  translate(width-configButton.w-45,configButton.h);
  configButton.draw();
  pop();

  //image(cdController.getFilteredImage(),0,0);
  //println(cdController.getRecognizedRect());
  
  //Arrancamos los hilos
  timer = millis();
  for(int i = 0; i< GameObject.listaObjetos.size(); i++){
    GameObject o = GameObject.listaObjetos.get(i);
    o.show();
  }

  synchronized (GameObject.listaObjetos){
    counter = 0;
    Iterator ite = GameObject.listaObjetos.iterator();
    while (ite.hasNext()){
      GameObject o = (GameObject) ite.next();
      Runnable worker = new WorkerThread(o, counter);
      executor.execute(worker);
      counter ++;
    }
  }
  
  for(int i = 0; i < jugador1.hitPoints; i++) {
      image(hitPoints_image, i*35+45,45);
  }

}

//println("Frames: " + frameRate);
public class WorkerThread implements Runnable {
  String name;
  Thread t;
  int i ;
  GameObject object;
  public WorkerThread(GameObject o, int i){
    object = o;
    this.i = i;
    name = "hilo ->" + i;
    //t = new Thread(this, name);
    //t.start();
    //System.out.println("New thread: " + name);
  }

  public void run(){
      objectController(this.object);
      //println(this.name + " esta trabajando");
  }
}

public class HiloCamara implements Runnable {
  String name;
  Thread t;
  int i ;
  
  GameObject object;
  public HiloCamara(){
    name = "hilo -> HiloCamara";
    t = new Thread(this, name);
    t.start();
    System.out.println("New thread: " + name);
  }

  public void run(){
      cdController.updateColorDetection();
  }
}

public class HiloGeneracionNivel implements Runnable {
  String name;
  Thread t;
  int i ;
  
  GameObject object;
  public HiloGeneracionNivel(){
    name = "hilo -> HiloGeneracionNivel";
    t = new Thread(this, name);
    t.start();
    System.out.println("New thread: " + name);
  }

  public void run(){
      juego.ejecutar(0);
  }
}

int sCount = 0;
int s2Count = 0;
public class HiloSonido implements Runnable {
  String name;
  String type;
  Thread t;
  int i ;
  
  GameObject object;
  public HiloSonido(String s){
    name = "hilo -> HiloSonido";
    this.type = s;
    t = new Thread(this, name);
    t.start();
    System.out.println("New thread: " + name);
  }

  public void run(){
    switch(type){
      case "shoot":
        playShootSound();
        break;
      case "explosion":
        playExplosionSound();
        break;
    }
  }
}
void objectController(GameObject obj){
    // Sección de jugador
    obj.movement();
    
    if (obj instanceof Ship){
      Ship objS = (Ship) obj;
      if (objS.hasWeapon()){
        Weapon mWeapon = objS.getWeapon();
        if(mWeapon.frequencyShoot > 0     &&
           objS.hasExited(30) == false     &&
           timer - mWeapon.internalTimer >= mWeapon.frequencyShoot){
          objS.shoot();
          mWeapon.internalTimer = timer;
        }
      }
    }

    if (obj instanceof PlayerShip) {
      Rect posRect=cdController.getRecognizedRect();
      if(posRect!= null){
        
        int newPosX = posRect.x + posRect.width/2;
        int newPosY = posRect.y + posRect.height/2;
        
        posX=round(lerp(posX,newPosX,.5));
        posY=round(lerp(posY,newPosY,.5));
      }
      obj.setPosition(posX, posY);
      synchronized(GameObject.listaObjetos){
        Iterator ite = GameObject.listaObjetos.copy().lista.iterator();
        while ( ite.hasNext() ){
          GameObject o = (GameObject)ite.next();
          //Comprobamos las colisiones con naves enemigas
          if( o instanceof EnemyShip){
            EnemyShip e = (EnemyShip) o;
            PlayerShip p = (PlayerShip) obj;
            if(p.hasCollisioned(e)){
              e.die();
              p.sufferDamage(1);
            }
          //Comprobamos las colisiones con Mejoras
          }else if( o instanceof Mejora){
            PlayerShip p = (PlayerShip) obj;
            Mejora m = (Mejora) o;
            if (p.hasCollisioned(m)){
              m.usarMejora(p); 
              m.die();
            }
          }
        }
      }
    }

    synchronized(GameObject.listaObjetos){
      if (obj instanceof Bullet){
        Bullet objB = (Bullet) obj;
        Iterator ite = GameObject.listaObjetos.copy().lista.iterator();
        while (ite.hasNext()){
          GameObject o = (GameObject) ite.next();
          if (o instanceof Ship){
            Ship objS = (Ship) o;
            if (objB.myShip instanceof PlayerShip){
               if ((objS instanceof EnemyShip) && (objB.hasCollisioned(objS))){
                 objS.sufferDamage(objB.getDamage());
                 objB.die();
               }
            }else if (objB.myShip instanceof EnemyShip){
              if ((objS instanceof PlayerShip)&& (objB.hasCollisioned(objS))){
                objS.sufferDamage(objB.getDamage());
                objB.die();
              }
            }
          }
        }
      }
    }

    // seccion de colisiones
    // exterior
    synchronized(GameObject.listaObjetos){
      if (obj.hasExited(600)){
        obj.die();
      }
    }
}

void playShootSound(){
    //if((20 - sCount) > 0) 
    this.shootSound.play();
}


void playExplosionSound(){
    //if((20 - s2Count) > 0) 
    this.explosionSound.play();
}

void keyPressed(){
  if (key == '1'){
    scene = GameScenes.DEBUG_MODE;
  }else if(key == '2'){
    scene = GameScenes.MAIN_MENU;
  }else if(key == '3'){
    scene = GameScenes.GAME;
  }
}

void mouseDragged() {
  if(scene == GameScenes.DEBUG_MODE){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mouseDragged();
  }else if(scene == GameScenes.MAIN_MENU){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mouseDragged();
  }
}

int i = 0;
void mousePressed() {
  if(scene == GameScenes.DEBUG_MODE){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mousePressed();
    
    
  }else if(scene == GameScenes.MAIN_MENU){
    CDCalibrator calibrator = cdController.getCalibrator();
    calibrator.mousePressed();
    confirmButton.mousePressed();
    quitButton.mousePressed();
    backButton.mousePressed();
    
  }else if (scene == GameScenes.GAME){
    if (mouseButton==LEFT) {
      jugador1.shoot();
      //Weapon actualWeapon = (Weapon) jugador1.weapons.get(i);
      //println("Estas usando el arma :" + actualWeapon.type);
    } else if(mouseButton==RIGHT){
      i = (i+1)%jugador1.weapons.size();
      jugador1.changeWeapon(i);
    }

    configButton.mousePressed();

  }else if (scene == GameScenes.WIN || scene == GameScenes.LOSE){
    playAgainButton.mousePressed();
    quitButton2.mousePressed();
    configButton.mousePressed();
  }
}

void mouseReleased(){
  if(scene == GameScenes.DEBUG_MODE){
  }else if(scene == GameScenes.MAIN_MENU){
    if (confirmButton.mouseReleased()) {
        if(!gameHasStarted) initGame();
        scene = GameScenes.GAME;
    } else if (quitButton.mouseReleased()) {
      exit();
    }else if(backButton.mouseReleased()){
      scene = GameScenes.GAME;
    }
  }else if(scene == GameScenes.WIN || scene == GameScenes.LOSE){
    if (playAgainButton.mouseReleased()) {
      synchronized(GameObject.listaObjetos){
        GameObject.listaObjetos.clear();
      }
      initGame();
      scene = GameScenes.GAME;
    }
    if (quitButton2.mouseReleased()) {
      exit();
    }

  }

  if(configButton.mouseReleased()){
      scene = GameScenes.MAIN_MENU;
  }

  
}

void captureEvent(Capture c){
  c.read();
  HiloCamara hilo1 = new HiloCamara();
  // if (c != null && c.available()){
  //   //cdController.updateColorDetection();
  // }
}
