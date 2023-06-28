import 'dart:ui';

import 'package:flame/game.dart';
import 'package:snake_game/managers/game_manager.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/grid.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/components/score_display.dart';
import 'package:snake_game/components/snake/snake.dart';

class SnakeGame extends FlameGame {
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

    food.position =
        background.position + Vector2(GameConfig.sizeCell, GameConfig.sizeCell);

    snake.position = background.position +
        Vector2(GameConfig.sizeCell * 4, GameConfig.sizeCell * 4);

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
  }

  void resetGame() {
    startGame();
    overlays.remove('gameOverOverlay');
  }
}
