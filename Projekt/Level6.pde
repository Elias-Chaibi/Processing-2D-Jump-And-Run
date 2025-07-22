int PlayerX6 = 50;
int PlayerY6 = 200;

//Koordinaten, Geschwindigkeit bewegende Plattformen
int x6 = 300;
int dx6 = 2;
int y6 = 310;
int dy6 = -1;

int x7 = 50;
int y7 = 100;
int dy7 = 1;




//Größe der Plattformen
int platformwidth6 = 80;
int platformheight6 = 10;

//Ziel
int GoalX6 = 630;
int GoalY6 = 30;

//Triggerorte und Größe
int TriggerX6 = 200;
int TriggerY6 = 92;
int TriggerHeight6 = 8;
int TriggerWidth6 = 30;

int TriggerX7 = 150;
int TriggerY7 = 442;
int TriggerHeight7 = 8;
int TriggerWidth7 = 30;

int TriggerX8 = 500;
int TriggerY8 = 442;
int TriggerHeight8 = 8;
int TriggerWidth8 = 30;

void drawLevel6() {
  background(LvL6BG);

  //Koordinaten der Plattformen
  int[] PlatformsX3 = {x6, 600, 300, x7, 160};
  int[] PlatformsY3 = {y6, 140, 380, y7, 100};

  //Bewegen der Plattformen
  y7 += dy7;
  if (y7 > 200) dy7 = -1;
  if (y7 < 100) dy7 = 1;

  PlayerY6 += playerSpeedY;
  PlayerX6 += playerSpeedX;

  // Kollisionen Checken
  for (int i = 0; i < PlatformsX3.length; i++) {
    if (PlayerX6 < PlatformsX3[i] + platformwidth6 &&
      PlayerX6 + playerWidth > PlatformsX3[i] &&
      PlayerY6 + playerHeight > PlatformsY3[i] &&
      PlayerY6 < PlatformsY3[i] + platformheight6) {
      if (PlayerY6 < PlatformsY3[i] && playerSpeedY > 0) {
        PlayerY6 = PlatformsY3[i] - playerHeight;
        playerSpeedY = 0;
        jumping = false;
      } else if (PlayerY6 + playerHeight > PlatformsY3[i] + platformheight6 && playerSpeedY < 0) {
        PlayerY6 = PlatformsY3[i] + platformheight6;
        playerSpeedY = 0;
      }
    }
  }

  //Schwerkraft (Spieler fällt, bis er auf den Boden trifft)
  if (PlayerY6 + playerHeight > groundY) {
    PlayerY6 = groundY - playerHeight;
    playerSpeedY = 0;
    jumping = false;
  } else {
    playerSpeedY++;
  }

  //Ziel berühren
  if (PlayerX6 < GoalX6 + GoalSize && PlayerX6 + playerWidth > GoalX6 && PlayerY6 + playerHeight > GoalY6 && PlayerY6 < GoalY6 + GoalSize) {
    gameState ++;
  }
  //Trigger berühren
  if (PlayerX6 + playerWidth > TriggerX6 && PlayerX6 < TriggerX6 + TriggerWidth6 && PlayerY6 + playerHeight > TriggerY6 && PlayerY6 < TriggerY6 +TriggerHeight5) {
    TriggerY6 = 98;
    TriggerHeight6 = 2;
    //Plattform bewegt sich nach
    y6 += dy6;
    if (y6 < 260) dy6 = 0;
  } else {
    TriggerY6 = 92;
    TriggerHeight6 = 8;
  }
  //Trigger 2 wird berührt
  if (PlayerX6 + playerWidth > TriggerX7 && PlayerX6 < TriggerX7 + TriggerWidth7 && PlayerY6 + playerHeight > TriggerY7 && PlayerY6 < TriggerY7 +TriggerHeight7) {
    TriggerY7 = 448;
    TriggerHeight7 = 2;
    //Plattform bewegt sich
    if (x6 > 400) dx6 = 0;
    x6 += dx6;
  } else {
    TriggerY7 = 442;
    TriggerHeight7 = 8;
    dx6 = 1;
  }
  //Trigger 3 wird berührt
  if (PlayerX6 + playerWidth > TriggerX8 && PlayerX6 < TriggerX8 + TriggerWidth8 && PlayerY6 + playerHeight > TriggerY8 && PlayerY6 < TriggerY8 +TriggerHeight8) {
    TriggerY8 = 448;
    TriggerHeight8 = 2;
    //Plattform bewegt sich
    if (x6 < 200) dx6 = 0;
    x6 -= dx6;
  } else {
    TriggerY8 = 442;
    TriggerHeight8 = 8;
    dx6 = 1;
  }
  //limitiert Spieler in Welt
  PlayerX6 = constrain(PlayerX6, 0, width - playerWidth);


  //PlattformenZeichnen
  for (int i = 0; i < PlatformsX3.length; i++) {
    image(PlatformLvL6, PlatformsX3[i], PlatformsY3[i], platformwidth6, platformheight6);
  }

  //Spieler Zeichnen
  image(imgx, PlayerX6, PlayerY6, playerWidth, playerHeight);
  //Ziel zeichnen
  image(FinalZiel, GoalX6, GoalY6);

  //Trigger zeichnen
  image(NukeKnopf, TriggerX6, TriggerY6, TriggerWidth6, TriggerHeight6);
  image(NukeKnopf, TriggerX7, TriggerY7, TriggerWidth7, TriggerHeight7);
  image(NukeKnopf, TriggerX8, TriggerY8, TriggerWidth8, TriggerHeight8);

  //wenn Spieler auf Boden kommt, ändert sich Sprite zurück
  if (imgx == imgjr && !jumping) imgx = imgr;
  else if (imgx == imgjl && !jumping) imgx = imgl;

  //Spieler dreht sich in der Luft
  if (jumping && right) imgx = imgjr;
  if (jumping && left) imgx = imgjl;
}
