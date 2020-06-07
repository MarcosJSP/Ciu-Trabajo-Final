import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;


int status;
int value;
int count;
Controller a;
Capture cam;

PlayerShip jugador1;
EnemyShip enemigo1;
Bullet bala1;

ArrayList<GameObject> gameObjects;

void setup() {
  size(1920, 1080, P3D);
  status = 1;
  //cam = new Capture(this, width/2, height);
  //a= new Controller(cam);
  gameObjects = new ArrayList<GameObject>();
  setupObjects();
  count = 0;
  value = 5;
}

void draw() {
  if (status == 0) {
    a.drawController();
  } else if (status == 1) {

    background(0);
    int i = gameObjects.size()-1;    
    while (i >=0 ) {


      GameObject obj = gameObjects.get(i);  
      obj.show();
      
      // seccion de tratamiento de la nave del jugador
      if (obj instanceof PlayerShip) {
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

      
      // seccion de colisiones

      if (obj.hasDied() ||obj.getPostion()[1] >height+40 || obj.getPostion()[1]<-40 || obj.getPostion()[0] <-40 ||obj.getPostion()[0]>width+40) gameObjects.remove(i);
      //println(gameObjects.size());
      i--;
    }
    if (count > 10) {
      count = 0;
    }
    count++;

    //jugador1.show();
    //jugador1.setPosition(1,0);
    //bala1.show();
    //bala1.movement(0,5);
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

//void mouseDragged(){
//  a.mouseD();
//  if(mouseButton==LEFT){
//    jugador1.setWeapon(new Weapon(5,0,-8));

//  }else{
//    jugador1.setWeapon(new Weapon(20,0,-4));

//  }

//  gameObjects.add(0,jugador1.shoot());

//}

void mousePressed() {
  //a.mouseP();
  if (mouseButton==LEFT) {
    jugador1.setWeapon(new Weapon(0, -8, 20,color(0,0,255),1));
  } else {
    jugador1.setWeapon(new Weapon(0, -4, 80,color(255,0,255),1));
  }
  gameObjects.add(0, jugador1.shoot());
}
