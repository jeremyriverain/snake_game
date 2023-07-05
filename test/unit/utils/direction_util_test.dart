import 'package:flame/game.dart';
import 'package:flutter/services.dart';
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

    test('keyboardToDirection', () {
      expect(DirectionUtil.keyboardToDirection({}), null);
      expect(
        DirectionUtil.keyboardToDirection({LogicalKeyboardKey.space}),
        null,
      );
      expect(
        DirectionUtil.keyboardToDirection(
          {LogicalKeyboardKey.space, LogicalKeyboardKey.arrowRight},
        ),
        Direction.right,
      );
      expect(
        DirectionUtil.keyboardToDirection(
          {LogicalKeyboardKey.space, LogicalKeyboardKey.arrowLeft},
        ),
        Direction.left,
      );
      expect(
        DirectionUtil.keyboardToDirection(
          {LogicalKeyboardKey.space, LogicalKeyboardKey.arrowUp},
        ),
        Direction.up,
      );
      expect(
        DirectionUtil.keyboardToDirection(
          {LogicalKeyboardKey.space, LogicalKeyboardKey.arrowDown},
        ),
        Direction.down,
      );
    });

    test('getForbiddenDirectionOf', () {
      expect(
        DirectionUtil.getForbiddenDirectionOf(Direction.down),
        Direction.up,
      );
      expect(
        DirectionUtil.getForbiddenDirectionOf(Direction.up),
        Direction.down,
      );
      expect(
        DirectionUtil.getForbiddenDirectionOf(Direction.left),
        Direction.right,
      );
      expect(
        DirectionUtil.getForbiddenDirectionOf(Direction.right),
        Direction.left,
      );
    });
  });
}
