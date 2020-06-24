class Juego{
  private ArrayList <Nivel> listaNiveles = new ArrayList <Nivel>();
  
  Juego(){}
  
  public void ejecutar(int i){
    listaNiveles.get(i).ejecutar();
  }
  
  //Por hacer: cargar mensaje
  public void cargarNivelesPredeterminados(){
    this.listaNiveles.add(nivel_1());
    this.listaNiveles.add(nivel_2());
    //this.listaNiveles.add(nivel_3());
  }
  
  public void cargarNivel(Nivel a){
    this.listaNiveles.add(a);
  }
  
  public void quitarNivel(int i){
    try{
      this.listaNiveles.remove(i);
    }catch(IndexOutOfBoundsException e){
      println("Error: indice introducido en reiniciarNivel() produce el error IndexOutOfBoundsException -" + e); 
    }catch(Exception e){
      println(e);
    }
  }
  
  //FabricaNaves -> (int nEjecuciones, int numeroNaves, float inicialX, float inicialY, float vel, float acc, 
  //float dir, int hitPoints, String tipoEscuadron, String tipoNave, String tipoArma, PImage imagen){
    
  private Nivel nivel_1(){
    FabricaNaves fabrica1 = new FabricaNaves  (1, 6,  width/2.0,           -100,      2.0, 0.1, GameObject.bot,   GameObject.bot,   3, "flecha",               "normal",    "normal",    shipI1);
    FabricaNaves fabrica2 = new FabricaNaves  (1, 6,  100,               height+100,  3.0, 0.0, GameObject.top,   GameObject.top,   3, "lineaRectaHorizontal", "normal",    "triple",    shipI1);
    FabricaNaves fabrica3 = new FabricaNaves  (1, 6,  200,               height+100,  2.0, 0.0, GameObject.top,   GameObject.right, 3, "lineaRectaVertical",   "normal",    "normal",   shipI1);
    FabricaNaves fabrica4 = new FabricaNaves  (1, 6,  -100,              height-200,  0.5, 1, GameObject.right,   GameObject.right, 3, "lineaInclinadaIzq",    "serpiente", "normal",    shipI1);
    FabricaNaves fabrica5 = new FabricaNaves  (1, 6,  width+100,         height-100,  3.0, 0.1, GameObject.left,  GameObject.left,  3, "lineaInclinadaDer",    "normal",    "serpiente", shipI1);
    FabricaNaves boss     = new FabricaNaves  (1, 1,  width/2.0, 50, 2.0, 0.1, GameObject.right, GameObject.bot, 100, "boss", "rebote", "serpiente", bossI);
    FabricaNaves mejora   = new FabricaMejoras(1, 1, width+100, height/2, 0.0, 0.0, GameObject.left, "Triple", "normal");
    FabricaNaves mejora2  = new FabricaMejoras(1, 1, - 200, height/2-100, 5.0, 0.0, GameObject.right, "Serpiente", "rebote");
    FabricaNaves mejora3  = new FabricaMejoras(1, 1, (width/2.0), -100, 5.0, 0.0, GameObject.bot, "Limon", "normal");
    
    Flota e1 = new Flota(5);
    Flota e2 = new Flota(3);
    Flota e3 = new Flota(4);
    Flota e4 = new Flota(10);
    Flota m1 = new Flota(3);
    Flota m2 = new Flota(3);
    Flota m3 = new Flota(3);
    
    e1.addFabrica(fabrica1);
    e1.addFabrica(fabrica2);
    e1.addFabrica(fabrica3);
    
    e2.addFabrica(fabrica4);
    e2.addFabrica(fabrica5);
    e2.addFabrica(fabrica2);
    
    e3.addFabrica(fabrica1);
    e3.addFabrica(fabrica4);
    e3.addFabrica(fabrica3);
    
    e4.addFabrica(boss);
    
    m1.addFabrica(mejora);
    m2.addFabrica(mejora2);
    m3.addFabrica(mejora3);
    
    Fase fase1 = new Fase(3);
    Fase fase2 = new Fase(3);
    Fase fase3 = new Fase(3);
    Fase fase4 = new Fase(3);
    
    fase1.addFlota(e1);
    fase1.addFlota(e2);
    fase1.addFlota(m2);
    fase1.addFlota(e3);
    fase1.addFlota(m1);
    fase1.addFlota(e2);
    fase1.addFlota(e1);
    fase1.addFlota(e1);
    
    
    fase2.addFlota(e3);
    fase2.addFlota(e2);
    fase2.addFlota(e1);
    fase2.addFlota(m2);
    fase2.addFlota(e3);
    fase2.addFlota(e2);
    fase2.addFlota(m3);
    fase2.addFlota(e3);
    fase2.addFlota(e2);
    
    fase3.addFlota(e2);
    fase3.addFlota(e1);
    fase3.addFlota(m1);
    fase3.addFlota(e3);
    fase3.addFlota(m3);
    fase3.addFlota(e2);
    fase3.addFlota(e3);
    fase3.addFlota(m2);
    fase3.addFlota(e2);
    
    fase4.addFlota(e4);
    fase4.addFlota(m1);
    fase4.addFlota(m2);
    fase4.addFlota(m3);
    
    Nivel nivel_1 = new Nivel();
    nivel_1.addFase(fase1);
    nivel_1.addFase(fase2);
    nivel_1.addFase(fase3);
    nivel_1.addFase(fase4);
    return nivel_1;
  }
  
  
  private Nivel nivel_2(){
    FabricaNaves boss = new FabricaNaves(1, 1,  width/2.0, 50, 2.0, 0.1, GameObject.right, GameObject.bot, 100, "boss", "rebote", "serpiente", bossI);
    //int nEjecuciones, int numeroNaves, float inicialX, float inicialY, float vel, float acc, float dir, String tipoMejora, String tipoMov
    FabricaNaves mejora = new FabricaMejoras(1, 1, width/2.0, height/2-100, 0.0, 0.0, GameObject.bot, "Triple", "normal");
    FabricaNaves mejora2 = new FabricaMejoras(1, 1, (width/2.0) + 200, height/2-100, 5.0, 0.0, GameObject.right, "Serpiente", "rebote");
    FabricaNaves mejora3 = new FabricaMejoras(1, 1, (width/2.0) - 200, height/2-100, 10.0, 5.0, GameObject.bot, "Limon", "normal");

    Flota e1 = new Flota(0);
    Fase f1 = new Fase(1);
    Nivel nivel1 = new Nivel();
    
    e1.addFabrica(boss);
    e1.addFabrica(mejora2);
    e1.addFabrica(mejora3);
    f1.addFlota(e1);
    nivel1.addFase(f1);
    
    return nivel1;
  }
  
  /*
  private Nivel nivel_3(){
    
  }
  */
}



class Nivel{
  ArrayList <Fase> fases = new ArrayList <Fase>();
  
  Nivel(){}
  
  public void ejecutar(){
    for(Fase fase : this.fases){
      fase.ejecutarFase();
    }
  }
  
  public void addFase(Fase f){
    this.fases.add(f);
  }
  
  void eliminarFase(int i){
    this.fases.remove(i);
  }
}

class Fase{
  ArrayList <Flota> listaFlotas = new ArrayList <Flota>(); 
  int waitBeforeStart = 1;
  
  Fase(int i){
    this.waitBeforeStart = i;
  }
  
  void ejecutarFase(){
    for(Flota e : listaFlotas){
      for(int i = 0; i<e.maxEjecuciones ; i++){
        e.ejecutar(i);
        count(this.waitBeforeStart); 
      }
    }
  }
  
  void addFlota(Flota escuadron){
    this.listaFlotas.add(escuadron);

  }
  
  void eliminarFlota(int i){
    this.listaFlotas.remove(i);
  }
}

class Flota{
    private ArrayList <FabricaNaves> listaFabricas = new ArrayList <FabricaNaves>();
    private int maxEjecuciones = 0;
    private int waitBeforeStart = 3;
    Flota (FabricaNaves [] lista, int i){
      addLista(lista);
      this.waitBeforeStart = i;
    }
    
    Flota(int i){
      this.waitBeforeStart = i;
    }
    
    public void addLista(FabricaNaves [] lista){
      for(FabricaNaves fabrica : lista){
        addFabrica(fabrica);
      }
    }
    
    public ArrayList <FabricaNaves> getLista(){
      return this.listaFabricas;  
      
    }
    
    public void addFabrica(FabricaNaves fabrica){
      if(fabrica.nEjecuciones > this.maxEjecuciones){
          this.maxEjecuciones = fabrica.nEjecuciones;
      }
      this.listaFabricas.add(fabrica);
    }
    
    public void ejecutar(int contador){
      for(FabricaNaves f : this.listaFabricas){
        if((f.getNejecuciones() - contador) > 0){
          f.crearEscuadron();
          if (f instanceof FabricaMejoras){
            println("hola2");
          }
          count(waitBeforeStart);
        }
      }
    }
}

void count(int i){
  long seconds = i;
  //Pasamos de segundos a minutos
  seconds *= 1000;
  try{
    Thread.sleep(seconds);
  }catch (Exception e){
    println(e);
  }
}

class FabricaNaves{
  protected int nEjecuciones = 1;
  protected int numeroNaves, hitPoints;
  protected float inicialX, inicialY;
  protected float dir;
  protected String tipoEscuadron, tipoNave, tipoArma;
  protected float vel, acc;
  protected PImage asset;
  protected float offsetX = 0;
  protected float offsetY = 0;
  protected float frequency = 2500;
  protected int damage = 1;
  protected PImage bulletI = bulletB;
  protected float dirShoot;
  
  FabricaNaves(int nEjecuciones, int numeroNaves, float inicialX, float inicialY, float vel, float acc, float dir, float dirShoot, int hitPoints, String tipoEscuadron, String tipoNave, String tipoArma, PImage imagen){
    this.numeroNaves = numeroNaves;
    this.inicialX = inicialX;
    this.inicialY = inicialY;
    this.dir = dir;
    this.tipoEscuadron = tipoEscuadron;
    this.tipoNave = tipoNave;
    this.vel = vel;
    this.acc = acc;
    this.hitPoints = hitPoints;
    this.asset = imagen;
    this.offsetX = imagen.width;
    this.offsetY = imagen.height;
    this.tipoArma = tipoArma;
    this.nEjecuciones = nEjecuciones;
    this.dirShoot = dirShoot;
  }
  
  FabricaNaves(int nEjecuciones, int numeroNaves, float inicialX, float inicialY, float vel, float acc, float dir, String tipoMov){
    this.numeroNaves = numeroNaves;
    this.inicialX = inicialX;
    this.inicialY = inicialY;
    this.dir = dir;
    this.vel = vel;
    this.acc = acc;
    this.nEjecuciones = nEjecuciones;
    this.tipoNave = tipoMov;
  }
  
  void setOffsetX(float offsetX, float offsetY){
    this.offsetX = offsetX;
    this.offsetY = offsetY;
  }
  
  int getNejecuciones(){
    return this.nEjecuciones; 
  }
  
  void crearEscuadron(){
    switch(this.tipoEscuadron){
      case "lineaRectaHorizontal":
        println("Localizacion X: " + inicialX + "  Localizacion Y: " + inicialY);
        for(int i = 0; i < numeroNaves ; i++){
          crearNave(offsetX*i, 0);
          println("Nave "+i + "-> offsetX: " + offsetX*i + " -- offsetY: " + 0);
        }
        break;
      
      case "lineaRectaVertical":
        for(int i = 0; i < numeroNaves ; i++){
          crearNave(0, offsetY*i);
        }
        break;
      
      case "lineaInclinadaIzq":
        this.offsetY = offsetY *2;
        for(int i = 0; i < numeroNaves ; i++){
          crearNave(-(offsetX*i), -(offsetY*i));
        }
        break;
      
      case "lineaInclinadaDer":
      this.offsetY = offsetY *2;
        for(int i = 0; i < numeroNaves ; i++){
          crearNave((offsetX*i), -(offsetY*i));
        }
        break;
      
      case "circulo":
        for(int i = 0; i < numeroNaves ; i++){
          float offsetX2 = offsetX * cos(radians(i*360/numeroNaves)) - offsetY * sin(radians(i*360/numeroNaves));
          float offsetY2 = offsetX * sin(radians(i*360/numeroNaves)) + offsetY * cos(radians(i*360/numeroNaves));
          crearNave(offsetX2, offsetY2);
        }
        break;
      
      case "flecha":
        float offsetX2 = offsetX;
        float offsetX = this.offsetX * cos(radians(this.dir)) - this.offsetY * sin(radians(this.dir));
        float offsetY = offsetX2 * sin(radians(this.dir)) + this.offsetY * cos(radians(this.dir));
        for(int i = 0; i < numeroNaves ; i++){
          if (i == 0){
            crearNave(0,0);
          }else if (i%2 == 0){
            crearNave(offsetX*i, offsetY*i);
            crearNave(-offsetY*i, offsetY*i);
          }else if (i == numeroNaves-1){
            crearNave(offsetX*i, offsetY*i);
          }else{
            
          }
        }
        break;
      
      case "boss":
        BossShip o = new BossShip(this.asset, this.tipoNave, this.inicialX+this.offsetX, this.inicialY+this.offsetY, this.vel, this.acc, this.dir, this.hitPoints);      
        o.setWeapon(bigBulletBoss, this.tipoArma, this.damage, this.dirShoot, 10, 500, color(255,0,0));
        o.setWeapon(bigBulletBoss, "triple", this.damage, this.dirShoot, 10, 1000, color(255,0,0));
        o.setWeapon(bigBulletBoss, "muro", this.damage, this.dirShoot, 10, 3000, color(255,0,0));  
        o.setWeapon(bigBulletBoss, "limon", this.damage, this.dirShoot, 10, 3000, color(255,0,0));
        //o.setWeapon(bigBulletBoss, this.tipoArma, this.damage, this.dirShoot, 10, this.frequency, color(255,0,0));
        break;
    }
  }
  
 void crearNave(float offsetX, float offsetY){
    EnemyShip o = new EnemyShip(this.asset, this.tipoNave, this.inicialX+offsetX, this.inicialY+offsetY, this.vel, this.acc, this.dir, this.hitPoints);      
    if (frequency > 0){
      o.setWeapon(this.bulletI, this.tipoArma, this.damage, this.dirShoot, 10, this.frequency, color(255,0,0));
      println();
    }else{
      o.setWeapon(this.bulletI, this.tipoArma, this.damage, this.dirShoot, 10, color(255,0,0));
    }
  }
  
  void setFrequency(float frequency){
    this.frequency = frequency;
  }
  
  void setDamage(int damage){
    this.damage = damage;
  }
  
  void setBulletImage(PImage bulletI){
    this.bulletI = bulletI;
  }
}

class FabricaMejoras extends FabricaNaves{
  protected String tipoMejora;
  FabricaMejoras(int nEjecuciones, int numeroNaves, float inicialX, float inicialY, float vel, float acc, float dir, String tipoMejora, String tipoMov){
    super(nEjecuciones, numeroNaves, inicialX, inicialY, vel, acc, dir, tipoMov);
    this.tipoMejora = tipoMejora;
  }
  
  @Override
  void crearEscuadron(){
    new Mejora(this.tipoEscuadron, 60, this.tipoMejora, this.inicialX, this.inicialY, this.vel, this.acc, this.dir);
  }
}

public void changeRandomSeed(){
  int randomanize = year() * month() * day() * hour() * minute() * second();
  randomSeed(randomanize);
}
