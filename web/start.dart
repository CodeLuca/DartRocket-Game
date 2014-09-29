part of mygame;

class start extends State {

  create(){

    game.add.background('purple', repeatMode: Background.REPEAT_XY);

    game.add.text("SpaceInvaders")
      ..x = game.stage.x / 2 + 450
      ..y = 200
      ..textColor = Color.White
      ..defaultTextFormat.size = 56
      ..width = 600;

    game.add.text("Use The WASD Keys and Spacebar to Play!.")
      ..x = game.stage.x / 2 + 375
      ..y = 300
      ..textColor = Color.White
      ..defaultTextFormat.size = 28
      ..width = 800;

    game.add.button('blue_button04', '')
      ..x = 450
      ..y = 375
      ..scaleX = 2
      ..scaleY = 2
      ..onTouchEnd.listen((_) {
      killState("play");
    })
      ..onMouseClick.listen((_) {
      killState("play");
    });

  }

}