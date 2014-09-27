part of mygame;
class Play extends State {

  Sprite player, enemy;

  Group<Sprite> bullets;


  @override
  create() {
    player = game.add.sprite('playerShip1_blue')
        ..x = game.world.width ~/ 2
        ..y = game.world.height ~/ 2
        ..speed = 200
        ..acceleration = 50
        ..minSpeed = 0
        ..maxSpeed = 300
        ..collideWorldBounds = true
        ..center();

    enemy = game.add.sprite('ufoRed')
        ..x = player.x + 100
        ..y = player.y + 50
        ..speed = 200
        ..acceleration = 50
        ..minSpeed = 0
        ..maxSpeed = 10
        ..collideWorldBounds = true
        ..center();

    bullets = new Group<Sprite>();
    for (int i = 0; i < 1; i++) {
      bullets.add(game.add.sprite('laserBlue01', addToWorld: false)
        //rotation
        ..speedY = 500
        ..move('up')
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
    if(enemy.x < player.x && enemy.y < player.y){
      enemy.rotation = 180 + 30;
      enemy.x += 1;
      enemy.y += 1;
    }
    //
    if(enemy.x > player.x && enemy.y < player.y){
      enemy.rotation = 180 + 25;
      enemy.x -= 1;
      enemy.y += 1;
    }
    //
    if(enemy.x < player.x && enemy.y > player.y){
      enemy.rotation = 90 - 45;
      enemy.x += 1;
      enemy.y -= 1;
    }
    //
    if(enemy.x > player.x && enemy.y > player.y){
      enemy.rotation = 180 + 45;
      enemy.x -= 1;
      enemy.y -= 1;
    }
    
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

    if (game.keyboard.isDown(KeyCode.Q)) {
      player.rotateAngles(-5);
      enemy.rotateAngles(-5);
    }
    if (game.keyboard.isDown(KeyCode.E)) {
      player.rotateAngles(5);
      enemy.rotateAngles(5);
    }

    if (game.keyboard.isDown(KeyCode.M)){
      Sprite bullet;
      if (bullets.any((item) => !item.alive)) {
        bullet = bullets.firstWhere((item) => !item.alive)
          ..x = player.x + player.width ~/ 2
          ..y = player.y
          ..alive = true;

        bullet.addToWorld();
      }
    }

    /*if (game.keyboard.isDown(KeyCode.J)) {
      player.speedUP();
    }
    if (game.keyboard.isDown(KeyCode.K)) {
      player.slowDown();
    }*/
  }
}