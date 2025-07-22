void drawStart() 
{
    image(StartImG1,0,0,width,height);

if ((mouseX > 320) && (mouseX < 605) &&
    (mouseY > 190) && (mouseY < 270) && (mousePressed == true) ) {
    gameState++ ;
}

}
