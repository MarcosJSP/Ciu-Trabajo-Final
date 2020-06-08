abstract class GameObject {
  
  float x,y,vx,vy,objectSize;
  boolean playerObject=false;
  boolean bulletObject=false;
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
  
  void setPlayerObject(boolean option){
    playerObject=option;
  }
  
  boolean getPlayerObject(){
    return playerObject;
  }
  
  boolean getBulletObject(){
    return bulletObject;
  }
  
  Bullet shoot(){
    return null;
  }
  
  
  boolean hasDied(){
    return false;
  }
   
}
