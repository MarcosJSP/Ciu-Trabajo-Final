import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;

Capture cam;

CVImage img;

int R= 255;
int G= 0;
int B= 0;


void setup(){
  size(1280,720);
  cam = new Capture(this,width,height);
  cam.start();
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  img= new CVImage(cam.width,cam.height);
}

void draw(){
  if(cam.available()){
    cam.read();
    img.copy(cam, 0, 0, cam.width, cam.height,0, 0, img.width, img.height);
    img.copyTo();
    //Hacemos un filtro de bgr a Hsv
    Mat bgr = img.getBGR();
    Mat hsv = new Mat();
    Mat hsvBlur = new Mat();
    Imgproc.cvtColor(bgr,hsv,Imgproc.COLOR_BGR2HSV);
    Imgproc.medianBlur(hsv,hsvBlur,3);
    
    
    Core.inRange(hsvBlur,new Scalar(160,100,100),new Scalar(179,255,255),hsvBlur);
    img.copyTo(hsvBlur);
    
    image(img,0,0);

  }
}

Scalar rgb2hsv(int r, int g, int b){
  float [] hsv = new float[3];
  Color.RGBtoHSB(r,g,b,hsv);
  println(hsv[0]*255+" "+hsv[1]*255+" "+hsv[2]*255);
  return new Scalar(hsv[0]*255,hsv[1]*255,hsv[2]*255);
}
