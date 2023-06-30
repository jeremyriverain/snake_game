import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';

class Grid extends PositionComponent with HasGameRef<SnakeGame> {
  @override
  onLoad() async {
    addAll(await getGridCells());

    size = Vector2(
      GameConfig.sizeCell * GameConfig.columns,
      GameConfig.sizeCell * GameConfig.rows,
    );

    add(RectangleHitbox());
  }

  Future<List<SpriteComponent>> getGridCells() async {
    final List<SpriteComponent> tiles = [];

    final rng = Random();

    for (var c = 0; c < GameConfig.rows; c++) {
      for (var i = 0; i < GameConfig.columns; i++) {
        tiles.add(
          SpriteComponent()
            ..sprite = await Sprite.load(
              'game_sprite.png',
              srcSize: Vector2(GameConfig.sizeAsset, GameConfig.sizeAsset),
              srcPosition: Vector2(
                GameConfig.sizeAsset * 4,
                rng.nextBool() ? 0 : GameConfig.sizeAsset,
              ),
            )
            ..size = size = Vector2.all(GameConfig.sizeCell)
            ..position =
                Vector2(i * GameConfig.sizeCell, c * GameConfig.sizeCell),
        );
      }
    }

    return tiles;
  }
}
