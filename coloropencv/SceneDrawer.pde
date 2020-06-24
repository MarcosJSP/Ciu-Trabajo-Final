class SceneDrawer{
  
  PImage modal, thiccckModal, semitransparentBackground;
  PFont robotoRegular, robotoBold;

  SceneDrawer (){
    robotoRegular=createFont("./Assets/Fonts/Roboto-Regular.ttf", 16);
    robotoBold=createFont("Verdana Bold", 54);
    modal = loadImage("./Assets/Images/Card.png");
    thiccckModal = loadImage("./Assets/Images/Thiccck card.png");
    semitransparentBackground = loadImage("./Assets/Images/Transparent background.png");
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

  void gameEndScreen(CDController cdc, MyButton playAgainButton, MyButton quitButton, Boolean victory) {
    PImage originalImg = cdc.getOriginalImage();
    if(originalImg == null) return;
    Rect rect = cdc.getRecognizedRect();
    CDCalibrator calibrator = cdc.getCalibrator();

    //paint modal
    push();
    
    //paint background transparency
    image(semitransparentBackground,0,0);

    translate(width/2, height/2);
    translate(-thiccckModal.width/2, - thiccckModal.height/2);

    //paint modal background
    image(thiccckModal, 0,0);

    push();
    float tSize = 54;
    textFont(robotoBold, tSize);
    textSize(tSize);
    if (victory){
      fill(67,245,109);
      text("Victoria", thiccckModal.width/2 - textWidth("Victoria")/2,thiccckModal.height/2-5);
    }else{
      fill(245,67,67);
      text("Derrota", thiccckModal.width/2 - textWidth("Derrota")/2,thiccckModal.height/2-5);
    }
    pop();
    
    int midSeparation = 15;

    push();
    translate(thiccckModal.width/2 - playAgainButton.w - midSeparation, thiccckModal.height/2+quitButton.h);
    quitButton.draw();
    pop();

    push();
    translate(thiccckModal.width/2 + midSeparation, thiccckModal.height/2+playAgainButton.h);
    playAgainButton.draw();
    pop();


    pop();

  }

}
