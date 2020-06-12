class CDCalibrator{  
  float lowerHue = 63;
  float upperHue = 83;
  float lowerSat = 60;
  float upperSat = 130;
  float lowerVal = 80;
  float upperVal = 255;
  float error = 5;
  
  CDCalibrator(){
  }
  
  Scalar getLowerHSV(){
    return new Scalar(lowerHue, lowerSat, lowerVal);
  }
  
  Scalar getUpperHSV(){
    return new Scalar(upperHue, upperSat, upperVal);
  }
  
  void draw(){
  }
  
  void mouseDragged(){
  }
  
  void mousePressed() {
  }
  
}
