import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/blocs/game_flow_bloc.dart';
import 'package:snake_game/blocs/score_bloc.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/ground/cell.dart';
import 'package:snake_game/components/snake/snake.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/utils/virtual_grid.dart';

class Ground extends PositionComponent {
  @override
  onLoad() async {
    super.onLoad();

    addAll(_cells());
    size = _sizeCells;

    _virtualGrid = VirtualGrid(
      sizeCell: GameConfig.sizeCell,
      columns: GameConfig.columns,
      rows: GameConfig.rows,
      gridPosition: position,
    );

    add(RectangleHitbox());

    _initializeSnake();
    _initializeFood();

    await add(
      FlameBlocListener<GameFlowBloc, GameState>(
        listenWhen: (previousState, newState) =>
            previousState == GameState.gameOver &&
            newState == GameState.playing,
        onNewState: (state) {
          _initializeSnake();
          _initializeFood();
        },
      ),
    );

    await add(
      FlameBlocListener<ScoreBloc, int>(
        listenWhen: (previousState, newState) {
          return newState != 0;
        },
        onNewState: (state) => _newFood(),
      ),
    );
  }

  late final VirtualGrid _virtualGrid;

  Snake _snake = Snake();

  Snake _createSnake() => Snake()
    ..position =
        _virtualGrid.toRelativePosition(virtualGridVector: Vector2(4, 9));

  void _initializeSnake() {
    removeWhere((component) => component is Snake);
    _snake = _createSnake();
    add(_snake);
  }

  Food _createFood(Vector2 position) => Food()
    ..position = _virtualGrid.toRelativePosition(
      virtualGridVector: position,
    );

  void _initializeFood() {
    _addFood(Vector2(9, 9));
  }

  void _addFood(Vector2 position) {
    removeWhere((component) => component is Food);
    add(_createFood(position));
  }

  void _newFood() {
    final emptyCells = _virtualGrid.getEmptyCells(_snake.bodyParts);
    final random = Random();
    _addFood(emptyCells[random.nextInt(emptyCells.length)]);
  }

  final _sizeCells = Vector2(
    GameConfig.sizeCell * GameConfig.columns,
    GameConfig.sizeCell * GameConfig.rows,
  );

  List<RectangleComponent> _cells() {
    final List<RectangleComponent> tiles = [];

    for (var row = 0; row < GameConfig.rows; row++) {
      for (var column = 0; column < GameConfig.columns; column++) {
        final hasHitbox =
            (row.isEven && column.isEven) || (row.isOdd && column.isOdd);
        tiles.add(
          Cell(
            color:
                hasHitbox ? const Color(0xFFAAD750) : const Color(0xFFA3D148),
            position: Vector2(
                column * GameConfig.sizeCell, row * GameConfig.sizeCell),
          ),
        );
      }
    }

    return tiles;
  }
}
