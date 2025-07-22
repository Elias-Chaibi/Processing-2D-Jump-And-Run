float x = 400;
float dx = 0.5;
float y = 400;
float dy = -0.5;
int z = 390;
int dz = -1;

int playerX2 = 50;
int playerY2 = 400;

//Größe der Plattformen
int platformwidth2 = 80;
int platformHeight2 = 10;

//Ziel
int GoalX2 = 30;
int GoalY2 = 30;

void drawLevel2() {
  background(LvL2BG);

  float[] PlatformsX2 = {100, 200, 300, x, 600, y, 150};
  int[] PlatformsY2 = {400, z, 300, 250, 150, 100, 140};

  x = x + dx;
  if (x > 500) dx = -0.5;
  if (x < 400) dx = 0.5;

  y = y + dy;
  if (y < 330) dy = 0.5;
  if (y > 400) dy = -0.5;

  z = z + dz;
  if (z < 310) dz = 1;
  if (z > 390) dz = -1;

  playerY2 += playerSpeedY;
  playerX2 += playerSpeedX;

  // Kollisionen Checken
  for (int i = 0; i < PlatformsX2.length; i++) {
    if (playerX2 < PlatformsX2[i] + platformwidth2 &&
      playerX2 + playerWidth > PlatformsX2[i] &&
      playerY2 + playerHeight > PlatformsY2[i] &&
      playerY2 < PlatformsY2[i] + platformHeight2) {
      if (playerY2 < PlatformsY2[i] && playerSpeedY > 0) {
        playerY2 = PlatformsY2[i] - playerHeight;
        playerSpeedY = 0;
        jumping = false;
      } else if (playerY2 + playerHeight > PlatformsY2[i] + platformHeight2 && playerSpeedY < 0) {
        playerY2 = PlatformsY2[i] + platformHeight2;
        playerSpeedY = 0;
      }
    }
  }

  //Schwerkraft (Spieler fällt, bis er auf den Boden trifft)
  if (playerY2 + playerHeight > groundY) {
    playerY2 = groundY - playerHeight;
    playerSpeedY = 0;
    jumping = false;
  } else {
    playerSpeedY++;
  }

  //Ziel berühren
  if (playerX2 < GoalX2 + GoalSize && playerX2 + playerWidth > GoalX2 && playerY2 + playerHeight > GoalY2 && playerY2 < GoalY2 + GoalSize) {
    gameState ++;
  }

  //limitiert Spieler in Welt
  playerX2 = constrain(playerX2, 0, width - playerWidth);

  //zeichnet Boden
  stroke(255);
  rect(0, groundY, width, groundY);

  //PlattformenZeichnen
  for (int i = 0; i < PlatformsX2.length; i++) {
    image(PlatformLvL2, PlatformsX2[i], PlatformsY2[i], platformwidth2, platformHeight2);
  }

  //Spieler Zeichnen
  image(imgx, playerX2, playerY2, playerWidth, playerHeight);
  //Ziel zeichnen
  square(GoalX2, GoalY2, GoalSize);
  image(Ziel, GoalX2, GoalY2 );

  //wenn Spieler auf Boden kommt, ändert sich Sprite zurück
  if (imgx == imgjr && !jumping) imgx = imgr;
  else if (imgx == imgjl && !jumping) imgx = imgl;

  //Spieler dreht sich in der Luft
  if (jumping && right) imgx = imgjr;
  if (jumping && left) imgx = imgjl;
}
