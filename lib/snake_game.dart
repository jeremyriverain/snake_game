import 'dart:ui';

import 'package:flame/game.dart';
import 'package:snake_game/food.dart';
import 'package:snake_game/grid.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake/snake.dart';

class SnakeGame extends FlameGame {
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

    addAll([
      background,
      food,
      snake,
    ]);
  }
}
