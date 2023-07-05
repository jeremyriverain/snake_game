import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/blocs/game_flow_bloc.dart';
import 'package:snake_game/blocs/snake_bloc.dart';
import 'package:snake_game/components/snake/snake_body_part.dart';
import 'package:snake_game/components/snake/snake_head.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/snake_game.dart';
import 'package:snake_game/utils/direction_util.dart';

class Snake extends PositionComponent
    with HasGameRef<SnakeGame>, FlameBlocReader<SnakeBloc, SnakeState> {
  final List<PositionComponent> bodyParts = [];

  Snake() : super(priority: 1);

  Vector2 defaultDirection = Vector2(GameConfig.speed, 0);

  bool hasStarted = false;

  @override
  onLoad() async {
    super.onLoad();
    final head = SnakeHead(
      whenEatFood: whenEatFood,
      whenDead: whenDead,
      whenCollideCell: whenCollideCell,
    );
    bodyParts.addAll([
      // SnakeBodyPart()
      //   ..position = -Vector2(
      //     GameConfig.sizeCell * 2,
      //     0,
      //   ),
      SnakeBodyPart()
        ..position = -Vector2(
          GameConfig.sizeCell,
          0,
        ),
      head,
    ]);

    addAll(bodyParts);
  }

  void whenDead() {
    gameRef.gameOver();
  }

  late Effect effect;

  void whenCollideCell() {
    bloc.add(CollideCellEvent());
  }

  void whenEatFood() {
    gameRef.onEatFood();
  }

  Effect createEffect() {
    final head = bodyParts.last;

    return MoveByEffect(
      DirectionUtil.directionToVector(bloc.state.direction),
      EffectController(
        duration: .2,
        curve: Curves.linear,
      ),
      onComplete: () {
        if (gameFlowBloc.state.gameState == GameState.playing) {
          head.add(createEffect());
        }
      },
    )..removeOnFinish = true;
  }

  @override
  void update(double dt) {
    if (!hasStarted && gameFlowBloc.state.gameState == GameState.playing) {
      hasStarted = true;
      final head = bodyParts.last;

      head.add(createEffect());
    }
  }

  double getHeadAngle(Direction direction) {
    return switch (direction) {
      Direction.down => pi / 2,
      Direction.up => 3 * pi / 2,
      Direction.right => 0,
      Direction.left => pi,
    };
  }
}
