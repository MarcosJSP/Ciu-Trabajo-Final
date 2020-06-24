class Mejora extends GameObject{
  int i;
  int nTiros = 32;
  String tipoMejora;
  Mejora(String type, int nTiros, String tipoMejora, float x, float y, float vel, float acc, float angle) {
    
    super(null, type, x, y, vel, acc, angle);
    this.nTiros = nTiros;
    this.tipoMejora = tipoMejora;
    switch(tipoMejora){
      case "Triple":
        this.asset = mejoraTriple;
        this.i = 1;
        break;
      case "Serpiente":
        this.asset = mejoraSerpiente;
        this.i = 2;
        break;
      case "Limon":
        this.asset = mejoraLimon;
        this.i = 3;
        break;
     } 
    this.objectSize[0] = this.asset.width;
    this.objectSize[1] = this.asset.height;
    this.setimageRotation(imageRotation+180);
    this.hitBox = new hitBox(this.objectSize[0], this.objectSize[1]);
    this.hitBox.rotateHitBox(imageRotation);
    this.lifeTimer = 200;
    this.hitBox_flag = true;
  }

  void usarMejora(PlayerShip nave){
    nave.changeWeaponT(i,nTiros);
  }
}
