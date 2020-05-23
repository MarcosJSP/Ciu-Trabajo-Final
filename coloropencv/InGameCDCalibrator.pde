class InGameCDCalibrator extends CDCalibrator {
  ColorPicker cp;
  InGameCDCalibrator(){
    cp = new ColorPicker(500,25);
  }
  
  void draw(){
    push();
    translate(width/2-cp.w/2, 9*height/10-cp.h/2);
    cp.draw();
    pop();
  }
  
  void mouseDragged(){
    cp.mouseDragged();
    color c = cp.getSelectedColor();
    int hue = int(map(hue(c), 0, 255, 0, 180));
    lowerHue = hue - 5;
    upperHue = hue + 5;
  }
}
