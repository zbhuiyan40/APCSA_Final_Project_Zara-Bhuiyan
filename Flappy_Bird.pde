PVector playerPos;
PVector dir = new PVector(0, 0);
PVector pipePos;
PVector pipeDir = new PVector(-2, 0);
PVector pipeYDir = new PVector(0, -2);
color yellow = #FFCF46;
color blue = #46C6FF;
color green = #86FF46;
color black = #000000;
color white = #FFFFFF;
color red = #f73309;
color na = color(255, 255, 255, 0);
                                        
                                       
PImage playerImg;
PImage pipeImg;
PImage background;
int pipeWidth, pipeHeight;
int speed = 1;
int frameCounter = 0;
int score = 0;
int highscore = 0;
int pipeSpace = 150;
boolean alreadyScore = false;
boolean gameOver = false;
boolean start = false;
boolean ishard = false;

void setup(){
  size(640, 480);
  playerImg = loadImage("FlappyBird.png");
  playerPos = new PVector(width/2, height/2);
  pipeImg = loadImage("Pipe.png");
  background = loadImage("Background.png");
  pipePos = new PVector(width/1.5 + 100, height/2 + random(0, 120));
  pipeWidth = pipeImg.width/2;
  pipeHeight = pipeImg.height/2;
  drawBackground();
  drawPlayer();
  startScreen();
  
}


void draw(){
  background(black);
  drawBackground();
  drawPlayer();
  drawPipe();
  fill(blue);
  stroke(4);
  rect(width/20, height/20, 300, 50, 5, 5, 5, 5);
  fill(black);
  textSize(25);
  text("Score: " + score, width/20 + 10, height/20 + 35);
  text("High Score: " + highscore, width/20 + 120, height/20 + 35);
  noFill();
  if(frameCount % speed == 0 && start && !ishard){
    update();
  }
  else if(frameCount % speed == 0 && ishard){
    hardupdate();
  }
  else startScreen();
}

void startScreen(){
    fill(blue);
    rect(width/2 - 180, height/2 -150, 360, 100, 5, 5, 5, 5);
    rect(width/2 - 180, height/2 + 100, 360, 100, 5, 5, 5, 5);
    fill(black);
    textSize(80);
    text("Start", width/2 - 150, height/2 - 70);
    text("HARD", width/2 - 150, height/2 + 180);
      if(mouseX >= width/2 - 180 && mouseX <= width/2 - 180 + 360 && mouseY >= height/2 - 150 && mouseY <= height/2 - 150 + 100) {
        fill(green);
        stroke(4);
        rect(width/2 - 180, height/2 -150, 360, 100, 5, 5, 5, 5);
        fill(black);
        textSize(80);
        text("Start", width/2 - 150, height/2 - 70);
        noFill();
        if(mousePressed) start = true;
      }
      else if(mouseX >= width/2 - 180 && mouseX <= width/2 - 180 + 360 && mouseY >= height/2 + 100 && mouseY <= height/2 + 100 + 100) {
        fill(red);
        stroke(4);
        rect(width/2 - 180, height/2 + 100, 360, 100, 5, 5, 5, 5);
        fill(black);
        textSize(80);
        text("HARD", width/2 - 150, height/2 + 180);
        noFill();
        if(mousePressed) {
          ishard = true;
        }
      }
    }


void update(){
  frameCounter++;
  if(gameOver) gameOver();
  else{
    if(keyPressed){
      dir.y = -5.0;
      playerPos.add(dir);
    }
    else{
    dir.y += 0.5;
    playerPos.add(dir);}
    frameCounter = 0;
    pipePos.add(pipeDir);
    if(pipePos.x <= playerPos.x - pipeWidth + 150 && alreadyScore == false) {
      score++;
      alreadyScore = true;
      if(score > highscore) highscore = score;
    }
    if(pipePos.x <= -pipeImg.width/2 + 120){
      pipePos = new PVector(width/1.5 + 100, height/2 + random(0, 120));
      pipeDir.x -= ((int)frameCounter/1000);
      if(pipeSpace >= 70) pipeSpace -= ((int)frameCounter/1000);
      alreadyScore = false;
    }
    if(playerPos.x >= pipePos.x + pipeWidth/4 && playerPos.x <= pipePos.x + pipeWidth/1.5  && ((playerPos.y >= pipePos.y  && playerPos.y <= pipePos.y + pipeHeight) || (playerPos.y <= pipePos.y - pipeSpace - 50 && playerPos.y >= 0)) || playerPos.y >= height || playerPos.y <= -50) gameOver = true; 
  }
}

void hardupdate(){
  update();
  pipePos.add(pipeYDir);
  if(pipePos.y < 0 + pipeHeight/2  || pipePos.y > height - pipeHeight/4) pipeYDir = new PVector(0, (pipeYDir.y + ((int)frameCounter/1000)) * -1);
}

void restart(){
  start = false;
  ishard = false;
  frameCounter = 0;
  gameOver = false;
  score = 0;
  speed = 1;
  pipeSpace = 150;
  alreadyScore = false;
  playerPos = new PVector(width/2, height/2);
  dir = new PVector(0, 0);
  pipePos = new PVector(width/1.5 + 100, height/2 + random(0, 120));
  pipeWidth = pipeImg.width/2;
  pipeHeight = pipeImg.height/2;
  pipeDir = new PVector(-2, 0);
  delay(500);
  
}

void gameOver(){
  background(green);
  fill(blue);
  stroke(4);
  rect(width/2 - 240, height/2 - 200, 480, 100, 5, 5, 5, 5);
  rect(width/2 - 240, height/2 - 50, 480, 100, 5, 5, 5, 5);
  rect(width/2 - 240, height/2 + 100, 480, 100, 5, 5, 5, 5);
  fill(black);
  textSize(80);
  text("Game Over", width/2 - 190, height/2 - 130);
  text("Score: " + score, width/2 - 190, height/2 + 30);
  text("Restart?", width/2 - 190, height/2 + 180);
  noFill();
  {
    if(mouseX >= width/2 - 240 && mouseX <= width/2 -240 + 480 && mouseY >= height/2 + 100 && mouseY <= height/2 + 100 + 100) {
      fill(green);
      stroke(4);
      rect(width/2 - 240, height/2 + 100, 480, 100, 5, 5, 5, 5);
      fill(black);
      textSize(80);
      text("Restart?", width/2 - 190, height/2 + 180);
      noFill();
      if(mousePressed) {
        restart();
      }
    }
  }
}

  



void drawPlayer(){
  image(playerImg, playerPos.x, playerPos.y, playerImg.width/10, playerImg.height/10);
}

void drawBackground(){
  image(background, 0, 0, background.width, background.height);
}

void drawPipe(){
  image(pipeImg, pipePos.x, pipePos.y, pipeWidth, pipeHeight);
  pushMatrix();
  scale(1, -1);
  image(pipeImg, pipePos.x, -pipePos.y + pipeSpace, pipeWidth, pipeHeight);
  popMatrix();
}
