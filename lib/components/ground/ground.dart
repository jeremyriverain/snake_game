import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/blocs/score_bloc.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/ground/cell.dart';
import 'package:snake_game/components/snake/snake.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/game_manager.dart';
import 'package:snake_game/snake_game.dart';
import 'package:snake_game/virtual_grid.dart';

class Ground extends PositionComponent
    with HasGameRef<SnakeGame>, FlameBlocReader<ScoreBloc, ScoreState> {
  late final VirtualGrid virtualGrid;

  Snake snake = Snake();
  Food food = Food();

  Snake createSnake() => Snake()
    ..position =
        virtualGrid.toRelativePosition(virtualGridVector: Vector2(4, 9));

  Food createFood(Vector2 position) => Food()
    ..position = virtualGrid.toRelativePosition(
      virtualGridVector: position,
    );

  @override
  onLoad() async {
    super.onLoad();

    addAll(await getGridCells());

    size = Vector2(
      GameConfig.sizeCell * GameConfig.columns,
      GameConfig.sizeCell * GameConfig.rows,
    );

    virtualGrid = VirtualGrid(
      sizeCell: GameConfig.sizeCell,
      columns: GameConfig.columns,
      rows: GameConfig.rows,
      gridPosition: position,
    );

    add(RectangleHitbox());

    await add(
      FlameBlocListener<ScoreBloc, ScoreState>(
        onNewState: (state) {
          if (game.gameManager.state != GameState.playing) {
            return;
          }

          if (bloc.state.score != 0) {
            onScoreUpdated();
          } else {
            removeWhere((component) => component is Snake);
            snake = createSnake();
            add(snake);

            removeWhere((component) => component is Food);
            food = createFood(Vector2(9, 9));
            add(food);
          }
        },
      ),
    );

    snake = createSnake();
    add(snake);

    food = createFood(Vector2(9, 9));
    add(food);
  }

  Future<List<RectangleComponent>> getGridCells() async {
    final List<RectangleComponent> tiles = [];

    for (var row = 0; row < GameConfig.rows; row++) {
      for (var column = 0; column < GameConfig.columns; column++) {
        tiles.add(
          Cell(
            color: (row.isEven && column.isEven) || (row.isOdd && column.isOdd)
                ? const Color(0xFFAAD750)
                : const Color(0xFFA3D148),
            position: Vector2(
                column * GameConfig.sizeCell, row * GameConfig.sizeCell),
          ),
        );
      }
    }

    return tiles;
  }

  void onScoreUpdated() {
    if (game.gameManager.state != GameState.playing) {
      return;
    }
    nextFood();
  }

  void nextFood() {
    remove(food);
    final emptyCells = getEmptyCells(snake);
    final random = Random();
    food = createFood(emptyCells[random.nextInt(emptyCells.length)]);
    add(food);
  }

  List<Vector2> getEmptyCells(Snake snake) {
    final filledCells = snake.bodyParts
        .map(
          (element) => virtualGrid.toVirtualVector(
            component: element,
          ),
        )
        .toList();

    return virtualGrid
        .getAllVectors()
        .where((cell) => !filledCells.contains(cell))
        .toList();
  }
}
