abstract class GameObject {
  
  float x,y,dx,dy,vx,vy;
  
  GameObject() {
  }

  void show(){ 
  }
  
  void setPosition(float x,float y){
  }
  
  float[] getPostion(){
    float [] result= {this.x,this.y};
    return result;
  }
  
  void movement(float vx, float vy){
    this.vx = vx;
    this.vy = vy;
  }
  
  boolean hasDied(){
    return false;
  }
   
}
