class InGameCDCalibrator extends CDCalibrator {
  ColorPicker cp;
  InGameCDCalibrator(){
    cp = new ColorPicker();
  }
  
  void draw(){
    cp.draw();
  }
  
  void mouseDragged(){
    cp.mouseDragged();
    color c = cp.getSelectedColor();
    int hue = int(map(hue(c), 0, 255, 0, 180));
    lowerHue = hue - 5;
    upperHue = hue + 5;
  }
}
