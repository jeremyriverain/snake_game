import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';

class Ground extends PositionComponent with HasGameRef<SnakeGame> {
  @override
  onLoad() async {
    addAll(await getGridCells());

    size = Vector2(
      GameConfig.sizeCell * GameConfig.columns,
      GameConfig.sizeCell * GameConfig.rows,
    );

    add(RectangleHitbox());
  }

  Future<List<RectangleComponent>> getGridCells() async {
    final List<RectangleComponent> tiles = [];

    for (var c = 0; c < GameConfig.rows; c++) {
      for (var i = 0; i < GameConfig.columns; i++) {
        tiles.add(
          RectangleComponent()
            ..size = size = Vector2.all(GameConfig.sizeCell)
            ..position =
                Vector2(i * GameConfig.sizeCell, c * GameConfig.sizeCell)
            ..setColor(
              (c.isEven && i.isEven) || (c.isOdd && i.isOdd)
                  ? const Color(0xFFAAD750)
                  : const Color(0xFFA3D148),
            ),
        );
      }
    }

    return tiles;
  }
}
