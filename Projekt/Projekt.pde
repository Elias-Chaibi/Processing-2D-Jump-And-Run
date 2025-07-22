//Variablen initiieren
int gameState = 0;

boolean jumping = false;
boolean right = false;
boolean left = false;

//Größe, Geschwindigkeit des Spielers
int playerWidth = 30;
int playerHeight = 40;
int playerSpeedY = 0;
int playerSpeedX = 0;

//Höhe des Bodens
int groundY;

//Ziel
int GoalSize = 50;

//Bilder
PImage imgx;
PImage imgr;
PImage imgl;
PImage imgjr;
PImage imgjl;
PImage StartImG1;
PImage StartImG2;
PImage LvL1BG;
PImage LvL2BG;
PImage LvL3BG;
PImage LvL4BG;
PImage PlatformLvL1;
PImage PlatformLvL2;
PImage PlatformLvL3;
PImage PlatformLvL4;
PImage FinalZiel;
PImage Ziel;
PImage NukeKnopf;
PImage   LvL5BG;
PImage   LvL6BG;
PImage PlatformLvL5;
PImage PlatformLvL6;

void setup() {
  size(700, 500);
  groundY = height - 50;
  frameRate(60);
  imgr = loadImage("png.png");
  imgl = loadImage("pngpng.png");
  imgx = imgr;
  imgjr = loadImage("Jump.png");
  imgjl = loadImage("JumpJump.png");
  StartImG1 = loadImage("Gumbos Adventure Startscreen png.png");
  StartImG2 = loadImage("Gumbos Adventure Endscreen png.png");
  LvL1BG = loadImage("BackgroundLvL1.png");
  LvL2BG = loadImage("BackgroundLvL2.png");
  LvL3BG = loadImage("BackgroundLvL3.png");
  LvL4BG = loadImage("BackgroundLvL4.png");
  LvL5BG = loadImage("BackgroundLvL5.png");
  LvL6BG = loadImage("BackgroundLvL6.png");
  PlatformLvL1 = loadImage("PlatformLvL1.png");
  PlatformLvL2 = loadImage("PlatformLvL2.png");
  PlatformLvL3 = loadImage("PlatformLvL3.png");
  PlatformLvL4 = loadImage("PlatformLvL4.png");
  PlatformLvL5 = loadImage("PlatformLvL5.png");
  PlatformLvL6 = loadImage("PlatformLvL6.png");
  Ziel = loadImage("Portal.png");
  FinalZiel = loadImage("FinalZiel.png");
  NukeKnopf = loadImage("NukeKnopf.png");
 
}

//Gamestates --> level
void draw() {
  if (gameState == 0) drawStart();
  else if (gameState == 1) drawLevel1();
  else if (gameState == 2) drawLevel2();
  else if (gameState == 3) drawLevel3();
  else if (gameState == 4) drawLevel4();
  else if (gameState == 5) drawLevel5();
  else if (gameState == 6) drawLevel6();
  else if (gameState == 7) drawEnd();
}


//Springen
void keyPressed() {
  if (!jumping) {
    if (key == ' ') {
      playerSpeedY = -15;
      jumping = true;
    }
  }
  //nach links und rechts bewegen
  if (keyCode == LEFT) {
    imgx = imgr;
    playerSpeedX = -5;
    if (!jumping) imgx = imgl;
    //if(jumping) imgx = imgjl;
    left = true;
    right = false;
  } else if (keyCode == RIGHT) {
    playerSpeedX = 5;
    if (!jumping) imgx = imgr;
    //if(jumping) imgx = imgjr;
    right = true;
    left = false;
  }

}
//stehen bleiben
void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    playerSpeedX = 0;
  }
}
