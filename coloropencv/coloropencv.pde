import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;


int status;
Controller a;
Capture cam;

PlayerShip jugador1;
Bullet bala1;

ArrayList<GameObject> gameObjects;

void setup(){
  size(1280, 480, P3D);
  status = 1;
  //cam = new Capture(this, width/2, height);
  //a= new Controller(cam);
  gameObjects = new ArrayList<GameObject>();
  jugador1 = new PlayerShip(50,50);
  
  
  gameObjects.add(jugador1);
}

void draw(){
  if (status == 0) {
    a.drawController();
  } else if (status == 1) {
    background(0);
      int i = gameObjects.size()-1;    
      while (i >=0 ) {
        GameObject obj = gameObjects.get(i);  
        obj.show();
        if (i == gameObjects.size()-1) {
          obj.setPosition(mouseX,mouseY);
        }
        
        if (obj.hasDied() ||obj.getPostion()[1] >height+40 || obj.getPostion()[1]<-40 || obj.getPostion()[0] <-40 ||obj.getPostion()[0]>width+40) gameObjects.remove(i);
        println(gameObjects.size());
        i--;
      }
    
    
    //jugador1.show();
    //jugador1.setPosition(1,0);
    //bala1.show();
    //bala1.movement(0,5);
  }
  
}


void mouseDragged(){
  //a.mouseD();
  if(mouseButton==LEFT){
    jugador1.setWeapon(new Weapon(5,0,-8));
    
  }else{
    jugador1.setWeapon(new Weapon(20,0,-4));
    
  }
  
  gameObjects.add(0,jugador1.shoot());
  
}

void mousePressed() {
  //a.mouseP();
  
  
}
