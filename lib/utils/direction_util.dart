import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/game_config.dart';

class DirectionUtil {
  static Direction vectorsToDirection(Vector2 start, Vector2 end) {
    final delta = end - start;
    final isHorizontal = delta.x.abs() > delta.y.abs();
    if (isHorizontal) {
      return delta.x < 0 ? Direction.left : Direction.right;
    }
    return delta.y < 0 ? Direction.up : Direction.down;
  }

  static Vector2 directionToVector(Direction direction) {
    return switch (direction) {
      Direction.down => Vector2(0, GameConfig.speed),
      Direction.up => Vector2(0, -GameConfig.speed),
      Direction.left => Vector2(-GameConfig.speed, 0),
      Direction.right => Vector2(GameConfig.speed, 0),
    };
  }

  static Direction? keyboardToDirection(Set<LogicalKeyboardKey> keysPressed) {
    final isArrowDown = keysPressed.contains(LogicalKeyboardKey.arrowDown);
    if (isArrowDown) {
      return Direction.down;
    }

    final isArrowLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    if (isArrowLeft) {
      return Direction.left;
    }

    final isArrowUp = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    if (isArrowUp) {
      return Direction.up;
    }
    final isArrowRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isArrowRight) {
      return Direction.right;
    }

    return null;
  }
}

enum Direction { up, down, left, right }
