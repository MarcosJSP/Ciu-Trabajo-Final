abstract class GameObject {
  
  float x,y,vx,vy,objectSize;
  
  GameObject() {
  }

  void show(){ 
  }
  
  void setPosition(float x,float y){
  }
  
  float getSize () {
    return 0;
  }
  
  float[] getPostion(){
    float [] result= {this.x,this.y};
    return result;
  }
  
  void movement(float vx, float vy){
    
    this.vx = vx;
    this.vy = vy;
  }
  
  Bullet shoot(){
    return null;
  }
  
  
  boolean hasDied(){
    return false;
  }
   
}
