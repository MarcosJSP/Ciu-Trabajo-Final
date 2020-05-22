import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;



Controller a=null;
Capture cam;

void setup(){
  size(1280, 480, P3D);
  cam = new Capture(this, width/2, height);
  a= new Controller(cam);
}

void draw(){
  a.drawController();
}


void mouseDragged(){
  a.mouseD();
}

void mousePressed() {
  a.mouseP();  
}
