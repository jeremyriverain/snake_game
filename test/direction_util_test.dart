import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/utils/direction_util.dart';

void main() {
  group('DirectionUtil', () {
    test('vectorsToDirection', () {
      expect(
        DirectionUtil.vectorsToDirection(Vector2(0, 0), Vector2(2, 1)),
        Direction.right,
      );

      expect(
        DirectionUtil.vectorsToDirection(Vector2(0, 0), Vector2(1, 2)),
        Direction.down,
      );

      expect(
        DirectionUtil.vectorsToDirection(Vector2(0, 0), Vector2(-2, 1)),
        Direction.left,
      );

      expect(
        DirectionUtil.vectorsToDirection(Vector2(0, 0), Vector2(-1, -2)),
        Direction.up,
      );
    });

    test('directionToVector', () {
      expect(
        DirectionUtil.directionToVector(Direction.left),
        Vector2(-GameConfig.speed, 0),
      );

      expect(
        DirectionUtil.directionToVector(Direction.right),
        Vector2(GameConfig.speed, 0),
      );

      expect(
        DirectionUtil.directionToVector(Direction.up),
        Vector2(0, -GameConfig.speed),
      );

      expect(
        DirectionUtil.directionToVector(Direction.down),
        Vector2(0, GameConfig.speed),
      );
    });
  });
}
