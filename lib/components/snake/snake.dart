import 'dart:async';

import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/components/snake/snake_body_part.dart';
import 'package:snake_game/components/snake/snake_head.dart';
import 'package:snake_game/snake_game.dart';

class Snake extends PositionComponent with HasGameRef<SnakeGame> {
  final bodyParts = [
    SnakeBodyPart()
      ..position = -Vector2(
        GameConfig.sizeCell * 2,
        0,
      ),
    SnakeBodyPart()
      ..position = -Vector2(
        GameConfig.sizeCell,
        0,
      ),
    SnakeHead(),
  ];

  Snake() : super(priority: 1);

  Vector2 direction = Vector2(150, 0);

  @override
  FutureOr<void> onLoad() {
    addAll(bodyParts);
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isPlaying) {
      position += direction * dt;
    }
  }
}
