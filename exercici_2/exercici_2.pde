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
  }
  void dibuixa() {  
    float r = cos(angle);
    fill(255, tr);
    ellipse(posX, posY, radio*r, radio*r);
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
    posY=posY+velY;
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
    if (posY>= height-radio) {
      posY = height - radio;
      velY= -velY;
    }
  }
}
void setup() {
  size(500, 400);
  ellipseMode(RADIUS);
  noStroke();
}
void draw() {
  background(200, 50, 100);
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
}
void mouseReleased() {
  int num =800;
  Bola[] a= new Bola[num];
  for (int i = 0; i<num; i++) {
    a[i] = new Bola();
    Bolas.add(a[i]);
  }
}

/////lo nuevo

void keyPressed() {
  if (key=='q' || key=='Q') {
    print(" q pressed");
  }
  if (key=='w' || key=='W') {
    print(" w pressed");
  }
  if (key=='e' || key=='E') {
    print(" e pressed");
  }
  if (key=='r' || key=='R') {
    print(" r pressed");
  }
}
