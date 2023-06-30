import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/managers/game_manager.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/grid.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/components/snake/snake.dart';

class SnakeGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  GameManager gameManager = GameManager();

  @override
  Color backgroundColor() => const Color(0xFF578B33);

  late Grid background;
  late Food food;
  late Snake snake;

  resetComponents() {
    background = Grid()
      ..position = Vector2(
        (size.x - GameConfig.columns * GameConfig.sizeCell) / 2,
        (size.y - GameConfig.rows * GameConfig.sizeCell) / 2,
      );

    food = Food()
      ..position = background.position +
          Vector2(
            GameConfig.sizeCell * 9 + GameConfig.sizeCell / 2,
            GameConfig.sizeCell * 9 + GameConfig.sizeCell / 2,
          );

    snake = Snake()
      ..position = background.position +
          Vector2(GameConfig.sizeCell * 3, GameConfig.sizeCell * 9);
  }

  @override
  onLoad() async {
    overlays.add(MyApp.instructionsOverlay);
    resetComponents();
    addAll([background, food, snake]);
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

  void resetGame() {
    startGame();
    overlays.remove('gameOverOverlay');
    removeAll([background, snake, food]);
    resetComponents();
    addAll([background, food, snake]);
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

    final isArrowDown = keysPressed.contains(LogicalKeyboardKey.arrowDown);
    final isArrowLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isArrowUp = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    final isArrowRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (!isArrowDown && !isArrowLeft && !isArrowUp && !isArrowRight) {
      return KeyEventResult.ignored;
    }

    if (gameManager.isPlaying) {
    } else if (gameManager.isIntro) {
      startGame();
    }
    return KeyEventResult.handled;
  }
}
