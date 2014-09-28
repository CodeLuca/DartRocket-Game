part of mygame;

class Play extends State {
  Random r = new Random();
  Sprite eOne, eTwo, eThree, eFour, eFive, eSix;
  Sprite eBullet;
  Sprite player, Shooter, melee;
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
        ..x = player.x + 500
        ..y = player.y
        ..speed = 200
        ..acceleration = 50
        ..minSpeed = 0
        ..maxSpeed = 10
        ..collideWorldBounds = true
        ..center();

    createSprite(Sprite sprite, int xp){
      sprite.x = 200 + xp;
      sprite.y = 100;
      sprite.speedY = 30;
      sprite.alive = true;
      enemies.add(sprite);
      return sprite;
    }
    Shooter = game.add.sprite('ufoRed');
    createSprite(Shooter, 1 * 100 + 10);
    eOne = game.add.sprite('ufoRed');
    createSprite(eOne, 2 * 100 + 10);
    spriteList.add(eOne);
    eTwo = game.add.sprite('ufoRed');
    createSprite(eTwo, 3 * 100 + 10);
    spriteList.add(eTwo);
    eThree = game.add.sprite('ufoRed');
    createSprite(eThree, 4 * 100 + 10);
    spriteList.add(eThree);
    eFour = game.add.sprite('ufoRed');
    createSprite(eFour, 5 * 100 + 10);
    spriteList.add(eFour);
    eFive = game.add.sprite('ufoRed');
    createSprite(eFive, 6 * 100 + 10);
    spriteList.add(eFive);
    eSix = game.add.sprite('ufoRed');
    createSprite(eSix, 7 * 100 + 10);
    spriteList.add(eSix);

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
          ..y = player.y
          ..alive = true;
        bullet.move('up');
        bullet.addToWorld();
      }
    }

    if(spriteList.length == 0) {
      killState("end");
    }
    game.physics.collison(enemies, bullets, (Sprite anenemy, Sprite abullet) {
      spriteList.remove(anenemy);
      anenemy.removeFromWorld();
      abullet.removeFromWorld();
    });

    game.physics.collison(player, eBullets, (Sprite theplayer, Sprite thebullet) {
//      Sprite b;
//      spriteList.forEach((b) => b.removeFromWorld());
//      eBullets.forEach((b) => b.removeFromWorld());
//      theplayer.removeFromWorld();
//      thebullet.removeFromWorld();
      killState("end");
    });


    /*if (game.keyboard.isDown(KeyCode.J)) {
      player.speedUP();
    }
    if (game.keyboard.isDown(KeyCode.K)) {
      player.slowDown();
    }*/
  }
  finish(){timerIsOn = false;}

  meleeEvent(){
    if(melee.x < player.x && melee.y < player.y){
      melee.rotation = 180 + 30;
      melee.x += 1;
      melee.y += 1;
    }
    //
    if(melee.x > player.x && melee.y < player.y){
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