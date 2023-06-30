import 'dart:async';

import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/components/snake/snake_body_part.dart';
import 'package:snake_game/components/snake/snake_head.dart';
import 'package:snake_game/components/snake/snake_tail.dart';
import 'package:snake_game/snake_game.dart';

class Snake extends PositionComponent with HasGameRef<SnakeGame> {
  final head = SnakeHead();

  final bodyParts = [
    SnakeBodyPart()
      ..position = -Vector2(
        GameConfig.sizeCell,
        0,
      ),
  ];
  final tail = SnakeTail()
    ..position = -Vector2(
      GameConfig.sizeCell * 2,
      0,
    );

  @override
  FutureOr<void> onLoad() {
    addAll([head, ...bodyParts, tail]);
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isPlaying) {
      position += Vector2(110, 0) * dt;
    }
  }
}