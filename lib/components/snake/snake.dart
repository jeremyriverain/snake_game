import 'dart:async';

import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/components/snake/snake_body.dart';
import 'package:snake_game/components/snake/snake_head.dart';
import 'package:snake_game/components/snake/snake_tail.dart';
import 'package:snake_game/snake_game.dart';

class Snake extends PositionComponent with HasGameRef<SnakeGame> {
  @override
  FutureOr<void> onLoad() {
    add(
      SnakeHead(),
    );

    add(
      SnakeBody()..position = -Vector2(GameConfig.sizeCell, 0),
    );

    add(
      SnakeTail()..position = -Vector2(GameConfig.sizeCell * 2, 0),
    );
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isPlaying) {
      position += Vector2(100, 0) * dt;
    }
  }
}
