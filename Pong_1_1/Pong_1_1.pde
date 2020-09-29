//Grupo 02. Ana Julia Marchi, Gabriel Noda, Jessica Goulart e Katarina Miky
//PIANOPONG
//É necessário importar a biblioteca Minim antes de começar
//Créditos dos sons: freesound.org. Copyright livre, para uso educacional.

float xBola, yBola, moveX, moveY, diam, raio;
float xRaq, yRaq;
float larguraRaq, alturaRaq;
float limiteCima, limiteBaixo;
int Pontos, Record, tecla, upDown;

import ddf.minim.*;// importa a biblioteca de áudio para ser usada nesse programa
Minim minim;

AudioSample vaia, P1, P2, P3, P4, P5, P6, P7, parede, jogSom, clap; // define samples

PImage fundo, plateia, placarImg, pianoImg, mulher, chamada, seuCoco;


void setup () {

  size (1300, 800);
  background(0);


  minim = new Minim (this);// sinaliza para o minim que ira carregar algo
  vaia= minim.loadSample ("vaia.mp3"); // carrega o arquivo de vaia
  parede= minim.loadSample ("parede.mp3"); //carrega o arquivo de bater na parede
  jogSom= minim.loadSample ("Pong.wav"); //carrega o arquivo de bater no jogador
  clap= minim.loadSample ("clap.mp3"); //carrega o arquivo de palmas

  P1= minim.loadSample ("P1.wav");
  P2= minim.loadSample ("P2.wav");
  P3= minim.loadSample ("P3.wav");
  P4= minim.loadSample ("P4.wav");
  P5= minim.loadSample ("P5.wav");
  P6= minim.loadSample ("P6.wav");
  P7= minim.loadSample ("P7.wav"); //carrega toque das teclas

  xBola = width+350; //colocar a bola fora da tela
  yBola = height+200;

  diam = 30; //diâmetro da bola
  raio= diam/2;

  larguraRaq=70;
  alturaRaq=150; //tamanho da raquete

  xRaq = 155; //onde começa coordenada x da raquete esquerda
  yRaq = height/2; //onde começa coordenada y da raquete esquerda

  limiteCima= alturaRaq/2;
  limiteBaixo= height-alturaRaq/2; //limite de posição do jogador
  Pontos=0;
  Record=0;
  tecla=0;

  chamada = loadImage("telainicio.png");
  seuCoco= loadImage ("telarestart.png");
  fundo = loadImage("Palco.png");
  plateia = loadImage("Plateia.png");
  placarImg = loadImage("Placar.png");
  pianoImg = loadImage ("Piano.png");
  mulher = loadImage ("Mulher.png"); //carregando imagens que serão usadas no jogo

  rectMode (CENTER); //muda localização dos parâmetros da função rect()para centro do retângulo
  textAlign (CENTER, CENTER); //alinhamento dos textos
}

void draw () {

  //Cenário ------------------------------------------------------------
  image (fundo, 100, 100);
  image (plateia, 0, 100);
  image (placarImg, 0, 0); //cenário sendo inserido


  fill(0);// pinta pontos de preto
  textSize(40);//tamanho dos pontos e recorde
  text (str(Pontos), width/2-90, 40); //printa quantidade de pontos
  text (str(Record), width/2+65, 40); //printa o recorde do jogador

  if (xBola==width+350) { //palmas do começo do jogo
    clap.trigger();
    xBola+=1;
  }




  translate (100, 100); //translada o enquadramento para o jogo


  fill (255); //piano
  rect (width-175, height/2, 150, height);


  xBola = xBola + moveX; 
  yBola = yBola + moveY; //incrementa a posição da bolinha


  if (xBola >width-250 &&yBola<=height) { //bate no piano ---------------
    if (yBola>=0 && yBola<=100) {
      P1.trigger(); //toca piano
      tecla= 1;
    } else if (yBola>100 && yBola<=200) {
      P2.trigger(); //toca piano
      tecla= 2;
    } else if (yBola>200 && yBola<=300) {
      P3.trigger(); //toca piano
      tecla=3;
    } else if (yBola>300 && yBola<=400) {
      P4.trigger(); //toca piano
      tecla=4;
    } else if (yBola>400 && yBola<=500) {
      P5.trigger(); //toca piano
      tecla=5;
    } else if (yBola>500 && yBola<=600) {
      P6.trigger(); //toca piano
      tecla=6;
    } else if (yBola>600 && yBola<=700) {
      P7.trigger(); //toca piano
      tecla=7;
    }
    moveX = -moveX; //muda de direção
  }

  if (moveX<0 && xBola>width-250+(moveX*12)) { //cor da tecla quando encosta
    fill (95, 140, 147);
    if (tecla==1) {
      rect (width-175, 50, 150, 100);
    } else if (tecla==2) {
      rect (width-175, 150, 150, 100);
    } else if (tecla==3) {
      rect (width-175, 250, 150, 100);
    } else if (tecla==4) {
      rect (width-175, 350, 150, 100);
    } else if (tecla==5) {
      rect (width-175, 450, 150, 100);
    } else if (tecla==6) {
      rect (width-175, 550, 150, 100);
    } else if (tecla==7) {
      rect (width-175, 650, 150, 100);
    }
  }

  image (pianoImg, 1050, 0); //imagem do piano


  if (yBola < 0 || yBola > height-100 && yBola!=height+200) { //variação de direção
    parede.trigger(); //toca som de bater na parede
    moveY = -moveY;
  }


  if (xBola <0) { //se a bolinha passar do jogador
    vaia.trigger();// reproduz a vaia
    if (Pontos>Record) { //substitui recorde se pontos for maior
      Record=Pontos;
    }
    moveX=0; //faz a bolinha parar de se movimentar
    moveY=0;
    xBola=width+200;
    yBola=height+200; //coloca a bolinha para fora da tela
  }


  if (xBola<=xRaq+35 && xBola>=xRaq+35-xBola && yBola>=yRaq-(alturaRaq/2) 
    && yBola<=yRaq+(alturaRaq/2) && moveX<0) { //bater na raquete
    jogSom.trigger();
    moveX-=2;
    if (moveY>0) {
      moveY+=2;
    } else {
      moveY-=2; //aumenta a velocidade da bolinha
    }
    moveX = -moveX; //muda a direção X da bolinha
    Pontos+=1; //aumenta a pontuação
  }




  //jogador ----------------------------------------------------
  //  fill (0, 200, 100);
  strokeWeight(0);
  noFill();
  rect (xRaq, yRaq, larguraRaq, alturaRaq); //hitbox do jogador
  image (mulher, xRaq-200, yRaq-86); //carrega a img do jogador


  if (keyPressed) { //movimento do jogador
    if (key =='w' || key=='W') {
      if (yRaq<=limiteCima) {
        yRaq=75;
      } else {
        yRaq-=18;
      }
    }
    if (key =='s' || key=='S') {
      if (yRaq>=limiteBaixo-100) {
        yRaq=height-175;
      } else {
        yRaq+=18;
      }
    }
  }




  //bolinha -----------------------------------------------------
  fill (200);
  circle (xBola, yBola, diam);


  if (xBola==width+351) { //imagem de começo do jogo
    image (chamada, 0, 125);
  }
  if (xBola==width+200) { //imagem de fim de jogo
    image (seuCoco, 171, 139);
    fill(0);// pinta pontos de preto
    textSize(60);//tamanho dos pontos e recorde
    text (str(Record), 520, 355); //printa o recorde do jogador
  }
}


void keyTyped () {
  //Começar e recomeçar jogo
  if (key==ENTER) {
    Pontos=0; //redefine a pontuação
    upDown= int(random(2));
    moveX= -6; //recomeça a velocidade da bolinha
    if (upDown==0) { //aleatoriza a direção da bolinha em Y
      moveY= 6;
    } else {
      moveY= -6;
    }

    xBola = width-300; //coloca a bola para começar na direita
    yBola = random(height-100); //coloca a bola para em alguma altura
    tecla=0;
  }
}
