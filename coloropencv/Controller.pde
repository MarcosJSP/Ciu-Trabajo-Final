import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;


class Controller {
  Capture cam;
  CVImage img, auximg;
  Rect recognizedRect = null;

  float lowerHue = 63;
  float upperHue = 83;
  float lowerSat = 60;
  float upperSat = 130;
  float lowerVal = 80;
  float upperVal = 255;
  Slider [] sliders;

  Controller(Capture cam) {
    this.cam=cam;
    cam.start();
    System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
    
    img = new CVImage(cam.width, cam.height);
    auximg=new CVImage(cam.width, cam.height);
    
    Slider lowerHueSlider = new Slider(200, 25, 0, 180, lowerHue, "lowerHue");
    Slider upperHueSlider = new Slider(200, 25, 0, 180, upperHue, "upperHue");
    Slider lowerSatSlider = new Slider(200, 25, 0, 255, lowerSat, "lowerSat");
    Slider upperSatSlider = new Slider(200, 25, 0, 255, upperSat, "upperSat");
    Slider lowerValSlider = new Slider(200, 25, 0, 255, lowerVal, "lowerVal");
    Slider upperValSlider = new Slider(200, 25, 0, 255, upperVal, "upperVal");

    sliders = new Slider []{lowerHueSlider, upperHueSlider, lowerSatSlider, upperSatSlider, lowerValSlider, upperValSlider};
  }
  
  void updateColorDetection(){
    if (!cam.available()) return;
      cam.read();
      img.copy(cam, 0, 0, cam.width, cam.height, 
        0, 0, img.width, img.height);
      auximg.copy(cam, 0, 0, cam.width, cam.height, 
        0, 0, img.width, img.height);
      img.copyTo();
      auximg.copyTo();

    //Cambiamos el filtro de bgr a Hsv
    Mat bgr = img.getBGR();
    Mat hsv = new Mat();
    Imgproc.cvtColor(bgr, hsv, Imgproc.COLOR_BGR2HSV);

    //Suavizamos la imagen en escala Hsv
    Mat hsvBlur = new Mat();
    Imgproc.medianBlur(hsv, hsvBlur, 3);

    //Resaltamos el color que nos interesa
    Mat hsvRange = new Mat();
    Scalar lower = new Scalar(lowerHue, lowerSat, lowerVal);
    Scalar upper = new Scalar(upperHue, upperSat, upperVal);
    Core.inRange(hsvBlur, lower, upper, hsvRange);

    //Erosionamos la imagen
    int erosion_size = 4;
    Mat hsvErode =  new Mat();
    Mat element = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new  Size(erosion_size, erosion_size));
    Imgproc.erode(hsvRange, hsvErode, element);
    
    //Dilatamos la imagen
    int dilation_size = 25;
    Mat hsvDilate =  new Mat();
    Mat element1 = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new  Size(dilation_size, dilation_size));
    Imgproc.dilate(hsvErode, hsvDilate, element1);
    
    //Hallamos la posición y el tamaño del objeto más grande identificado
    ArrayList<MatOfPoint> contours = new ArrayList<MatOfPoint>();
    Mat hsvContours = new Mat();
    Imgproc.findContours(hsvDilate, contours, hsvContours, 1, 1);
    if (contours.size() > 0) {
      Rect rect = Imgproc.boundingRect(contours.get(contours.size()-1));
      //println(rect.toString());
      Imgproc.rectangle(hsvDilate, rect, new Scalar(255, 0, 255), 5);
      contours.clear();
      setRecognizedRect(rect);
    } 

    //Finalmente actualizamos la imagen con los filtros
    img.copyTo(hsvDilate);
  }

  void drawController() {
    push();
    translate(0,height/2-img.height/2);
    scale(-1,1);//reversing x
    
    //left
    image(img, -img.width, 0);
    translate(-width/2,0);
    
    //right
    image(auximg,-img.width, 0);
    Rect rect = getRecognizedRect();
    if(rect!=null){
      noFill();
      stroke(250,0,0);
      rect(-img.width+rect.x, rect.y, rect.width, rect.height);
    }
    pop();
    drawSliders();
  }

  void drawSliders() {
    for (int i = 0; i < sliders.length; i++) {
      sliders[i].draw();
      translate(0, sliders[i].h);
    }
  }

  void updateHue(Color rgb) {
    float [] hsv = Color.RGBtoHSB(rgb.getRed(), rgb.getGreen(), rgb.getBlue(), null);
    float hue = hsv[0] * 180;
    lowerHue = hue - 10;
    upperHue = hue + 10;
  }
  
  void setRecognizedRect(Rect rect){
    this.recognizedRect = rect;
  }
  
  Rect getRecognizedRect(){
    return this.recognizedRect;
  }

  void mouseD() {
    for (int i = 0; i < sliders.length; i++) {
      sliders[i].mouseDragged();
    }
    lowerHue = sliders[0].getVal();
    upperHue = sliders[1].getVal();
    lowerSat = sliders[2].getVal();
    upperSat = sliders[3].getVal();
    lowerVal = sliders[4].getVal();
    upperVal = sliders[5].getVal();
  }

  void mouseP() {
    if (mouseButton == RIGHT) {
      //colorMode(HSB,255);
      color c = get(mouseX, mouseY);
      int hue = int(map(hue(c), 0, 255, 0, 180));
      lowerHue = hue - 10;
      upperHue = hue + 10;
      if (lowerHue < 0) lowerHue = 180 + lowerHue;
      //if (upperHue > 180) upperHue = upperHue - 180;
      sliders[0].setValue(lowerHue);
      sliders[1].setValue(upperHue);
    }
  }
}
