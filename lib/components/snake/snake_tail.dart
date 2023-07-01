import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';

class SnakeTail extends SpriteComponent {
  SnakeTail()
      : super(
          size: Vector2.all(
            GameConfig.sizeCell,
          ),
        );

  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeCellAsset, GameConfig.sizeCellAsset),
      srcPosition: Vector2(0, 0),
    );
  }
}
