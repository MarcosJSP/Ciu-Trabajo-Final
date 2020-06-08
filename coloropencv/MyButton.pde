class MyButton{
    PImage defaultState, pressedState, currentState;
    float h, w;
    private PVector pos;
    boolean isOverButton;

    MyButton(PImage defaultState,PImage pressedState){
        this.defaultState = defaultState;
        this.pressedState = pressedState;
        this.currentState = this.defaultState;
        this.h = defaultState.height;
        this.w = defaultState.width;
        this.pos = new PVector(0,0);
        isOverButton = false;
    }

    void draw(){
        pos = new PVector(modelX(0, 0, 0), modelY(0, 0, 0));
        if(
        mouseX > pos.x && mouseX < (pos.x + this.w) &&
        mouseY > pos.y && mouseY < (pos.y + this.h)
        ){
            isOverButton=true;
        }else{
            isOverButton=false;
        }

        image(this.currentState,0,0);
    }

    boolean mousePressed(){
        if(isOverButton){
            this.currentState = pressedState;
        }
        return isOverButton;
    }

    boolean mouseReleased(){
        if(!isOverButton){
            this.currentState = defaultState;
        }
        print("esta pressed? - " + isOverButton);
        return isOverButton;
    }

}
