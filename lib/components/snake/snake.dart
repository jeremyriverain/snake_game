import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:snake_game/blocs/game_flow_bloc.dart';
import 'package:snake_game/blocs/snake_bloc.dart';
import 'package:snake_game/components/snake/snake_body_part.dart';
import 'package:snake_game/components/snake/snake_head.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/snake_game.dart';
import 'package:snake_game/utils/direction_util.dart';
import 'package:snake_game/utils/snake_effect.dart';

class Snake extends PositionComponent
    with HasGameRef<SnakeGame>, FlameBlocReader<SnakeBloc, SnakeState> {
  final List<PositionComponent> bodyParts = [];

  Snake() : super(priority: 1);

  bool hasStarted = false;

  @override
  onLoad() async {
    super.onLoad();
    bodyParts
      ..clear()
      ..addAll(
        List.generate(bloc.state.lengthSnake, (index) {
          if (index == 0) {
            return SnakeHead(
              whenEatFood: whenEatFood,
              whenDead: whenDead,
            );
          }

          return SnakeBodyPart()
            ..position = -Vector2(GameConfig.sizeCell * index, 0);
        }),
      );

    addAll(bodyParts);

    await add(
      FlameBlocListener<GameFlowBloc, GameFlowState>(
        listenWhen: (previousState, newState) {
          return newState.gameState == GameState.gameOver;
        },
        onNewState: (state) {
          for (final bodyPart in bodyParts) {
            bodyPart.removeWhere((component) => component is Effect);
          }
        },
      ),
    );
  }

  void whenDead() {
    gameRef.gameOver();
  }

  void whenEatFood() {
    gameRef.onEatFood();
  }

  @override
  void update(double dt) {
    if (!hasStarted && gameFlowBloc.state.gameState == GameState.playing) {
      hasStarted = true;
      final effect = SnakeEffect.createEffect(
        snakeBloc: gameRef.snakeBloc,
        gameFlowBloc: gameFlowBloc,
        component: bodyParts.first,
        direction: gameRef.snakeBloc.state.direction,
        previousDirection: Direction.right,
      );
      bodyParts.first.addAll(effect);
      gameRef.snakeBloc.add(MoveEvent(effect: effect));
    }
  }
}
