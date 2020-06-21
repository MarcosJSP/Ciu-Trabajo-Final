class Juego{
  private ArrayList <Nivel> listaNiveles = new ArrayList <Nivel>();
  
  Juego(){}
  
  public void ejecutar(int i){
    listaNiveles.get(i).ejecutar();
  }
  
  //Por hacer: cargar mensaje
  
  public void cargarNivelesPredeterminados(){
    this.listaNiveles.add(nivel_1());
    //this.listaNiveles.add(nivel_2());
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
  //   float dir, int hitPoints, String tipoEscuadron, String tipoNave, String tipoArma, PImage imagen){
    
  private Nivel nivel_1(){
    FabricaNaves fabrica1 = new FabricaNaves(3, 3,  width/2.0,         -100,        3.0, 0.1, GameObject.bot,   GameObject.bot,   3, "lineaRectaHorizontal", "normal",    "normal",    shipI1);
    FabricaNaves fabrica2 = new FabricaNaves(5, 3,  100,               height+100,  3.0, 0.0, GameObject.top,   GameObject.top,   3, "lineaRectaHorizontal", "normal",    "triple",    shipI1);
    FabricaNaves fabrica3 = new FabricaNaves(2, 3,  200,               height+100,  2.0, 0.0, GameObject.top,   GameObject.right, 3, "lineaRectaVertical",   "normal",    "circulo",   shipI1);
    FabricaNaves fabrica4 = new FabricaNaves(4, 3,  -100,              height-100,  4.0, 0.2, GameObject.right, GameObject.right, 3, "lineaInclinadaIzq",    "serpiente", "normal",    shipI1);
    FabricaNaves fabrica5 = new FabricaNaves(6, 3,  width+100,         height-100,  3.0, 0.1, GameObject.left,  GameObject.left,  3, "lineaInclinadaDer",    "normal",    "serpiente", shipI1);
    
    Flota e1 = new Flota();
    Flota e2 = new Flota();
    Flota e3 = new Flota();
    
    e1.addFabrica(fabrica1);
    e1.addFabrica(fabrica2);
    e1.addFabrica(fabrica3);
    
    e2.addFabrica(fabrica4);
    e2.addFabrica(fabrica5);
    e2.addFabrica(fabrica5);
    
    e3.addFabrica(fabrica1);
    e3.addFabrica(fabrica4);
    e3.addFabrica(fabrica3);
    
    Fase fase1 = new Fase();
    Fase fase2 = new Fase();
    Fase fase3 = new Fase();
    
    fase1.addFlota(e1);
    fase1.addFlota(e2);
    fase1.addFlota(e1);
    fase1.addFlota(e2);
    fase1.addFlota(e1);
    fase1.addFlota(e2);
    
    fase2.addFlota(e3);
    fase2.addFlota(e2);
    fase2.addFlota(e1);
    fase2.addFlota(e3);
    fase2.addFlota(e2);
    fase2.addFlota(e3);
    fase2.addFlota(e2);
    
    fase3.addFlota(e2);
    fase3.addFlota(e1);
    fase3.addFlota(e3);
    fase3.addFlota(e2);
    fase3.addFlota(e3);
    fase3.addFlota(e2);
    
    Nivel nivel_1 = new Nivel();
    nivel_1.addFase(fase1);
    nivel_1.addFase(fase2);
    nivel_1.addFase(fase3);
    return nivel_1;
  }
  
  /*
  private Nivel nivel_2(){
    
  }
  
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
  
  Fase(){}
  
  void ejecutarFase(){
    for(Flota e : listaFlotas){
      e.ejecutar();
      count(8);
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
    
    Flota (FabricaNaves [] lista){
      addLista(lista);
    }
    
    Flota(){}
    
    public void addLista(FabricaNaves [] lista){
      for(FabricaNaves fabrica : lista){
        this.listaFabricas.add(fabrica);
        if(fabrica.nEjecuciones > this.maxEjecuciones){
          this.maxEjecuciones = fabrica.nEjecuciones;
        }
      }
    }
    public ArrayList <FabricaNaves> getLista(){
      return this.listaFabricas;  
      
    }
    
    public void addFabrica(FabricaNaves fabrica){
      this.listaFabricas.add(fabrica);
      if(fabrica.nEjecuciones > this.maxEjecuciones){
          this.maxEjecuciones = fabrica.nEjecuciones;
        }
    }
    
    public void ejecutar(){
      int count = 0;
      for(FabricaNaves f : this.listaFabricas){
        if( f.getNejecuciones() - count > 0){
          f.crearEscuadron();
          count(3);
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
  private int nEjecuciones = 1;
  private int numeroNaves, hitPoints;
  private float inicialX, inicialY;
  private float dir;
  private String tipoEscuadron, tipoNave, tipoArma;
  private float vel, acc;
  private PImage asset;
  private float offsetX = 0;
  private float offsetY = 0;
  private float frequency = 2.5;
  private int damage = 1;
  private PImage bulletI = bulletB;
  private float dirShoot;
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
    this.offsetX = imagen.width*2;
    this.offsetY = imagen.height*2;
    this.tipoArma = tipoArma;
    this.nEjecuciones = nEjecuciones;
    this.dirShoot = dirShoot;
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
        for(int i = 0; i < numeroNaves ; i++){
          this.offsetX = (offsetX * i);
          this.offsetY = 0;
          crearNave();
        }
        break;
      
      case "lineaRectaVertical":
        for(int i = 0; i < numeroNaves ; i++){
          this.offsetX = 0;
          this.offsetY = (offsetY * i);
          crearNave();
        }
        break;
      
      case "lineaInclinadaIzq":
        for(int i = 0; i < numeroNaves ; i++){
          offsetX = -(offsetX * i);
          offsetY = -(offsetY * i);
          crearNave();
        }
        break;
      
      case "lineaInclinadaDer":
        for(int i = 0; i < numeroNaves ; i++){
          offsetX = (offsetX * i);
          offsetY = -(offsetY * i);
          crearNave();
        }
        break;
      
      case "circulo":
        for(int i = 0; i < numeroNaves ; i++){
          float offsetX2 = offsetX;
          offsetX = offsetX2 * cos(radians(i*360/numeroNaves)) - offsetY * sin(radians(i*360/numeroNaves));
          offsetY = offsetX2 * sin(radians(i*360/numeroNaves)) + offsetY * cos(radians(i*360/numeroNaves));
          crearNave();
        }
        break;
      
      case "flecha":
        for(int i = 0; i < numeroNaves ; i++){
          if (i == 0){
            crearNave();
          }else if (i%2 == 0){
            offsetY = offsetY*i;
            offsetX = offsetX*i;
            crearNave();
            offsetX = -offsetX*i;
            crearNave();
          }else if (i == numeroNaves-1){
            offsetY = offsetY*i;
            offsetX = offsetX*i;
            crearNave();
          }else{
            
          }
        }
        break;
    }
  }
  
 void crearNave(){
    EnemyShip o = new EnemyShip(this.asset, this.tipoNave, this.inicialX+this.offsetX, this.inicialY+this.offsetY, this.vel, this.acc, this.dir, this.hitPoints);      
    if (frequency > 0){
      o.setWeapon(this.bulletI, this.tipoArma, this.damage, this.dirShoot, 10, this.frequency, color(255,0,0));
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

public void changeRandomSeed(){
  int randomanize = year() * month() * day() * hour() * minute() * second();
  randomSeed(randomanize);
}
