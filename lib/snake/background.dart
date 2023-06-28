import 'package:flame/components.dart';
import 'package:snake_game/constants.dart';

class Background extends PositionComponent with HasGameRef {
  final int numRows;
  final int numColumns;

  Background({
    required this.numRows,
    required this.numColumns,
  });

  @override
  onLoad() async {
    final List<SpriteComponent> tiles = [];

    for (var c = 0; c < numColumns; c++) {
      for (var i = 0; i < numRows; i++) {
        tiles.add(
          SpriteComponent()
            ..sprite = await Sprite.load(
              'game_sprite.png',
              srcSize: Vector2(sizeItemSprite, sizeItemSprite),
              srcPosition: Vector2(
                sizeItemSprite * 4,
                (i.isEven && c.isEven) || (i.isOdd && c.isOdd)
                    ? 0
                    : sizeItemSprite,
              ),
            )
            ..size = size = Vector2.all(sizeCell)
            ..position = Vector2(i * sizeCell, c * sizeCell),
        );
      }
    }

    addAll(tiles);
  }
}
