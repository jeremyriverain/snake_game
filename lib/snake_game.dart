import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/game_manager.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/field.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/components/snake/snake.dart';
import 'package:snake_game/virtual_grid.dart';

class SnakeGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  final GameManager gameManager = GameManager();

  late final VirtualGrid virtualGrid;
  @override
  Color backgroundColor() => const Color(0xFF578B33);

  late Field field;
  late Food food;
  late Snake snake;

  initFood(Field field) {
    food = Food()
      ..position = virtualGrid.toAbsolutePosition(
            virtualGridVector: Vector2(9, 9),
          ) +
          Vector2.all(GameConfig.sizeCell / 2);
  }

  initSnake(Field field) {
    snake = Snake()
      ..position =
          virtualGrid.toAbsolutePosition(virtualGridVector: Vector2(3, 9));
  }

  @override
  onLoad() async {
    overlays.add(MyApp.instructionsOverlay);
    field = Field()
      ..position = Vector2(
        (size.x - GameConfig.columns * GameConfig.sizeCell) / 2,
        (size.y - GameConfig.rows * GameConfig.sizeCell) / 2,
      );

    virtualGrid = VirtualGrid(
      sizeCell: GameConfig.sizeCell,
      columns: GameConfig.columns,
      rows: GameConfig.rows,
      gridPosition: field.position,
    );
    initFood(field);
    initSnake(field);
    addAll([field, food, snake]);
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
    removeAll([snake, food]);
    initFood(field);
    initSnake(field);
    addAll([food, snake]);
  }

  void eatFood() {
    gameManager.increaseScore();
    final nextFoodPosition = getNextPositionFood(snake);
    remove(food);
    food = Food()
      ..position = virtualGrid.toAbsolutePosition(
            virtualGridVector: nextFoodPosition,
          ) +
          Vector2.all(GameConfig.sizeCell / 2);
    add(food);
  }

  Vector2 getNextPositionFood(Snake snake) {
    final forbiddenPositions = snake.bodyParts
        .map(
          (element) => virtualGrid.toVirtualGrid(
            component: element,
          ),
        )
        .toList();

    final potentialFoodPosition = virtualGrid
        .getAllCells()
        .where((cell) => !forbiddenPositions.contains(cell))
        .toList();

    final random = Random();
    return potentialFoodPosition[random.nextInt(potentialFoodPosition.length)];
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
