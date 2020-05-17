import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;


Capture cam;
PImage test;
CVImage img,auximg;
ArrayList<MatOfPoint> contours = new ArrayList<MatOfPoint>();

float lowerHue = 63;
float upperHue = 83;
float lowerSat = 60;
float upperSat = 130;
float lowerVal = 80;
float upperVal = 255;

Slider [] sliders;

void setup(){
  size(1280,480,P3D);
  cam = new Capture(this,width/2,height);
  cam.start();
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  test = cam;
  img = new CVImage(test.width,test.height);
  auximg=new CVImage(cam.width, cam.height);
  Slider lowerHueSlider = new Slider(200,50, 0, 180, lowerHue, "lowerHue");
  Slider upperHueSlider = new Slider(200,50, 0, 180, upperHue, "upperHue");
  Slider lowerSatSlider = new Slider(200,50, 0, 255, lowerSat, "lowerSat");
  Slider upperSatSlider = new Slider(200,50, 0, 255, upperSat, "upperSat");
  Slider lowerValSlider = new Slider(200,50, 0, 255, lowerVal, "lowerVal");
  Slider upperValSlider = new Slider(200,50, 0, 255, upperVal, "upperVal");
  
  
  sliders = new Slider []{lowerHueSlider,upperHueSlider,lowerSatSlider, upperSatSlider, lowerValSlider, upperValSlider}; 
}

void draw(){
  if (cam.available()) {
    cam.read();
    
    img.copy(cam, 0, 0, cam.width, cam.height, 
        0, 0, img.width, img.height);
    img.copyTo();

     auximg.copy(cam, 0, 0, cam.width, cam.height, 
        0, 0, img.width, img.height);
     auximg.copyTo();

    
  }
  
  //Hacemos un filtro de bgr a Hsv
  Mat bgr = img.getBGR();
  Mat hsv = new Mat();
  Imgproc.cvtColor(bgr,hsv,Imgproc.COLOR_BGR2HSV);
  
  //Suavizamos la imagen en escala Hsv
  Mat hsvBlur = new Mat();
  Mat hsvRange = new Mat();
  Mat hsvContours = new Mat();
  Mat hsvErode =  new Mat();
  Mat hsvDilate =  new Mat();
  Imgproc.medianBlur(hsv,hsvBlur,3);
  
  //Resaltamos el color que nos interesa
  //updateHue(new Color(252,78,129));
  Scalar lower = new Scalar(lowerHue, lowerSat, lowerVal);
  Scalar upper = new Scalar(upperHue, upperSat, upperVal);
  Core.inRange(hsvBlur,lower,upper, hsvRange);
  
  int erosion_size = 4;
  int dilation_size = 25;
     
  Mat element = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new  Size(erosion_size , erosion_size));
  
  Imgproc.erode(hsvRange,hsvErode,element);
  
  Mat element1 = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new  Size(dilation_size , dilation_size));
  
  Imgproc.dilate(hsvErode,hsvDilate,element1);
  
  Rect rect = null;
  Imgproc.findContours(hsvDilate,contours,hsvContours,1,1);
  if (contours.size() > 0) {
    rect = Imgproc.boundingRect(contours.get(contours.size()-1));
    println(rect.toString());
    Imgproc.rectangle(hsvDilate,rect,new Scalar(255,0,255),5);
    contours.clear();
  } 
  
  img.copyTo(hsvDilate);
  image(img,0,0);
  image(auximg, width/2, 0);
  drawSliders();
}


void drawSliders(){
  for(int i = 0; i < sliders.length; i++){
    sliders[i].draw();
    translate(0,50);
  }
}

void mouseDragged(){
  for(int i = 0; i < sliders.length; i++){
    sliders[i].mouseDragged();
  }
  lowerHue = sliders[0].getVal();
  upperHue = sliders[1].getVal();
  lowerSat = sliders[2].getVal();
  upperSat = sliders[3].getVal();
  lowerVal = sliders[4].getVal();
  upperVal = sliders[5].getVal();
  
}

// MAYBE BORRAR
void updateHue(Color rgb){
  float [] hsv = Color.RGBtoHSB(rgb.getRed() ,rgb.getGreen(),rgb.getBlue(),null);
  float hue = hsv[0] * 180;
  lowerHue = hue - 10;
  upperHue = hue + 10;
}


void mousePressed() {
  if (mouseButton == RIGHT) {
    //colorMode(HSB,255);
    color c = get(mouseX,mouseY);
    int hue = int(map(hue(c),0,255,0,180));
    lowerHue = hue - 10;
    upperHue = hue + 10;
    if (lowerHue < 0) lowerHue = 180 + lowerHue;
    //if (upperHue > 180) upperHue = upperHue - 180;
    sliders[0].setValue(lowerHue);
    sliders[1].setValue(upperHue);
    
  }
}
