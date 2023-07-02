import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/game_manager.dart';
import 'package:snake_game/components/ground/ground.dart';
import 'package:snake_game/game_config.dart';

class SnakeGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  final GameManager gameManager = GameManager();

  @override
  Color backgroundColor() => const Color(0xFF578B33);

  Ground createGround() => Ground()
    ..position = Vector2(
      (size.x - GameConfig.columns * GameConfig.sizeCell) / 2,
      (size.y - GameConfig.rows * GameConfig.sizeCell) / 2,
    );

  @override
  onLoad() async {
    overlays.add(MyApp.instructionsOverlay);
    add(createGround());
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
    removeWhere((component) => component is Ground);
    add(createGround());
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
