import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;


int status;
DebugCDCalibrator debugCDCalibrator;
CDController cdController;

Capture cam;

NaveJugador jugador1;
Bullet bala1;

ArrayList<GameObject> gameObjects;

void setup() {
  size(1280, 720, P3D);
  status = 0;
  cam = new Capture(this, 1280/2, 480);

  debugCDCalibrator = new DebugCDCalibrator();

  cdController = new CDController(cam, debugCDCalibrator);
  gameObjects = new ArrayList<GameObject>();
  jugador1 = new NaveJugador(50, 50);
  bala1 = new Bullet(50, 20, 10);
  gameObjects.add(bala1);
  gameObjects.add(jugador1);
}

void draw() {
  background(200);
  cdController.updateColorDetection();

  if (status == 0) {
    drawDebugScreen();
  } else if (status == 1) {
    
  } else if (status == 2) {
    background(0);
    int i = gameObjects.size()-1;    
    while (i >=0 ) {
      GameObject obj = gameObjects.get(i);  
      obj.show();
      if (obj.hasDied()) gameObjects.remove(i);
      i--;
    }


    //jugador1.show();
    //jugador1.setPosition(1,0);
    //bala1.show();
    //bala1.movement(0,5);
  }
  println("Frames: " + frameRate);
}

void drawDebugScreen() {
  PImage originalImg = cdController.getOriginalImage();
  PImage filteredImg = cdController.getFilteredImage();
  Rect rect = cdController.getRecognizedRect();
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
  debugCDCalibrator.draw();
}


void mouseDragged() {
  debugCDCalibrator.mouseDragged();
}

void mousePressed() {
  debugCDCalibrator.mousePressed();
}
