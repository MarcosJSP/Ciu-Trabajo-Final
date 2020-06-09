class MyButton{
    PImage defaultState, pressedState, currentState;
    float h, w;
    private PVector pos;
    boolean isOverButton, locked;

    MyButton(PImage defaultState,PImage pressedState){
        this.defaultState = defaultState;
        this.pressedState = pressedState;
        this.currentState = this.defaultState;
        this.h = defaultState.height;
        this.w = defaultState.width;
        this.pos = new PVector(0,0);
        isOverButton = false;
        locked = false;
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

        if (locked){
            image(this.pressedState,0,0);
        }else{
            image(this.defaultState,0,0);
        }

        
    }

    boolean mousePressed(){
        if(isOverButton){
            locked = true;
        }else{
            locked = false;
        }
        println(locked);
        return locked;
    }

    boolean mouseReleased(){
        println(locked);
        if(isOverButton && locked){
            locked = false;
            return true;
        }else{
            locked = false;
            return false;
        }
    }

}
