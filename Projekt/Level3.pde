int playerX3 = 50;
int playerY3 = 400;

//Orte und Geschwindigkeiten der sich bewegenden Plattformen
int x1 = -50;
int dx1 = 20;
int y1 = 10000;
int dy1 = -3;

int x2 = 20;
int y2 = 100;
int dy2 = 2;

int HeightX3 = 8;

// Koordinaten und Größe der Plattformen

int platformwidth3 = 80;
int platformheight3 = 10;

//Ziel
int GoalX3 = 30;
int GoalY3 = 30;

//Triggergröße und Ort
int TriggerX3 = 500;
int TriggerY3 = 442;
int TriggerHeight3 = HeightX3;
int TriggerWidth3 = 30;
void drawLevel3() {
  background(LvL3BG);

  //Orte der Plattformen
  int[] PlatformsX3 = {x1, x2};
  int[] PlatformsY3 = {y1, y2};

  //Bewegung der Plattform
  y2 = y2 + dy2;
  if (y2 > 250) dy2 = -2;
  if (y2 < 100) dy2 = 2;

  //Spieler
  playerY3 += playerSpeedY;
  playerX3 += playerSpeedX;

  // Kollisionen Checken
  for (int i = 0; i < PlatformsX3.length; i++) {
    if (playerX3 < PlatformsX3[i] + platformwidth3 &&
      playerX3 + playerWidth > PlatformsX3[i] &&
      playerY3 + playerHeight > PlatformsY3[i] &&
      playerY3 < PlatformsY3[i] + platformheight3) {
      if (playerY3 < PlatformsY3[i] && playerSpeedY > 0) {
        playerY3 = PlatformsY3[i] - playerHeight;
        playerSpeedY = 0;
        jumping = false;
      } else if (playerY3 + playerHeight > PlatformsY3[i] + platformheight3 && playerSpeedY < 0) {
        playerY3 = PlatformsY3[i] + platformheight3;
        playerSpeedY = 0;
      }
    }
  }

  //Schwerkraft (Spieler fällt, bis er auf den Boden trifft)
  if (playerY3 + playerHeight > groundY) {
    playerY3 = groundY - playerHeight;
    playerSpeedY = 0;
    jumping = false;
  } else {
    playerSpeedY++;
  }
  //Ziel berühren
  if (playerX3 < GoalX3 + GoalSize && playerX3 + playerWidth > GoalX3 && playerY3 + playerHeight > GoalY3 && playerY3 < GoalY3 + GoalSize) {
    gameState ++;
  }
  //Trigger auslösen
  if (playerX3 + playerWidth > TriggerX3 && playerX3 < TriggerX3 + TriggerWidth3 && playerY3 + playerHeight > TriggerY3 && playerY3 < TriggerY3 +TriggerHeight3) {
    TriggerY3 = 448;
    TriggerHeight3 = 2;
    //Plattform kommt ins Spiel
    x1 = x1 + dx1;
    if (x1 > 100) dx1 = 0;
    y1 = 350;
  }

  //limitiert Spieler in Spielwelt
  playerX3 = constrain(playerX3, 0, width - playerWidth);

  //zeichnet Boden
  stroke(255);
  rect(0, groundY, width, groundY);

  //Plattformen Zeichnen
  for (int i = 0; i < PlatformsX3.length; i++) {
    image(PlatformLvL3, PlatformsX3[i], PlatformsY3[i], platformwidth3, platformheight3);
  }

  //Spieler Zeichnen
  image(imgx, playerX3, playerY3, playerWidth, playerHeight);

  //Ziel zeichnen, Trigger zeichnen
  square(GoalX3, GoalY3, GoalSize);
  image(Ziel, GoalX3, GoalY3 );
  image(NukeKnopf, TriggerX3, TriggerY3, TriggerWidth3, TriggerHeight3);

  //wenn Spieler auf Boden kommt, ändert sich Sprite zurück
  if (imgx == imgjr && !jumping) imgx = imgr;
  else if (imgx == imgjl && !jumping) imgx = imgl;

  //Spieler dreht sich in der Luft
  if (jumping && right) imgx = imgjr;
  if (jumping && left) imgx = imgjl;
}
