class Slider{
  float w, h, val, min, max;
  PVector pos;
  String title;
  
  Slider(float w, float h, float min, float max, float val, String title){
    this.w = w;
    this.h = h;
    this.val = val;
    this.min = min;
    this.max = max;
    this.title = title;
  }
  
  void draw(){
    pos = new PVector(modelX(0, 0, 0), modelY(0, 0, 0));
    fill(250);
    rect(0,0,w,h);
    fill(200);
    rect(0,0,map(this.val, this.min, this.max, 0, w),h);
    fill(0);
    textSize(this.h/2);
    text(this.title + " " +this.val,0,this.h/2);  
  }
  
  float getVal(){
    return this.val;
  }
  
  void setValue(float val) {
    this.val = val;
  }
     
  void mouseDragged(){
    if(
      mouseX > pos.x && mouseX < (pos.x + this.w) &&
      mouseY > pos.y && mouseY < (pos.y + this.h)
    ){
      println(mouseX-pos.x);
      this.val = map(mouseX - pos.x, 0, this.w, this.min, this.max );
      //println(this.val);
    }
  }
}
