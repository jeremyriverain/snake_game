import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/managers/game_manager.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/grid.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/components/score_display.dart';
import 'package:snake_game/components/snake/snake.dart';

class SnakeGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  GameManager gameManager = GameManager();

  @override
  Color backgroundColor() => const Color(0xFF578B33);

  Food food = Food();
  Snake snake = Snake();

  @override
  onLoad() async {
    final background = Grid()
      ..position = Vector2(
        (size.x - GameConfig.columns * GameConfig.sizeCell) / 2,
        (size.y - GameConfig.rows * GameConfig.sizeCell) / 2,
      );

    food.position = background.position +
        Vector2(GameConfig.sizeCell * 9, GameConfig.sizeCell * 9);

    snake.position = background.position +
        Vector2(GameConfig.sizeCell * 3, GameConfig.sizeCell * 9);

    final scoreDisplay = ScoreDisplay()
      ..position = background.position +
          Vector2(
            10,
            -GameConfig.sizeCell - 10,
          );

    addAll([background, food, snake, scoreDisplay]);
  }

  void startGame() {
    gameManager.reset();
    gameManager.state = GameState.playing;
    overlays.remove(MyApp.instructionsOverlay);
  }

  void resetGame() {
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
