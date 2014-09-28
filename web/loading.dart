part of mygame;

class Loading extends State {

  load() {

    new Text(this,"Loading...")
        ..x = 400
        ..y = 300;

    game.resourceManager.addTextureAtlas('spaceinvader', 'images/spaceinvader',
        TextureAtlasFormat.JSON);
    game.resourceManager.addBitmapData('enemyShip', 'playerShip1_red.png');

  }
  create() {
    killState("play");
  }
}
