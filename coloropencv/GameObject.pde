abstract class GameObject {
  
  float x,y,dx,dy,vx,vy;
  
  GameObject() {
  }

  void show(){ 
  }
  
  void setPosition(){
  }  
  
  void movement(int vx, int vy){
    this.vx = vx;
    this.vy = vy;
  }
  
  boolean hasDied(){
    return false;
  }
   
}
