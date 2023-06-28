import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';

class SnakeBody extends SpriteComponent {
  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeAsset, GameConfig.sizeAsset),
      srcPosition: Vector2(GameConfig.sizeAsset * 1, 0),
    );
    size = Vector2.all(GameConfig.sizeCell);
  }
}
