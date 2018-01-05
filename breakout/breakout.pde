import ddf.minim.*;

Minim minim;  
AudioPlayer player1; 
AudioPlayer player2;
AudioPlayer player3;

void setup() {
  size(600, 500);
  
   minim = new Minim(this);
   player1 = minim.loadFile("sound1.mp3");//トップページのサウンド
   player2 = minim.loadFile("sound2.mp3");//プレイ中のサウンド
   player3 = minim.loadFile("breakedSound.mp3");//ブロックとボールが当たった音
   
}
int ss = 0;
float sp = 80;
float x = 0;
float y = 160;
float dx = 1;
float dy = 2;
float sx = 1;
float sy = 2;

int ball_count = 3;

int hit[][] = {
  {
    0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0
  }
  , 
  {
    0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0
  }
  , 
  {
    0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 0, 0, 0, 2, 2, 0, 0
  }
  , 
  {
    0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 2, 2, 0, 0, 2, 2, 0, 0
  }
  , 
  {
    0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 2, 2, 0, 0
  }
  , 
  {
    0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2, 2, 2, 0, 0
  }
  , 
  {
    0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 2, 0, 0
  }
  , 
  {
    0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0
  }
  , 
  {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  }
  , 
  {
    0, 0, 0, 0, 100, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 100, 100, 100, 0, 0, 0, 0
  }
};// <---

int block[][] = {
  {
    0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0
  }
  , 
  {
    0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0
  }
  , 
  {
    0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0
  }
  , 
  {
    0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0
  }
  , 
  {
    0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0
  }
  , 
  {
    0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0
  }
  , 
  {
    0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0
  }
  , 
  {
    0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0
  }
  , 
  {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  }
  , 
  {
    0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0
  }
};
float r_w = 50.0; // racket width
float b_w = 20.0; // block width
float b_h = 20.0; // block height
float a_w = 10.0; // ball width
float a_h = 10.0; // ball height
int q=400;

//バーとボールの当たり判定
boolean checkHit(float x, float y) {
  if (y + a_h < q||y > q + 3) {
    return false;
  }
  if (x + a_w >= mouseX && x < mouseX + r_w/2) {
    dx=-1;
    return true;
  } else if (x == mouseX + r_w/2) {
    dx=0;
    return true;
  } else if (x > mouseX + r_w/2 && x <= mouseX + r_w) {
    dx=1;
    return true;
  } else {
    return false;
  }
}

//ボールの生成
void show_block(int n, int m) {
  if (hit[n][m]==1) {
    stroke(0);
    fill(150, 150, 255);
  }
  if (hit[n][m]==2) {
    stroke(0);
    fill(20, 20, 200);
  }
  if (hit[n][m] == 99) {
    stroke(255, 0, 0);
    fill(0, 0, 0, 0);
  }
  if (hit[n][m] == 100) {
    stroke(0, 0, 20);
    fill(0, 0, 0, 0);
  }
  rect(b_w * m, n * b_h, b_w, b_h);

  fill(255);
}

//ブロックとボールの当たり判定
int checkHitBlock(int n, int m, float x, float y) {
  float left   = b_w * m ;
  float right  = b_w * (m + 1);
  float top    = 20 * n ;
  float bottom = 20 * n + 20;
  float cx = left + b_w / 2;
  float cy = top + b_h / 2;
  float y1, y2;

  if ((x + a_w <= left) ||
    (x >= right) ||
    (y + a_h <= top) ||
    (y >= bottom)) {
    return 0;
  }

  x = x + a_w / 2;
  y = y + a_h / 2;

  y1 = y - (-(x - cx)* b_h / b_w + cy);
  y2 = y - ( (x - cx)* b_h / b_w + cy);

  if (y1 > 0) {
    if (y2 > 0) {
      return 1;
    } else if (y2 == 0) {
      return 2;
    } else {
      return 3;
    }
  } else if (y1 < 0) {
    if (y2 > 0) {
      return 7;
    } else if (y2 == 0) {
      return 6;
    } else {
      return 5;
    }
  } else {
    if (y2 > 0) {
      return 8;
    } else if (y2 == 0) {
      return -1;
    } else {
      return 4;
    }
  }
}

//トップ画面のスタート枠の範囲をクリックするとブロック崩しが始まる
void mouseClicked() {
  if (ss == 0 ) {
    if (200<mouseX&&mouseX<400&&320<mouseY&&mouseY<370) {
      ss = 1;
      
      player1.close();
      player1.rewind();
      player2.play();
      player2.loop();
      
    }
  }
}
//ボールが当たった時のサウンド
void bollAttackedSound() {
  player3.play();
  player3.rewind();
}

//ボールのスピードを徐々にあげる
void speedBoll() {
  if (ball_count > 0 && sp <= 300) {
    sp = sp + 0.01;
}
text(sp, 200, 200);
}

//ボールをただ動かすだけ
void moveBoll() {
  int randomColor;
  randomColor = int(random(255));
  x = x + dx; 
  y = y + dy;
  fill(x, y, randomColor);

  // check reflection
  if (x >= 600) {
    dx = -(random(1, 2));
    bollAttackedSound();
  } else if (x <= 0) {
    dx = random(1, 2);
    bollAttackedSound();
  }

  if (y >= 500) {
    dy = -(random(1, 2));
    bollAttackedSound();
  } else if (y <= 0) {
    dy = random(1, 2);
    bollAttackedSound();
  }
  ellipse(x, y, a_w, a_w);//ball
}

boolean dbool=true;

//---------------------------------void draw-------------------------------//
void draw() {

  switch(ss) {
    //-------------------------------トップ画面-----------------------------//
  case 0:
    player1.play();
    background(0);
    q=500;

    moveBoll();

    textSize(100);
    fill(255, 255, 0, 90);
    rect(200, 320, 200, 50);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Breakout", width/2, height/2-120);
    textSize(50);
    text("START", width/2, height/2+90);
    textSize(30);
    text("key = a", width/2, height/2+140);
    if (keyPressed) {
      if (key == 'A' || key == 'a') {
        ss = 1;
        
         player1.close();
         player1.rewind();        
         player2.play();
         player2.loop();
         
      }
    }
    break;
    //----------------------------ブロック崩し----------------------------//
  case 1:

    frameRate(sp);
    q=400;
    int ref = 0;

    // move ball
    x = x + dx; 
    y = y + dy;

    // check reflection
    if (x + a_w >= 610) {
      dx = -1;
    } else if (x < 0) {
      dx = 1;
    }

    if (y + a_w > 510) {
      x = 0;
      y = 100;
      dx = 1;
      dy = 2;
      ball_count--;
      sp = 80;
      if (ball_count == 0) {
        dx = 0;
        dy = 0;
      }
    } else if (y < 0) {
      dy = 2;
    }


    background(0, 0, 20);
    stroke(0);
    fill(0, 255, 255);
    ellipse(x, y, a_w, a_w);//ball
    rect(mouseX, 400, r_w, 6); // pad

    speedBoll();


    for (int i = 0; i<10; i++) {
      for (int j = 0; j<30; j++) {

        if (hit[i][j] > 0) {
          show_block(i, j);
          ref = checkHitBlock( i, j, x, y);


          switch (ref) {
          case 1:
            if (hit[i][j] != 99)
            {
              hit[i][j]--;
              bollAttackedSound();
            }
          case 2:
          case 8:
            dy = sy;
            break;
          case 5:
            if (hit[i][j] != 99)
            {
              hit[i][j]--;
              bollAttackedSound();
            }
          case 4:
          case 6:
            dy = -sy;
            break;
          }
          switch (ref) {
          case 3:
            if (hit[i][j] != 99)
            {
              hit[i][j]--;
              bollAttackedSound();
            }
          case 2:

          case 4:
            dx = sx;
            break;
          case 7:
            if (hit[i][j] != 99)
            {
              hit[i][j]--;
              bollAttackedSound();
            }
          case 6:

          case 8:
            dx = -sx;
            break;
          }
        }
      }
    }

    if (checkHit(x, y)) {
      dy = -random(1, 3);
    }


    if (ball_count == 0) {
      ss = 2;
    }



    break;
    //--------------------------------ゲームオーバー画面-----------------------------//
  case 2:
    background(10, 10, 10);
    while (dbool) {
      dx=1;
      dy=1;
      dbool=false;
    }
    moveBoll();
    textSize(50);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    text("GameOver", width/2, height/2);
    textSize(30);
    text("Retry key = z", width/2, height/2+70);
    text("Top key = t", width/2, height/2+110);
    if (keyPressed) {
      //リトライする
      if (key == 'Z' || key == 'z') {
        ss = 1;
        ball_count= 3;
        dx=1;
        dy=2;
        dbool=true;
        for (int i = 0; i < 10; i++)
        {
          for (int j = 0; j < 30; j++)
          {
            if (block[i][j] == 1)
            {
              hit[i][j] = 2;
            }
            if (block[i][j] == 2)
            {
              hit[i][j] = 100;
            }
          }
        }
      }
      //トップ画面に戻る
      if (key == 'T' || key == 't') {
        ss = 0;
        ball_count= 3;
        dx=1;
        dy=2;
        dbool=true;
        for (int i = 0; i < 10; i++)
        {
          for (int j = 0; j < 30; j++)
          {
            if (block[i][j] == 1)
            {
              hit[i][j] = 2;
            }
            if (block[i][j] == 2)
            {
              hit[i][j] = 100;
            }
          }
        }
      }
    }
    break;
  }
}