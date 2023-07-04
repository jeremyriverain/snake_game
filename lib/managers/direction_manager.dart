import 'package:flame/game.dart';
import 'package:snake_game/game_config.dart';

class DirectionManager {
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
}

enum Direction { up, down, left, right }
