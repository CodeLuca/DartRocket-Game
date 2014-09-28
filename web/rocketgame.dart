library mygame;

import 'package:dartrocket/dartrocket.dart';
import 'dart:async';
import 'dart:math';

part 'end.dart';
part 'play.dart';
part 'loading.dart';

void main() {
  
  //starting the game engine
  Game game = new Game(width:1280, height:720);

  game.add.defaultResourceMode = GameObjectFactory.TEXTUREATLAS;
  game.add.defaultTextureAtlasName = 'spaceinvader';

  game.stateManager.addStateMap({
      "loading": new Loading(),
      "play": new Play(),
      "end": new end()
  });

  //start the play state
  game.stateManager.initState("loading");
}