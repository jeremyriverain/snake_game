import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/blocs/snake_bloc.dart';
import 'package:snake_game/utils/direction_util.dart';

class SnakeEffect {
  static List<Effect> createHeadEffect({
    required SnakeBloc snakeBloc,
    required PositionComponent component,
    required Direction direction,
    required Direction previousDirection,
  }) {
    return [
      MoveByEffect(
        DirectionUtil.directionToVector(direction),
        EffectController(
          duration: .4,
          curve: Curves.linear,
        ),
        onComplete: () {
          component.addAll(createHeadEffect(
            snakeBloc: snakeBloc,
            component: component,
            direction: snakeBloc.state.direction,
            previousDirection: direction,
          ));
        },
      )..removeOnFinish = true,
      RotateEffect.by(
        getAngleFrom(
          previousDirection: previousDirection,
          direction: direction,
        ),
        EffectController(
          duration: .25,
          curve: Curves.linear,
        ),
      )
    ];
  }

  static List<Effect> createBodyEffect({
    required PositionComponent component,
  }) {
    return [
      MoveByEffect(
        DirectionUtil.directionToVector(Direction.right),
        EffectController(
          duration: .4,
          curve: Curves.linear,
        ),
        onComplete: () {
          component.addAll(createBodyEffect(
            component: component,
          ));
        },
      )..removeOnFinish = true,
    ];
  }

  static double getAngleFrom({
    required Direction direction,
    required Direction previousDirection,
  }) {
    Never throwError() {
      return throw StateError(
          'from $previousDirection to $direction should not happen');
    }

    return switch ((previousDirection, direction)) {
      (Direction.right, Direction.down) => pi / 2,
      (Direction.down, Direction.left) => pi / 2,
      (Direction.left, Direction.up) => pi / 2,
      (Direction.up, Direction.right) => pi / 2,
      (Direction.right, Direction.up) => -pi / 2,
      (Direction.up, Direction.left) => -pi / 2,
      (Direction.left, Direction.down) => -pi / 2,
      (Direction.down, Direction.right) => -pi / 2,
      (Direction.up, Direction.up) => 0,
      (Direction.left, Direction.left) => 0,
      (Direction.down, Direction.down) => 0,
      (Direction.right, Direction.right) => 0,
      (Direction.up, Direction.down) => throwError(),
      (Direction.down, Direction.up) => throwError(),
      (Direction.left, Direction.right) => throwError(),
      (Direction.right, Direction.left) => throwError(),
    };
  }
}
