import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:snake_game/blocs/snake_bloc.dart';
import 'package:snake_game/components/snake/snake_head.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';
import 'package:snake_game/utils/direction_util.dart';

class Snake extends PositionComponent
    with HasGameRef<SnakeGame>, FlameBlocReader<SnakeBloc, SnakeState> {
  final List<PositionComponent> bodyParts = [];

  Snake() : super(priority: 1);

  Vector2 defaultDirection = Vector2(GameConfig.speed, 0);

  @override
  onLoad() async {
    super.onLoad();
    final snake = SnakeHead(
      whenEatFood: whenEatFood,
      whenDead: whenDead,
    );
    bodyParts.addAll([
      // SnakeBodyPart()
      //   ..position = -Vector2(
      //     GameConfig.sizeCell * 2,
      //     0,
      //   ),
      // SnakeBodyPart()
      //   ..position = -Vector2(
      //     GameConfig.sizeCell,
      //     0,
      //   ),
      snake,
    ]);

    addAll(bodyParts);
  }

  void whenDead() {
    gameRef.gameOver();
  }

  void whenEatFood() {
    // final bodyPart = SnakeBodyPart()
    //   ..position = -Vector2(
    //     GameConfig.sizeCell * bodyParts.length - 1,
    //     0,
    //   )
    //   ..anchor = Anchor.topRight
    //   ..size = Vector2(0, GameConfig.sizeCell)
    //   ..add(SizeEffect.to(
    //     Vector2.all(GameConfig.sizeCell),
    //     EffectController(
    //       duration: .1,
    //     ),
    //   ));
    // bodyParts.add(bodyPart);
    // add(bodyPart);
    gameRef.gameManager.increaseScore();
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isPlaying) {
      final head = bodyParts.last;
      head.position +=
          DirectionUtil.directionToVector(bloc.state.direction) * dt;
      head.angle = getHeadAngle(bloc.state.direction);
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
