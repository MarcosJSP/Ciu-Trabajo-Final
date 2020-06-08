class ColorPicker{
  private int w, h;
  private PImage colorBand;
  private PVector pos;
  private int selectedPos = 0;
  private int selectedColor;
  
  ColorPicker(){
    this.colorBand = loadImage("./Assets/Color Picker.png");
    this.w = colorBand.width;
    this.h = colorBand.height;
    // this.colorBand.resize(this.w, this.h);
    this.selectedColor = this.colorBand.get(0,0);
  }
  
  public void draw(){
    push();
    // translate(-this.w/2, -this.h/2);
    pos = new PVector(modelX(0, 0, 0), modelY(0, 0, 0));
    image(colorBand,0,0);
    
    translate(this.selectedPos,this.h/2);
    
    // stroke(0);
    // fill(250,);
    // circle(0,0,30);
    stroke(255,255,255);
    fill(getSelectedColor());
    circle(0,0,25);
    
    pop();
  }
  
  public color getSelectedColor(){
    return color(this.selectedColor);
  }
  
  void mouseDragged(){
    if(
      mouseX > pos.x && mouseX < (pos.x + this.w) &&
      mouseY > pos.y && mouseY < (pos.y + this.h)
    ){
      this.selectedPos = round(mouseX-pos.x);
      this.selectedColor = this.colorBand.get(selectedPos,0);
    }
  }
  
}
