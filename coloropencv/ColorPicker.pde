class ColorPicker{
  private int w, h;
  private PImage colorBand;
  private PVector pos;
  private int selectedPos = 0;
  private int selectedColor;
  
  ColorPicker(int w, int h){
    this.w = w;
    this.h = h;
    this.colorBand = loadImage("colorBand.png");
    this.colorBand.resize(this.w, this.h);
    this.selectedColor = this.colorBand.get(0,0);
  }
  
  public void draw(){
    pos = new PVector(modelX(0, 0, 0), modelY(0, 0, 0));
    pushMatrix();
    pushStyle();
    image(colorBand,0,0);
    
    translate(this.selectedPos,this.h/2);
    
    stroke(0);
    fill(250);
    circle(0,0,30);
    
    fill(getSelectedColor());
    circle(0,0,25);
    
    popStyle();
    popMatrix();
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
