import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/managers/direction_manager.dart';

void main() {
  group('DirectionManager', () {
    test('vectorsToDirection', () {
      expect(
        DirectionManager.vectorsToDirection(Vector2(0, 0), Vector2(2, 1)),
        Direction.right,
      );

      expect(
        DirectionManager.vectorsToDirection(Vector2(0, 0), Vector2(1, 2)),
        Direction.down,
      );

      expect(
        DirectionManager.vectorsToDirection(Vector2(0, 0), Vector2(-2, 1)),
        Direction.left,
      );

      expect(
        DirectionManager.vectorsToDirection(Vector2(0, 0), Vector2(-1, -2)),
        Direction.up,
      );
    });

    test('directionToVector', () {
      expect(
        DirectionManager.directionToVector(Direction.left),
        Vector2(-GameConfig.speed, 0),
      );

      expect(
        DirectionManager.directionToVector(Direction.right),
        Vector2(GameConfig.speed, 0),
      );

      expect(
        DirectionManager.directionToVector(Direction.up),
        Vector2(0, -GameConfig.speed),
      );

      expect(
        DirectionManager.directionToVector(Direction.down),
        Vector2(0, GameConfig.speed),
      );
    });
  });
}
