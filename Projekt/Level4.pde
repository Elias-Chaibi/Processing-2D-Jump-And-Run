int playerX4 = 50;
int playerY4 = 400;

//Orte, Geschwindigkeiten Plattformen
int x5 = -50;
int dx5 = 20;
int y5 = 10000;
int dy5 = -3;

//Größe der Plattformen
int platformwidth4 = 80;
int platformheight4 = 10;

//Ziel
int GoalX4 = 30;
int GoalY4 = 30;

//Trigger Größe und Ort
int TriggerX4 = 580;
int TriggerY4 = 142;
int TriggerHeight4 = 8;
int TriggerWidth4 = 30;

void drawLevel4() {
  background(LvL5BG);

  //X-und Y-Werte der Plattformen
  int[] PlatformsX3 = {x5, 60, 550, 400, 550};
  int[] PlatformsY3 = {y5, 160, 350, 250, 150};

  //Spieler
  playerY4 += playerSpeedY;
  playerX4 += playerSpeedX;

  // Kollisionen Checken
  for (int i = 0; i < PlatformsX3.length; i++) {
    if (playerX4 < PlatformsX3[i] + platformwidth4 &&
      playerX4 + playerWidth > PlatformsX3[i] &&
      playerY4 + playerHeight > PlatformsY3[i] &&
      playerY4 < PlatformsY3[i] + platformheight4) {
      if (playerY4 < PlatformsY3[i] && playerSpeedY > 0) {
        playerY4 = PlatformsY3[i] - playerHeight;
        playerSpeedY = 0;
        jumping = false;
      } else if (playerY4 + playerHeight > PlatformsY3[i] + platformheight4 && playerSpeedY < 0) {
        playerY4 = PlatformsY3[i] + platformheight4;
        playerSpeedY = 0;
      }
    }
  }

  //Schwerkraft (Spieler fällt, bis er auf den Boden trifft)
  if (playerY4 + playerHeight > groundY) {
    playerY4 = groundY - playerHeight;
    playerSpeedY = 0;
    jumping = false;
  } else {
    playerSpeedY++;
  }
  //Ziel berühren
  if (playerX4 < GoalX4 + GoalSize && playerX4 + playerWidth > GoalX4 && playerY4 + playerHeight > GoalY4 && playerY4 < GoalY4 + GoalSize) {
    delay(10);
    gameState ++;
  }
  //Trigger berühren
  if (playerX4 + playerWidth > TriggerX4 && playerX4 < TriggerX4 + TriggerWidth4 && playerY4 + playerHeight > TriggerY4 && playerY4 < TriggerY4 +TriggerHeight4) {
    TriggerY4 = 148;
    TriggerHeight4 = 2;
    //Plattform erscheint
    x5 = x5 + dx5;
    if (x5 > 230) dx5 = 0;
    y5 = 170;
  } else {
    //Trigger geht wieder hoch
    TriggerY4 = 142;
    TriggerHeight4 = 8;
  }

  //limitiert Spieler in Welt
  playerX4 = constrain(playerX4, 0, width - playerWidth);
  stroke(255);
  rect(0, groundY, width, groundY);

  //PlattformenZeichnen
  for (int i = 0; i < PlatformsX3.length; i++) {
    image(PlatformLvL5, PlatformsX3[i], PlatformsY3[i], platformwidth4, platformheight4);
  }

  //Spieler Zeichnen
  image(imgx, playerX4, playerY4, playerWidth, playerHeight);
  //Ziel zeichnen
  image(Ziel, GoalX4, GoalY4);
  //Trigger zeichnen
  image(NukeKnopf, TriggerX4, TriggerY4, TriggerWidth4, TriggerHeight4);


  //wenn Spieler auf Boden kommt, ändert sich Sprite zurück
  if (imgx == imgjr && !jumping) imgx = imgr;
  else if (imgx == imgjl && !jumping) imgx = imgl;

  //Spieler dreht sich in der Luft
  if (jumping && right) imgx = imgjr;
  if (jumping && left) imgx = imgjl;
}
