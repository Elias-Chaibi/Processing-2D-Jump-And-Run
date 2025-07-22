//Spielerort
int playerX1 = 50;
int playerY1 = 400;
// Koordinaten und Größe der Plattformen
int[] PlatformsX1 = {100, 200, 300, 400};
int[] PlatformsY1 = {400, 350, 300, 250};
int platformwidth1 = 80;
int platformheight1 = 10;

//Ziel
int GoalX = 500;
int GoalY = 150;
void drawLevel1() {
  windowResize(700, 500);
  groundY = height - 50;
  background(LvL1BG);


  playerY1 += playerSpeedY;
  playerX1 += playerSpeedX;

  // Kollisionen Checken
  for (int i = 0; i < PlatformsX1.length; i++) {
    if (playerX1 < PlatformsX1[i] + platformwidth1 &&
      playerX1 + playerWidth > PlatformsX1[i] &&
      playerY1 + playerHeight > PlatformsY1[i] &&
      playerY1 < PlatformsY1[i] + platformheight1) {
      if (playerY1 < PlatformsY1[i] && playerSpeedY > 0) {
        playerY1 = PlatformsY1[i] - playerHeight;
        playerSpeedY = 0;
        jumping = false;
      } else if (playerY1 + playerHeight > PlatformsY1[i] + platformheight1 && playerSpeedY < 0) {
        playerY1 = PlatformsY1[i] + platformheight1;
        playerSpeedY = 0;
      }
    }
  }

  //Schwerkraft (Spieler fällt, bis er auf den Boden trifft)
  if (playerY1 + playerHeight > groundY) {
    playerY1 = groundY - playerHeight;
    playerSpeedY = 0;
    jumping = false;
  } else {
    playerSpeedY++;
  }
  //Ziel berühren
  if (playerX1 < GoalX + GoalSize && playerX1 + playerWidth > GoalX && playerY1 + playerHeight > GoalY && playerY1 < GoalY + GoalSize) {
    gameState ++;
  }

  //limitiert Spieler in Welt
  playerX1 = constrain(playerX1, 0, width - playerWidth);
  stroke(255);
  //zeichnet Boden
  rect(0, groundY, width, groundY);
  fill(22);

  //PlattformenZeichnen
  for (int i = 0; i < PlatformsX1.length; i++) {
    image(PlatformLvL1, PlatformsX1[i], PlatformsY1[i], platformwidth1, platformheight1);
  }

  //Spieler Zeichnen
  image(imgx, playerX1, playerY1, playerWidth, playerHeight);
  //Ziel zeichnen

  square(GoalX, GoalY, GoalSize);
  image(Ziel, GoalX, GoalY );

  //wenn Spieler auf Boden kommt, ändert sich Sprite zurück
  if (imgx == imgjr && !jumping) imgx = imgr;
  else if (imgx == imgjl && !jumping) imgx = imgl;

  //Spieler dreht sich in der Luft
  if (jumping && right) imgx = imgjr;
  if (jumping && left) imgx = imgjl;
}
