part of mygame;

class Play extends State {
  static int potato = 1;
  Random r = new Random();
  Sprite eOne, eTwo, eThree, eFour, eFive, eSix, eSeven, eEight, eNine, eTen, eEleven, eTwelve, eThirteen;
  Sprite eBullet;
  Sprite player, Shooter, melee, melee2, melee3;
  Group<Sprite> bullets, eBullets;
  Group<Sprite> enemies = new Group<Sprite>();
  List<Sprite> spriteList = new List<Sprite>();
  List<Sprite> eBulletsList = new List<Sprite>();
  Timer bulletTimer, eBulletTimer;
  bool timerIsOn = false;

  @override
  create() {
    game.add.background(
        'purple',
        isMovable: true,
        repeatMode: Background.REPEAT_XY)
      ..vx = 100
      ..vy = 250;


    player = game.add.sprite('playerShip1_blue')
        ..x = game.world.width ~/ 2
        ..y = game.world.height - 100
        ..speed = 200
        ..acceleration = 50
        ..minSpeed = 0
        ..maxSpeed = 300
        ..collideWorldBounds = true
        ..center();

    melee = game.add.sprite('flatDark23')
        ..alive = true
        ..x = player.x + 500
        ..y = player.y
        ..speed = 200
        ..acceleration = 50
        ..minSpeed = 0
        ..maxSpeed = 10
        ..collideWorldBounds = true
        ..center();

    createSprite(Sprite sprite, int xp, bool top){
      sprite.x = 200 + xp;
      if(top == true){
        sprite.y = 10;
      } else {
        sprite.y = 110;
      }
      sprite.speedY = 30;
      sprite.alive = true;
      enemies.add(sprite);
      return sprite;
    }

    Shooter = game.add.sprite('ufoRed');
    createSprite(Shooter, 1 * 100 + 10, false);
    eOne = game.add.sprite('ufoRed');
    createSprite(eOne, 2 * 100 + 10, false);
    spriteList.add(eOne);
    eTwo = game.add.sprite('ufoRed');
    createSprite(eTwo, 3 * 100 + 10, false);
    spriteList.add(eTwo);
    eThree = game.add.sprite('ufoRed');
    createSprite(eThree, 4 * 100 + 10, false);
    spriteList.add(eThree);
    eFour = game.add.sprite('ufoRed');
    createSprite(eFour, 5 * 100 + 10, false);
    spriteList.add(eFour);
    eFive = game.add.sprite('ufoRed');
    createSprite(eFive, 6 * 100 + 10, false);
    spriteList.add(eFive);
    eSix = game.add.sprite('ufoRed');
    createSprite(eSix, 7 * 100 + 10, false);
    spriteList.add(eSix);
    eSeven = game.add.sprite('ufoRed');
    createSprite(eSeven, 1 * 100 + 10, true);
    spriteList.add(eSeven);
    eEight = game.add.sprite('ufoRed');
    createSprite(eEight, 2 * 100 + 10, true);
    spriteList.add(eEight);
    eNine = game.add.sprite('ufoRed');
    createSprite(eNine, 3 * 100 + 10, true);
    spriteList.add(eNine);
    eTen = game.add.sprite('ufoRed');
    createSprite(eTen, 4 * 100 + 10, true);
    spriteList.add(eTen);
    eEleven = game.add.sprite('ufoRed');
    createSprite(eEleven, 5 * 100 + 10, true);
    spriteList.add(eEleven);
    eTwelve = game.add.sprite('ufoRed');
    createSprite(eTwelve, 6 * 100 + 10, true);
    spriteList.add(eTwelve);
    eThirteen = game.add.sprite('ufoRed');
    createSprite(eThirteen, 7 * 100 + 10, true);
    spriteList.add(eThirteen);

    eBullets = new Group<Sprite>();
    for (int z = 0; z < 15; z++) {
      Sprite spr = game.add.sprite('laserBlue01', addToWorld: false)
        ..speedY = 100
        ..killOutOfBounds = true;
      eBullets.add(spr);
      eBulletsList.add(spr);
    }

    eBulletTimer = new Timer.periodic(new Duration(milliseconds: 300), (_) {
      int eShooter = r.nextInt(spriteList.length);
      if (eBullets.any((item) => !item.alive)) {
        eBullet = eBullets.firstWhere((item) => !item.alive)
          ..x = spriteList[eShooter].x + 45
          ..y = spriteList[eShooter].y
          ..alive = true;
        eBullet.move('down');
        eBullet.addToWorld();
      }
    });

    bullets = new Group<Sprite>();
    for (int i = 0; i < 10; i++) {
      bullets.add(game.add.sprite('laserBlue01', addToWorld: false)
        //rotation
        ..speedY = 500
        ..killOutOfBounds = true);
    }

    game.keyboard.onKeyDownAndKeyUpHandler(
        KeyCode.J,
        player.speedUP,
        player.stopSpeedChange);
    game.keyboard.onKeyDownAndKeyUpHandler(
        KeyCode.K,
        player.slowDown,
        player.stopSpeedChange);
}
  @override
  update() {

      meleeEvent();
    player.stop();
    //player.stopSpeedChange();

    if (game.keyboard.isDown(KeyCode.W)) {
      player.move('forward');
    }
    if (game.keyboard.isDown(KeyCode.S)) {
      player.move('backward');
    }
    if (game.keyboard.isDown(KeyCode.A)) {
      player.move('left');
    }
    if (game.keyboard.isDown(KeyCode.D)) {
      player.move('right');
    }

//    if (game.keyboard.isDown(KeyCode.Q)) {
//      player.rotateAngles(-5);
//      enemy.rotateAngles(-5);
//    }
//    if (game.keyboard.isDown(KeyCode.E)) {
//      player.rotateAngles(5);
//      enemy.rotateAngles(5);
//    }

    Sprite bullet;

    if (game.keyboard.isDown(KeyCode.SPACE)) {
      if (timerIsOn) {
        return;
      } else {
        timerIsOn = true;
        bulletTimer = new Timer(new Duration(milliseconds: 300), (finish));
        player.center();
        bullet = bullets.firstWhere((item) => !item.alive)
          ..x = player.x
          ..y = player.y - 50
          ..alive = true;
        bullet.move('up');
        bullet.addToWorld();
      }
    }

    if(spriteList.length == 0 && melee.alive == false) {
      eBulletTimer.cancel();
      death = "You win!";
      killState("end");
    }
    game.physics.collison(enemies, bullets, (Sprite anenemy, Sprite abullet) {
      spriteList.remove(anenemy);
      anenemy.removeFromWorld();
      abullet.removeFromWorld();
    });

    game.physics.collison(player, eBullets, (Sprite theplayer, Sprite thebullet) {
      eBulletTimer.cancel();
      death = "You died by getting hit by an enemy bullet!";
      killState("end");
    });

    game.physics.collison(bullets, melee, (Sprite thebullet, Sprite melee) {
      spriteList.remove(melee);
      thebullet.removeFromWorld();
      melee.alive = false;
      melee.removeFromWorld();
    });

    game.physics.collison(player, melee, (Sprite theplayer, Sprite meleee) {
        eBulletTimer.cancel();
        death = "You died by getting hit by the Melee alien!";
        killState("end");
    });

    game.physics.collison(player, enemies, (Sprite theplayer, Sprite anenemy) {
      eBulletTimer.cancel();
      death = "You died by getting hit by an enemy alien!";
      killState("end");
    });

  }
  finish(){timerIsOn = false;}

  meleeEvent(){
    if(melee.x < player.x && melee.y < player.y){
      melee.rotation = 180 + 30;
      melee.x += 1;
      melee.y += 1;
    }
    //
    if(melee.x > player.x && melee.y < player.y || melee.x > player.x && melee.y == player.y){
      melee.rotation = 180 + 25;
      melee.x -= 1;
      melee.y += 1;
    }
    //
    if(melee.x < player.x && melee.y > player.y){
      melee.rotation = 90 - 45;
      melee.x += 1;
      melee.y -= 1;
    }
    //
    if(melee.x > player.x && melee.y > player.y){
      melee.rotation = 180 + 45;
      melee.x -= 1;
      melee.y -= 1;
    }
  }

}