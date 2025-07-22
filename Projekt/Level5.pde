int PlayerX5 = 50;
int PlayerY5 = 400;

//Orte, Geschwindigkeiten bewegende Plattformen
int a1 = -50;
int da1 = 40;
int b1 = 10000;
int db1 = -3;

int a2 = 250;
int b2 = 100;
int db2 = 2;

int HeightX4 = 8;

// Koordinaten und Größe der Plattformen

int platformwidth5 = 80;
int platformheight5 = 10;

//Ziel
int GoalX5 = 50;
int GoalY5 = 350;

//Trigger 1
int TriggerX5 = 100;
int TriggerY5 = 100;
int TriggerHeight5 = HeightX4;
int TriggerWidth5 = 30;
boolean TriggerPressed;

//Trigger 2
int Trigger2X4 = 570;
int Trigger2Y4 = 100;
int Trigger2Height4 = 8;
boolean Trigger2pressed = false;

void drawLevel5() {
  background(LvL4BG);
  //Koordinaten der Plattformen
  int[] PlatformsX3 = {a1, a2, 75, 400, 500, 545};
  int[] PlatformsY3 = {b1, b2, 108, 250, 350, 108};

  //Bewegung der Plattform zwischen zwei Punkten
  b2 = b2 + db2;
  if (b2 > 200) db2 = -2;
  if (b2 < 108) db2 = 2;

  PlayerY5 += playerSpeedY;
  PlayerX5 += playerSpeedX;

  // Kollisionen Checken
  for (int i = 0; i < PlatformsX3.length; i++) {
    if (PlayerX5 < PlatformsX3[i] + platformwidth5 &&
      PlayerX5 + playerWidth > PlatformsX3[i] &&
      PlayerY5 + playerHeight > PlatformsY3[i] &&
      PlayerY5 < PlatformsY3[i] + platformheight5) {
      if (PlayerY5 < PlatformsY3[i] && playerSpeedY > 0) {
        PlayerY5 = PlatformsY3[i] - playerHeight;
        playerSpeedY = 0;
        jumping = false;
      } else if (PlayerY5 + playerHeight > PlatformsY3[i] + platformheight5 && playerSpeedY < 0) {
        PlayerY5 = PlatformsY3[i] + platformheight5;
        playerSpeedY = 0;
      }
    }
  }

  //Schwerkraft (Spieler fällt, bis er auf den Boden trifft)
  if (PlayerY5 + playerHeight > groundY) {
    PlayerY5 = groundY - playerHeight;
    playerSpeedY = 0;
    jumping = false;
  } else {
    playerSpeedY++;
  }
  //Ziel berühren
  if (PlayerX5 < GoalX5 + GoalSize && PlayerX5 + playerWidth > GoalX5 && PlayerY5 + playerHeight > GoalY5 && PlayerY5 < GoalY5 + GoalSize && Trigger2pressed) gameState ++;

  //Trigger 1 wird gedrückt
  if (PlayerX5 + playerWidth > TriggerX5 && PlayerX5 < TriggerX5 + TriggerWidth5 && PlayerY5 + playerHeight > TriggerY5 && PlayerY5 < TriggerY5 +TriggerHeight5) {
    TriggerY5 = 106;
    TriggerHeight5 = 2;
    TriggerPressed = true;
    //Plattform erscheint
    a1 = a1 + da1;
    if (a1 > 400) da1 = 0;
    b1 = 150;
  }
  //Trigger 2 wird gedrückt
  if (PlayerX5 + playerWidth > Trigger2X4 && PlayerX5 < Trigger2X4 + TriggerWidth5 && PlayerY5 + playerHeight > Trigger2Y4 && PlayerY5 < Trigger2Y4 +TriggerHeight5) {
    Trigger2Y4 = 106;
    Trigger2Height4 = 2;
    Trigger2pressed = true;
  }
  //limitiert Spieler in Welt
  PlayerX5 = constrain(PlayerX5, 0, width - playerWidth);
  stroke(255);
  rect(0, groundY, width, groundY);

  //Plattformen Zeichnen
  for (int i = 0; i < PlatformsX3.length; i++) {
    image(PlatformLvL4, PlatformsX3[i], PlatformsY3[i], platformwidth5, platformheight5);
  }

  //Spieler Zeichnen
  image(imgx, PlayerX5, PlayerY5, playerWidth, playerHeight);

  //Ziel zeichnen erst wenn 2. Trigger gedrückt wurde
  if (Trigger2pressed) image(Ziel, GoalX5, GoalY5);
  //Trigger zeichnen
  fill(22);
  image(NukeKnopf, TriggerX5, TriggerY5, TriggerWidth5, TriggerHeight5);
  image(NukeKnopf, Trigger2X4, Trigger2Y4, TriggerWidth5, Trigger2Height4);

  //wenn Spieler auf Boden kommt, ändert sich Sprite zurück
  if (imgx == imgjr && !jumping) imgx = imgr;
  else if (imgx == imgjl && !jumping) imgx = imgl;

  //Spieler dreht sich in der Luft
  if (jumping && right) imgx = imgjr;
  if (jumping && left) imgx = imgjl;
}
