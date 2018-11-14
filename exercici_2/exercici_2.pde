ArrayList<Bola> Bolas = new ArrayList<Bola>();
class Bola {
  float posX;
  float posY;
  float velX;
  float velY;
  float radio;
  float tr;
  float angle;
  boolean fade;
  int time;
  float darude;
  Bola() {
    fade = false;
    time = (int)random(60, 200);
    posX = mouseX;
    posY = mouseY;
    float r = random(0.5);
    r = sqrt(r);
    float a = random(TAU);
    velX = r*cos(a);
    velY = r*sin(a);
    radio = random(1, 5);
    tr =  random(20, 100);
    angle = random(TAU);
    darude=random(-5, 5);
  }
  void dibuixa() {  
    float r = cos(angle);
    fill(255, tr);
    if (starOn) {
      tint(200, 50, 100, tr); /// es rosa perque la Misericordia ho vol rosa.
      pushMatrix();
      translate(posX, posY);
      if (random(200)%2==0) {
        rotate(angle+darude);
      }
      rotate(angle-darude);
      image(star, 0, 0);
      popMatrix();
    } else {
      ellipse(posX, posY, radio*r, radio*r);
    }
    angle += 0.05;
    if (!fade) {
      tr = tr + 5*noise(random(255)*0.02+frameCount*0.1);
      tr = tr%100;
    } else {
      tr *= 0.9;
    }
    time--;
  }
  void mou() {
    posX=posX+velX;
    if (gravityOn) {
      posY=posY+velY+random(10);
    } else {
      posY=posY+velY;
    }
  }
  void controla() {
    if (posX <= radio) {
      posX= radio;
      velX = -velX;
    }
    if (posX >= width-radio) {
      posX = width - radio;
      velX = -velX;
    }
    if (posY <= radio) {
      posY = radio;
      velY= -velY;
    }
    if (posY>= height-radio&&!gravityOn) {
      posY = height - radio;
      velY= -velY;
    }
  }
}
PImage star;
void setup() {
  size(500, 400);
  ellipseMode(RADIUS);
  noStroke();
  star=loadImage("star.png");
}
void draw() {
  if (starOn) {
    background(255, 255, 255);
  } else {
    background(200, 50, 100);
  }
  for (Bola k : Bolas) {
    k.mou();
    k.controla();
    k.dibuixa();
  }
  int siz=Bolas.size();
  for (int l=siz-1; l>=0; l--) {
    if (Bolas.get(l).time<=0) {
      Bolas.remove(l);
    }
  }
  if (lineOn) {
    int sir=Bolas.size();
    for (int l=1; l<sir-1; l++) {
      float px=Bolas.get(l).posX;
      float py=Bolas.get(l).posY;
      float nx=Bolas.get(l-1).posX;
      float ny=Bolas.get(l-1).posY;
      stroke(255,125,12,20);
      line(px,py,nx,ny);
    }
  }
}
void mouseReleased() {
  int num =200;
  if (starOn) {
    num=20;
  }
  Bola[] a= new Bola[num];
  for (int i = 0; i<num; i++) {
    a[i] = new Bola();
    Bolas.add(a[i]);
  }
}

/////lo nuevo
boolean gravityOn=false;
boolean starOn=false;
boolean lineOn=false;
void keyPressed() {
  if (key=='q' || key=='Q') {
    gravityOn=!gravityOn;
    print(gravityOn);
  }
  if (key=='w' || key=='W') {
    print(" w pressed");
    starOn=!starOn;
    print(starOn);
  }
  if (key=='e' || key=='E') {
    lineOn=!lineOn;
    print(lineOn);
  }
}
