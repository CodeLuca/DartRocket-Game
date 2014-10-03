part of mygame;

class end extends State {
  create(){
    game.add.background(
        'purple',
        isMovable: true,
        repeatMode: Background.REPEAT_XY)
      ..vx = 100
      ..vy = 250;

    game.add.text("Thanks for Playing! " + death)
      ..textColor = Color.White
      ..autoSize
      ..defaultTextFormat.size = 32
      ..x = 200
      ..y = 300
      ..width = 5000;

  }
}
