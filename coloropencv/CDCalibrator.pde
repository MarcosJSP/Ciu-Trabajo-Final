class CDCalibrator{
  Capture cam;
  
  float lowerHue = 63;
  float upperHue = 83;
  float lowerSat = 60;
  float upperSat = 130;
  float lowerVal = 80;
  float upperVal = 255;
  
  CDCalibrator(Capture cam){
    this.cam = cam;
  }
  
  Scalar getLowerHSV(){
    return new Scalar(lowerHue, lowerSat, lowerVal);
  }
  
  Scalar getUpperHSV(){
    return new Scalar(upperHue, upperSat, upperVal);
  }
  
}
