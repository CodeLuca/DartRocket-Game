part of mygame;

class end extends State {

  create(){
    new Background.color(this, color: Color.Beige, scaleMode: Background.SCALE_FULL_XY);
    game.add.text("Thanks for Playing")
      ..x = 300
      ..y = 300
      ..width = 500;
  }
}