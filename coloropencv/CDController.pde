import processing.video.*;
import java.lang.*;
import cvimage.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.*;
import java.awt.Color;


class CDController {
  Capture cam;
  PImage lastCamFrame=null;
  CVImage img, auximg;
  Rect recognizedRect = null;
  
  CDCalibrator cdCalibrator;
  CDController(Capture cam, CDCalibrator cdCalibrator) {
    this.cam=cam;
    this.cdCalibrator = cdCalibrator;
    cam.start();
    System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

    img = new CVImage(cam.width, cam.height);
    auximg=new CVImage(cam.width, cam.height);
  }

  PImage mirrorImage(PImage img) {
    PImage mirrorImg = createImage(img.width, img.height, ARGB);

    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        mirrorImg.set(img.width-x-1, y, img.get(x, y));
      }
    }

    return mirrorImg;
  }

  void updateColorDetection() {
    lastCamFrame = mirrorImage(cam);
    img.set(0,0,lastCamFrame);
    img.copyTo();

    //Cambiamos el filtro de bgr a Hsv
    Mat mat = img.getBGR();
    Imgproc.cvtColor(mat, mat, Imgproc.COLOR_BGR2HSV);

    //Suavizamos la imagen en escala Hsv
    Imgproc.medianBlur(mat, mat, 3);

    //Resaltamos el color que nos interesa
    Scalar lowerHSV = cdCalibrator.getLowerHSV();
    Scalar upperHSV = cdCalibrator.getUpperHSV();
    Core.inRange(mat, lowerHSV, upperHSV, mat);

    //Erosionamos la imagen
    int erosion_size = 4;
    Mat element = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new  Size(erosion_size, erosion_size));
    Imgproc.erode(mat, mat, element);

    //Dilatamos la imagen
    int dilation_size = 30;
    Mat element1 = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new  Size(dilation_size, dilation_size));
    Imgproc.dilate(mat, mat, element1);

    //Hallamos la posición y el tamaño del objeto más grande identificado
    ArrayList<MatOfPoint> contours = new ArrayList<MatOfPoint>();
    Imgproc.findContours(mat, contours, mat, 1, 1);
    if (contours.size() > 0) {
      Rect lastRect = getRecognizedRect();
      if(lastRect==null){
          Rect rect = Imgproc.boundingRect(contours.get(contours.size()-1));
          setRecognizedRect(rect);
          Imgproc.rectangle(mat, rect, new Scalar(255, 0, 255), 5);
        }else{
          for(int i=0; i < contours.size();i++){
              Rect rect = Imgproc.boundingRect(contours.get(contours.size()-1- i));
              int error = 10;
              rect.x -= error; rect.y -= error;
              rect.width += error; rect.height += error;
              
              if(checkOverlap(lastRect, rect)) {
                setRecognizedRect(rect);
                Imgproc.rectangle(mat, rect, new Scalar(255, 0, 255), 5);
                break;
              }else if(i+1 >= contours.size()){
                setRecognizedRect(null);
              }
          }
      }
      contours.clear();
      
    } else {
      setRecognizedRect(null);
    }

    //Finalmente actualizamos la imagen con los filtros
    img.copyTo(mat);
  }
  
  void draw() {
    push();
    translate(0, height/2-img.height/2);

    //left
    image(img, 0, 0);
    translate(width/2, 0);

    //right
    //image(auximg, 0, 0);
    image(lastCamFrame, 0,0);
    Rect rect = getRecognizedRect();
    if (rect!=null) {
      noFill();
      stroke(250, 0, 0);
      rect(rect.x, rect.y, rect.width, rect.height);
    }
    pop();
  }

  void setRecognizedRect(Rect rect) {
    this.recognizedRect = rect;
  }

  Rect getRecognizedRect() {
    return this.recognizedRect;
  }
  
  PImage getOriginalImage(){
    return lastCamFrame;
  }
  
  PImage getFilteredImage(){
    return img;
  }
  
  CDCalibrator getCalibrator(){
    return cdCalibrator;
  }
  
  boolean ready(){
    return 
      cdCalibrator != null
      && lastCamFrame != null
      && img != null;
  }
  
  boolean checkOverlap(Rect a, Rect b){
    return a.x < b.x + b.width &&  a.x+a.width > b.x &&
            a.y < b.y + b.height  && b.y < a.y + a.height;
  }

}
