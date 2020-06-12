class DebugCDCalibrator extends CDCalibrator {
  
  Slider [] sliders;
  
  DebugCDCalibrator(){
    super();
    Slider lowerHueSlider = new Slider(200, 25, 0, 180, lowerHue, "lowerHue");
    Slider upperHueSlider = new Slider(200, 25, 0, 180, upperHue, "upperHue");
    Slider lowerSatSlider = new Slider(200, 25, 0, 255, lowerSat, "lowerSat");
    Slider upperSatSlider = new Slider(200, 25, 0, 255, upperSat, "upperSat");
    Slider lowerValSlider = new Slider(200, 25, 0, 255, lowerVal, "lowerVal");
    Slider upperValSlider = new Slider(200, 25, 0, 255, upperVal, "upperVal");

    sliders = new Slider []{lowerHueSlider, upperHueSlider, lowerSatSlider, upperSatSlider, lowerValSlider, upperValSlider};
  }
  
  void draw() {
    //draw sliders
    for (int i = 0; i < sliders.length; i++) {
      sliders[i].draw();
      translate(0, sliders[i].h);
    }
  }
  
  void mouseDragged() {
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

  void mousePressed() {
    if (mouseButton == RIGHT) {
      color c = get(mouseX, mouseY);
      int hue = int(map(hue(c), 0, 255, 0, 180));
      lowerHue = hue - error;
      upperHue = hue + error;
      sliders[0].setValue(lowerHue);
      sliders[1].setValue(upperHue);
    }
  }
}
