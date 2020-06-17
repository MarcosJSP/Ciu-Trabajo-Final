class SceneDrawer{
  
  PImage modal;
  PFont robotoRegular;
  SceneDrawer (){
    robotoRegular=createFont("./Assets/Fonts/Roboto-Regular.ttf", 16);
    modal = loadImage("./Assets/Card.png");
    // confirmButton = loadImage("./Assets/Confirm button.png");
  }
  
  void drawDebugScreen(CDController cdc) {
    PImage originalImg = cdc.getOriginalImage();
    if(originalImg == null) return;
    PImage filteredImg = cdc.getFilteredImage();
    Rect rect = cdc.getRecognizedRect();
    CDCalibrator calibrator = cdc.getCalibrator();
    push();
    translate(0, height/2-originalImg.height/2);
  
    //left
    image(filteredImg, 0, 0);
    translate(width/2, 0);
  
    //right
    image(originalImg, 0, 0);
    if (rect!=null) {
      noFill();
      stroke(250, 0, 0);
      rect(rect.x, rect.y, rect.width, rect.height);
    }
    pop();

    //paint modal color picker
    push();
    translate(width/2, 9*height/10);
    calibrator.draw();
    pop();
  }
  
  void drawIngameScreen(CDController cdc, MyButton confirmButton, MyButton quitButton) {
    PImage originalImg = cdc.getOriginalImage();
    if(originalImg == null) return;
    Rect rect = cdc.getRecognizedRect();
    CDCalibrator calibrator = cdc.getCalibrator();

    push();

    translate(width/2-originalImg.width/2, height/2-originalImg.height/2);
    //paint cam
    image(originalImg, 0, 0);

    //paint recognized color square
    if (rect!=null) {
      noFill();
      stroke(250, 0, 0);
      rect(rect.x, rect.y, rect.width, rect.height);
    }
    pop();

    //paint modal
    push();
    translate(width/2, 9*height/10);
    translate(-modal.width/2, -modal.height/2);

    //paint modal background
    image(modal, 0,0);

    //paint modal text
    push();
    textFont(robotoRegular, 16);
    fill(255);
    float tSize = 16;
    textSize(tSize);
    text("Selecciona el color a detectar",30,45+tSize/2/2);
    pop();

    //paint modal button
    push();
    translate(modal.width - 30 - confirmButton.w, confirmButton.h);
    confirmButton.draw();
    pop();

    //paint modal color picker
    push();
    translate(30,modal.height - 45);
    calibrator.draw();
    pop();

    pop();

    //paint quit button
    push();
    translate(width-quitButton.w-45,quitButton.h);
    quitButton.draw();
    pop();
  }

}
