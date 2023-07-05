import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/blocs/score_bloc.dart';
import 'package:snake_game/blocs/snake_bloc.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/game_manager.dart';
import 'package:snake_game/components/ground/ground.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/utils/direction_util.dart';

class SnakeGame extends FlameGame
    with KeyboardEvents, HasCollisionDetection, DragCallbacks {
  final GameManager gameManager = GameManager();

  final ScoreBloc scoreBloc;
  SnakeGame({
    required this.scoreBloc,
  });

  final SnakeBloc snakeDirectionBloc = SnakeBloc();

  @override
  Color backgroundColor() => const Color(0xFF578B33);

  Vector2? dragStartPosition;
  Vector2? dragLastPosition;

  Ground createGround() => Ground()
    ..position = Vector2(
      (size.x - GameConfig.columns * GameConfig.sizeCell) / 2,
      (size.y - GameConfig.rows * GameConfig.sizeCell) / 2,
    );

  @override
  onLoad() async {
    overlays.add(MyApp.instructionsOverlay);
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<ScoreBloc, ScoreState>(
            create: () => scoreBloc,
          ),
          FlameBlocProvider<SnakeBloc, SnakeState>(
            create: () => snakeDirectionBloc,
          ),
        ],
        children: [
          createGround(),
          gameManager,
        ],
      ),
    );
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    dragStartPosition = event.localPosition;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    dragLastPosition = event.localPosition;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    final dragStartPosition = this.dragStartPosition;
    final dragLastPosition = this.dragLastPosition;

    if (dragLastPosition != null && dragStartPosition != null) {
      snakeDirectionBloc.add(
        DragScreenEvent(
          dragStartPosition: dragStartPosition,
          dragLastPosition: dragLastPosition,
        ),
      );
    }
    this.dragStartPosition = null;
    this.dragLastPosition = null;
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    dragStartPosition = null;
    dragLastPosition = null;
  }

  void startGame() {
    gameManager.reset();
    gameManager.state = GameState.playing;
    overlays.remove(MyApp.instructionsOverlay);
  }

  void gameOver() {
    gameManager.state = GameState.gameOver;
    overlays.add(MyApp.gameOverOverlay);
  }

  void playAgain() {
    startGame();
    overlays.remove('gameOverOverlay');
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (gameManager.isGameOver || !isKeyDown) {
      return KeyEventResult.ignored;
    }

    final direction = DirectionUtil.keyboardToDirection(keysPressed);

    if (direction == null) {
      return KeyEventResult.ignored;
    }

    if (gameManager.isPlaying) {
      snakeDirectionBloc.add(TapArrowKeyEvent(directionRequested: direction));
    } else if (gameManager.isIntro) {
      startGame();
    }
    return KeyEventResult.handled;
  }
}
