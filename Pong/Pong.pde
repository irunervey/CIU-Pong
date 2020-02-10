import processing.sound.*;
int px,py;
int vx,vy;
int jx,jy;
int jx2,jy2;
int[] marcador= {0,0};
int diferencia;
int finalizado=0;
int movimiento1=0;
int movimiento2=0;
boolean inicio;
SoundFile sonidoCol;
SoundFile sonidoGol;
SoundFile sonidoGan;

void setup(){
  size(800,800);
  fill(128);
  noStroke();
  vx=5-int(random(0,2))*10;;
  inicio=false;
  restart();
  jx=(int)(width*0.9);
  jy=height/2;
  jx2=(int)(width*0.1);
  jy2=height/2;
  diferencia=3;
  sonidoCol=new SoundFile(this,"Col.wav");
  sonidoGol=new SoundFile(this,"Gol.wav");
  sonidoGan=new SoundFile(this,"Gan.wav");
}


void draw(){
  background(0);
  if(inicio){
    iniciar();
  } else{
    imprimirMarcador();
    if(finalizado==0){
      stroke(0,0,255);
      fill(0,0,255);
      ellipse(px,py,20,20);
      crearJugador(jx,jy,130,0,0);
      crearJugador(jx2,jy2,0,130,0);
      movimientoPelota();
      comprobarColision();
      movimiento();
      gol();
    } else{
      fin();
    }
  }
}

void gol(){
  if(px>width || px<0){
      if(vx<0){
        marcador[1]++;
      }else{
        marcador[0]++;
      }
      if(marcador[0]-marcador[1]==diferencia||marcador[0]-marcador[1]==-diferencia){
        fin();
        thread("suena3");
      }else{
        thread("suena2");
      } 
      restart();
    }
}

void comprobarColision(){
  if(px > jx2 && px < jx2+10 && (py)<(jy2+80) && (py)>(jy2-20)){
       colision(jy2);
    }
    if(px > jx-10 && px < jx+20 && (py)<(jy+80) && (py)>(jy-20)){
      colision(jy);
    }
    if(py>height || py<0){
      vy=-vy;
    }
}

void movimientoPelota(){
  px=px+vx;
  py=py+vy;
}

void crearJugador(int posx, int posy,int color1,int color2,int color3){
  fill(color1,color2,color3);
  stroke(color1,color2,color3);
  rect(posx,posy,10,60);
}

void colision(int pos){
  vx=-vx;
  int variacion=py-(pos+30);
  vy=int(variacion*10/65);
  thread("suena1");
}

void keyPressed(){
  if (key == CODED){
    if (keyCode == UP){
      movimiento2=1; 
    } if (keyCode == DOWN){
      movimiento2=2;
    }
    if (keyCode ==RIGHT){
      if(diferencia != 20){
        diferencia++;
      }
    } if (keyCode == LEFT){
      if(diferencia != 1){
        diferencia--;
      }
    }
  }
  if(key == 'W'|| key == 'w'){
    movimiento1=1;
  } if(key == 's'|| key == 'S'){
    movimiento1=2;
  }if (key == ENTER){
    if(finalizado!=0){
      finalizado=0;
      nuevo();
    } 
  } 
}

void keyReleased(){
  if (key == CODED){
    if (keyCode == UP){
      movimiento2=0;
    } if (keyCode == DOWN){
      movimiento2=0;
    }
  }
  if(key == 'W'|| key == 'w'){
    movimiento1=0;
  } if(key == 's'|| key == 'S'){
    movimiento1=0;
  }
}

void restart(){
  vy=int(random(-7,7));
  vx=-vx;
  px=width/2;
  py=height/2;
}

void imprimirMarcador(){
  fill(255,255,255);
  textSize(30);
  text(marcador[0],width/2-50,height/5);
  text(marcador[1],width/2+50,height/5);
}

void fin(){
  vx=0;
  vy=0;
  if(marcador[0]>marcador[1]){
    text("Ha ganado el jugador1",width/3,height/2);
  } else{
    text("Ha ganado el jugador2",width/3,height/2);
  }
  fill(140,0,0);
  text("Pulsa enter para jugar de nuevo",width/4,height*2/3);
  finalizado=1;
}

void movimiento(){
  if(movimiento2!=0){
    if(movimiento2==1){
      if(jy > 0){
        jy=jy-10;
      }
    }else{
      if(jy+60 < width){
        jy=jy+10;
      }
    }
  }
  if(movimiento1!=0){
    if(movimiento1==1){
      if(jy2 > 0){
        jy2=jy2-10;
      }
    }else{
      if(jy2+60 < width){
        jy2=jy2+10;
      }
    }
  }
}

void suena1(){
  sonidoCol.play();
}
void suena2(){
  sonidoGol.play();
}
void suena3(){
  sonidoGan.play();
}

void nuevo(){
  vx=5-int(random(0,2))*10;
  marcador[0]=0;
  marcador[1]=0;
}
void iniciar(){
  text("Diferencia de:",diferencia,width/3,height/2);
  
}
