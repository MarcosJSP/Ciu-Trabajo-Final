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
    this.listaNiveles.add(nivel_3());
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
  
  private Nivel nivel_1(){
    Nivel nivel_1 = new Nivel();
    Fase fase1 = new Fase();
    Fase fase2 = new Fase();
    
    fase1.añadirEscuadron()
    Escuadron e1 = new Escuadron();
    
  }
  
  private Nivel nivel_2(){
    
  }
  
  private Nivel nivel_3(){
    
  }
  
}



class Nivel{
  ArrayList <Fase> fases = new ArrayList <Fase>();
  
  Nivel(){}
  
  public void ejecutar(){
    for(Fase fase : this.fases){
      fase.ejecutarFase();
    }
  }
  
  public void añadirFase(Fase f){
    this.fases.add(f);
  }
  
  void eliminarFase(int i){
    this.fases.remove(i);
  }
}

class Fase{
  ArrayList <Escuadron>escuadrones = new ArrayList <Escuadron>(); 
  
  Fase(){}
  
  void ejecutarFase(){
    for(Escuadron e : escuadrones){
      e.ejecutar();
    }
  }
  
  void añadirEscuadron(Escuadron escuadron){
    this.escuadrones.add(escuadron);
  }
  
  void eliminarEscuadron(int i){
    this.escuadrones.remove(i);
  }
}

class Escuadron{
    private ArrayList <FabricaNaves> listaFabricas = new ArrayList <FabricaNaves>();
    private int maxEjecuciones = 0;
    
    Escuadron (FabricaNaves [] lista){
      añadirLista(lista);
    }
    
    Escuadron(){}
    
    public void añadirLista(FabricaNaves [] lista){
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
    
    public void añadirFabrica(FabricaNaves fabrica){
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
          count();
        }
      }
    }
}

void count(){
  long seconds = 1;
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
  private float offsetX;
  private float offsetY;
  private float frequency = 0;
  private int damage = 1;
  private PImage bulletI = loadImage("./Assets/Images/Boss small bullet.png");
  
  FabricaNaves(int nEjecuciones, int numeroNaves, float inicialX, float inicialY, float vel, float acc, float dir, int hitPoints, String tipoEscuadron, String tipoNave, String tipoArma, PImage imagen){
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
    this.offsetX = imagen.width * 2;
    this.offsetY = imagen.height * 2;
    this.tipoArma = tipoArma;
    this.nEjecuciones = nEjecuciones;
  }
  
  void setOffsetX(float offsetX, float offsetY){
    this.offsetX = offsetX;
    this.offsetY = offsetY;
  }
  
  int getNejecuciones(){
    return this.nEjecuciones; 
  }
  
  //EnemyShip(PImage imagen, String type, float x, float y, float vel, float acc, float angle, int hitPoints)
  void crearEscuadron(){
    switch(this.tipoEscuadron){
      case "lineaRectaHorizontal":
        for(int i = 0; i < numeroNaves ; i++){
          crearNave(offsetX*i, 0);
        }
        break;
      
      case "lineaRectaVertical":
        for(int i = 0; i < numeroNaves ; i++){
          crearNave(0, offsetY*i);
        }
        break;
      
      case "lineaInclinadaIzq":
        for(int i = 0; i < numeroNaves ; i++){
          crearNave(offsetY*i, offsetY*i);
        }
        break;
      
      case "lineaInclinadaDer":
        for(int i = 0; i < numeroNaves ; i++){
          crearNave(offsetX*i, -offsetY*i);
        }
        break;
      
      case "circulo":
        break;
      
      case "flecha":
        break;
    }
  }
  
 void crearNave(float offsetX, float offsetY){
    EnemyShip o = new EnemyShip(this.asset, this.tipoNave, this.inicialX+offsetX, this.inicialY+offsetY, this.vel, this.acc, this.dir, this.hitPoints);      
    if (frequency > 0){
      o.setWeapon(this.bulletI, this.tipoArma, this.damage, this.dir, 10, this.frequency, color(255,0,0));
    }else{
      o.setWeapon(this.bulletI, this.tipoArma, this.damage, this.dir, 10, color(255,0,0));
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
