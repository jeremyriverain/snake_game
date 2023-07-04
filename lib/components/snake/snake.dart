import 'dart:async';

import 'package:flame/components.dart';
// import 'package:flame/effects.dart';
// import 'package:snake_game/game_config.dart';
// import 'package:snake_game/components/snake/snake_body_part.dart';
import 'package:snake_game/components/snake/snake_head.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';

class Snake extends PositionComponent with HasGameRef<SnakeGame> {
  final List<PositionComponent> bodyParts = [];

  Snake() : super(priority: 1);

  Vector2 defaultDirection = Vector2(GameConfig.speed, 0);

  @override
  FutureOr<void> onLoad() {
    bodyParts.addAll([
      // SnakeBodyPart()
      //   ..position = -Vector2(
      //     GameConfig.sizeCell * 2,
      //     0,
      //   ),
      // SnakeBodyPart()
      //   ..position = -Vector2(
      //     GameConfig.sizeCell,
      //     0,
      //   ),
      SnakeHead(
        whenEatFood: whenEatFood,
        whenDead: whenDead,
      ),
    ]);

    addAll(bodyParts);
  }

  void whenDead() {
    gameRef.gameOver();
  }

  void whenEatFood() {
    // final bodyPart = SnakeBodyPart()
    //   ..position = -Vector2(
    //     GameConfig.sizeCell * bodyParts.length - 1,
    //     0,
    //   )
    //   ..anchor = Anchor.topRight
    //   ..size = Vector2(0, GameConfig.sizeCell)
    //   ..add(SizeEffect.to(
    //     Vector2.all(GameConfig.sizeCell),
    //     EffectController(
    //       duration: .1,
    //     ),
    //   ));
    // bodyParts.add(bodyPart);
    // add(bodyPart);
    gameRef.gameManager.increaseScore();
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isPlaying) {
      position += defaultDirection * dt;
    }
  }
}
